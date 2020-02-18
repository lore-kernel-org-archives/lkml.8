Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AE8C34037
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5DB207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mj6hBil2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgBRMYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:24:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37310 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgBRMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:24:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so23691051wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 04:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Re/qzEfuGmEmN6RxPFcJneNfN0qHMlxoSuOmrZrkTeU=;
        b=mj6hBil2iLdz+cczgouO2gaCmIfyVkInRXsS63E0gqDl4B2rgB7eJKkKlAn8UrA8Jz
         QA3NnNBnww3tlN+SGg3J8S88XZ0Nd2Ml46qTBv0yo3TIpxY4JK6ECGA5OHEWbJf3Yhec
         MoTVuiHP9ApF3jvvn4kX8uFX6DsrUc5dVHlhfTtnbtLlqmNmzpumdbSv2NZeD2Sc6p4n
         Re8n+947kCLJwb2+BMP54W84BLvP0rIzA+tAdgbOc7LL5wt+5YK86cnL6Rro373s7kNC
         PFQe3zFVnUcKl6s2yl5iEQw328dgKRlFcB/ZBSyB/Y32AbUHBeMhojH1kjSFnUTVlcBg
         gTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Re/qzEfuGmEmN6RxPFcJneNfN0qHMlxoSuOmrZrkTeU=;
        b=Q6PN2y+x84aki7Vm1HQBqUIz1fPWNwBB1Uy9cAQEzYmMq0DgFEUH8D54QJSDOrwo4C
         /HE3d60AUKaiSMijvxYcWVrdVMcut4Kh/JYp+r5hOYIZEngrLUzvU7+i9NZ2kkQMppK0
         izWwdLTJeZ5iLuXreZOFvCaBz99T4V3iDaqwz4VoDPMj6w9nR2qKw3dQg+kDja4RMADP
         Yn/OpgDyRlQCLb9WrklLefj6SdLsUpHzPHR9C+3BCNi6h/xrsOVpwKsl1Eq5zkF0aVJ5
         x/HFyy/jZcJN4eNhve/xvJud9eysUP8/TkOCYEcZOR3qjq9iQcMjE9LMS7tu7QmUmdBH
         87qQ==
X-Gm-Message-State: APjAAAW1+pxTMXH2sSnS0LKCCCfj2sxoQz5WgMZE6tdmrw2A9I9U4OTJ
        iGek9dks0AGWbzPH7Y+ZjtHA7A==
X-Google-Smtp-Source: APXvYqxgTkUABQWZa4GKXpopxZNVDbhQPp/JsI03dbyF6i111bHEcaXHg9yi9TELKiIAhD0Vn4SAOA==
X-Received: by 2002:adf:a381:: with SMTP id l1mr28798603wrb.102.1582028667675;
        Tue, 18 Feb 2020 04:24:27 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y6sm5890329wrl.17.2020.02.18.04.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 04:24:26 -0800 (PST)
Subject: Re: [PATCH v2 5/7] nvmem: release the write-protect pin
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200218094234.23896-1-brgl@bgdev.pl>
 <20200218094234.23896-6-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d2232172-f503-b7e4-a117-691ab2c480f4@linaro.org>
Date:   Tue, 18 Feb 2020 12:24:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200218094234.23896-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/02/2020 09:42, Bartosz Golaszewski wrote:
> @@ -428,6 +429,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	device_del(&nvmem->dev);
>   err_put_device:
>   	put_device(&nvmem->dev);
> +	gpiod_put(nvmem->wp_gpio);
>   err_ida_remove:
>   	ida_simple_remove(&nvmem_ida, nvmem->id);
>   err_free_nvmem:

This is also redundant as explained in my previous comments about release()

--srini


> -- 
