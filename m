Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA2FC3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E570208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Ibbybj3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgDQK0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728830AbgDQK0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:26:47 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E3C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:26:46 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id f8so1358997lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=abDyn/jXseXxq1cb7bzkp4uCUuMQnA0AHpsOMWQZYsc=;
        b=Ibbybj3B49zX5Erj/RuaY9e3gsgQ5r7g/GnmjSMpZ/abyKFCQAXFSZECh04pljsSDe
         K1oL4Jtupdt6W0gpdx2hMGO0/KoQk/hbf41AWqkdYrU268L1WB5zWGC+ilh8mGKMutXl
         eHMnHDsuvNOf09CZB1Jw6062l1EK38hwF+VraL5qIXpvAWli/rENokjYyaolv82CzlL5
         uS5ZVkRjkmDiQYrIGv3X5lYcASPKF2cgh5QAJWSm2S0Z2nyBRDCV1P9LFq7l7+uBKdae
         j0l41cDPgHlRH7LrYrTSQNRIkQuqfr2k4wVA4i2kPg9bpIHVQtYpZClL3HgqGeCGityA
         L9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=abDyn/jXseXxq1cb7bzkp4uCUuMQnA0AHpsOMWQZYsc=;
        b=jHzRUXzs1N6JKA+DpnYDQ2jmJdKwUUk51BpRSGELXDPD3ln9svivg+oHozW7C+8/aJ
         GffHLjmeZlf8GTHQ8uHh8AT3kGGS8jVsUTsrz9ZHQ6YIdJaNdgBDPk4HcoUW+XhVuceo
         nx7M1HrclKVj97Lv40aHv1Q60qOcOaZZ13gYZDezsvxp9aeY9BoHCi1e+2CdRl9ZcWeT
         WRVWeLpWh5ZdmaNsDjVtuNYINUSVHTFrNC7J65Jp/hnLjv/Cgt+nwbDB0gyRhJqQExQB
         nxcNGNykcjXpdKCbSYTU3odJPolsvyvTyhig+3aLvfHNLOdSF2LyV8OUcUnFI1lBCEg4
         PrVA==
X-Gm-Message-State: AGi0Pubgehq7I4t8hwzRVobb6Njz6dszuj+ptx2TAoQ4UxBHbU5JFt9c
        rkaBuSkpRjuE/Zrkvsf4JGwmvQ==
X-Google-Smtp-Source: APiQypKjN7ryKHp7crnqULqVwMcxdcRVmUG5EbaOPwpMcWc6SP+r9a0h77F07utY1WzaZU4k1WmcKA==
X-Received: by 2002:a19:5206:: with SMTP id m6mr1607205lfb.33.1587119205308;
        Fri, 17 Apr 2020 03:26:45 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4680:4c27:1a2:7a5f:abbc:5b1c? ([2a00:1fa0:4680:4c27:1a2:7a5f:abbc:5b1c])
        by smtp.gmail.com with ESMTPSA id a11sm11712142lji.62.2020.04.17.03.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 03:26:44 -0700 (PDT)
Subject: Re: [PATCH] irqchip/irq-bcm7038-l1: make bcm7038_l1_of_init() static
To:     Jason Yan <yanaijie@huawei.com>, f.fainelli@gmail.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        justinpopo6@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200417074036.46594-1-yanaijie@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <ecb3e3e1-7761-faa7-10fa-67da69604306@cogentembedded.com>
Date:   Fri, 17 Apr 2020 13:26:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417074036.46594-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 17.04.2020 10:40, Jason Yan wrote:

> Fix the following sparse warning:
> 
> drivers/irqchip/irq-bcm7038-l1.c:419:12: warning: symbol
> 'bcm7038_l1_of_init' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   drivers/irqchip/irq-bcm7038-l1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
> index eb9bce93cd05..fd7c537fb42a 100644
> --- a/drivers/irqchip/irq-bcm7038-l1.c
> +++ b/drivers/irqchip/irq-bcm7038-l1.c
> @@ -416,7 +416,7 @@ static const struct irq_domain_ops bcm7038_l1_domain_ops = {
>   	.map			= bcm7038_l1_map,
>   };
>   
> -int __init bcm7038_l1_of_init(struct device_node *dn,
> +static int __init bcm7038_l1_of_init(struct device_node *dn,
>   			      struct device_node *parent)

    Reindent the above line please, it should start under *struct* on the 1st 
line.

[...]

MBR, Sergei
