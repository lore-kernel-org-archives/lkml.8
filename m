Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C43C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC02084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582647432;
	bh=l1kpRAXXYq9H4NhUC8N2qXkQy/OJyYRbQ9OH2Dk8bWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sh9qKM4qDV022FwIo05eqP4GqZAGSaCqUWJL5BYRiUlVS89zjHhOXVzPrQUWq5w8A
	 OV7h/YhOcpOhLrL1RJ29wOQEPnc1jVJpIn+Onpl3+9hYpAmb8N+cbRvRFas5LFhwx2
	 ptvLyE6Ooukt90IqjdrzBNT5UxD9HI/Jpo+k/W2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgBYQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:17:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgBYQRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:17:10 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050F820CC7;
        Tue, 25 Feb 2020 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582647430;
        bh=l1kpRAXXYq9H4NhUC8N2qXkQy/OJyYRbQ9OH2Dk8bWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nKiwBpAGLLBuQKBfn37X2vtqT259Mb9XHd5bOP1nZZRGOl6JQzS8GWAsJ7PBuXfwx
         gZ6TH88rnVq9XSgu26VHUwMb8Qordy829i2btfle/acgmc9QPiO5X8ME6MccexZiKP
         BCtHM4o8WqXWNHav/CW6STmUhy/9w4kW6sWKCE+4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j6ctQ-007rqy-BK; Tue, 25 Feb 2020 16:17:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Feb 2020 16:17:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Heyi Guo <guoheyi@huawei.com>
Cc:     linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] irq-gic-v3-its: fix access width for gicr_syncr
In-Reply-To: <20200225090023.28020-1-guoheyi@huawei.com>
References: <20200225090023.28020-1-guoheyi@huawei.com>
Message-ID: <740ba8790b72a42d400cc9fc317c4dba@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: guoheyi@huawei.com, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-25 09:00, Heyi Guo wrote:
> GICR_SYNCR is a 32bit register, so it is better to access it with
> 32bit access width, though we have not seen any real problem.
> 
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> 
> ---
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 65a11257d220..5c6790e3bfbf 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1321,7 +1321,7 @@ static void lpi_write_config(struct irq_data *d,
> u8 clr, u8 set)
> 
>  static void wait_for_syncr(void __iomem *rdbase)
>  {
> -	while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
> +	while (readl_relaxed(rdbase + GICR_SYNCR) & 1)
>  		cpu_relax();
>  }

Yup, nice catch. Looks like no implementation really cares about it,
but still worth fixing.

I'll take it for 5.7.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
