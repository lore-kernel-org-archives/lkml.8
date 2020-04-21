Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AD0C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254AB206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lsbJCe8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgDUNqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728479AbgDUNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:46:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB98C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OVhMcy33txF59g0GBmGeFBQDP70B2RqtUabZXK1bvjc=; b=lsbJCe8hYyvP/bM2+8ZjQExB8F
        wW7IbPCxgJ87FAqhi8UUM1p6+2Kdy1zbMgHYKUO78dADozz1SGL9wRaVmxefK5umzpfvj2dSGaa1+
        kL6VJnOffbRMsyY0Hw8uIrW2asxI8RSyUX9DVA+YouXZzp6WSS3Z/Qi1u3YEUaOGdqpZaShggLMj3
        xLLBbFEeuHWHOMPPrOpAaVWJw7GVTEba7UifEsW/hHbtrHrGPP7JrM1oG5gRah5gFq6v9lS9VO9iq
        OcbQUgXq74J4RrIEaG+l2dbVudQITmHvyc4n6uQqe7Xci2A8X05kzqxM6WwRTWMi6ufO/oB2mTWaC
        4iGYPJfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQtDy-0001dj-RL; Tue, 21 Apr 2020 13:46:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74829306064;
        Tue, 21 Apr 2020 15:46:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65E602BAC792B; Tue, 21 Apr 2020 15:46:04 +0200 (CEST)
Date:   Tue, 21 Apr 2020 15:46:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 00/15] perf/x86: Add perf text poke events
Message-ID: <20200421134604.GR20730@hirez.programming.kicks-ass.net>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 11:13:12PM +0300, Adrian Hunter wrote:
> 
> Adrian Hunter (15):
>       perf: Add perf text poke event
>       perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers
>       kprobes: Add symbols for kprobe insn pages
>       kprobes: Add perf ksymbol events for kprobe insn pages
>       perf/x86: Add perf text poke events for kprobes
>       ftrace: Add symbols for ftrace trampolines
>       ftrace: Add perf ksymbol events for ftrace trampolines
>       ftrace: Add perf text poke events for ftrace trampolines

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
