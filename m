Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A0FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE37520899
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593070313;
	bh=s5YiudHcf15Ba+FMBJAD7g36E/5kHkePxrq4qUiroxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vyaa/mMYqzXTVtFvfynn0A1rbzhWzYLryUCFKBw8XK7o1Xs6EQl3RPNoaYSB4uPpI
	 ZXSkMoL5Vbsb+Gk5rL1Pbaj8Vx+e+JD6OoGnVMeZhDyVvZuLK30er5QLQOs0KANQV0
	 67YTrvL7hkTDKWOYsSzv1FoJZySIcHoGkoqkc/ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390224AbgFYHbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgFYHbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:31:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCEB2076E;
        Thu, 25 Jun 2020 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593070311;
        bh=s5YiudHcf15Ba+FMBJAD7g36E/5kHkePxrq4qUiroxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zS+JQNgGbxh0EBYvwZZ5MtYVDwiSnTQxXKOpFOpKYt78GDWI8H1SqX44UpNjQaztT
         3yMB6Jes9gx71Wc7uKMZTtKw+APn5gGs6CH5ZZTCIq48+CKLpl7nMyZK+PfJg3z8NA
         M4IV34lzbiJBna0zrKQNOFiIQl58+J+g4d+M+ZK0=
Date:   Thu, 25 Jun 2020 08:31:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 6/8] arm: Break cyclic percpu include
Message-ID: <20200625073145.GA7444@willie-the-truck>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.454517573@infradead.org>
 <20200623090257.GA3743@willie-the-truck>
 <20200624175320.GN4781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624175320.GN4781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:53:20PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 10:02:57AM +0100, Will Deacon wrote:
> > On Tue, Jun 23, 2020 at 10:36:51AM +0200, Peter Zijlstra wrote:
> > > In order to use <asm/percpu.h> in irqflags.h, we need to make sure
> > > asm/percpu.h does not itself depend on irqflags.h.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/arm/include/asm/percpu.h |    2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > --- a/arch/arm/include/asm/percpu.h
> > > +++ b/arch/arm/include/asm/percpu.h
> > > @@ -10,6 +10,8 @@
> > >   * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
> > >   */
> > >  #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
> > > +register unsigned long current_stack_pointer asm ("sp");
> > 
> > If you define this unconditionally, then we can probably get rid of the
> > copy in asm/thread_info.h, rather than duplicate the same #define.
> 
> The below delta seems to build arm-allnoconfig, arm-defconfig and
> arm-allmodconfig.
> 
> Although please don't ask me how asm/thread_info.h includes asm/percpu.h
> 
> Does that work for you?

Yes, thanks! I can't believe you removed the helpful comment.

> -/*
> - * how to get the current stack pointer in C
> - */

Will
