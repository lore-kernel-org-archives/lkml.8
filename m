Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79742C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7BE2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593003055;
	bh=+Kf1QO6wgC2hEGOUt0o6CDJuByakQhbWMS2qb5q4egs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bv/mVbyH3JP/U7YnuijcZYrNxOLM2J6ViPiQB3jNNPfF4sUKtdy6Ml+xgBMpFDNDO
	 yUPKpw9CUFd3oTnwiGixZ91P1aIPR6nIr9dYGGv2NOxQtpbB4X/rsUx3JvCY+SQkoh
	 8kvDJnYBB5xVuyyldDvtRUXiGb3k3DqTme/i9vCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390889AbgFXMuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390845AbgFXMuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:50:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E2620663;
        Wed, 24 Jun 2020 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593003050;
        bh=+Kf1QO6wgC2hEGOUt0o6CDJuByakQhbWMS2qb5q4egs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KexdEXajkBXXkeJHwCLviB9dTD51SZqHb8XJi6GVgBXNgsjULPBftkc0BH5bpeWLE
         E8ijx24xCKlZTug1Mtc61oVCw2GfLQGPm4rpURBMcYk7gsgmS1LgtS4pFkij1G+v4C
         Ctyam3S+A5Wq516L02qIULTEP32y9k3tu/CqGMqc=
Date:   Wed, 24 Jun 2020 13:50:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     mark.rutland@arm.com, tuanphan@os.amperecomputing.com,
        john.garry@huawei.com, linux-kernel@vger.kernel.org,
        shameerali.kolothum.thodi@huawei.com, harb@amperecomputing.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] perf/smmuv3: Fix shared interrupt handling
Message-ID: <20200624125045.GC6270@willie-the-truck>
References: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
 <b7d056f7-3a3d-568d-ea6d-24bb30b4761b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d056f7-3a3d-568d-ea6d-24bb30b4761b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:48:14PM +0100, Robin Murphy wrote:
> On 2020-04-08 17:49, Robin Murphy wrote:
> > IRQF_SHARED is dangerous, since it allows other agents to retarget the
> > IRQ's affinity without migrating PMU contexts to match, breaking the way
> > in which perf manages mutual exclusion for accessing events. Although
> > this means it's not realistically possible to support PMU IRQs being
> > shared with other drivers, we *can* handle sharing between multiple PMU
> > instances with some explicit affinity bookkeeping and manual interrupt
> > multiplexing.
> > 
> > RCU helps us handle interrupts efficiently without having to worry about
> > fine-grained locking for relatively-theoretical race conditions with the
> > probe/remove/CPU hotplug slow paths. The resulting machinery ends up
> > looking largely generic, so it should be feasible to factor out with a
> > "system PMU" base class for similar multi-instance drivers.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > RFC because I don't have the means to test it, and if the general
> > approach passes muster then I'd want to tackle the aforementioned
> > factoring-out before merging anything anyway.
> 
> Any comments on whether it's worth pursuing this?

Sorry, I don't really get the problem that it's solving. Is there a crash
log somewhere I can look at? If all the users of the IRQ are managed by
this driver, why is IRQF_SHARED dangerous?

Will
