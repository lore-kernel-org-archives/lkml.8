Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E72C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B93F2070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+t7yo72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCFJfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:35:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32260 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726047AbgCFJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583487320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tsFi+O9az18f1T3MjIac9BWaKJWw7F/SruWPHEZq+5Y=;
        b=G+t7yo72Z3zN3AFVDqqDcZiNBVqR3MS23WYwjUHkaGF3H2KNL1NLP7Jwo2K+Y3TauEmS7R
        6bewIuA8W9ChW6nIeOiHlBOUSkG6NENQvozp5xPUnaTvRPTaBquKb0ABXv1aIvKtYPNvvM
        Wj6/zQBgbhYWv11WuEY5jGbDQTSB43U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-PBnw_K2DPTaO2DJMsZRHOA-1; Fri, 06 Mar 2020 04:35:16 -0500
X-MC-Unique: PBnw_K2DPTaO2DJMsZRHOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D600801F78;
        Fri,  6 Mar 2020 09:35:13 +0000 (UTC)
Received: from krava (ovpn-205-205.brq.redhat.com [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D2E091D68;
        Fri,  6 Mar 2020 09:35:09 +0000 (UTC)
Date:   Fri, 6 Mar 2020 10:35:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/3] perf tool: build related fixes
Message-ID: <20200306093506.GC281906@krava>
References: <20200306071110.130202-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306071110.130202-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:11:07PM -0800, Ian Rogers wrote:
> These patches better enable a build of perf when not using the regular
> Makefiles, in my case using bazel.
> 
> Ian Rogers (3):
>   tools: fix off-by 1 relative directory includes
>   libperf: avoid redefining _GNU_SOURCE in test
>   tools/perf: build fixes for arch_errno_names.sh

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/include/uapi/asm/errno.h              | 14 +++++-----
>  tools/lib/perf/tests/test-evlist.c          |  2 ++
>  tools/perf/arch/arm64/util/arm-spe.c        | 20 +++++++-------
>  tools/perf/arch/arm64/util/perf_regs.c      |  2 +-
>  tools/perf/arch/powerpc/util/perf_regs.c    |  4 +--
>  tools/perf/arch/x86/util/auxtrace.c         | 14 +++++-----
>  tools/perf/arch/x86/util/event.c            | 12 ++++-----
>  tools/perf/arch/x86/util/header.c           |  4 +--
>  tools/perf/arch/x86/util/intel-bts.c        | 24 ++++++++---------
>  tools/perf/arch/x86/util/intel-pt.c         | 30 ++++++++++-----------
>  tools/perf/arch/x86/util/machine.c          |  6 ++---
>  tools/perf/arch/x86/util/perf_regs.c        |  8 +++---
>  tools/perf/arch/x86/util/pmu.c              |  6 ++---
>  tools/perf/trace/beauty/arch_errno_names.sh |  4 +--
>  14 files changed, 76 insertions(+), 74 deletions(-)
> 
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

