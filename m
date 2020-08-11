Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF98C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9F82076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597154335;
	bh=Y1lbVbdfo/u3kgJVXLeJEnxHkiYVqy6G6bUGXrD3d9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=T3oj+GOBLv/5MaiFtckzVzMIfUDJtkHVkxU7KosLtB3fGe6cr+PA7VPkiF/DmGC/h
	 wQ+FTxZHGXb81pbdW3RJFZj7axZ/Cpwvj26g4smwvtmmZ6Jmjz8CIscobOveg119gS
	 FmZOoZucopGseIjrESIFP5tDNfQqBDp6s2oOcBEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgHKN6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbgHKN6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:58:52 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BD9204FD;
        Tue, 11 Aug 2020 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597154331;
        bh=Y1lbVbdfo/u3kgJVXLeJEnxHkiYVqy6G6bUGXrD3d9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hB9wtHwGE9UPTG58/aFDvuQNzT0EMsMPMhBrA/S2LVWwrrGn35w2oQmOzkPnricpy
         mJLDdVnIwfkC7qU8usJa8FLTK1kkd1wVJVwwwiH+IwFWIAsYuXUlho4poJINI83OHx
         JOD1K1smRBtzlF6ejrH0cwvJ8mv1a6HbTtM5opgE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k5Unh-001InR-VM; Tue, 11 Aug 2020 14:58:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Aug 2020 14:58:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: Re: [PATCH v2 00/17] arm/arm64: Turning IPIs into normal interrupts
In-Reply-To: <CAFA6WYNw7TgypuEdOVRQ4QzAe6BbOg8V0_6O-Xb1=8xybse=nQ@mail.gmail.com>
References: <20200624195811.435857-1-maz@kernel.org>
 <CAFA6WYNw7TgypuEdOVRQ4QzAe6BbOg8V0_6O-Xb1=8xybse=nQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <807e577b5e9a762d9ce7a4acc2e309c8@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On 2020-08-11 14:15, Sumit Garg wrote:
> Hi Marc,
> 
> On Thu, 25 Jun 2020 at 01:28, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> For as long as SMP ARM has existed, IPIs have been handled as
>> something special. The arch code and the interrupt controller exchange
>> a couple of hooks (one to generate an IPI, another to handle it).
>> 
>> Although this is perfectly manageable, it prevents the use of features
>> that we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It
>> also means that each interrupt controller driver has to follow an
>> architecture-specific interface instead of just implementing the base
>> irqchip functionalities. The arch code also duplicates a number of
>> things that the core irq code already does (such as calling
>> set_irq_regs(), irq_enter()...).
>> 
>> This series tries to remedy this on arm/arm64 by offering a new
>> registration interface where the irqchip gives the arch code a range
>> of interrupts to use for IPIs. The arch code requests these as normal
>> per-cpu interrupts.
>> 
>> The bulk of the work is at the interrupt controller level, where all 5
>> irqchips used on arm+SMP/arm64 get converted.
>> 
>> Finally, we drop the legacy registration interface as well as the
>> custom statistics accounting.
>> 
>> Note that I have had a look at providing a "generic" interface by
>> expanding the kernel/irq/ipi.c bag of helpers, but so far all
>> irqchips have very different requirements, so there is hardly anything
>> to consolidate for now. Maybe some as hip04 and the Marvell horror get
>> cleaned up (the latter certainly could do with a good dusting).
>> 
>> This has been tested on a bunch of 32 and 64bit guests (GICv2, GICv3),
>> as well as 64bit bare metal (GICv3). The RPi part has only been tested
>> in QEMU as a 64bit guest, while the HiSi and Marvell parts have only
>> been compile-tested.
> 
> This series works perfectly fine on Developerbox.
> 
> I just want to follow-up regarding when you are planning to push this
> series upstream? Are you waiting for other irqchips (apart from GIC)
> to be reviewed?

I'd certainly like people to review (and maybe test if they have
the HW at hand) the rest of the interrupt controller changes.

I'll probably repost the series around -rc1.

> Actually mine work to turn IPI as a pseudo NMI [1] is dependent on
> this patch-set.
> 
> [1] https://lkml.org/lkml/2020/5/20/488

I'm aware of this.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
