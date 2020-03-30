Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB51C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC0A2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585562658;
	bh=+5E2uDtgJracD2PnF70wbWvJ7gRXjEPw9tunBXPv0wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=m69/K84jr4wsV7hu+hy25k4v6+zk2dcx6AgZVvLtCw1dt+vOT3wpIzXf2uaBgQhs0
	 +eor0sQ00fSFf5ds6ufQh59hdbmBHqQ/ZFB6OUsyC5w9vKqkE4Mj0ie0aO9Dy5eK4j
	 UtZmJTHey/sDrsxH+D+PEm6hrIkeejzNU1BytzEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgC3KER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgC3KEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:04:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E18206E6;
        Mon, 30 Mar 2020 10:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585562656;
        bh=+5E2uDtgJracD2PnF70wbWvJ7gRXjEPw9tunBXPv0wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AGH8THsVKFyWxLzYdEo2Fa8Bp/GuoSzOXu4Bi3vAp6M1zIAO0SqG557QMDVpePOWH
         eGbnObAeXnVESpdj4RjW/9N37HmjYlsKMIsc79poLjAKNKj/2HNsjVMnNoxxk2xqoP
         1GXWhX9o209T3znVrY6PN8Z5HJ7oZ3J/3/nBYTB0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jIrHC-00Gpqi-7Y; Mon, 30 Mar 2020 11:04:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Mar 2020 11:04:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        x86 <x86@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [tip: irq/core] irqchip/xilinx: Enable generic irq multi handler
In-Reply-To: <44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com>
References: <20200317125600.15913-4-mubin.usman.sayyed@xilinx.com>
 <158551357076.28353.1716269552245308352.tip-bot2@tip-bot2>
 <083ad708-ea4d-ed53-598e-84d911ca4177@xilinx.com>
 <085188fea81d5ddc88b488124596a4a3@kernel.org>
 <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
 <ca0f62da-1e89-4fe8-5cb4-b7a86f97c5a3@xilinx.com>
 <21f1157d885071dcfdb1de0847c19e24@kernel.org>
 <44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com>
Message-ID: <2ee07d59d34be09be7653cbb553f26dc@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: michal.simek@xilinx.com, linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, tglx@linutronix.de, stefan.asserhall@xilinx.com, x86@kernel.org, sfr@canb.auug.org.au
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-30 10:27, Michal Simek wrote:
> On 30. 03. 20 11:19, Marc Zyngier wrote:
>> On 2020-03-30 10:12, Michal Simek wrote:
>>> On 30. 03. 20 11:03, Michal Simek wrote:

[...]

>>> One more thing. We could also get this function back and it will be 
>>> fine
>>> too. But up2you.
>> 
>> If you leave it up to me, I'll revert the whole series right now.
>> 
>> What I'd expect from you is to tell me exactly what is the minimal
>> change that keeps it working on both ARM, microblaze and PPC.
>> If it is a revert, tell me which patches to revert. if it is a patch
>> on top, send me the fix so that I can queue it now.
> 
> It won't be that simple. Please revert patches
> 
> 9c2d4f525c00 ("irqchip/xilinx: Do not call irq_set_default_host()")
> a0789993bf82 ("irqchip/xilinx: Enable generic irq multi handler")
> 
> And we should be fine.

Now reverted and pushed out. I'll send a pull request to Thomas 
tomorrow.

         M.
-- 
Jazz is not dead. It just smells funny...
