Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11C0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943CE20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590597536;
	bh=HImJ4+KBT1EItcn7tHo4ZDvj8h7g5bsCnSP3idyTnU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=S7KJZ2DAl1cXbMk09vGm5HAjk/CJr96YedmnbsX8MgeSTNnOuic6wZB3bYrYSs7RY
	 wd1PatAr+dZxodLzLXNc6k9q6SY0xOZ1DJIGT7G9vWuczJMFYUCku/W4KHSbcapXd7
	 0Wa0SU/cxf33I1lkY/y6N1axZRHGZUl9rjzz26Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391313AbgE0Qiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgE0Qiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:38:55 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6249F2084C;
        Wed, 27 May 2020 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590597534;
        bh=HImJ4+KBT1EItcn7tHo4ZDvj8h7g5bsCnSP3idyTnU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ziHCJc/BkN4BvcBfyp/vV678CKeJooERoRC/JHPfVI9uPFNE7ChPPE7R71siTdQ6T
         eDlmgsW+zRblIqKUT6Sz2ocsAh5noae3yuV9twRi95GCuRjNeeItJF7oczZwe2nJfv
         +yOmrJLGSpSBagyJ0EJQpyFCk/SP5A24OdyZK8s0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jdz4u-00FlZB-JU; Wed, 27 May 2020 17:38:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 May 2020 17:38:52 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] irqchip/irq-mtk-sysirq: drop unnecessary spinlock
In-Reply-To: <20200527161743.15972-1-brgl@bgdev.pl>
References: <20200527161743.15972-1-brgl@bgdev.pl>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <58fca7418c8d18392562aaad2c3a6634@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: brgl@bgdev.pl, tglx@linutronix.de, jason@lakedaemon.net, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, fparent@baylibre.com, stephane.leprovost@mediatek.com, pedro.tsai@mediatek.com, andrew.perepech@mediatek.com, bgolaszewski@baylibre.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-27 17:17, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This driver takes a regular spinlock when a raw spinlock is already
> taken which results in the following lockdep splat:
> 
> =============================
> [ BUG: Invalid wait context ]
> 5.7.0-rc6-02446-gb9827c0a9fe7-dirty #1 Not tainted
> -----------------------------
> swapper/0/0 is trying to lock:
> ffffff800303b798 (&chip_data->lock){....}-{3:3}, at:
> mtk_sysirq_set_type+0x48/0xc0
> other info that might help us debug this:
> context-{5:5}
> 2 locks held by swapper/0/0:
>  #0: ffffff800302ee68 (&desc->request_mutex){....}-{4:4}, at:
> __setup_irq+0xc4/0x8a0
>  #1: ffffff800302ecf0 (&irq_desc_lock_class){....}-{2:2}, at:
> __setup_irq+0xe4/0x8a0
> stack backtrace:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
> 5.7.0-rc6-02446-gb9827c0a9fe7-dirty #1
> Hardware name: Pumpkin MT8516 (DT)
> Call trace:
>  dump_backtrace+0x0/0x180
>  show_stack+0x14/0x20
>  dump_stack+0xd0/0x118
>  __lock_acquire+0x8c8/0x2270
>  lock_acquire+0xf8/0x470
>  _raw_spin_lock_irqsave+0x50/0x78
>  mtk_sysirq_set_type+0x48/0xc0
>  __irq_set_trigger+0x58/0x170
>  __setup_irq+0x420/0x8a0
>  request_threaded_irq+0xd8/0x190
>  timer_of_init+0x1e8/0x2c4
>  mtk_gpt_init+0x5c/0x1dc
>  timer_probe+0x74/0xf4
>  time_init+0x14/0x44
>  start_kernel+0x394/0x4f0
> 
> We don't need the spinlock here - the irq_set_type() callback is always
> called with the irq_desc->lock taken. This removes the spinlock 
> entirely.

It looks really great. Not.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/irqchip/irq-mtk-sysirq.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c 
> b/drivers/irqchip/irq-mtk-sysirq.c
> index 73eae5966a40..da2fc4809222 100644
> --- a/drivers/irqchip/irq-mtk-sysirq.c
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> @@ -12,10 +12,8 @@
>  #include <linux/of_address.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> -#include <linux/spinlock.h>
> 
>  struct mtk_sysirq_chip_data {
> -	spinlock_t lock;
>  	u32 nr_intpol_bases;
>  	void __iomem **intpol_bases;
>  	u32 *intpol_words;
> @@ -30,14 +28,12 @@ static int mtk_sysirq_set_type(struct irq_data
> *data, unsigned int type)
>  	u8 intpol_idx = chip_data->intpol_idx[hwirq];
>  	void __iomem *base;
>  	u32 offset, reg_index, value;
> -	unsigned long flags;
>  	int ret;
> 
>  	base = chip_data->intpol_bases[intpol_idx];
>  	reg_index = chip_data->which_word[hwirq];
>  	offset = hwirq & 0x1f;
> 
> -	spin_lock_irqsave(&chip_data->lock, flags);
>  	value = readl_relaxed(base + reg_index * 4);
>  	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_EDGE_FALLING) {
>  		if (type == IRQ_TYPE_LEVEL_LOW)
> @@ -53,7 +49,6 @@ static int mtk_sysirq_set_type(struct irq_data
> *data, unsigned int type)
> 
>  	data = data->parent_data;
>  	ret = data->chip->irq_set_type(data, type);
> -	spin_unlock_irqrestore(&chip_data->lock, flags);
>  	return ret;
>  }
> 
> @@ -212,7 +207,6 @@ static int __init mtk_sysirq_of_init(struct
> device_node *node,
>  		ret = -ENOMEM;
>  		goto out_free_which_word;
>  	}
> -	spin_lock_init(&chip_data->lock);
> 
>  	return 0;

Sight... Do you realize that these two locks do not protect the same
thing at all? One protects the interrupt data, and the other protects
the MMIO register which is shared between multiple interrupts, and
on which the driver performs a RMW.

Thanks to the removal of this spinlock, two irq_set_type() can execute
in parallel and silently corrupt the register. Not exactly an 
improvement.

         M.
-- 
Jazz is not dead. It just smells funny...
