Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B3CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE22920656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC6ATCSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFKJDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:03:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726783AbgFKJDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591866180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97xtZHAc1XXOLbnqcFjzV4Je09Xvv3dI4KKq8ENrPn0=;
        b=OC6ATCSQs+8O4z0H+QKqgCkLpmvg+lA9hEfjA9Pv6MHyKuoo1yGANN58l+mdgKtAeetDPh
        5WJtzJGjoXrEDdEYvA+IDti5SS+bPsGLBtCZXDsNFDTEkAkXy6/eI5AfU3S15QpoE5gGBI
        opdTaed4Hz/AFMZEd7cD49c1pYzS5AU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-mpQCfyvTM92C65Z1BunWsA-1; Thu, 11 Jun 2020 05:02:55 -0400
X-MC-Unique: mpQCfyvTM92C65Z1BunWsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D1D8193F561;
        Thu, 11 Jun 2020 09:02:53 +0000 (UTC)
Received: from krava (unknown [10.40.194.223])
        by smtp.corp.redhat.com (Postfix) with SMTP id 89FCE78914;
        Thu, 11 Jun 2020 09:02:50 +0000 (UTC)
Date:   Thu, 11 Jun 2020 11:02:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 00/10] perf parse-events: enable more flex/bison warnings
Message-ID: <20200611090249.GC1786122@krava>
References: <20200610215100.256599-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:50:50PM -0700, Ian Rogers wrote:
> All C compiler warnings are disabled are disabled by -w. This change
> removes the -w from flex and bison targets. To avoid implicit
> declarations header files are declared as targets and included.
> 
> Tested with GCC 9.3.0 and clang 9.0.1.
> 
> Previously posted as a single change:
> https://lore.kernel.org/lkml/20200609234344.3795-2-irogers@google.com/
> 
> Ian Rogers (10):
>   perf parse-events: Use automatic variable for flex input
>   perf parse-events: Use automatic variable for yacc input
>   perf pmu: Add bison debug build flag
>   perf pmu: Add flex debug build flag
>   perf parse-events: Declare flex header file output
>   perf parse-events: Declare bison header file output
>   perf parse-events: Disable a subset of flex warnings
>   perf expr: Avoid implicit lex function declaration
>   perf parse-events: Avoid implicit lex function declaration
>   perf parse-events: Disable a subset of bison warnings

looks great, I wonder what the -w replacement will do in
Arnaldo's distro test, but it'd be nice to get rid it

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/perf/util/Build          | 50 +++++++++++++++++++++-------------
>  tools/perf/util/expr.y         |  2 ++
>  tools/perf/util/parse-events.y |  1 +
>  3 files changed, 34 insertions(+), 19 deletions(-)
> 
> -- 
> 2.27.0.278.ge193c7cf3a9-goog
> 

