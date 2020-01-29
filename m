Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23019C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7A020732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580300291;
	bh=3Wt7wzJqut3lLvWETWHOk3WmRL0r/qJdKTJe7GZKl8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tA0WFnggtUQqwqHKP7W6CNZRUghPhbWBvmtrjBNJV0gg7xUAzkraSXlSU2Lv8CCrE
	 9LnBNTbIPEeOntT/xjPrVhZ9WTUt92CJ2wsFVaZyYY7+mT/4rPydkPq6Qg7qnOhht4
	 AOKhjwrPsc4nNviaKCj68A2FtyaZm54sJ77jYqh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgA2MSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:18:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgA2MSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:18:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D83682071E;
        Wed, 29 Jan 2020 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580300289;
        bh=3Wt7wzJqut3lLvWETWHOk3WmRL0r/qJdKTJe7GZKl8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tr50Kz68WnPJfmWahLHjF0GJ3Q2ZxxRqnIH++Xna1nSFvT2W/0JFg8ZJy4MFakh5o
         aSupCEk+D4GsXiHo1FPlINDYYUDdiclzF2Eh71vWo7sWFWKDqZpAIqYhHlEwvS6nJD
         rVBfIfnHXUN3OU2QnmW959cQqAh0sYKfvCckN5Qg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1iwmII-0020uL-Vq; Wed, 29 Jan 2020 12:18:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jan 2020 12:18:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH RESEND] irqchip: some Kconfig cleanup for C-SKY
In-Reply-To: <d44baeee-cceb-7c02-7249-e6b4817f0847@infradead.org>
References: <d44baeee-cceb-7c02-7249-e6b4817f0847@infradead.org>
Message-ID: <f85f31ce562e3eb1d7f6c99d73fe3de8@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rdunlap@infradead.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, guoren@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-29 02:25, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fixes to Kconfig help text:
> 
> - spell out "hardware"
> - fix verb usage
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> Acked-by: Guo Ren <guoren@kernel.org>
> ---
>  drivers/irqchip/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200128.orig/drivers/irqchip/Kconfig
> +++ linux-next-20200128/drivers/irqchip/Kconfig
> @@ -438,7 +438,7 @@ config CSKY_MPINTC
>  	help
>  	  Say yes here to enable C-SKY SMP interrupt controller driver used
>  	  for C-SKY SMP system.
> -	  In fact it's not mmio map in hw and it use ld/st to visit the
> +	  In fact it's not mmio map in hardware and it uses ld/st to visit 
> the
>  	  controller's register inside CPU.
> 
>  config CSKY_APB_INTC
> @@ -446,7 +446,7 @@ config CSKY_APB_INTC
>  	depends on CSKY
>  	help
>  	  Say yes here to enable C-SKY APB interrupt controller driver used
> -	  by C-SKY single core SOC system. It use mmio map apb-bus to visit
> +	  by C-SKY single core SOC system. It uses mmio map apb-bus to visit
>  	  the controller's register.
> 
>  config IMX_IRQSTEER

I'll queue that as part of the next batch of fixes.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
