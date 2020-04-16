Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC070C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B816121924
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp8FtEBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgDPTZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727819AbgDPTZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 15:25:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924DC061A0C;
        Thu, 16 Apr 2020 12:25:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so2104811pgi.5;
        Thu, 16 Apr 2020 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gNOpmFkdJM5lK0kvLGKRDTe65pEdwYduioppFrEiEAE=;
        b=Gp8FtEBFGrZFmDlA8bU7KYFpceLvV6VY7Z3+9oFxYQMJuFCYGqUiMQQzsElPI5ijCf
         1q97+ASefxiE+RlVnh1NO7VZF+5/Yf4vRG+yvVqHToSGL4H3bHHDrG3sU3mjOyvczHTm
         /MhZcmRov8Rr5jvIwHcrD9y+g1fOv0gNId+UBOJBacZzDQGTv4Od0iGLfV83B/jZz1yT
         iKGMgiSnRvY+jeuQEYAvqS9wNFPj/ZiPyBaJZxh9Wyv9jegzrF1CpwebVg/pb0vsOCor
         9HlU0lEXk3mqgMOXnZYNWxMhZpxtJBds5A1AJP5yrO7KrITFmZpQsX02Gs0MdLTD8rML
         p1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gNOpmFkdJM5lK0kvLGKRDTe65pEdwYduioppFrEiEAE=;
        b=O6ERIetgpDPfCqjgzcIX7ipSvVYGJeAINNN6ZwwG12NouJSQZqZSqs3TXPCydSqv3T
         wW7jyf361eeMPHN1eCT99MbrO5QdQ9FPB7ZUM7UW3AN4IEY0n/ok1ZyMMd3RnmoZO823
         ULb9YCLWazS3iQvdSedBoxCWdXG11PkseAV1Y621q4WYPe89P7RHfbYvkYdJE5zsHRBF
         f7LNrHXB1KlkHFQ3C5z9nXkIJPYxYY/48WFYGmQf8XSRbcD4lXAukl7GIervegloiIOc
         sOtFGwjWNF85gFBsGKTZY4A4KN+n4vesu/JsExjxOFsS91n5TcaE9LXG8Po6C/BRiQPZ
         u5ug==
X-Gm-Message-State: AGi0PuarNexh+sfGH1UvQs7sXiGoeXgbeOXzC/Yt7BgBq4AR0qKHSM8D
        StiJqgdtmd/eCKDT3pHrt0NFMZPI
X-Google-Smtp-Source: APiQypLUAIx8sl4AiWezY2GN+IdXUA5NuQf47pUCuULAbjSQvR0MlWJupKfeqmv3Ibm7RHkOd3eztQ==
X-Received: by 2002:a63:6f45:: with SMTP id k66mr34179713pgc.246.1587065126838;
        Thu, 16 Apr 2020 12:25:26 -0700 (PDT)
Received: from [10.230.188.26] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o125sm15959886pgo.74.2020.04.16.12.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 12:25:26 -0700 (PDT)
Subject: Re: [PATCH 4/5] net: macb: WoL support for GEM type of Ethernet
 controller
To:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        harini.katakam@xilinx.com
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        pthombar@cadence.com, sergio.prado@e-labworks.com,
        antoine.tenart@bootlin.com, linux@armlinux.org.uk, andrew@lunn.ch,
        michal.simek@xilinx.com
References: <cover.1587058078.git.nicolas.ferre@microchip.com>
 <56bb7a742093cec160c4465c808778a14b2607e7.1587058078.git.nicolas.ferre@microchip.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6fc99e01-6d64-4248-3627-aa14a914df72@gmail.com>
Date:   Thu, 16 Apr 2020 12:25:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <56bb7a742093cec160c4465c808778a14b2607e7.1587058078.git.nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/2020 10:44 AM, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Adapt the Wake-on-Lan feature to the Cadence GEM Ethernet controller.
> This controller has different register layout and cannot be handled by
> previous code.
> We disable completely interrupts on all the queues but the queue 0.
> Handling of WoL interrupt is done in another interrupt handler
> positioned depending on the controller version used, just between
> suspend() and resume() calls.
> It allows to lower pressure on the generic interrupt hot path by
> removing the need to handle 2 tests for each IRQ: the first figuring out
> the controller revision, the second for actually knowing if the WoL bit
> is set.
> 
> Queue management in suspend()/resume() functions inspired from RFC patch
> by Harini Katakam <harinik@xilinx.com>, thanks!
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

[snip]

>   
> +static irqreturn_t gem_wol_interrupt(int irq, void *dev_id)
> +{
> +	struct macb_queue *queue = dev_id;
> +	struct macb *bp = queue->bp;
> +	u32 status;
> +
> +	status = queue_readl(queue, ISR);
> +
> +	if (unlikely(!status))
> +		return IRQ_NONE;
> +
> +	spin_lock(&bp->lock);
> +
> +	if (status & GEM_BIT(WOL)) {
> +		queue_writel(queue, IDR, GEM_BIT(WOL));
> +		gem_writel(bp, WOL, 0);
> +		netdev_vdbg(bp->dev, "GEM WoL: queue = %u, isr = 0x%08lx\n",
> +			    (unsigned int)(queue - bp->queues),
> +			    (unsigned long)status);
> +		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> +			queue_writel(queue, ISR, GEM_BIT(WOL));

You would also need a pm_wakeup_event() call here to record that this 
device did wake-up the system.
-- 
Florian
