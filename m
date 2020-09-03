Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275ABC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A8F2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599120687;
	bh=rJxGAzsygQT4RNJ8/7eqK5SedYsnLFAZPBmD/dAfqfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bbOkMJePeXUsnEx106oSFeZiwAeCQf+C71ENVdzSsVMoE474wcYm4kAffkWph7Sco
	 i2oOY0Aa7SsFnTLBq0QzCJQLUq4Jj5FWGEKIq7H3OSp2ttlbJZ0bwH3/WKv/wjaNhj
	 vekTWLvNDPRczjTDeTNyN6dvjCe3nUTnIEgbuyeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgICILO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbgICIKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:10:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0612A206C0;
        Thu,  3 Sep 2020 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599120619;
        bh=rJxGAzsygQT4RNJ8/7eqK5SedYsnLFAZPBmD/dAfqfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0BGrv3PLDaa+QK2PDuDfal9bNknNJggPGAdJVKr2IdzelOIszG1+gyl/oCkri07ik
         WO9AJUCDpZG0yN9t920xkrBs1Rz8aS+E3zW4h5gpLDJYCko4T6LYrxFNEe86NpmYu+
         o20F2NjvMBpEKd39CupSny3jKDhl+9l+aBsDQNJo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDkK1-008pUu-1u; Thu, 03 Sep 2020 09:10:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Sep 2020 09:10:16 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/tango: Fix possible null ptr reference in
 tangox_irq_init
In-Reply-To: <20200903015952.308888-1-yebin10@huawei.com>
References: <20200903015952.308888-1-yebin10@huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <25ddba499eaec2db3a70343c82669635@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yebin10@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-03 02:59, Ye Bin wrote:
> In tangox_irq_init allocate chip but not test.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  drivers/irqchip/irq-tango.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
> index 34290f09b853..25da120230ad 100644
> --- a/drivers/irqchip/irq-tango.c
> +++ b/drivers/irqchip/irq-tango.c
> @@ -187,6 +187,8 @@ static int __init tangox_irq_init(void __iomem
> *base, struct resource *baseres,
>  		panic("%pOFn: failed to get address", node);
> 
>  	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		panic("%pOFn: failed to get chip", node);
>  	chip->ctl = res.start - baseres->start;
>  	chip->base = base;

So you are trading a panic for a panic? What is the point?
A failing kzalloc already gives you all the information you may
need.

         M.
-- 
Jazz is not dead. It just smells funny...
