Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF572C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C446C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583917432;
	bh=ibkYfT8H8iwwHnGO0guecciLLSfXPKRIswI7WrzOsAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Kpqfcz4NPnVEKJxu91eNNl7bpNi8LQd1ur4quh08grTEWTuRAG8QzVzLVCj25cfTZ
	 zMxnlaBISnuYFPRlGBHJdTPd3RweSbyCruIPkrYsVPbru9V92S5onntczzk7M9cPP3
	 d53PBuZdGZGUAlXQiH28YSnWmntziHTyMaKMTBeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgCKJDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgCKJDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:03:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1A520873;
        Wed, 11 Mar 2020 09:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583917430;
        bh=ibkYfT8H8iwwHnGO0guecciLLSfXPKRIswI7WrzOsAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fqXpF49MGci3+/2P1nx05RN+C8Q7kAwE1N+DvnF1cM+9+DQmXANQlSecX4bDgB5Te
         UDGPbYKaFfd2wiuPtW52npjmWKskS+tC8pOAhkN0jD6YwZ7mSbLGwNgsWmNSMaq6dH
         Al/hCcA5OZoMyq9ueqOAbRQv/roYKcq5MtGN7tiQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBxHI-00BrMA-Ow; Wed, 11 Mar 2020 09:03:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Mar 2020 09:03:48 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 03/32] irqchip/gic-v3: Workaround Cavium TX1 erratum
 when reading GICD_TYPER2
In-Reply-To: <20200311084515.5vbfudbls3cj2cre@rric.localdomain>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-4-maz@kernel.org>
 <20200309221137.5pjh4vkc62ft3h2a@rric.localdomain>
 <b1b7db1f0e1c47b7d9e2dfbbe3409b77@kernel.org>
 <20200311084515.5vbfudbls3cj2cre@rric.localdomain>
Message-ID: <74682a83c75bc8e517462d181e6c24c7@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rrichter@marvell.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 2020-03-11 08:45, Robert Richter wrote:
> Hi Marc,
> 
> On 10.03.20 11:41:09, Marc Zyngier wrote:
>> On 2020-03-09 22:11, Robert Richter wrote:
>> > On 24.12.19 11:10:26, Marc Zyngier wrote:
> 
>> > > @@ -1502,6 +1512,12 @@ static const struct gic_quirk gic_quirks[] = {
>> > >  		.mask	= 0xffffffff,
>> > >  		.init	= gic_enable_quirk_hip06_07,
>> > >  	},
>> > > +	{
>> > > +		.desc	= "GICv3: Cavium TX1 GICD_TYPER2 erratum",
>> >
>> > There is no errata number yet.
>> 
>> Please let me know when/if you obtain one.
> 
> GIC-38539: GIC faults when accessing reserved GICD_TYPER2 register
> 
> Applies to (covered with iidr mask below):
> 
>  ThunderX: CN88xx
>  OCTEON TX: CN83xx, CN81xx
>  OCTEON TX2: CN93xx, CN96xx, CN98xx, CNF95xx*
> 
> Issue: Access to GIC reserved registers results in an exception.
> Notes:
> 1) This applies to other reserved registers too.
> 2) The errata number is unique over all IP blocks, so a macro
>    CAVIUM_ERRATUM_38539 is ok.

Great, thanks a lot for chasing this. One question though: does this
apply to the distributor only? Or to all reserved registers regardless
of the architectural block they are in?

It won't change the workaround for now, but knowing the scope of the
erratum will help future developments.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
