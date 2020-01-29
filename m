Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4252C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EF820702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RCII856z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgA2UiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:38:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38396 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgA2UiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:38:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so251446pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 12:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I/3MIyesWwLMZvoquoi7/37fnkG30lH2RtrUZl2JY2g=;
        b=RCII856zNQ+5oofjSFPKITF/gPTInLOj3Bh8ZgmaHEk7wpcvKCtOUKUxi5Fazcpk2x
         jG+C3Ps8b6d29UipkLfgcYTpH6UEhv7b4AhlR7c9O3RWekLCn6gki/XcsACCuIrSgef4
         dwsyBtU4SN7Piz79NMuLyKVtBEcqEN039rBOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I/3MIyesWwLMZvoquoi7/37fnkG30lH2RtrUZl2JY2g=;
        b=thxpz0Gr44LpTpDdbpUJNWBBnYzHHQv7bwLBjnRTmGunD+QKrSEgasHnEZPOcn2R98
         uN0ip5wWlvGtrTDl2KNjSi9sE8zBsPE2zPZX5OlDsA9a7mGUnaRlXRhlt9VNpzyuzssD
         mVQxcTvoWOkxiefNeP8bjLZEJB2xrWhd2cC3dF8YXvNoCSfDJIDrlquVhJ77Nv2Z4eFz
         bsgxyUKGyPMiTjacoWs6NqDyc+VBiMq7yh/ELZ0ic7DXY3keb/8OExDiJA5h1etiSkIp
         XbgR1o1QLKrjGjssbpFC8AEFdqXf3z372EiyzN1s5lexBql1VFaCeMq2upCL6cPrGQSX
         50zA==
X-Gm-Message-State: APjAAAUhw8k0+4OirF0h757gJtt3Ej1oeXVCes73mQYIzTO0QDfjtZRp
        JgPP9Z6eIw+Kn0cZMRRaWF98jQ==
X-Google-Smtp-Source: APXvYqzTw+xm1aPbfFtOpUBNxbQQnU4Kqem8ct4fM6luLP9FdjijLkOJpwXwa0gAgqPC142Zo9Dy1g==
X-Received: by 2002:a63:1f21:: with SMTP id f33mr918798pgf.91.1580330300869;
        Wed, 29 Jan 2020 12:38:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b185sm3644304pfa.102.2020.01.29.12.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 12:38:20 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:38:19 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/8] dt-bindings: phy: qcom-qusb2: Add support for
 overriding Phy tuning parameters
Message-ID: <20200129203819.GE71044@google.com>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
 <1580305919-30946-5-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580305919-30946-5-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 07:21:55PM +0530, Sandeep Maheswaram wrote:
> Add support for overriding QUSB2 V2 phy tuning parameters
> in device tree bindings.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> index 43082c8..dfef356 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> @@ -80,6 +80,28 @@ properties:
>          maximum: 63
>          default: 0
>  
> +  qcom,bias-ctrl-value:
> +    description:
> +        It is a 6 bit value that specifies bias-ctrl-value. It is a PHY
> +        tuning parameter that may vary for different boards of same SOC.
> +        This property is applicable to only QUSB2 v2 PHY.

As commented on 'dt-bindings: phy: qcom,qusb2: Convert QUSB2 phy bindings
to yaml' a possible improvement could be to restrict these properties to
the QUSB2 v2 PHY through the schema.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 63
> +        default: 0
> +
> +  qcom,charge-ctrl-value:
> +    description:
> +        It is a 2 bit value that specifies charge-ctrl-value. It is a PHY
> +        tuning parameter that may vary for different boards of same SOC.
> +        This property is applicable to only QUSB2 v2 PHY.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 3
> +        default: 0
> +
>    qcom,hstx-trim-value:
>      description:
>          It is a 4 bit value that specifies tuning for HSTX
> @@ -118,6 +140,17 @@ properties:
>          maximum: 1
>          default: 0
>  
> +  qcom,hsdisc-trim-value:
> +    description:
> +        It is a 2 bit value tuning parameter that control disconnect
> +        threshold and may vary for different boards of same SOC.
> +        This property is applicable to only QUSB2 v2 PHY.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 3
> +        default: 0
> +
>  required:
>    - compatible
>    - reg

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
