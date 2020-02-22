Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7395C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913C8206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="pv3F9y3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgBVSGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:06:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32893 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgBVSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:06:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so5666782lji.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 10:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GBIxSIeZmeDMNIuD3/L4tNo0lsdugthZe8A+ZiKwsNU=;
        b=pv3F9y3+OT0H8xQLmYaVojz8GUG0opoKQ+jwNHqay+rxS+VwZGx6fv683ddYF7GAs+
         bklU9TDNvtruVUeDZq9Og0hh92ncVq4GATaY1vjCxtMi+RCqYZnpovILqZ5PZbxFj9Zm
         quQv/z2VtTAxdrDeqGZI6Tp9gwbwimdMdN8xvUl0GCIt40eaMcZgkjaPpilR7TniAKL8
         qTdy41GaI/3HApqI9eFLBsGeG5n93/vCVhUKgZqLsiRWu8KycHFvl8jmplg4RnBODxsd
         L9x9K8Umfb8J+dcgF2oTtP46n4cMnMFJHTtToz+di+1cjldzcw7hX0Jdjdmf1NuA/T/d
         SJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GBIxSIeZmeDMNIuD3/L4tNo0lsdugthZe8A+ZiKwsNU=;
        b=HwBP/izps0tsdYeBn5ceMfk4jbwd0zhwOpCc1q1WY+R+pyimSviQmGtmSpFxes8edo
         2QNZb1UVxU8qq3BVvFnz5z621oElhnR8L62+H0HmGWx6JlCGC5fsBfaVEizhsx2qR2ye
         EWP2W59pZajGhjp+mfDRAcatcScXnCio4mbCy2jtwrpF7bRPuhJgcr/GYWT7WyhyWhI3
         gqHMQLzwxY9nItzTQb4icJlz2yFtRESUjXJBbKfJ03XQYqGHRUJ5h/RXFy76zI5VOIf6
         VbFTJpbmlAlwIt63GZggcAFp0KzASXnmj1vu6Niga0gJYO9sW0DoPzpI2eiVi/UmQoZO
         kFug==
X-Gm-Message-State: APjAAAUFcJSElP3S0rW273Ri4HhhxjT4GD/as74fNa5lAGhaU7KKBlzQ
        GZ2pnU3haE96t94zhoC3YnLV6YhkIGI=
X-Google-Smtp-Source: APXvYqyvWJSQqBtILUCVcF2wX6xT0599tZsTh8hWakuWZ2eucs2bVjoe3wXtngSXRR3NSaMlJ3Lixw==
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr25878094lji.274.1582394805812;
        Sat, 22 Feb 2020 10:06:45 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4621:26b8:f6bb:b31c:6567:7228])
        by smtp.gmail.com with ESMTPSA id i13sm3602020ljg.89.2020.02.22.10.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Feb 2020 10:06:44 -0800 (PST)
Subject: Re: [for-next PATCH 5/5] arm64: dts: ti: k3-j721e-mcu: add scm node
 and phy-gmii-sel nodes
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20200222120358.10003-1-grygorii.strashko@ti.com>
 <20200222120358.10003-6-grygorii.strashko@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <f54c18c5-9c74-7853-1812-1b31d4160307@cogentembedded.com>
Date:   Sat, 22 Feb 2020 21:06:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200222120358.10003-6-grygorii.strashko@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02/22/2020 03:03 PM, Grygorii Strashko wrote:

> Add DT node for MCU System Control module DT node and DT node for the TI
> J721E SoC phy-gmii-sel PHY required for Ethernet ports mode selection.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 16c874bfd49a..9b3d10241a2e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -34,6 +34,20 @@
>  		};
>  	};
>  
> +	mcu_conf: scm_conf@40f00000 {

   The devce names should be generic and it appears that DT spec even has has
a device name "syscon".

[...]

MBR, Sergei
