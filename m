Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE7BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8887420809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCFrhuo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgG2Hsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Hsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:48:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB60C061794;
        Wed, 29 Jul 2020 00:48:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g8so1806814wmk.3;
        Wed, 29 Jul 2020 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wWA3cfypyLmf7qdbYPEp9Obskc/EXQ9KkvF/jWM+ZEI=;
        b=gCFrhuo7zYWBXf2i8cx0tOErYZ0Pmiuh2uXm0va/SQt0m42M9hhwAk8iDFOxRzSmz/
         7YZ+EGjSJBE9EHJDG8AhAOt5sOPumX6vDoSSvOD4swOTxjibEeLBP0PjQ9bFsO1oaKtH
         IQMTUYnH5Ytg8ONzqJo4ZTP/06cuBJx3hdkqDGYgm8rXjehHtPBM8uD5vzrCL3Dt1XBw
         XpzaVOCCWfFO3jrCyeIO7QPFvtgYTlpVGPvoCKNS5Whb4Zb1iz8DiskdKmoAH9TtB4H1
         O9oBxd/DJTehKCKhaalzFoeRsPcVOK2U3l6bQ3ls65MfeSZjaC8/8MMPOABf7vaNNB5k
         X7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wWA3cfypyLmf7qdbYPEp9Obskc/EXQ9KkvF/jWM+ZEI=;
        b=IBOLD129jhsJJTzK/8LupbzhPlAiV3ywhlbil0JTeAdV8tWKoGeVRPLSdLm11DQbTA
         pupw/qSt00xk3HG2jI8dDtjPeSof0C5j80hl/iAuQLU1gPL+TWi6sGPD4Juius/+a+4e
         ohrD8Y/iQhTBOlgbxQdfn1XIo5otg/Zfb+r5ltjn9Zpo2xnKiel8dU7F75gOaRnXx7jk
         /f6BR0K1Dm0PkE+T6ZdhsCZY1OSE2xMlKxDVAMPMfhOLYiLMGXemCVSHxyuJNqhmWpBe
         yavuez0Pr1ItdyhS+JxsrgnAHCF/gkzyi1jecIjh9b71cHctS6tkQ6zEw9u8E+t6rMzM
         Xeeg==
X-Gm-Message-State: AOAM5320fAwTuP73rpv2uwXakgd0naovH2nMFnXKxD20ydDjOCGW8ZoX
        BILYSLlp2HparUQikGN9wnc=
X-Google-Smtp-Source: ABdhPJw18Au7sbqmb2ly8qEkFwpnF373GPLonF39c3FLWDODiw+v1gYTJWkig9ko8XkbuWkbIICozQ==
X-Received: by 2002:a1c:660a:: with SMTP id a10mr7018743wmc.115.1596008924274;
        Wed, 29 Jul 2020 00:48:44 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id 68sm3632756wra.39.2020.07.29.00.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 00:48:43 -0700 (PDT)
Subject: Re: [PATCH 1/2] reset-controller: ti: adjust the reset assert and
 deassert interface
To:     Crystal Guo <crystal.guo@mediatek.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, seiya.wang@mediatek.com
References: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
 <1596008357-11213-2-git-send-email-crystal.guo@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <ba0d1e29-3ba3-5379-d03e-1ccec21c2ffa@gmail.com>
Date:   Wed, 29 Jul 2020 09:48:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1596008357-11213-2-git-send-email-crystal.guo@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/07/2020 09:39, Crystal Guo wrote:
> Add ti_syscon_reset() to integrate assert and deassert together,
> and change return value of the reset assert and deassert interface
> from regmap_update_bits to regmap_write_bits.
> 
> when clear bit is already 1, regmap_update_bits can not write 1 to it again.
> Some IC has the feature that, when set bit is 1, the clear bit change
> to 1 together. It will truly clear bit to 0 by write 1 to the clear bit
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>   drivers/reset/reset-ti-syscon.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
> index a2635c2..5a8ec8f 100644
> --- a/drivers/reset/reset-ti-syscon.c
> +++ b/drivers/reset/reset-ti-syscon.c
> @@ -89,7 +89,7 @@ static int ti_syscon_reset_assert(struct reset_controller_dev *rcdev,
>   	mask = BIT(control->assert_bit);
>   	value = (control->flags & ASSERT_SET) ? mask : 0x0;
>   
> -	return regmap_update_bits(data->regmap, control->assert_offset, mask, value);
> +	return regmap_write_bits(data->regmap, control->assert_offset, mask, value);

Nack, this will break the driver for the other devices.
The kernel has to work not just for your SoC but for all devices of all 
architectures. You can't just hack something up, that will work on your specific 
SoC.

Regards,
Matthias

>   }
>   
>   /**
> @@ -120,7 +120,7 @@ static int ti_syscon_reset_deassert(struct reset_controller_dev *rcdev,
>   	mask = BIT(control->deassert_bit);
>   	value = (control->flags & DEASSERT_SET) ? mask : 0x0;
>   
> -	return regmap_update_bits(data->regmap, control->deassert_offset, mask, value);
> +	return regmap_write_bits(data->regmap, control->deassert_offset, mask, value);
>   }
>   
>   /**
> @@ -158,10 +158,19 @@ static int ti_syscon_reset_status(struct reset_controller_dev *rcdev,
>   		!(control->flags & STATUS_SET);
>   }
>   
> +static int ti_syscon_reset(struct reset_controller_dev *rcdev,
> +			   unsigned long id)
> +{
> +	ti_syscon_reset_assert(rcdev, id);
> +
> +	return ti_syscon_reset_deassert(rcdev, id);
> +}
> +
>   static const struct reset_control_ops ti_syscon_reset_ops = {
>   	.assert		= ti_syscon_reset_assert,
>   	.deassert	= ti_syscon_reset_deassert,
>   	.status		= ti_syscon_reset_status,
> +	.reset		= ti_syscon_reset,
>   };
>   
>   static int ti_syscon_reset_probe(struct platform_device *pdev)
> 
