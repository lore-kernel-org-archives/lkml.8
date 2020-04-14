Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3876C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF9120732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LoFK+I6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440997AbgDNPwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440987AbgDNPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:52:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224AC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:52:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so10635792wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=uN0TIUWhXWSobokMdn3Cae3WuG2MAfFXZCbP4BbRQYI=;
        b=LoFK+I6tpK526IXb/HJ63KdTycL+qUFmUZnxNw8NLro/U5V6BX/SlkDOLyAHVMnLyf
         MQYdOgBvWW1X/L60TkRCc9MqA++270r6iAJ3ZRwlPKb1/NPM6Nk2MqPxCkRV8WjFlNN6
         ZmRklPNnVF95N1yZaY2U9UjqlzubGJnw5Jt+14k6JqanWr1bFHv/r0ULo10OafDMXHkX
         SrTjzKM4L3IwKydPOEyvOOf2opVI6J5Tcf7pES5Rk7x84jK1sssdWh6SsSSs9ArEwZGc
         Hqej7gJERbL+fmTeMb5jyNoQPzFB1ZaF6WXrzEjkYZTX5y6yd8dZtcwIFWIVXqu9aSKd
         RnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=uN0TIUWhXWSobokMdn3Cae3WuG2MAfFXZCbP4BbRQYI=;
        b=HXxfjZwDyqJ1hzit3Uo/U0XCiFeOC3cg2LIVFXIhMVHX+1n9m6gfw7hKmF53y9DKRm
         XJfC9N71oUwLeDE410yNyQTu/YJ79G0XgmvZCIW6q+qgxARZdIPEvwNrmNkBbGpfmTF8
         Q8GK8obU9sOTgYM7ImkHnS13+BIb7ExoT3xD2bkQD4s4vo3CQJ7plRXgWwgTa6w7yhpR
         3LcJAOVzpTtVZogBpwVu1HkWt6ElfI3lTJO36jXswfANnhe4S5VbUX1AMYjdAWW8ibvz
         /SLtRcZdsSfnUnTF/RW/i6bT3AXFlvlVmjJj6EX7lHss+W9RjqGs/BOSA1rknuRwLZxQ
         wvtA==
X-Gm-Message-State: AGi0PubpAeP36Q69z5CTeClMVllIxCmdPFNHnt5Gg4Oa+qrD8cPhHkyR
        mM/iAr/pVAhkddGkj+pwK3Dr7w==
X-Google-Smtp-Source: APiQypJtqRV/cPyJgxPWg14A9VkXjv2ap4pSZVR4LkFlYNdUgsM2F2H1r9AIWBy+S8TWH93JMDygBQ==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr10074700wrr.160.1586879547477;
        Tue, 14 Apr 2020 08:52:27 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id n124sm19673794wma.11.2020.04.14.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 08:52:26 -0700 (PDT)
References: <20200407144658.829246-1-maz@kernel.org> <20200414142018.6e7e5ec3@why>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] irqchip/meson-gpio: Fix HARDIRQ-safe -> HARDIRQ-unsafe lock order
In-reply-to: <20200414142018.6e7e5ec3@why>
Date:   Tue, 14 Apr 2020 17:52:25 +0200
Message-ID: <1jeesqt686.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 14 Apr 2020 at 15:20, Marc Zyngier <maz@kernel.org> wrote:

