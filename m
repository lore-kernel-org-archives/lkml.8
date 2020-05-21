Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412A5207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nC1DRrF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgEUKLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:11:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgEUKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MXiJifaZtgfEcmcUxJdE198Idg9c7DGrSBxW7026Ud4=; b=nC1DRrF+mF+dnRH1p/ebtgPAQ6
        gLxrv/pcapO3aCrkJVcaJVtPVaC+jAJjCMtnpSvBqpJBOc0X5jmeH0P7Dz+PJujoqZ0/n1EuPCmVE
        UruNDUgUlUhRG4TMAks1Hl4B8xRZvg9oKJOxkBFEnXQwgVVusDkuu5yKb7Pc4+qSY7etSICVJUoV8
        6d/jt2Fg82ppC/YN3CfLR7iV3Tj5Zh2J6CO6rDD+FiBcVIfP8RoHBZOAA/1/vJkdbvCxmm+W3fcGf
        N+MX1SOGps9gOy91OLdUtAozqYX4lguWc1lDOxpfYXDe4DVL7sp4QbBgURjaCiNAdZAE5QeT2zJGx
        vaaa5skw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbiA6-0001kN-P5; Thu, 21 May 2020 10:10:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EEBE1304123;
        Thu, 21 May 2020 12:10:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7C732B7DA1F7; Thu, 21 May 2020 12:10:47 +0200 (CEST)
Date:   Thu, 21 May 2020 12:10:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Endless soft-lockups for compiling workload since next-20200519
Message-ID: <20200521101047.GH325280@hirez.programming.kicks-ass.net>
References: <CAG=TAF6jUsQrW-fjbS3vpjkMfn8=MUDsuQxjk3NMfvQa250RHA@mail.gmail.com>
 <20200520125056.GC325280@hirez.programming.kicks-ass.net>
 <20200521004035.GA15455@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521004035.GA15455@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 02:40:36AM +0200, Frederic Weisbecker wrote:

>                                                        atomic_fetch_or(...., nohz_flags(0))
>     softirq() {                                        #VMEXIT or anything that could stop a CPU for a while
>         run_rebalance_domain() {
>             nohz_idle_balance() {
>                 atomic_andnot(NOHZ_KICK_MASK, nohz_flag(0))

I'm an idiot and didn't have enough wake-up-juice; I missed that andnot
clearing the flag again.

Yes, fun fun fun..
