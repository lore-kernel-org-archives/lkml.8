Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2D7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C1320748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cvHO6Au5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgEUPM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgEUPM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:12:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7DEC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vu0Vaxs7IefmouAAAzANzYnryWDduj56r+NgTrTYkZs=; b=cvHO6Au5II47Bw46tKmX9ddJY
        NNPdxihzF1xRveiO5KeHqkQRyrLIVwEyy5VIEQf/DPsQBWBqKyRKEnZKSI6ROgHy9rsiQH5t9pnPp
        qC5LFl+SiPr+9evpFbTP6Y5GGkzAU92ZQfe8ATLSxhlRcyI5MB4moG62SI1LAUbXAwjd04kNZ58pD
        Z2dkufbj1cPu/cjGQuwDTWn6lOi40EAFQ/tGgL1QsWstVf7UiQf8lLPsumuDOqBzuQExzdCgaCDrb
        i1XRYcPh50FYF3SGaZxQ3yyElk8ww08hnK/BDPx8Af4JLCGVK4ja/8mb9l2XKd/hJpa5R4wjIfnfn
        p9CbQ4Xrw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35116)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jbmrp-0002k7-0D; Thu, 21 May 2020 16:12:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jbmrk-0000Ix-EH; Thu, 21 May 2020 16:12:12 +0100
Date:   Thu, 21 May 2020 16:12:12 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 04/11] ARM: Allow IPIs to be handled as normal interrupts
Message-ID: <20200521151212.GT1551@shell.armlinux.org.uk>
References: <20200519161755.209565-1-maz@kernel.org>
 <20200519161755.209565-5-maz@kernel.org>
 <20200519222447.GJ1551@shell.armlinux.org.uk>
 <jhjk115xu4a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjk115xu4a.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 03:03:49PM +0100, Valentin Schneider wrote:
> 
> On 19/05/20 23:24, Russell King - ARM Linux admin wrote:
> > On Tue, May 19, 2020 at 05:17:48PM +0100, Marc Zyngier wrote:
> >> In order to deal with IPIs as normal interrupts, let's add
> >> a new way to register them with the architecture code.
> >>
> >> set_smp_ipi_range() takes a range of interrupts, and allows
> >> the arch code to request them as if the were normal interrupts.
> >> A standard handler is then called by the core IRQ code to deal
> >> with the IPI.
> >>
> >> This means that we don't need to call irq_enter/irq_exit, and
> >> that we don't need to deal with set_irq_regs either. So let's
> >> move the dispatcher into its own function, and leave handle_IPI()
> >> as a compatibility function.
> >>
> >> On the sending side, let's make use of ipi_send_mask, which
> >> already exists for this purpose.
> >
> > You say nothing about the nesting of irq_enter() and irq_exit()
> > for scheduler_ipi().
> >
> > Given that lockdep introduced the requirement that hard IRQs can't
> > be nested, are we sure that calling irq_exit() twice is safe?
> >
> > Looking at irqtime_account_irq(), it seems that will cause double-
> > accounting of in-interrupt time, since we will increment
> > irq_start_time by just over twice the the period spent handling
> > the IPI.
> >
> > I think the rest of irq_exit() should be safe, but still, this
> > behaviour should be documented at the very least, if not avoided.
> >
> 
> x86 does the same (though IIUC only when tracing reschedule IPI's),

Right, so when the system is operating normally, then the accounting is
correct.  When the reschedule path is being explicitly traced, then
the accounting will be doubled for it.

What's being proposed for ARM is to always have this mis-accounting,
where no mis-accounting was present before - and some of us (me) /do/
enable IRQ accounting in our kernels as standard. So, you can take
this as a kernel regression report from a user.

> and MIPS has the same issue as it also uses generic IRQ IPI's - so
> although it's not ideal, I think we can live with it.

Yes, but is there anyone who cares about this for MIPS?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
