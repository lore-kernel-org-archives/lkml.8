Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88E4C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F0C20838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583663286;
	bh=Pbz7s51U/HHD3bMxGsxaZXnGc/ZWW+UudYPmMSFTIOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=et7RQebxXPz76DHdKDZto3whPJaWb/DhG2Gemwq82W/ixD26BAJA9natWoloSlbxI
	 IwMbL5NdNKOustcS61v9yVSnvV7Q6q0fSWBvKK1lk3xHa8jIM1UJSsUy81R5Oi5Rud
	 1zGRzZIN52wa2MWC94TVTpYzCTZQhiyoXuwYCejA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgCHK2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgCHK2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:28:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE4A2072A;
        Sun,  8 Mar 2020 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583663284;
        bh=Pbz7s51U/HHD3bMxGsxaZXnGc/ZWW+UudYPmMSFTIOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2T1qVxPoM9KZz0QTcRkm+T2mcogVPuXyQzqK7x58/waiW6bLTQiFd0h++tSncf0aB
         S7UWUgG+JEHifQ+inPsLIEmy9oZsfuYNZlm8dDKZglztvRPWFKNly+8qo+ZuhP75aA
         cwFwsrtwMwXRYqG9AFGJc2WXA0Fk86kl3DiQrSrY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAtAA-00B0TY-EG; Sun, 08 Mar 2020 10:28:02 +0000
Date:   Sun, 8 Mar 2020 10:27:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH] irqchip/gic-v3: avoid reading typer2 if GICv3
Message-ID: <20200308102756.4bae3c27@why>
In-Reply-To: <20200307233442.958122-1-msalter@redhat.com>
References: <20200307233442.958122-1-msalter@redhat.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: msalter@redhat.com, linux-kernel@vger.kernel.org, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

+Robert for Marvell/Cavium

On Sat,  7 Mar 2020 18:34:42 -0500
Mark Salter <msalter@redhat.com> wrote:

> Trying to boot v5.6-rc1 on a ThunderX platform leads to
> a SEA splat when trying to read the GICv4 TYPER2 register:

There is no such thing as a GICv4 register. All registers exist on all
versions of the architecture. They all have a well defined behaviour
when not implemented, which is RAZ/WI. New versions of the GICv3
architecture (which continues to evolve in parallel to GICv4) may use
this register as well, and this patch would then become a problem on
its own.

Now, to the issue itself:

> 
> [    0.000000] GICv3: 0 Extended SPIs implemented
> [    0.000000] Internal error: synchronous external abort: 96000210 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc4+ #11
> [    0.000000] Hardware name: Cavium ThunderX CN88XX board (DT)
> [    0.000000] pstate: 60400085 (nZCv daIf +PAN -UAO)
> [    0.000000] pc : __raw_readl+0x0/0x8
> [    0.000000] lr : gic_init_bases+0x110/0x4b0
> [    0.000000] sp : ffff800011973dd0
> [    0.000000] x29: ffff800011973dd0 x28: 0000000002150018
> [    0.000000] x27: 0000000000000018 x26: 0000000000000000
> [    0.000000] x25: 0000000000000002 x24: ffff010fe7ef6700
> [    0.000000] x23: 0000000000000000 x22: ffff800010dc3b90
> [    0.000000] x21: ffff010fef138020 x20: 00000000009b0404
> [    0.000000] x19: ffff80001198c508 x18: 0000000000000005
> [    0.000000] x17: 000000006fc20c07 x16: 0000000000000001
> [    0.000000] x15: 0000000000000010 x14: ffffffffffffffff
> [    0.000000] x13: ffff800091973b4f x12: ffff800011973b5c
> [    0.000000] x11: ffff800011989000 x10: 0000000000000080
> [    0.000000] x9 : ffff8000101991e4 x8 : 0000000000040000
> [    0.000000] x7 : 000000000000413d x6 : 0000000000000000
> [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
> [    0.000000] x3 : 0000000000000080 x2 : ffff8000119c1f10
> [    0.000000] x1 : ffff800011991a40 x0 : ffff800013c9000c
> [    0.000000] Call trace:
> [    0.000000]  __raw_readl+0x0/0x8
> [    0.000000]  gic_of_init+0x170/0x1f8
> [    0.000000]  of_irq_init+0x1e4/0x3c4
> [    0.000000]  irqchip_init+0x1c/0x40
> [    0.000000]  init_IRQ+0x164/0x194
> [    0.000000]  start_kernel+0x334/0x4cc
> 
> So avoid reading TYPER2 on GICv3.

I have reported this exact problem back in October:

https://lore.kernel.org/lkml/20191027144234.8395-1-maz@kernel.org/

and proposed a patch for it:

https://lore.kernel.org/lkml/20191027144234.8395-11-maz@kernel.org/

I've been repeatedly asking for Marvell/Cavium to come up with a
description of the issue so that we know the extent of the problem. So
far, all I've heard is the sound of crickets, which confirm my
impression that this HW is dead to its manufacturer and that they don't
want to support it. I'm not asking much though: just tell me what is
wrong (again!) with this CPU, which are the affected revisions, what is
the errata number and I'll deal with it.

I can't get that information. Can you?

I'm now proposing that we fully remove support for TX1 from the
mainline kernel, because every single bit of this CPU is completely
busted. Just look at the number of workarounds we have to carry around.
Without involvement from Marvell, this CPU is a liability for the rest
of the arm64 kernel (just look at what we have to do to enable KPTI
*because of TX1*, the amount of crap I added to KVM to fully emulate
the broken CPU interface, and plenty of other things).

I intend to propose such removal once 5.7-rc1 lands.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
