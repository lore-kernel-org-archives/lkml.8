Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7D120842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZuapSbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgCCPK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:10:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46491 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgCCPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:10:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id h18so3850802ljl.13;
        Tue, 03 Mar 2020 07:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=srYBJQBn40ddvd9Oy2lph/9+g4zk3ppatIYkVI/mDpU=;
        b=lZuapSbNZ4EIwa2OG0I+vk5CXF9p5PcP4FAUsGhHvfoOmPtUN80qLQyiGhHDm8LYEH
         w32rOdgYWrDXbgvmSwz8ME1N8zbKeVYviIvLzcry4nXf0E0aKijEL8Vzs9ux7YPG7Tz5
         N+ScuTx184UxpAFpNm7K0xQby3ogUb/l9lgrmjSTV6aG4UvUCq62IoESmjjcOKIz8aRa
         FS7PMRLSlIDmDQxeuhhQHh1awCbJfI6gF9O5a4LOpoauQ1aCJamHlXAPzYqTnPnLqw8A
         Bbg1mBHJ7AyLpG58tJDvuuXWGgJ2dVIh0AP2EnAaX5exZdTngwkXtK4ia7hPN8zB4LAA
         naqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=srYBJQBn40ddvd9Oy2lph/9+g4zk3ppatIYkVI/mDpU=;
        b=NB8dSX2CQsN7jqSs2AI8s3Joo2Wfg233B2cUwkrHXpJcdzmQcaOn1KosMc9eCAvbbI
         jg9ry/+JNZxjtxRuKwRRsYQE5n9Zw3o4oug9zNm3+k0o4+9qH0g9EqHTszUy/0wNPvST
         i1Z3iV6kWkEMpIk3YHj6oJQ7+TfTV5AunxZsyNnAWWB+zSpavOi5NoaJ1tgC2o993aXj
         1BzRzgUucwR76qBkSXCvag8bKa2LfqUqzVmgWOa/q+b4CsvDl6tYvDnIcrKJ3b/1pQO1
         jdxglptO5rfXMGFzi7DTkB6iLKIBBzfucxjV2ESGIwkpcc/5sHekPqZpBmVCdKwiYnXh
         ymMA==
X-Gm-Message-State: ANhLgQ2xZNKNX3rSKlHH+sS/z4PZssVAkgQ+5/hp4cywg02+d4QKL5mS
        GwWw/mbUgzVBYRbPbSIwKnysWw1T
X-Google-Smtp-Source: ADFU+vvkFl1Zh01+7/XZPhJgxMIs7pGaIKPdrbXOPe/ptTcaGythQv4/hP85GnjUp6g489j1NEMTDQ==
X-Received: by 2002:a2e:7009:: with SMTP id l9mr2797800ljc.96.1583248255159;
        Tue, 03 Mar 2020 07:10:55 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id t14sm4907012ljo.56.2020.03.03.07.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 07:10:54 -0800 (PST)
Subject: Re: [PATCH] usb: phy: tegra: Include proper GPIO consumer header to
 fix compile testing
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1583234960-24909-1-git-send-email-krzk@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9cce90a5-88b5-b875-9d20-34b5a9dd165e@gmail.com>
Date:   Tue, 3 Mar 2020 18:10:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583234960-24909-1-git-send-email-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.03.2020 14:29, Krzysztof Kozlowski пишет:
> The driver uses only GPIO Descriptor Consumer Interface so include
> proper header.  This fixes compile test failures (e.g. on i386):
> 
>     drivers/usb/phy/phy-tegra-usb.c: In function ‘ulpi_phy_power_on’:
>     drivers/usb/phy/phy-tegra-usb.c:695:2: error:
>         implicit declaration of function ‘gpiod_set_value_cansleep’ [-Werror=implicit-function-declaration]
>     drivers/usb/phy/phy-tegra-usb.c: In function ‘tegra_usb_phy_probe’:
>     drivers/usb/phy/phy-tegra-usb.c:1167:11: error:
>         implicit declaration of function ‘devm_gpiod_get_from_of_node’ [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/usb/phy/phy-tegra-usb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
> index 6153cc35aba0..cffe2aced488 100644
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
> @@ -12,12 +12,11 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/resource.h>
>  #include <linux/slab.h>
> 

Thanks,

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
