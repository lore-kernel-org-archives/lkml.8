Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B8DC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2D0206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asksjxHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCGKpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:45:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28704 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgCGKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 05:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583577917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPDCZ/KbzdltRPn25i5SoU+xFMCcgx/ga1DrivtTXmo=;
        b=asksjxHHkLr0hWTZG48bI5UgC4g13dEQ8opotyMmrddoFjppZSx8gvwUJX0LfFSlYVKyUu
        zS0kBegrZQUAUB/zoezsfAhjGg3OLL3Qf4YXxR2qzmcr1nVfAFH7nD0Viac7ANOZeri9sf
        SDgRWDqit0Lf0OHtttYxWtTDyI5cNVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-4Ya9bD6BNjmfUZ5RElNv9g-1; Sat, 07 Mar 2020 05:45:15 -0500
X-MC-Unique: 4Ya9bD6BNjmfUZ5RElNv9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46C34107ACCA;
        Sat,  7 Mar 2020 10:45:13 +0000 (UTC)
Received: from krava (ovpn-205-205.brq.redhat.com [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBD415C1BB;
        Sat,  7 Mar 2020 10:45:06 +0000 (UTC)
Date:   Sat, 7 Mar 2020 11:45:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/1] perf/tool: fix read in event parsing
Message-ID: <20200307104501.GA311316@krava>
References: <20200307073121.203816-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307073121.203816-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 11:31:21PM -0800, Ian Rogers wrote:
> ADD_CONFIG_TERM accesses term->weak, however, in get_config_chgs this
> value is accessed outside of the list_for_each_entry and references
> invalid memory. Add an argument for ADD_CONFIG_TERM for weak and set it
> to false in the get_config_chgs case.
> This bug was cause by clang's address sanitizer and libfuzzer. It can be
> reproduced with a command line of:
>   perf stat -a -e i/bs,tsc,L2/o
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

nice catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