> On Tue,  7 Apr 2020 15:46:58 +0100
> Marc Zyngier <maz@kernel.org> wrote:
>
> +Jerome, Martin,
>
>> Running a lockedp-enabled kernel on a vim3l board (Amlogic SM1)
>> leads to the following splat:
>> 
>> [   13.557138] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>> [   13.587485] ip/456 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>> [   13.625922] ffff000059908cf0 (&irq_desc_lock_class){-.-.}-{2:2}, at: __setup_irq+0xf8/0x8d8
>> [   13.632273] which would create a new lock dependency:
>> [   13.637272]  (&irq_desc_lock_class){-.-.}-{2:2} -> (&ctl->lock){+.+.}-{2:2}
>> [   13.644209]
>> [   13.644209] but this new dependency connects a HARDIRQ-irq-safe lock:
>> [   13.654122]  (&irq_desc_lock_class){-.-.}-{2:2}
>> [   13.654125]
>> [   13.654125] ... which became HARDIRQ-irq-safe at:
>> [   13.664759]   lock_acquire+0xec/0x368
>> [   13.666926]   _raw_spin_lock+0x60/0x88
>> [   13.669979]   handle_fasteoi_irq+0x30/0x178
>> [   13.674082]   generic_handle_irq+0x38/0x50
>> [   13.678098]   __handle_domain_irq+0x6c/0xc8
>> [   13.682209]   gic_handle_irq+0x5c/0xb0
>> [   13.685872]   el1_irq+0xd0/0x180
>> [   13.689010]   arch_cpu_idle+0x40/0x220
>> [   13.692732]   default_idle_call+0x54/0x60
>> [   13.696677]   do_idle+0x23c/0x2e8
>> [   13.699903]   cpu_startup_entry+0x30/0x50
>> [   13.703852]   rest_init+0x1e0/0x2b4
>> [   13.707301]   arch_call_rest_init+0x18/0x24
>> [   13.711449]   start_kernel+0x4ec/0x51c
>> [   13.715167]
>> [   13.715167] to a HARDIRQ-irq-unsafe lock:
>> [   13.722426]  (&ctl->lock){+.+.}-{2:2}
>> [   13.722430]
>> [   13.722430] ... which became HARDIRQ-irq-unsafe at:
>> [   13.732319] ...
>> [   13.732324]   lock_acquire+0xec/0x368
>> [   13.735985]   _raw_spin_lock+0x60/0x88
>> [   13.739452]   meson_gpio_irq_domain_alloc+0xcc/0x290
>> [   13.744392]   irq_domain_alloc_irqs_hierarchy+0x24/0x60
>> [   13.749586]   __irq_domain_alloc_irqs+0x160/0x2f0
>> [   13.754254]   irq_create_fwspec_mapping+0x118/0x320
>> [   13.759073]   irq_create_of_mapping+0x78/0xa0
>> [   13.763360]   of_irq_get+0x6c/0x80
>> [   13.766701]   of_mdiobus_register_phy+0x10c/0x238 [of_mdio]
>> [   13.772227]   of_mdiobus_register+0x158/0x380 [of_mdio]
>> [   13.777388]   mdio_mux_init+0x180/0x2e8 [mdio_mux]
>> [   13.782128]   g12a_mdio_mux_probe+0x290/0x398 [mdio_mux_meson_g12a]
>> [   13.788349]   platform_drv_probe+0x5c/0xb0
>> [   13.792379]   really_probe+0xe4/0x448
>> [   13.795979]   driver_probe_device+0xe8/0x140
>> [   13.800189]   __device_attach_driver+0x94/0x120
>> [   13.804639]   bus_for_each_drv+0x84/0xd8
>> [   13.808474]   __device_attach+0xe4/0x168
>> [   13.812361]   device_initial_probe+0x1c/0x28
>> [   13.816592]   bus_probe_device+0xa4/0xb0
>> [   13.820430]   deferred_probe_work_func+0xa8/0x100
>> [   13.825064]   process_one_work+0x264/0x688
>> [   13.829088]   worker_thread+0x4c/0x458
>> [   13.832768]   kthread+0x154/0x158
>> [   13.836018]   ret_from_fork+0x10/0x18
>> [   13.839612]
>> [   13.839612] other info that might help us debug this:
>> [   13.839612]
>> [   13.850354]  Possible interrupt unsafe locking scenario:
>> [   13.850354]
>> [   13.855720]        CPU0                    CPU1
>> [   13.858774]        ----                    ----
>> [   13.863242]   lock(&ctl->lock);
>> [   13.866330]                                local_irq_disable();
>> [   13.872233]                                lock(&irq_desc_lock_class);
>> [   13.878705]                                lock(&ctl->lock);
>> [   13.884297]   <Interrupt>
>> [   13.886857]     lock(&irq_desc_lock_class);
>> [   13.891014]
>> [   13.891014]  *** DEADLOCK ***
>> 
>> The issue can occur when CPU1 is doing something like irq_set_type()
>> and CPU0 performing an interrupt allocation, for example. Taking
>> an interrupt (like the one being reconfigured) would lead to a
>> deadlock.

