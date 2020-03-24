Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE84CC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87412074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRZLcd1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCXTTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:19:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43422 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCXTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:19:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id g27so11038956ljn.10;
        Tue, 24 Mar 2020 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7fQRQ3RTaos7/s0RQFo8A2f8cwQKwdrnRsxFFOCClLE=;
        b=SRZLcd1dIEBKj/kS2qUqsbMwlhI5ud2ZbTHlDk7yGUlOsOVBHJxPhBawWOCURFlOdk
         u8PvEMlsQXqro1nxtTYtlrtrto7FnV5GLDN83V80ufxIOKklXz3awO+ZXr3kH/PUiMVi
         FLXMe3uoji3p6IHxOajLBdgBpGQe9BnBdN7TUfZF5ynv8S6J3ZuVSS83OqjvGyCtAzBU
         a9K2pOVHad/FvUI95Wpd9VMxukphyUaxtyDcP19m93NxMkiGi9wW91ECz0a3mIH+1TQL
         hLL8U/f/cHkCTbz9ZMY7gj4y9VbGmlqMpez5yMcNJX3AfjUazsisgpSGtfcATWSDHN1t
         zvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fQRQ3RTaos7/s0RQFo8A2f8cwQKwdrnRsxFFOCClLE=;
        b=JRUix2muZiiC0lIvayLHUD2r9etdFBZO5bERprbllDVQ/YjymrGB+C3WGUbREQ6Br1
         twf/NnUizmkF8ooNtRZLoSJxOvAkelqt66Msra/APXHvt4bbq9vO3styy4uFmguDdvNw
         e3hvQGLfStXKlURKgEM+NGpMen7H75UcO5ynLxVQPajb9FI3Ay2G3foQcgbyqY9HE+sM
         8j8cNcsfwwnJiCrpZIKJA7qcDZX/YDIAKFhgxKZnT+TbIPQpHRkBcjRMkXOSPVFxa0bg
         QN9NTfMUfgpb39wFfoqYD+Iivek8oUGTNG6w+F5YhoxeoAqUeum1mR7KoFQI6vrn5CzU
         nrLw==
X-Gm-Message-State: AGi0PubQ/yMonjWNa5xUZOoP1OntrE5qVwQPUW0hi41k1JNOrQGeY2Cw
        Xow+zJ5f0EXXoUVX9KI+v+FXso1T
X-Google-Smtp-Source: ADFU+vvbl9s0AQapsahwCNsJ69SeiSCjVA0b7vlkq3l4smsy1tslBIfS0q8sR8mJpvsPurY60HmuUQ==
X-Received: by 2002:a2e:800a:: with SMTP id j10mr507176ljg.65.1585077544943;
        Tue, 24 Mar 2020 12:19:04 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id 9sm12167157ljf.0.2020.03.24.12.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 12:19:03 -0700 (PDT)
Subject: Re: [RFC PATCH v5 9/9] arm64: tegra: Add Tegra VI CSI support in
 device tree
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1584985955-19101-1-git-send-email-skomatineni@nvidia.com>
 <1584985955-19101-10-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <672819ea-01d3-2eca-8bb7-84ffd64256d4@gmail.com>
Date:   Tue, 24 Mar 2020 22:19:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584985955-19101-10-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.03.2020 20:52, Sowjanya Komatineni пишет:
...
> +			pd_venc: venc {
> +				clocks = <&tegra_car TEGRA210_CLK_VI>,
> +					 <&tegra_car TEGRA210_CLK_CSI>;
> +				resets = <&mc TEGRA210_MC_RESET_VI>,

The MC resetting should be needed only for a hardware hot-resetting. It
should be wrong to add it to the power domain.

> +					 <&tegra_car TEGRA210_RST_VI>,
> +					 <&tegra_car TEGRA210_CLK_CSI>;
> +				#power-domain-cells = <0>;
> +			};
>  		};
