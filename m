Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44892C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0982076C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgF2WaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:30:09 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40965 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgF2WaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:30:08 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AAEDB20009;
        Mon, 29 Jun 2020 22:30:04 +0000 (UTC)
Date:   Tue, 30 Jun 2020 00:30:04 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: atmel-ssc: lock with mutex instead of spinlock
Message-ID: <20200629223004.GC3800@piout.net>
References: <50f0d7fa107f318296afb49477c3571e4d6978c5.1592998403.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50f0d7fa107f318296afb49477c3571e4d6978c5.1592998403.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2020 13:35:41+0200, Michał Mirosław wrote:
> Uninterruptible context is not needed in the driver and causes lockdep
> warning because of mutex taken in of_alias_get_id(). Convert the lock to
> mutex to avoid the issue.
> 
> Cc: stable@vger.kernel.org
> Fixes: 099343c64e16 ("ARM: at91: atmel-ssc: add device tree support")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  v2: rebased onto v5.7.5, added Fixes tag
> ---
>  drivers/misc/atmel-ssc.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index ab4144ea1f11..d6cd5537126c 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -10,7 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/spinlock.h>
> +#include <linux/mutex.h>
>  #include <linux/atmel-ssc.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -20,7 +20,7 @@
>  #include "../../sound/soc/atmel/atmel_ssc_dai.h"
>  
>  /* Serialize access to ssc_list and user count */
> -static DEFINE_SPINLOCK(user_lock);
> +static DEFINE_MUTEX(user_lock);
>  static LIST_HEAD(ssc_list);
>  
>  struct ssc_device *ssc_request(unsigned int ssc_num)
> @@ -28,7 +28,7 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
>  	int ssc_valid = 0;
>  	struct ssc_device *ssc;
>  
> -	spin_lock(&user_lock);
> +	mutex_lock(&user_lock);
>  	list_for_each_entry(ssc, &ssc_list, list) {
>  		if (ssc->pdev->dev.of_node) {
>  			if (of_alias_get_id(ssc->pdev->dev.of_node, "ssc")
> @@ -44,18 +44,18 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
>  	}
>  
>  	if (!ssc_valid) {
> -		spin_unlock(&user_lock);
> +		mutex_unlock(&user_lock);
>  		pr_err("ssc: ssc%d platform device is missing\n", ssc_num);
>  		return ERR_PTR(-ENODEV);
>  	}
>  
>  	if (ssc->user) {
> -		spin_unlock(&user_lock);
> +		mutex_unlock(&user_lock);
>  		dev_dbg(&ssc->pdev->dev, "module busy\n");
>  		return ERR_PTR(-EBUSY);
>  	}
>  	ssc->user++;
> -	spin_unlock(&user_lock);
> +	mutex_unlock(&user_lock);
>  
>  	clk_prepare(ssc->clk);
>  
> @@ -67,14 +67,14 @@ void ssc_free(struct ssc_device *ssc)
>  {
>  	bool disable_clk = true;
>  
> -	spin_lock(&user_lock);
> +	mutex_lock(&user_lock);
>  	if (ssc->user)
>  		ssc->user--;
>  	else {
>  		disable_clk = false;
>  		dev_dbg(&ssc->pdev->dev, "device already free\n");
>  	}
> -	spin_unlock(&user_lock);
> +	mutex_unlock(&user_lock);
>  
>  	if (disable_clk)
>  		clk_unprepare(ssc->clk);
> @@ -237,9 +237,9 @@ static int ssc_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> -	spin_lock(&user_lock);
> +	mutex_lock(&user_lock);
>  	list_add_tail(&ssc->list, &ssc_list);
> -	spin_unlock(&user_lock);
> +	mutex_unlock(&user_lock);
>  
>  	platform_set_drvdata(pdev, ssc);
>  
> @@ -258,9 +258,9 @@ static int ssc_remove(struct platform_device *pdev)
>  
>  	ssc_sound_dai_remove(ssc);
>  
> -	spin_lock(&user_lock);
> +	mutex_lock(&user_lock);
>  	list_del(&ssc->list);
> -	spin_unlock(&user_lock);
> +	mutex_unlock(&user_lock);
>  
>  	return 0;
>  }
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
