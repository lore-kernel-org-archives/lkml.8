Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D0C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5213220733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZLDcC7OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBJJY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:24:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37222 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgBJJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:24:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so6647661wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 01:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6LLNGWwnNqxNd6F2xQZE8zoYhDbdrpNBw6F4uoch4qI=;
        b=ZLDcC7OLt3G31KAu25tSEdvNou0PhatIGyppZwEu9itBb1t4yIkP/svSC6l96YKiVL
         xjTlS84Zy7/nCgwpwmTGFbdxD2eBTw52iqzOMxlXNYhtv9Undcr8k9mbeQuoQY08/yBk
         Gb/v8CCIJnNE3oX5YVgoBu+S2wUVdKKeDQRSoyfjgJsPYkgp+rvvew9bxKVbdHfi6xKp
         uC44YYDZSP2mlVAyyiTnAAoqUlXsjjwJtRRf1tk9kiKWg1t6EWpL1FXr2rcqxHxICP2d
         1VqmGAllGW6b37CatwNj5HVUirepg9WTlYJ06/3Le2QoD18fd9Oe6hh3IlpZQzm/Ya0v
         3Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6LLNGWwnNqxNd6F2xQZE8zoYhDbdrpNBw6F4uoch4qI=;
        b=Mo2XfrH0z20U3NbHzTZhzSHwIuwEO9ClvyVzYhdNwkVKTJApznW2beLWrJbpDX1Iqw
         8DqvDMnLfht+g9nOvdq3d1K78UxdQXtmuL2H1kg/m46N070+27yKLOIjOrR86++5RmZy
         F7BZ7mFQr8LnVXfgs4oil17e/mC9Xj13pa9wH1jrHQfW0XGRs0fKo7uvRenfe6YYQLPr
         2J+c1hHqJlOVgqy4RUKHCBUsRKuUoG5hctqR2+luTbZEhfjFpsfrcNPP9wcowSkMh6qx
         1bO7ctWeHA8ihQOfX3OGFDxoKWdzeEgC0R0KYtV9WjRwFCuagpuxYe3kjWIwpEZpxIii
         prKg==
X-Gm-Message-State: APjAAAXjw/jEP7XkBFm4KXUdaS3sAfBe8F6e+tK7CERAe0qj8fxwkDWc
        1wYjFxy4DBJYCyielXj/qB0g6WrzyRLSSw==
X-Google-Smtp-Source: APXvYqwWmHHZ07oJdmYmRDGOHUzm8xZAXkbqyM/BPjQx4uigstOFbyC/KKJzipZNxpU6sNepxRPLjg==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr803652wrb.33.1581326692747;
        Mon, 10 Feb 2020 01:24:52 -0800 (PST)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l15sm15458585wrv.39.2020.02.10.01.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 01:24:52 -0800 (PST)
Subject: Re: [PATCH v4 0/3] drm: bridge: adv7511: Add support for ADV7535
To:     Bogdan Togorean <bogdan.togorean@analog.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, gregkh@linuxfoundation.org,
        tglx@linutronix.de, sam@ravnborg.org, alexander.deucher@amd.com,
        matt.redfearn@thinci.com, robdclark@chromium.org,
        wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org
References: <20200121082719.27972-1-bogdan.togorean@analog.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <ec42e0c3-9238-a193-b1a8-57fee89dd185@baylibre.com>
Date:   Mon, 10 Feb 2020 10:24:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121082719.27972-1-bogdan.togorean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2020 09:27, Bogdan Togorean wrote:
> This patch-set add support for ADV7535 part in ADV7511 driver.
> 
> ADV7535 and ADV7533 are pin to pin compatible parts but ADV7535
> support TMDS clock upto 148.5Mhz and resolutions up to 1080p@60Hz.
> 
> ---
> Changes in v4:
>  - get out ADV7533 v1p2 voltage selection of this patch set
>  - removal CONFIG_DRM_I2C_ADV7533 from Kconfig moved to new commit
> 
> Bogdan Togorean (3):
>   drm: bridge: adv7511: Remove DRM_I2C_ADV7533 Kconfig
>   drm: bridge: adv7511: Add support for ADV7535
>   dt-bindings: drm: bridge: adv7511: Add ADV7535 support
> 
>  .../bindings/display/bridge/adi,adv7511.txt   | 23 ++++++-----
>  drivers/gpu/drm/bridge/adv7511/Kconfig        | 13 ++----
>  drivers/gpu/drm/bridge/adv7511/Makefile       |  3 +-
>  drivers/gpu/drm/bridge/adv7511/adv7511.h      | 40 +------------------
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  | 20 +++++-----
>  5 files changed, 26 insertions(+), 73 deletions(-)
> 

Applying to drm-misc-next with Andrzej's r-b, patchwork missed them...

Neil
