Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B087C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C7024958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942399;
	bh=T/l+fD4/K8YZbH77q/ovCCx3TaSkpiQDkUX6Bjk+iLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=umnqzRDrjrPVqkVsgvne9inYMpQkFTUYAgBrEBvGG+zjXzGTtxxdl3q7qZOFpZNaG
	 44s4VUfiCpgivrG6HJbenrcTAPuwpYKUT67mCmLtxZ5Awnt3y0vRARXNDqwmxuPwgv
	 E61TemMNepH/nM1fBzhxLY1BmVP4kmo2UB3sj0bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgEHMxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbgEHMxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:53:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7161A2497A;
        Fri,  8 May 2020 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942389;
        bh=T/l+fD4/K8YZbH77q/ovCCx3TaSkpiQDkUX6Bjk+iLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VfDHB1iXxDHwPKzKtS+ZeRTqv9BIzr+1BPvZ4ocT6i25RmWw2k4vb1VmuV5QuLTFz
         Pz0CrBxAzSR8Rw0hyiNGS0TG8X9Eld28yi2rodHhXQOBlcwujS1KGj7280E8XLZASW
         yp7QpQZZIhua+aeWKsO7Va13V5ZbnXK4Pk+38qyA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jX2V1-00AblO-Rv; Fri, 08 May 2020 13:53:07 +0100
Date:   Fri, 8 May 2020 13:53:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Query regarding pseudo nmi support on GIC V3 and request_nmi()
Message-ID: <20200508135306.1936b09b@why>
In-Reply-To: <27ecf3b0-4bb4-e89d-2ca9-3828cdcb2834@codeaurora.org>
References: <2a0d5719-b2c7-1287-e0b5-2dd8b1072e49@codeaurora.org>
        <87ftca1z9k.wl-maz@kernel.org>
        <2f41b2e8-925e-3869-da39-fd4ab28ca1b1@codeaurora.org>
        <20200508132740.2d645ea2@why>
        <27ecf3b0-4bb4-e89d-2ca9-3828cdcb2834@codeaurora.org>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: neeraju@codeaurora.org, julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 18:09:00 +0530
Neeraj Upadhyay <neeraju@codeaurora.org> wrote:

> Hi Marc,
> 
> On 5/8/2020 5:57 PM, Marc Zyngier wrote:
> > On Fri, 8 May 2020 16:36:42 +0530
> > Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
> >   
> >> Hi Marc,
> >>
> >> On 5/8/2020 4:15 PM, Marc Zyngier wrote:  
> >>> On Thu, 07 May 2020 17:06:19 +0100,
> >>> Neeraj Upadhyay <neeraju@codeaurora.org> wrote:  
> >>>>
> >>>> Hi,
> >>>>
> >>>> I have one query regarding pseudo NMI support on GIC v3; from what I
> >>>> could understand, GIC v3 supports pseudo NMI setup for SPIs and PPIs.
> >>>> However the request_nmi() in irq framework requires NMI to be per cpu
> >>>> interrupt source (it checks for IRQF_PERCPU). Can you please help
> >>>> understand this part, how SPIs can be configured as NMIs, if there is
> >>>> a per cpu interrupt source restriction?  
> >>>
> >>> Let me answer your question by another question: what is the semantic
> >>> of a NMI if you can't associate it with a particular CPU?  
> >>>   >>  
> >> I was actually thinking of a use case, where, we have a watchdog
> >> interrupt (which is a SPI), which is used for detecting software
> >> hangs and cause device reset; If that interrupt's current cpu
> >> affinity is on a core, where interrupts are disabled, we won't be
> >> able to serve it; so, we need to group that interrupt as an fiq;  
> > 
> > Linux doesn't use Group-0 interrupts, as they are strictly secure
> > (unless your SoC doesn't have EL3, which I doubt).  
> 
> Yes, we handle that watchdog interrupt as a Group-0 interrupt, which
> is handled as fiq in EL3.
> 
> >   
> >> I was thinking, if its feasible to mark that interrupt as pseudo
> >> NMI and route it to EL1 as irq. However, looks like that is not the
> >> semantic of a NMI and we would need something like pseudo NMI ipi
> >> for this.  
> > 
> > Sending a NMI IPI from another NMI handler? Even once I've added
> > these, there is no way this will work for that particular scenario.
> > Just look at the restrictions we impose on NMIs.
> >   
> 
> Sending a pseudo NMI IPI (to EL1) from fiq handler (which runs in
> EL3); I will check, but do you think, that might not work?

How do you know, from EL3, what to write in memory so that the NMI
handler knows what you want to do? Are you going to parse the S1 page
tables? Hard-code the behaviour of some random Linux version in your
legendary non-updatable firmware? This isn't an acceptable behaviour.

An IPI is between two CPUs used by the same SW entitiy. What runs at
EL3 is completely alien to Linux, and so is Linux to EL3. If you want
to IPI, send Group-0 IPIs that are private to the firmware.

If you want to inject NMI-type exceptions into EL1, you can always try
SDEI (did I actually write this? Help!). But given your use case below,
that wouldn't work either.

> > Frankly, if all you need to do is to reset the SoC, use EL3
> > firmware. That is what it is for.
> >   
> 
> Before triggering SoC reset, we want to collect certain  EL1 debug
> information like stack trace for CPUs and other debug information.

Frankly, if you are going to reset the SoC because EL1/EL2 has gone
bust, how can you trust it to do anything sensible when injecting an
interrupt?. Once you take a SPI at EL3, gather whatever state you want
from EL3. Do not involve EL1 at all.

	M.
-- 
Jazz is not dead. It just smells funny...
