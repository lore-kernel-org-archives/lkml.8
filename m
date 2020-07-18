Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56520C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3585322B48
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BhMPO6/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgGRIsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 04:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgGRIsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 04:48:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40BBC0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 01:48:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so13423742wrp.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=BjhOckuzjQ8qA75c221JxO7XJtdarvNGL84ItYCWCv0=;
        b=BhMPO6/9G8wcxqz03YbmYYe/ndNtetAFO8a9Nx1XnyNOd0DDSBgR4SPJ3F2BqOgEOH
         r6i64c8vNlLEwNuvtbj6qKL0rV4hr5KXaEi40lJ45Nq05z0OaG2oVroJQv5fCJUCR5U+
         +PfGmmAXnm03NUWLQx1tJFLDhd70zUzHJJkacc9c1FL1+Hc5NiQO40kjt7uUqNTE65eN
         gjuEDgOsI/Kjd8PWXxtqdySW8DgcHg2agIHhxrVHX/XhGK7Oa8DbQ0GUQGOBYGUP1njC
         4tGWi49W4Oqnale+QiNfsCM0qi+oJF6bcV/gIUMHXJB2SEzCfFSZ4mq8rkUfFrntdKG3
         79Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BjhOckuzjQ8qA75c221JxO7XJtdarvNGL84ItYCWCv0=;
        b=eqs9Ft5jXS0vUOTOZPZm50EPTVOa3YDJwYdIXc2fIUO7PwZ8w00V1e4Vx9EZNaA92I
         w6n8GTvhe6gQC31bTBYh2AVKgNk44q/cLbdVlQphGksjrwfOJgk4RKwxpMy7AemAmOxr
         eIY8jeGQexmXM0TSL9mCGFAZjGss/GTRBIX5F2r3Ir6D/w+uDKLK3VrXBKjBAwGsCDQo
         B5HAUubxQo5fNEKwlR/qOwxyJvoeLBadg2TA6LGSFdbMazfpRdhfxoCCGN71B42yR0Do
         CnpejexUSBvvo1BS4L3duWjXQCLV2C4QKfWNPX/e/879kHCl0AA3endBnQ2cJNA1s2Yh
         2ZxA==
X-Gm-Message-State: AOAM530DN+sqiV1XIhRl8INf9l91ZA8kwGeJz1tWYdxLRNQ/+2kDRfDS
        cZ5db9qRVJ//KBn+wk1xweDin/GPHZdkOg==
X-Google-Smtp-Source: ABdhPJx/Kazr2a2GBlOYCPRTxUJoU9hxnfl4aBe6j1HembJqBpTiqWfE52+z9kxOmbbOyQYIVrVhMQ==
X-Received: by 2002:adf:a4c8:: with SMTP id h8mr118367wrb.262.1595062115944;
        Sat, 18 Jul 2020 01:48:35 -0700 (PDT)
Received: from Armstrongs-MacBook-Pro.local ([2a01:e35:2ec0:82b0:9d0:bf63:799d:4aa1])
        by smtp.gmail.com with ESMTPSA id k131sm19391018wmb.36.2020.07.18.01.48.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 01:48:35 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: update spifc node name on Khadas
 VIM3/VIM3L
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200718054505.4165-1-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <a3b745d9-c73e-b56e-5b94-6c79f2197bc4@baylibre.com>
Date:   Sat, 18 Jul 2020 10:48:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200718054505.4165-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 18/07/2020 à 07:45, Christian Hewitt a écrit :
> The VIM3/VIM3L Boards use w25q128 not w25q32 - this is a cosmetic change
> only - the device probes fine with the current device-tree.
> 
> Fixes: 0e1610e726d3 ("arm64: dts: khadas-vim3: add SPIFC controller node")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 27408c10a811..6b75157265e1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -360,7 +360,7 @@
>  	pinctrl-0 = <&nor_pins>;
>  	pinctrl-names = "default";
>  
> -	w25q32: spi-flash@0 {
> +	w25q128: spi-flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		compatible = "winbond,w25q128fw", "jedec,spi-nor";
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
