Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E86C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0E520B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586424444;
	bh=HatT2IdEBwyftwxp9Qj7Ct8wNjI44BrpEB0SS+p2Wvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y7DBGs77ESUEHxK69Tk5H5V4SNk5+nF1aQHMhip5CtBjymBZ/1xkGp8zu+fyb+sjv
	 Lq98h2IZelYfMMJeAe2yLlcKJjC68S45o1qZqyz+mfiiaQ9mYT+h3ahfd2hpYX9FYG
	 LOF/F4ffHVLhHWAm4QAVZupO5DwuwNWWc5p9wTXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDIJ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgDIJ1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:27:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3BD2084D;
        Thu,  9 Apr 2020 09:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586424442;
        bh=HatT2IdEBwyftwxp9Qj7Ct8wNjI44BrpEB0SS+p2Wvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TLFe7cjISdDfygUXXw4Y6MFcf5o9XaOAqzIq9ONFlagDTpgXEeRc4gFBW9ptsjv8x
         UIhFV3rYUZtIKwNrwy/3GJGODr+7nxupmFqxAr1HTXRv+sT1RuhlWvZE+Zo4yhYD0g
         zGLj+0PWfupBIrp+Xl2z4GJR5YYgTjYoeoFrTpQA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jMTSy-001rhe-AC; Thu, 09 Apr 2020 10:27:20 +0100
Date:   Thu, 9 Apr 2020 10:27:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wuyun.wu@huawei.com>,
        <wanghaibin.wang@huawei.com>
Subject: Re: [PATCH] irqchip/mbigen: Free msi_desc on device teardown
Message-ID: <20200409102718.73875cd9@why>
In-Reply-To: <20200408114352.1604-1-yuzenghui@huawei.com>
References: <20200408114352.1604-1-yuzenghui@huawei.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, wuyun.wu@huawei.com, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 19:43:52 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

Hi Zenghui,

> Using irq_domain_free_irqs_common() on the irqdomain free path will
> leave the MSI descriptor unfreed when platform devices get removed.
> Properly free it by MSI domain free function.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 6b566bba263b..ff7627b57772 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -220,10 +220,16 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
>  	return 0;
>  }
>  
> +static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs)
> +{
> +	platform_msi_domain_free(domain, virq, nr_irqs);
> +}
> +
>  static const struct irq_domain_ops mbigen_domain_ops = {
>  	.translate	= mbigen_domain_translate,
>  	.alloc		= mbigen_irq_domain_alloc,
> -	.free		= irq_domain_free_irqs_common,
> +	.free		= mbigen_irq_domain_free,
>  };
>  
>  static int mbigen_of_create_domain(struct platform_device *pdev,

Should this deserve a:

Fixes: 9650c60ebfec0 ("irqchip/mbigen: Create irq domain for each
mbigen device")

Otherwise queued for post -rc1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
