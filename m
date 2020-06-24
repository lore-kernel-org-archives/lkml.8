Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B68C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B7220706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNso/P9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403922AbgFXNKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:10:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57610 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728843AbgFXNKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593004247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AjjjuOuQA9xfPFn+NEdIeAaJBoXrFuGSdN2W9j81pr4=;
        b=WNso/P9n9VUJ1Z/vPD0dNobGPiRCaJEjfNCiy/N4DVv9OY5qa7LK9UwxUhzGuHqkg53CNG
        5M//mhRy7ZyHtSYwO72WCzkXROr4Qf/8jZ5rQC/aZ1RF8hkNjCTJyThw18zsoTuAJVy9we
        ILt1V6nLN+Pwa0HSmt3i3WmgNFCwqwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-x8hRrT6EOtWF7Iz6QEFzEQ-1; Wed, 24 Jun 2020 09:10:43 -0400
X-MC-Unique: x8hRrT6EOtWF7Iz6QEFzEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36A1F800597;
        Wed, 24 Jun 2020 13:10:42 +0000 (UTC)
Received: from krava (unknown [10.40.193.204])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3748A1C8;
        Wed, 24 Jun 2020 13:10:40 +0000 (UTC)
Date:   Wed, 24 Jun 2020 15:10:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Remi Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [PATCH 3/3] perf tests: Add test for PE binary format support
Message-ID: <20200624131039.GC2719003@krava>
References: <20200624103041.825746-1-rbernon@codeweavers.com>
 <20200624103041.825746-3-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624103041.825746-3-rbernon@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:30:41PM +0200, Remi Bernon wrote:
> This adds a precompiled file in PE binary format, with split debug file,
> and tries to read its build_id and .gnu_debuglink sections, as well as
> looking up the main symbol from the debug file. This should succeed if
> libbfd is supported.

SNIP

> diff --git a/tools/perf/tests/pe-file.exe b/tools/perf/tests/pe-file.exe
> new file mode 100644

dreams coming true.. windows.exe file in perf sources ;-)

awesome, thanks for the test

jirka

