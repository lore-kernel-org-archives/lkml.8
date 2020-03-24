Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A355C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABD12076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="igCXhxZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgCXSlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:41:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgCXSlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Wd0k7Pl2dpveFVlxa5+59jPfGtSekGDFn8MRmZyOnso=; b=igCXhxZLgbxBS17ynr5P06jWKk
        ZXZFEi2ggjJ3+C5Z3JvnWpM4vl1RkKfCfuCV1pI5fK8wJTYjGO1GsHvhNNYIBqyFjElr0iaLX0v9R
        hip4TOIAmRGKM1ehEUZEzHd+dijs4YupUW5CjMC6bVLdUezWKBAGFlUrCwU9JoI4xD2ahzYxhm0OC
        NjmctzqXzNlaaKxdODgarAF822ywGhq5dSZRR9nbMKogkOGrIteVr+1jgRYgU6BZyrVaSS55KuW50
        vFi2OrDIeWccuYUwWeDRV6TMpcIIne9bXf8mwxLiyZRs6cS7YqlAi9e3CwiuzS/ReUw5AQHhJdwdr
        WVFp+FCg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGoUB-0008FS-VI; Tue, 24 Mar 2020 18:41:12 +0000
Subject: Re: [PATCH v18 4/4] leds: multicolor: Introduce a multicolor class
 definition
To:     Dan Murphy <dmurphy@ti.com>, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
References: <20200324181434.24721-1-dmurphy@ti.com>
 <20200324181434.24721-5-dmurphy@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e9d6c050-0ee4-6829-bd23-25e9bbf72774@infradead.org>
Date:   Tue, 24 Mar 2020 11:41:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324181434.24721-5-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20 11:14 AM, Dan Murphy wrote:
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index d82f1dea3711..37dcdb06a29b 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -30,6 +30,16 @@ config LEDS_CLASS_FLASH
>  	  for the flash related features of a LED device. It can be built
>  	  as a module.
>  
> +config LEDS_CLASS_MULTI_COLOR
> +	tristate "LED Mulit Color LED Class Support"

	              Multi
or even	              MultiColor
or	              Multicolor

> +	depends on LEDS_CLASS
> +	help
> +	  This option enables the multicolor LED sysfs class in /sys/class/leds.
> +	  It wraps LED class and adds multicolor LED specific sysfs attributes
> +	  and kernel internal API to it. You'll need this to provide support
> +	  for multicolor LEDs that are grouped together. This class is not
> +	  intended for single color LEDs. It can be built as a module.
> +
>  config LEDS_BRIGHTNESS_HW_CHANGED
>  	bool "LED Class brightness_hw_changed attribute support"
>  	depends on LEDS_CLASS


-- 
~Randy

