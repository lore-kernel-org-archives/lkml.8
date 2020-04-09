Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2149C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7451A2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586431068;
	bh=8Ug6GC5kIzXNDcpmlUlWmetp+Yosb2nlpMdk9+yDKt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=I0MSbwYPj4W5IvF7JHoIo2Vxroo8cq8a7C8gd0jUs6XOcLnSHICnNSIGeVhHpsibe
	 90yspvwZ/oPk6Vn0inRo3CwZ+vGGBzAppLmqzolTxtCEpK8A6qoyyfYK5/qg9vatXG
	 GzcO1ZoC0wbDVA52Fpt2Z7TiZtegi+xUdm+gv4jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDILRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDILRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:17:46 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6398320B1F;
        Thu,  9 Apr 2020 11:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586431066;
        bh=8Ug6GC5kIzXNDcpmlUlWmetp+Yosb2nlpMdk9+yDKt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ctufLEy1uCQSKe1nAzuhT+y5VHQOdlCiK99NoyJ0WIg40r+EiJDhsuimSQZ1zdOuQ
         FwZQWyS81yBA56/MOvtHKMLRuatS1bNYsNKhFzzydx4qETOvcMymWLzzrOLxpIdR8S
         VYZSWTFuc4bowJJVn9HqZr/mikD0qsEVfKW6TSDY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jMVBo-001t7x-LJ; Thu, 09 Apr 2020 12:17:44 +0100
Date:   Thu, 9 Apr 2020 12:17:43 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] irqchip/ti-sci-inta: fix processing of masked irqs
Message-ID: <20200409121743.10bbcc9a@why>
In-Reply-To: <851d5063-475e-ea7b-6609-684b08283550@ti.com>
References: <20200408191532.31252-1-grygorii.strashko@ti.com>
        <20200409103144.3b2169bf@why>
        <851d5063-475e-ea7b-6609-684b08283550@ti.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: grygorii.strashko@ti.com, nm@ti.com, peter.ujfalusi@ti.com, jason@lakedaemon.net, lokeshvutla@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, ssantosh@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 14:11:12 +0300
Grygorii Strashko <grygorii.strashko@ti.com> wrote:

> On 09/04/2020 12:31, Marc Zyngier wrote:
> > On Wed, 8 Apr 2020 22:15:32 +0300
> > Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> >   
> >> The ti_sci_inta_irq_handler() does not take into account INTA IRQs state
> >> (masked/unmasked) as it uses INTA_STATUS_CLEAR_j register to get INTA IRQs
> >> status, which provides raw status value.
> >> This causes hard IRQ handlers to be called or threaded handlers to be
> >> scheduled many times even if corresponding INTA IRQ is masked.
> >> Above, first of all, affects the LEVEL interrupts processing and causes
> >> unexpected behavior up the system stack or crash.
> >>
> >> Fix it by using the Interrupt Masked Status INTA_STATUSM_j register which
> >> provides masked INTA IRQs status.
> >>
> >> Fixes: 9f1463b86c13 ("irqchip/ti-sci-inta: Add support for Interrupt Aggregator driver")
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>  
> > 
> > Given the failure mode, doesn't this deserve a Cc stable?  
> 
> Sorry, was not sure how it works here.
> "Fixes" tag now is usually enough to get included in stable.
> Any way, I'll track it and if not included will re-send for stable.

Last time I asked, Greg was adamant that a Cc: stable was needed to
guarantee a backport. In some cases, the patch is picked up anyway, but
it doesn't hurt to have the stable tag if you think it should be
backported.

Anyway, I've now added such tag.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
