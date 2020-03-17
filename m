Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6740C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E22320714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jOeS0u82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgCQRD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:03:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=JrfbfStkuLthDJce1M1JugDTO24hOoZE58L7iN+zG2U=; b=jOeS0u829MtADQiUjmIqAmuJKK
        etUNM1qkA+POedoDZdTcxDQbKGA5Ltl+G3zo4zyk9vZF9F2epczpebM4r+qpE4cCDXtTbXsEqsRdC
        vwNMTgdrUxksdy3oy99KgYgsqiZaRhcsOrVfOjATxum+k7gbgA0tJIopajlTDy02l8YxkBiQ1Oqsp
        WZvYKipXpfKvXKt/4eEl73Rqf0Te0oYUmBL1iVqhpx1sjqeu4xwtJlkjmqD1lVEyMOCXQFsABTnbR
        HDsNTn55SBEezIAwjDefrCoetIBT6CbDNMVV31xTZvsIqj4wOzCxWEanwQpjL1gxU+eP8GLC/1SgA
        nJFHVyqQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFdC-0007p4-Kj; Tue, 17 Mar 2020 17:03:55 +0000
Subject: Re: [PATCH v6 3/3] hwmon: add Gateworks System Controller support
To:     Tim Harvey <tharvey@gateworks.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
References: <1584464453-28200-1-git-send-email-tharvey@gateworks.com>
 <1584464453-28200-4-git-send-email-tharvey@gateworks.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f7ccbdb4-917a-2dd7-bf6b-8c82b87bc167@infradead.org>
Date:   Tue, 17 Mar 2020 10:03:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584464453-28200-4-git-send-email-tharvey@gateworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/20 10:00 AM, Tim Harvey wrote:
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 23dfe84..99dae13 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -494,6 +494,15 @@ config SENSORS_F75375S
>  	  This driver can also be built as a module. If so, the module
>  	  will be called f75375s.
>  
> +config SENSORS_GSC
> +        tristate "Gateworks System Controller ADC"
> +        depends on MFD_GATEWORKS_GSC
> +        help
> +          Support for the Gateworks System Controller A/D converters.

Hi Tim,
Those 4 lines above should be using tabs for indentation.
+ 2 spaces on the final "Support" line.

> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called gsc-hwmon.
> +
>  config SENSORS_MC13783_ADC
>          tristate "Freescale MC13783/MC13892 ADC"
>          depends on MFD_MC13XXX


-- 
~Randy

