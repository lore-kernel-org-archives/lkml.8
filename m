Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380DDC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC512077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J2hzEvkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDVNZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgDVNZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:25:36 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDD2C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CckiFsLIOz39/Q99CdZ55wqBbVLH1g4nRz8wpxPrbkI=; b=J2hzEvkMPGlG48+wNy9fP+CcWl
        YcTklKWQQHlOy8F5/Ptj9q0lsaxA/FIRMuARdiPIg7PgjERwrfOsNnzcxqBN0lMWd6YksC+fmNyT+
        U5PnXkc1ltHDU7cqoG3qU0bb7TbuMjaeTQ2uMHjrKOE8DkbjllsGH8iO+BlmcaXH/N52jNQN5kROm
        y6h+yppf59dwYajiKl96h8gniYbNoIYzgIzgE2FpgXoxXgAor7nqGLec2wDfor+KBJZRmBdSvLdzs
        zUeRA1TniVcLfiNGOf5Hw1b4OvG64g7S/731L29ZooCzu+RG5kZfCLQhqb2R8NApQgF6/hNJZ/8NV
        oCP53Ttg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRFMx-0000wz-IY; Wed, 22 Apr 2020 13:24:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB677300739;
        Wed, 22 Apr 2020 15:24:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FABB25E17E39; Wed, 22 Apr 2020 15:24:48 +0200 (CEST)
Date:   Wed, 22 Apr 2020 15:24:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, wim@linux-watchdog.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 16/23] sched,watchdog: Convert to sched_set_fifo()
Message-ID: <20200422132448.GH20730@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112832.165197058@infradead.org>
 <20200422085155.7549ca94@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422085155.7549ca94@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 08:51:55AM -0400, Steven Rostedt wrote:
> On Wed, 22 Apr 2020 13:27:35 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Because SCHED_FIFO is a broken scheduler model (see previous patches)
> > take away the priority field, the kernel can't possibly make an
> > informed decision.
> > 
> > Effectively changes prio from 99 to 50.
> 
> Hmm, this being a watchdog, and looking at commit 38a1222ae4f364d
> ("watchdog: core: make sure the watchdog worker always works")
> 
> I wonder if we should add a sched_set_high(), or have some other kind of
> watchdog handler that is guaranteed to trigger.

It's FIFO, it'll never win from either a deadline or a stop-task. After
that it doesn't matter.

fifo_high() is most definitely a bad idea, because then we're back into
the whole 'fifo priority' has meaning -- it does not. At least, it
doesn't until you've got system design information.

Maybe we should rename fifo_low to get away from that. I just drew a
blank on a better name there.
