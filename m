Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E160C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B3320873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6Ym6uMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgE0QSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:18:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56938 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbgE0QSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JepJfRV2MtlN/s6yxUvXYLjP1XodOHFXgF9Sww6msw4=; b=G6Ym6uMP6jS6a1wL4kUzB8Q+25
        VKKl+aZUyY67XKm4VuIms2owLyscxosFuc6iqHSTBY5NsV7pfoa2UrrXuk9CqC6eUE67b6TN8TC8V
        VrnD8y+IzYfRlDgBqdQFZ2eMuUNyXfFvQc0s1MNdly4trAx7+3ZDHMJ+7eoPxG6nCyi/WCV4e0HX6
        eIqlUDE2uKgf3gn4pr5EozafxDEd1IaZzwowOyeTuVm8Qkc7eUcEGcjriIKjevpcD0AIIJH61dUnj
        ueM5/lNtreEAqg9eRreds+bon1bOu33wHecivYatsqT4/FwaQD8QWEpoaZd3vmzasuptV1ZACgc6M
        lGr/CymQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdykJ-00027z-0r; Wed, 27 May 2020 16:17:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 074523012C3;
        Wed, 27 May 2020 18:17:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4D262B99FB3F; Wed, 27 May 2020 18:17:32 +0200 (CEST)
Date:   Wed, 27 May 2020 18:17:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 04/15] kprobes: Add perf ksymbol events for kprobe
 insn pages
Message-ID: <20200527161732.GA706495@hirez.programming.kicks-ass.net>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <20200512121922.8997-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512121922.8997-5-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 03:19:11PM +0300, Adrian Hunter wrote:
> @@ -202,6 +207,13 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
>  		 * next time somebody inserts a probe.
>  		 */
>  		if (!list_is_singular(&kip->list)) {
> +			/*
> +			 * Record perf ksymbol unregister event before removing
> +			 * the page.
> +			 */
> +			perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
> +					   (u64)kip->insns, PAGE_SIZE, true,
> +					   kip->cache->sym);
>  			list_del_rcu(&kip->list);
>  			synchronize_rcu();
>  			kip->cache->free(kip->insns);

My manual build script haz complaints:

i386-defconfig  ../kernel/kprobes.c: In function ‘__get_insn_slot’:
../kernel/kprobes.c:190:51: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (u64)kip->insns,
^
../kernel/kprobes.c: In function ‘collect_one_slot’:
../kernel/kprobes.c:215:9: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
(u64)kip->insns, PAGE_SIZE, true,
^
FAIL


Now, there's a ton of such warnings elsewhere in the tree, but still I
feel we should perhaps strive for a clean build.
