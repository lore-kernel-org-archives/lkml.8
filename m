Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEE7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682F92083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QOX8nsO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFVH6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgFVH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:58:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970EFC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:58:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so3855162wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RnzS9Psse9ulhOjd5cJJfFYSBWvJN3BYxrA41zp+nj0=;
        b=QOX8nsO8Phfz0d521oNL0WXfr55SOmcu2B7BVirXReZCfMgCS5XQIC5MMWH6UW0E9/
         kr9QyAqsVP1q50cG7HX8v6JsDEI+nPnfURWpKcP0lRJhsUdXZO+znoMsbr9lJSrCUkrA
         PLsGUoMTu38RoC9rGzRiXMGk8ntEbyfeN4kWJzejmxGwJ2r7w8IcXEGk3xdrfkJhmo+r
         bWqD1xrEnK0D6Woe37E7EKSViVwxS6G4Ky1ZSWbUfV4GisC7VNATbaNiMBEKESKCyuNO
         htDPJ6fQbFHP55sXCpyjIdkVYaDZQiu5NJoJEgH9YtcrHkzAH6GNEnKLINh9qG8sh57E
         NZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RnzS9Psse9ulhOjd5cJJfFYSBWvJN3BYxrA41zp+nj0=;
        b=I9ymNFaQHivcruxsST1ZqKrAIyTFM44FXCkwULf5xVrXq01FX5R5yXEx83fq0RL5lM
         yqJWpu4AGEyMe37ErQxfD5ydAC9XAUCBSxpPNQrvB7YdzoxtxRwT51eEHhYf1VHbT12M
         SroVc3GXZc0VH52SgucKs5q1Vs738xuWasGAkPYR+v1UBuSSxOF0pXQeH8B23skh/9k8
         IUqketJHgaff+LJV13yTeeaJ3DabWWARj3ozpLgCypO7zftalGJMh2tteTZyvrbGEXGE
         e16zsRdoXQwK8k4wh7yt8+QLfn5Axnejgk6Dy93iVQmT8dpMdUI9KN9491EewU6sCUMS
         fukg==
X-Gm-Message-State: AOAM530/AuHDxsEHVp59+0InllKlGTo42DAE4eX9X1JrKbxE5i/O1n0V
        wAZt+qtBBrQrNMcv4bfE9rvT3imh6d0jGg==
X-Google-Smtp-Source: ABdhPJy3U2wK4+JdJX4gut5BkGA3c3/jfHgcznW8Hklmr+1Ep19p5B+lNyN4fQPG/fEp1c1zSXbMyg==
X-Received: by 2002:adf:df03:: with SMTP id y3mr16809629wrl.376.1592812726975;
        Mon, 22 Jun 2020 00:58:46 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc? ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id d63sm16560122wmc.22.2020.06.22.00.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 00:58:46 -0700 (PDT)
Subject: Re: [PATCH v2] soc: amlogic: meson-gx-socinfo: Fix S905X3 and S905D3
 ID's
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200609081318.28023-1-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <8757c066-2590-ff24-ebcc-2a9508fd9968@baylibre.com>
Date:   Mon, 22 Jun 2020 09:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609081318.28023-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2020 10:13, Christian Hewitt wrote:
> Correct the SoC revision and package bits/mask values for S905D3/X3 to detect
> a wider range of observed SoC IDs, and tweak sort order for A311D/S922X.
> 
> S905X3 05 0000 0101  (SEI610 initial devices)
> S905X3 10 0001 0000  (ODROID-C4 and recent Android boxes)
> S905X3 50 0101 0000  (SEI610 later revisions)
> S905D3 04 0000 0100  (VIM3L devices in kernelci)
> S905D3 b0 1011 0000  (VIM3L initial production)
> 
> Fixes commit c9cc9bec36d0 ("soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs")
> Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  drivers/soc/amlogic/meson-gx-socinfo.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
> index 01fc0d20a70d..6f54bd832c8b 100644
> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
> @@ -66,10 +66,12 @@ static const struct meson_gx_package_id {
>  	{ "A113D", 0x25, 0x22, 0xff },
>  	{ "S905D2", 0x28, 0x10, 0xf0 },
>  	{ "S905X2", 0x28, 0x40, 0xf0 },
> -	{ "S922X", 0x29, 0x40, 0xf0 },
>  	{ "A311D", 0x29, 0x10, 0xf0 },
> -	{ "S905X3", 0x2b, 0x5, 0xf },
> -	{ "S905D3", 0x2b, 0xb0, 0xf0 },
> +	{ "S922X", 0x29, 0x40, 0xf0 },
> +	{ "S905D3", 0x2b, 0x4, 0xf5 },
> +	{ "S905X3", 0x2b, 0x5, 0xf5 },
> +	{ "S905X3", 0x2b, 0x10, 0x3f },
> +	{ "S905D3", 0x2b, 0x30, 0x3f },
>  	{ "A113L", 0x2c, 0x0, 0xf8 },
>  };
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
