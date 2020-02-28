Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA72CC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C6624699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiCNBCpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1RYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:24:04 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43496 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1RYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:24:04 -0500
Received: by mail-yw1-f66.google.com with SMTP id f204so3981300ywc.10;
        Fri, 28 Feb 2020 09:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=8DBagXdO92SGZD18edolNudaDY7BySfxVES4onPKc48=;
        b=BiCNBCpDhvom4uoBEgi6wWUf78Kj5hpmt5TQuapy9qcR64nz4OnJs4O7vU8LcLUu1Q
         Nfy/foDa3tGn4/w4Qq2UVG6M4CVuzCmn9cGtWCFzLZD/gC/cBKSKqjOgg1Y3L5Yy0mGv
         PDHzM2BiUkH/rSgYYhZ/pZYHhX40OjyNXBiHVxpBfnnDjWLEmX58heB6u2EeaeQzIDcy
         6/UrxwaLyrcFcHFVPAHwz4hCE5WmYIR+hl7l9Q9Zqhhks6gu/viQxHQ2VyXC/iKyyhnS
         TRQifnXdpH2I43DBTHtwz6C4YTGxMhpodWZtaFd/rok5ZYFKXb0osBRKqJwU0XgXJ6eg
         8KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8DBagXdO92SGZD18edolNudaDY7BySfxVES4onPKc48=;
        b=XX1+gNaPKc4Z0uSrQBdJ/DdWScm3Ut8RGOKW0NTnB5j/vyjhF/DO42AkeAgVp5fnH5
         TmWGHH97mAPICbaEtOSVEPpi7HvRu+0qMkOeabSso9TYlxs1wv9LNwaxnZsfl5FKX1wn
         CzMIWVE4weW+CKbyoUJm09cTD6dCn2j/NTSb1tKf2BLUrybeAQenSw8V0QPlznA3mozO
         VTDl+pO8YaXl5/lDc4Wd15FME1dBt97mJELQqKJc0jylgIH6wm2GjKH0BaitfK8LZPCI
         UCnnwZ31Ktkzzepw0iptArnex9HQ2fHqdlsaHz9lzo1jZ0E6tjZv0MoibHMwel18s9pr
         2aYQ==
X-Gm-Message-State: APjAAAXgeeppPAgeNn1QnfX+WQaFJr+y6U+alE28Bzpylg5WjtXWoaJg
        JyI4wwOdZ+P06vE4O4ltRwqwlsklsj8=
X-Google-Smtp-Source: APXvYqzjFFyA3EgEXXPFZc4AK1Co1/BHuEDPNq3NoVt9mMTOgu4Ojh5FyaxarOeEjgtDprXLfIV49w==
X-Received: by 2002:a25:b16:: with SMTP id 22mr4521149ybl.380.1582910643178;
        Fri, 28 Feb 2020 09:24:03 -0800 (PST)
Received: from [192.168.1.111] (96-42-251-64.dhcp.roch.mn.charter.com. [96.42.251.64])
        by smtp.gmail.com with ESMTPSA id a202sm4221235ywe.8.2020.02.28.09.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 09:24:02 -0800 (PST)
Subject: Re: [PATCH v2] ARM: dts: rainier: Set PCA9552 pin types
To:     Matthew Barth <msbarth@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
References: <20200225201415.431668-1-msbarth@linux.ibm.com>
From:   Brandon Wyman <bjwyman@gmail.com>
Message-ID: <ec4c675a-b1db-c2d5-97d0-dcff44123db0@gmail.com>
Date:   Fri, 28 Feb 2020 11:24:01 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225201415.431668-1-msbarth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-02-25 14:14, Matthew Barth wrote:
> All 16 pins of the PCA9552 at 7-bit address 0x61 should be set as type
> GPIO.
>
> Signed-off-by: Matthew Barth <msbarth@linux.ibm.com>
> ---
> v2: Added leds-pca955x.h include
>      Added upstream to patch
> ---
Reviewed-by: Brandon Wyman <bjwyman@gmail.com>
> ---
>   arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index c63cefce636d..d9fa9fd48058 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -4,6 +4,7 @@
>   
>   #include "aspeed-g6.dtsi"
>   #include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
>   
>   / {
>   	model = "Rainier";
> @@ -351,66 +352,82 @@
>   
>   		gpio@0 {
>   			reg = <0>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@1 {
>   			reg = <1>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@2 {
>   			reg = <2>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@3 {
>   			reg = <3>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@4 {
>   			reg = <4>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@5 {
>   			reg = <5>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@6 {
>   			reg = <6>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@7 {
>   			reg = <7>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@8 {
>   			reg = <8>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@9 {
>   			reg = <9>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@10 {
>   			reg = <10>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@11 {
>   			reg = <11>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@12 {
>   			reg = <12>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@13 {
>   			reg = <13>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@14 {
>   			reg = <14>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   
>   		gpio@15 {
>   			reg = <15>;
> +			type = <PCA955X_TYPE_GPIO>;
>   		};
>   	};
>   
