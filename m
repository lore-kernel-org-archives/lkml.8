Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE5FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D24820835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591955366;
	bh=8i+MqAZZFAmkFbs5MEhIuuE6tT35KuFo73qlUAq0tAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0jpM19W2f9aJHZ7bJH61rv67InsTQMJW+BqTMDYqwzIy17jaR1UwY0C8mMtq99kRt
	 t5pH8LSL9ZIoGlUXVTfuJ/873Z3OUoUF+T5WdDd+9B+cuiJbQ41p1b99qIxdZg53Ip
	 aRCRNYbeNngFEV4Bgoxzl8GJRUxlA1+g/K1WkPN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFLJtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgFLJtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:49:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC7120792;
        Fri, 12 Jun 2020 09:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591955362;
        bh=8i+MqAZZFAmkFbs5MEhIuuE6tT35KuFo73qlUAq0tAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AJPWCXpf5yw3CIw1ucO/Zb+rLt65FkcO+cwH53R+fgdavBidUaEeVC6jbB0CGe/lx
         hjvK8i54prSYSYMXFb6cbzn8ge3sgbTbrj7YL52Gs0M9tvyCiwd8hvATuHg1JtEGGl
         akTV/kur5/hiMWgSMhPtGK789B7PFpAh2Q4dt4EM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jjgJM-002M4c-JE; Fri, 12 Jun 2020 10:49:20 +0100
Date:   Fri, 12 Jun 2020 10:49:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/11] arm/arm64: Turning IPIs into normal interrupts
Message-ID: <20200612104918.3829bb26@why>
In-Reply-To: <d1ac7873-0f02-dbe0-dd3c-4fd14a87cf03@gmail.com>
References: <20200519161755.209565-1-maz@kernel.org>
        <d1ac7873-0f02-dbe0-dd3c-4fd14a87cf03@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sumit.garg@linaro.org, kernel-team@android.com, linux@arm.linux.org.uk, jason@lakedaemon.net, catalin.marinas@arm.com, tglx@linutronix.de, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, 19 May 2020 10:50:46 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 5/19/2020 9:17 AM, Marc Zyngier wrote:
> > For as long as SMP ARM has existed, IPIs have been handled as
> > something special. The arch code and the interrupt controller exchange
> > a couple of hooks (one to generate an IPI, another to handle it).
> > 
> > Although this is perfectly manageable, it prevents the use of features
> > that we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It
> > also means that each interrupt controller driver has to follow an
> > architecture-specific interface instead of just implementing the base
> > irqchip functionnalities. The arch code also duplicates a number of
> > things that the core irq code already does (such as calling
> > set_irq_regs(), irq_enter()...).
> > 
> > This series tries to remedy this on arm/arm64 by offering a new
> > registration interface where the irqchip gives the arch code a range
> > of interrupts to use for IPIs. The arch code requests these as normal
> > interrupts.
> > 
> > The bulk of the work is at the interrupt controller level, where all 3
> > irqchips used on arm64 get converted.
> > 
> > Finally, the arm64 code drops the legacy registration interface. The
> > same thing could be done on 32bit as well once the two remaining
> > irqchips using that interface get converted.
> > 
> > There is probably more that could be done: statistics are still
> > architecture-private code, for example, and no attempt is made to
> > solve that (apart from hidding the IRQs from /proc/interrupt).
> > 
> > This has been tested on a bunch of 32 and 64bit guests.  
> 
> Does this patch series change your position on this patch series
> 
> https://lore.kernel.org/linux-arm-kernel/20191023000547.7831-3-f.fainelli@gmail.com/T/
> 
> or is this still a no-no?

I don't think this series changes anything. There is no easy way to
reserve SGIs in a way that would work for all combination of OS and FW,
and the prospect of sending SGIs between S and NS has already been
dubious (yes, the GIC architecture allows it, but it has been written
by people who have never designed any large piece of SW).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
