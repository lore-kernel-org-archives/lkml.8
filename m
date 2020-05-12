Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB5FC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D766020714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KjtedJkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgELI6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbgELI6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:58:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7538EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1I1EUzsXfpvR0+SnUXqMXlU26M2INlMVph+MUYQS+cI=; b=KjtedJkYK4JIJ9RoybiQdeUiMu
        AKoWhm4YU+GjO5Sb9R6jxNbR0bjJ+5o8Q0iu8i3YUNZMgt6d2ohef1Hk4zrCnn401/FwDjD7JL4qw
        cVKZR52EY2z0gO9gAn6YALTVRWU+t/Bo1k6SJeuLOY1mcVqsiV4PBQvmdj5hicKcAbAE0UTGpDSC0
        hXe9cBA03qyMxMZ5mwGrAFxeSmHpM7K1V+AFwAlltfYUAcY6VBlM6oMt/TaTmSgKt3og5i1kuMjEd
        SBGgniVxUxkdJ2BuPovIlZCl7QemHRFJeaOKh0zgVVVZb7qTzYKIcXWgaEVj/YvM8bKFbAr9pW47O
        2vKi5IHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYQjQ-0006jg-6A; Tue, 12 May 2020 08:57:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A91C4305EEF;
        Tue, 12 May 2020 10:57:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 929A3286BFA73; Tue, 12 May 2020 10:57:41 +0200 (CEST)
Date:   Tue, 12 May 2020 10:57:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: perf_event: Fix time offset prior to epoch
Message-ID: <20200512085741.GG2978@hirez.programming.kicks-ass.net>
References: <20200505135544.6003-1-leo.yan@linaro.org>
 <20200511092200.GF2957@hirez.programming.kicks-ass.net>
 <20200511092519.GA3001@hirez.programming.kicks-ass.net>
 <20200512063812.GA20352@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512063812.GA20352@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:38:12PM +0800, Leo Yan wrote:

> I have verified this change, it works as expected on my Arm64 board.
> Also paste the updated code which makes building success with minor
> fixing.

W00t !

> I am not sure how to proceed, will you merge this?  Or you want me to
> send out formal patches (or only for the Arm64 part)?

I suppose I can write a Changelog for the thing, Will asked for another
change as well.

> P.s. it's shame I still missed you guys suggestion in prvious thread
> even though you have provide enough ifno, and thank you for the helping!

All good.


> ---8<---

> -	/*
> -	 * time_shift is not expected to be greater than 31 due to
> -	 * the original published conversion algorithm shifting a
> -	 * 32-bit value (now specifies a 64-bit value) - refer
> -	 * perf_event_mmap_page documentation in perf_event.h.
> -	 */
> -	if (shift == 32) {
> -		shift = 31;
> -		userpg->time_mult >>= 1;
> -	}

Is there a reason you completely lost that? IIRC I preserved that.
Although I don't know if it is still relevant.

I'll keep it for now, and removal can be a separate patch with proper
justification, ok?
