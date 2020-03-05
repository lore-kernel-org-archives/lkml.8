Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804B0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5744A20848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zXKm95Ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCEL7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:59:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46264 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgCEL7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t84ouAsyX1J6mOnF2FaVLphyRW6vdfA28vHTnYsA3QE=; b=zXKm95Ar5SZL7zetu9S3VecTTP
        qSFTTZsy5Ne+ypZZtac/Esp4fDAv7EPrqLGmcXJhgck1LcxNlWzyBpUBedgyIthm5ZtzoOudZiPvQ
        O/hrF0UzT+ryNwDn7f3FzaocfDD/DrqpZyifG+Hhw0SyGMIB4OZg/rLjkdLW3McrToPjaRMvJFavD
        /IhBAN/EGjvwS6mdqMc1ai36c7HwYo7GgZumiCZNYNr1gfJECTk6ggzp3A7V+BhiT3W8EzH4Kmt+Z
        IfsgbolAg1mOaCD8DTVY+KycjGFOWrdjiWMIJvaSXONbRcuTOaxsNZ6vW/YSlwNdSsgwuerrPfc/L
        1zCMfggQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9p9r-0003Oq-KX; Thu, 05 Mar 2020 11:59:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B60C030066E;
        Thu,  5 Mar 2020 12:59:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 734D320139C6B; Thu,  5 Mar 2020 12:59:16 +0100 (CET)
Date:   Thu, 5 Mar 2020 12:59:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86/optprobe: Fix OPTPROBE vs UACCESS
Message-ID: <20200305115916.GE2579@hirez.programming.kicks-ass.net>
References: <20200305092130.GU2596@hirez.programming.kicks-ass.net>
 <20200305194006.e3c447159aa866ac95fd02de@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305194006.e3c447159aa866ac95fd02de@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 07:40:06PM +0900, Masami Hiramatsu wrote:
> Hi Peter,
> 
> On Thu, 5 Mar 2020 10:21:30 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > 
> > While looking at an objtool UACCESS warning, it suddenly occurred to me
> > that it is entirely possible to have an OPTPROBE right in the middle of
> > an UACCESS region.
> > 
> > In this case we must of course clear FLAGS.AC while running the KPROBE.
> > Luckily the trampoline already saves/restores [ER]FLAGS, so all we need
> > to do is inject a CLAC. Unfortunately we cannot use ALTERNATIVE() in the
> > trampoline text, so we have to frob that manually.
> 
> Good catch! so this prevents optprobe handler to access user space
> avoiding SMAP feature.

Yes that, but also worse, since the patch referenced by Fixes, x86_64 no
longer saves/restores FLAGS on context switch, and if the OPTPROBE were
to (accidentally) call into schedule() (say through preempt_enable()),
the next task could also run without SMAP for a while.

> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!
