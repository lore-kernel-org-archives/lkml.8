Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858F920675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ehj1QJjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgBLKDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:03:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgBLKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/g3wWot6qhpaIN6InSmMeDgjV6uWOVP/yABQGqj6p/M=; b=ehj1QJjS+sfIYafRTZRJ1alg6f
        +fsWX2YuTfxDjGP1Io0rQ9ZfdIN4tuk3MiqP9V7yEgBWEHjmL5QzkR9G4vq0GO5BOf8duyzf39BKO
        rgNs7308TWVi4oei79W/lO7+ta1hd/NdCwnwdK6qM9+napnvRDzi8t88r7iAzthZmGNfvlfSB063M
        BwBEcaAVyBxVY9y3HJPD80Vvv5aDMChugzRCMctq//S/t4yr9N7wbC5gVrOgZasq7H5+JSd0qWC0s
        T6mf2xnpCj66D0d3oaUAxGoPXjHL4HwsYmFKKtuqbijVv3TTFplNNDrLc8v9ceAWrITIXJ1W1mDPN
        TIWqGxeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1ori-0005x5-LP; Wed, 12 Feb 2020 10:03:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FDEC300235;
        Wed, 12 Feb 2020 11:01:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DE752026E97A; Wed, 12 Feb 2020 11:03:28 +0100 (CET)
Date:   Wed, 12 Feb 2020 11:03:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mpe@ellerman.id.au
Cc:     mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 0/8] tracing vs rcu vs nmi
Message-ID: <20200212100328.GB14914@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212093210.468391728@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:32:10AM +0100, Peter Zijlstra wrote:
> Hi all,
> 
> These here patches are the result of Mathieu and Steve trying to get commit
> 865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
> tracepoints") reverted again.
> 
> One of the things discovered is that tracing MUST NOT happen before nmi_enter()
> or after nmi_exit(). I've only fixed x86, but quickly gone through other
> architectures and there is definitely more stuff to be fixed (simply grep for
> nmi_enter in your arch).

For Power:

 - system_reset_exception()
 - machine_check_exception()
 - soft_nmi_interrupt()
 - __perf_event_interrupt() (book3s)
 - perf_event_interrupt() (fsl)

will want looking at.
