Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F311DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AE320772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591188301;
	bh=wznEth5LdDyFT2k6Sw+uElZFtO2dV9GyNCqcSvMWmiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oNGQNTy38O2syZlvmDBH+Vu6xT7OWTGHj7BuaEsI+jBjJ2R2eMcQdUxiZ9kD54GgB
	 MXFAJ/AE6odjhR+2CPGGJEjQ3fX0ujimNYjB2ipsKcMF8zYWm/GzuxkPbfk+LjinbM
	 NQ2gGxesHSM0tSXKSWXScSYomarrHC2iEWrHoHN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgFCMpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgFCMpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:45:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9684920678;
        Wed,  3 Jun 2020 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591188299;
        bh=wznEth5LdDyFT2k6Sw+uElZFtO2dV9GyNCqcSvMWmiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TqJZLS5KZ9qZJvkMiMjiz8zauZtj59/mrNXISG8AqBgMaf8/TuF8N+oZrprg8teTI
         4UID6E/9spmMnTEyVpOI9wvGbKsF36T3yX1UJtK7385ZNLwGPoz0I+aM7PPH4UnVoB
         4R8DDi7tJvwRzWGeYlcOU/FHpmjL9zY+rndY/WeQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jgSlO-00HS6q-6J; Wed, 03 Jun 2020 13:44:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Jun 2020 13:44:58 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Machulsky, Zorik" <zorik@amazon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
In-Reply-To: <87y2p5fatl.fsf@nanos.tec.linutronix.de>
References: <20200529015501.15771-1-alisaidi@amazon.com>
 <8c3be990888ecfb7cca9503853dc4aac@kernel.org>
 <2C4F431F-8140-4C82-B4BD-E51DE618FC08@amazon.com>
 <20200530174929.7bf6d5d7@why> <eed907d48de84c96e3ceb27c1ed6f622@kernel.org>
 <37e55e71faf76dc3db76d89c20c1bdfff942e380.camel@amazon.com>
 <87y2p5fatl.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <d08bd61ffffe59091f6542b4f75292d1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, benh@amazon.com, alisaidi@amazon.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dwmw@amazon.co.uk, zeev@amazon.com, zorik@amazon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-02 21:54, Thomas Gleixner wrote:
> "Herrenschmidt, Benjamin" <benh@amazon.com> writes:
>> On Sun, 2020-05-31 at 12:09 +0100, Marc Zyngier wrote:
>>> > The semantic of activate/deactivate (which maps to started/shutdown
>>> > in the IRQ code) is that the HW resources for a given interrupt are
>>> > only committed when the interrupt is activated. Trying to perform
>>> > actions involving the HW on an interrupt that isn't active cannot be
>>> > guaranteed to take effect.
>>> >
>>> > I'd rather address it in the core code, by preventing set_affinity (and
>>> > potentially others) to take place when the interrupt is not in the
>>> > STARTED state. Userspace would get an error, which is perfectly
>>> > legitimate, and which it already has to deal with it for plenty of
>>> > other
>>> > reasons.
>> 
>> So I finally found time to dig a bit in there :) Code has changed a 
>> bit
>> since last I looked. But I have memories of the startup code messing
>> around with the affinity, and here it is. In irq_startup() :
>> 
>> 
>> 		switch (__irq_startup_managed(desc, aff, force)) {
>> 		case IRQ_STARTUP_NORMAL:
>> 			ret = __irq_startup(desc);
>> 			irq_setup_affinity(desc);
>> 			break;
>> 		case IRQ_STARTUP_MANAGED:
>> 			irq_do_set_affinity(d, aff, false);
>> 			ret = __irq_startup(desc);

Grump. Nice catch. In hindsight, this is obvious, as managed interrupts
may have been allocated to target CPUs that have been hot-plugged off.

>> 			break;
>> 		case IRQ_STARTUP_ABORT:
>> 			irqd_set_managed_shutdown(d);
>> 			return 0;
>> 
>> So we have two cases here. Normal and managed.
>> 
>> In the managed case, we set the affinity before startup. I feel like 
>> your
>> patch might break that or am I missing something ?
> 
> It will break stuff because the affinity is not stored in case that the
> interrupt is not started.
> 
> I think we can fix this in the core code but that needs more thought.
> __irq_can_set_affinity() is definitely the wrong place.

Indeed. I completely missed the above. Back to square one.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