Just to make sure I understand
* the 1st trace is a CPU getting interrupted while setting the irq type
* the 2nd trace is another CPU trying to allocate an irq for network PHY.

>> 
>> A solution to this is:
>> 
>> - Reorder the locking so that meson_gpio_irq_update_bits takes the lock
>>   itself at all times, instead of relying on the caller to lock or not,
>>   hence making the RMW sequence atomic,
>> 
>> - Rework the critical section in meson_gpio_irq_request_channel to only
>>   cover the allocation itself, and let the gpio_irq_sel_pin callback
>>   deal with its own locking if required,
>> 
>> - Take the private spin-lock with interrupts disabled at all times

Looks like the only safe path if I understand correctly.
The patch below looks good to me.

>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>

Thanks for the fix Marc.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

>> ---
>>  drivers/irqchip/irq-meson-gpio.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
>> index ccc7f823911b..bc7aebcc96e9 100644
>> --- a/drivers/irqchip/irq-meson-gpio.c
>> +++ b/drivers/irqchip/irq-meson-gpio.c
>> @@ -144,12 +144,17 @@ struct meson_gpio_irq_controller {
>>  static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
>>  				       unsigned int reg, u32 mask, u32 val)
>>  {
>> +	unsigned long flags;
>>  	u32 tmp;
>>  
>> +	spin_lock_irqsave(&ctl->lock, flags);
>> +
>>  	tmp = readl_relaxed(ctl->base + reg);
>>  	tmp &= ~mask;
>>  	tmp |= val;
>>  	writel_relaxed(tmp, ctl->base + reg);
>> +
>> +	spin_unlock_irqrestore(&ctl->lock, flags);
>>  }
>>  
>>  static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl)
>> @@ -196,14 +201,15 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
>>  			       unsigned long  hwirq,
>>  			       u32 **channel_hwirq)
>>  {
>> +	unsigned long flags;
>>  	unsigned int idx;
>>  
>> -	spin_lock(&ctl->lock);
>> +	spin_lock_irqsave(&ctl->lock, flags);
>>  
>>  	/* Find a free channel */
>>  	idx = find_first_zero_bit(ctl->channel_map, NUM_CHANNEL);
>>  	if (idx >= NUM_CHANNEL) {
>> -		spin_unlock(&ctl->lock);
>> +		spin_unlock_irqrestore(&ctl->lock, flags);
>>  		pr_err("No channel available\n");
>>  		return -ENOSPC;
>>  	}
>> @@ -211,6 +217,8 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
>>  	/* Mark the channel as used */
>>  	set_bit(idx, ctl->channel_map);
>>  
>> +	spin_unlock_irqrestore(&ctl->lock, flags);
>> +
>>  	/*
>>  	 * Setup the mux of the channel to route the signal of the pad
>>  	 * to the appropriate input of the GIC
>> @@ -225,8 +233,6 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
>>  	 */
>>  	*channel_hwirq = &(ctl->channel_irqs[idx]);
>>  
>> -	spin_unlock(&ctl->lock);
>> -
>>  	pr_debug("hwirq %lu assigned to channel %d - irq %u\n",
>>  		 hwirq, idx, **channel_hwirq);
>>  
>> @@ -287,13 +293,9 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
>>  			val |= REG_EDGE_POL_LOW(params, idx);
>>  	}
>>  
>> -	spin_lock(&ctl->lock);
>> -
>>  	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL,
>>  				   REG_EDGE_POL_MASK(params, idx), val);
>>  
>> -	spin_unlock(&ctl->lock);
>> -
>>  	return 0;
>>  }
>>  

