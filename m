Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85858C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C3206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuwN5K/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgDCVL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:11:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44079 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCVL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:11:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so8397855lji.11;
        Fri, 03 Apr 2020 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JoTm+bFk1b4wV/ZEGvF6eL+XjT1zXesgWygtLbj063Q=;
        b=HuwN5K/syHVKjw8JGl/TibGxBj4HjiW/VyIlS+G/15frL85inIIKnqT+dc3oTVDx1p
         H5hjUGiXTNxqaoiioBZ9dVotsWUC+eKxm3fN9IbNZHYiMq1YLbrgGI8LVKzc80ldkyrI
         VhpeLPY6+BkqAYcaWYtVbQl1NwquvxcDjk/gsxcuVK6QvoUyYXMNCgfjjWj1+APOm7hx
         KGcMcEmykKDduf6NE+PTYXtWOehw1d4T2KM5HCK2ctfRmFSvUcvMAvfnn2U7JtIyM9GR
         EPKYwiab+XnPyNbTE9wm3XE17Abg7wbS+i2FTR6xGIRRweGL5ALfmHTA2igirMIRhoCF
         7OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JoTm+bFk1b4wV/ZEGvF6eL+XjT1zXesgWygtLbj063Q=;
        b=amJWzDEnF9C3nJFjcHPyq3mFYS4/on6etzHelEXRa+nRmE6/xZIBZ//VHDasIHdoEy
         KpBJZkCMEVYS4ay6YU2R0dnJX6QbuIMwCSHOetsOP/wCMSJu5NJBvUL8c1MMgHfkjbI7
         9Ay4yDEZzL66VDCfItRNgS9UzFPjYIiR88p/g3nLWw2n/d9IDLHeUgzJjN0QpBSCnWtX
         O2D/EAC6aGLcYAJW4qGdW87iK+k40QwUaAdxCpd6FPm216Jf7shtBM3PsPN+7bcRxxtr
         atTPfegCuXnLLUa3S+yhuTx4p0tuU2Whz9x3eQCEHfenW3zL/Zj4LGqAyar2SM0iogNF
         CLIg==
X-Gm-Message-State: AGi0PuZCRoASR0x+hTewlG15CAorrUTjyRnySg73qhZ/mZevszCKLrVr
        Yigmg64UJuz3sapoyfh5rf7NA5O3
X-Google-Smtp-Source: APiQypIDMsBV/vJeVbN8qdBLtOyA9ymv6vUWZwD632rhkKfhjIYIXBFGsmKQw664GSpELaqbZjSajQ==
X-Received: by 2002:a2e:8146:: with SMTP id t6mr5962740ljg.236.1585948314719;
        Fri, 03 Apr 2020 14:11:54 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id v9sm5659166ljj.31.2020.04.03.14.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 14:11:54 -0700 (PDT)
Subject: Re: [PATCH v3 5/7] arm64: tegra: Enable native timers on Jetson TX2
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200403202209.299823-1-thierry.reding@gmail.com>
 <20200403202209.299823-6-thierry.reding@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <948734ce-0f4e-e09b-a928-74199455eed7@gmail.com>
Date:   Sat, 4 Apr 2020 00:11:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403202209.299823-6-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.04.2020 23:22, Thierry Reding пишет:
> From: Thierry Reding <treding@nvidia.com>
> 
> Enable the native timers on Jetson TX2 to allow using the watchdog
> functionality to recover from system hangs, for example.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> index da96de04d003..9aa17744c4a0 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> @@ -58,6 +58,10 @@ memory-controller@2c00000 {
>  		status = "okay";
>  	};
>  
> +	timer@3010000 {
> +		status = "okay";
> +	};

Why timer needs to be enabled per-board?
