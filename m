Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC99C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4B92076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldxAiEUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgG2Hpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2Hpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:45:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB234C061794;
        Wed, 29 Jul 2020 00:45:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so17663866wrx.9;
        Wed, 29 Jul 2020 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O+ETSXA6RyFZRpnWcbmn7fgTJlT89iJkYuFlDE0wwHw=;
        b=ldxAiEUF7m47Z96S6vgEZzfr3N9UpXPqj1PG8UnrxVKo8qRfizI9cjQLMlMP5AS7tj
         e2txp0GTVY7DIj4OlM9lIISC4YoeY/+0N6/eAWBzEewvqIiCRlBuaVBDZvg4ZthMoO7e
         CP+tkipdL6V50KMfZmRTbSA1mKr4y79WlC+3aYH/4yd896dfBw3VL3AnWytEm1wa9BdW
         KXBIdqFLicgjYThAF0GYX2nFIpPI0ST8Gw/IWvVSVpeK/tB7ys4T5K55YNszjvzbOkxC
         MOKuiM83Do4EwqlM3RbaCXYt1UtTaMKLG3vqPjhfrspupQns4dMeNPVA4wI8HuOyo4ze
         C2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O+ETSXA6RyFZRpnWcbmn7fgTJlT89iJkYuFlDE0wwHw=;
        b=XgIliVuO4QueqMEIdcX5/s/b1vKBZvbXF9zLIf2eSd1MaozystfkDsz40zV2wS1k7z
         1IScr+3OLBVdUBeKbocyGRUSxv93F4EoqQwCwFwwsiaDmtjnWByFuRqFdZmAmRP6d+I2
         uoKEV3OvfkN97gjF2MonnpnSTyXBhelMtxm0pwr0YVtbCLZaREVmpyad98/pi65lWPqC
         Ary1YdWyG4AV4GKdyn1OCII/f5gRXSlkRriUCGszXrIYJoNrQUGQ1QWvK+imvbU9+X8j
         Y+3rZJs+UB1T+fndwg7jzNaNRbMZT/9QYXRTPAILoqiy9N6gVlhKRqI3r94PxOVuaHoK
         ePLw==
X-Gm-Message-State: AOAM530tYeJTVvKw/8m/8XJiMDXY0U5xGNRV0s/s3mRBSX24tKs+a1wR
        DMIRkZA3Z94CBevtIzBg8aI=
X-Google-Smtp-Source: ABdhPJwfFlS5I2dKSqCQPxUR7kjkBgQTVm6GIWd3Aw/T37/KvKHZ0aX3Vj7Y/eIYZFtX/E6njpeFGA==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr26645654wro.233.1596008729618;
        Wed, 29 Jul 2020 00:45:29 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id c7sm3540328wrq.58.2020.07.29.00.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 00:45:28 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: mt8192: add infracfg_rst node
To:     Crystal Guo <crystal.guo@mediatek.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, seiya.wang@mediatek.com
References: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
 <1596008357-11213-3-git-send-email-crystal.guo@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b81f1936-caf0-e843-9556-14e3024d6d6f@gmail.com>
Date:   Wed, 29 Jul 2020 09:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1596008357-11213-3-git-send-email-crystal.guo@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/07/2020 09:39, Crystal Guo wrote:
> add infracfg_rst node which is for MT8192 platform
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index b16dbbd..adc6239 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -217,9 +217,17 @@
>   		};
>   
>   		infracfg: infracfg@10001000 {
> -			compatible = "mediatek,mt8192-infracfg", "syscon";
> +			compatible = "mediatek,mt8192-infracfg", "syscon", "simple-mfd";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> +
> +			infracfg_rst: reset-controller {
> +				compatible = "ti,syscon-reset";
> +				#reset-cells = <1>;
> +				ti,reset-bits = <
> +					0x140 15 0x144 15 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 0: pcie */

You have Texas Instruments hardware inside infracfg? Are you sure?

> +				>;
> +			};
>   		};
>   
>   		pericfg: pericfg@10003000 {
> 
