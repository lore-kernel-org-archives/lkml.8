Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54370C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E28321973
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594692843;
	bh=q05MLq7bX1XyoNb93CUTW5If2isAdq0kxDegyXhy0Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J3Dr6WFv9ML8BiXSgmMgKCi5epmI0LKJZ/j/JY+wwRdDIuAAhyIBLyATG4Ov7AWtV
	 DAv7Hhu5HWb0xeCGZUbqFMixEumU55/6Aoiirau5707nZovVIjz2S4JKWx8zcZJ/mw
	 DwwasgVIhaYB6cA8lDaty09e+hEdOMIKqdK9fiKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGNCOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:14:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34938 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNCOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:14:01 -0400
Received: by mail-io1-f67.google.com with SMTP id v8so15720761iox.2;
        Mon, 13 Jul 2020 19:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C+dgJBiObKmhR4JP1UeGCITpVO+CO7lrYLHGkNo5jx4=;
        b=C6y0HkcR/lr1mJEsKrrSWlO4joCXBKGeZ6jxMJNjjMFUzQhMK0DU4b7GV+3myKa5u+
         mNNm9vsdv3ps3k0e9SgrIRaUEo5WrB4KONt/SG+CnEISilVXT/iDXNdTBPItI5WICYaA
         viwx59e+bfxObzaYuz4wwhZIgEj5IPFv6Y5aN/Lmb/HpZn9fKyfz8h33XKopMwWr8wUu
         pm4iTLcp36yYxiOyI6ASRsZhpXh9aEo0iNaiQTHnnRHxpjAFk4eS4bX0qra3IfjXOBX3
         fpDQNkFGSigbZjVwe+Q1buPAm7sIDlZQMQIC40rK6XgKFYulw0tNpjKF1fR5KF1BvjYu
         hdpw==
X-Gm-Message-State: AOAM530mlviz3xTW+g4+H6tRG1cgrmte6hoar71aEuw8sAQ3qjvCfjmF
        yCVFdqB9gDRMdBDmEfoscQ==
X-Google-Smtp-Source: ABdhPJzrcMOoGSZYtZg0y6yOE5FDvN85POZPSvpYtiCv2Ey0dVSwjar8881k3UDJhMR9vQ7Ig3Lu2A==
X-Received: by 2002:a02:ba05:: with SMTP id z5mr3406590jan.127.1594692840298;
        Mon, 13 Jul 2020 19:14:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k3sm8450085iot.42.2020.07.13.19.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:13:59 -0700 (PDT)
Received: (nullmailer pid 1139098 invoked by uid 1000);
        Tue, 14 Jul 2020 02:13:58 -0000
Date:   Mon, 13 Jul 2020 20:13:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Tai =?utf-8?B?W+aItOW/l+WzsF0=?= <james.tai@realtek.com>,
        Stanley Chang =?utf-8?B?W+aYjOiCsuW+t10=?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/29] dt-bindings: soc: realtek: rtd1195-chip: Add
 iso-syscon property
Message-ID: <20200714021358.GA1138124@bogus>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-6-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623025106.31273-6-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 04:50:42AM +0200, Andreas Färber wrote:
> Allow to optionally specify a phandle to iso syscon to identify the chip.
> RTD1295 family will want to check the ISO_CHIP_INFO1 register.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  A SoC specific binding would defeat the purpose of the generic Linux driver
>  detecting the SoC based on registers.
>  Simply allowing it all for SoC families seems the most flexible.
>  
>  v1 -> v2:
>  * Instead of extending reg, allow optional iso-syscon property for RTD129x.
>    Iso syscon currently does not have a compatible, and it may need to differ
>    across SoC families.
>  
>  .../bindings/soc/realtek/realtek,rtd1195-chip.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
> index 86a1de214782..dfe33c95f68d 100644
> --- a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
> +++ b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
> @@ -11,6 +11,7 @@ maintainers:
>  
>  description: |
>    The Realtek DHC SoCs have some registers to identify the chip and revision.
> +  To identify the exact model within a family, further registers are needed.
>  
>  properties:
>    compatible:
> @@ -19,6 +20,8 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  iso-syscon: true

Needs a type $ref (phandle).

> +
>  required:
>    - compatible
>    - reg
> @@ -31,4 +34,10 @@ examples:
>          compatible = "realtek,rtd1195-chip";
>          reg = <0x1801a200 0x8>;
>      };
> +  - |
> +    chip-info@9801a200 {
> +        compatible = "realtek,rtd1195-chip";
> +        reg = <0x9801a200 0x8>;
> +        iso-syscon = <&iso>;
> +    };
>  ...
> -- 
> 2.26.2
> 
