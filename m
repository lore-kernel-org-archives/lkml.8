Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98CBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923BC2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585909130;
	bh=RO5qFxGEAhe7sc5dP8ijSZuqx2o+C7z3RagoGe96ce4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sLlAnKWs1YdOCQwxTw5yA9QPQzWvvm3rxecPinu82qxiRRpzd1cSTU9Yxmo4sXnWz
	 +tMh8hn+QjJuApj+3bThoc0PU+/jayMjjkDrTlhPm413Y8vdBszXsVCGjmDYZndij+
	 ba3RwMBn68imQ1vHeeJFHxGeGbjp1u/1lXtYYvIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgDCKSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgDCKSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:18:46 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 336FE2073B;
        Fri,  3 Apr 2020 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585909125;
        bh=RO5qFxGEAhe7sc5dP8ijSZuqx2o+C7z3RagoGe96ce4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2O0x/Rmwj692FzKaUD7ywOxIZQvcu53sPHlXjEjIlShObU4sFOWKnrsKrAgctOhyu
         akTamW7FymNkpQgHnCz4LcW+0wyFBrHDeonhr9QGBkmz5UPHK3gfsG3/yDiG60zyV5
         177S2VE3YmUZgxBaXN3ei/D6L2m9weJs85y+Psvw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jKJPP-000T70-DR; Fri, 03 Apr 2020 11:18:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 03 Apr 2020 11:18:43 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?Lu=C3=ADs_Matallui?= <matallui@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Help with IRQ-MSI-IRQ bridges
In-Reply-To: <CAE3Pknn88NZNqiaHahM4HVvTU82hdMcbhGWWb4AyXXYMbcGuaQ@mail.gmail.com>
References: <CAE3Pknn88NZNqiaHahM4HVvTU82hdMcbhGWWb4AyXXYMbcGuaQ@mail.gmail.com>
Message-ID: <3ebbe879471898218f34918b1d009887@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: matallui@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 2020-04-03 02:35, Luís Matallui wrote:
> Hi,
> 
> I've got this SoC which uses IRQ-MSI and MSI-IRQ bridges in order to
> get interrupts from devices external to the ARM subsystem.
> I already got some pointers from Maz and have been able to create the
> drivers with the stacked domains and can now see the mappings working
> fine across domains.
> 
> Maz pointed me to the Marvell mvebu-gicp (for my MSI controller, a.k.a
> MSI-IRQ bridge) and to mvebu-icu for the MSI client (IRQ-MSI bridge).
> 
> I now have the interrupts working, but it seems like I'm missing a
> bunch of them. And therefore my device doesn't work properly.
> The main difference between my HW and Marvell's is that my IRQs are
> not level-triggered and the MSIs don't support the two messages for
> level-triggered interrupts.

Which is probably a very good thing, as long as all your devices 
generate
only edge-triggered interrupts.

> 
> To illustrate my system:
> 
> DEV --line--> IRQ-MSI Bridge (MSIC) --msi--> MSI-IRQ Bridge (GICP)
> --line--> GICv2
> 
> For MSIC, all I can do is configure the address and data for the MSI,
> and I believe on every rising edge of the Device IRQ, an MSI is sent.
> For GICP, all I have is a doorbell and a way to enable/disable it, and
> whenever the doorbell is enabled and has a value != 0, the IRQ line to
> GICv2 gets asserted.
> 
> The first thing I noticed is that when I get an interrupt, the IRQ
> flow goes like:
> 
>   handle_irq();
>   irq_eoi();
> 
> So, I guess my first question here is, how can I guarantee that I
> don't get another MSI whilst in handle_irq()?

At the GIC level, once the interrupt is Ack'd, anything that is signed
after this ack is a separate interrupt. It will be made pending and will
fire once the GIC driver EOIs the first one.

> If I do, then I will clear the doorbell on irq_eoi() (because that's
> my only choice) and will lose the queued IRQs.

Why do you need to do anything at the doorbell level? This is just a 
write,
so there should be nothing to clear. If you do need to clear anything,
then your MSI-IRQ bridge isn't stateless as it should, and you'll need 
to
give much more details about the HW. Do you have a pointer to the TRM
for your HW?

> It also seems that I'm missing IRQs in the beginning after probing the
> device, and before it was working for me when I was setting up all
> these registers manually and simply using GICv2 as my only interrupt
> controller.

Well, setting all of this in firmware is always the preferred option
if you don't expect things to change dynamically.

> I do see the unmask() ops being called for all my stacked irqchips, so
> I don't understand how I'm missing so many interrupts.

unmask is just a static configuration to enable the interrupt. There 
shouldn't
be that many calls to that later on unless an endpoint driver 
disables/enables
interrupts by hand.

Please give us a bit more details to understand the context, as there is 
only
so much I can do with so little HW information.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
