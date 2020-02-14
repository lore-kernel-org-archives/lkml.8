Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF268C3B19D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859132082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0DSWpQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgBNPXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:23:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35436 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgBNPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:23:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so11620829edv.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iS6rIChJcSTaaI1Nz9SixMHI08wMem1DxlHDDVUuoQc=;
        b=Q0DSWpQlYw40CM2s7bmXe66Q4hjXXHnPWGOXCxqFnp2fykuf72NaBN56YMu0EUxOaf
         XSLajIVpJQz9aLUhsZl6A/A0S/CytZwJQJgwBLRe1kJA4yN30jnjeurCj87vXgcxDd0m
         UpmN1gszuxHjAxv7CNUjyOU/UIWDSMWSrM2lhot2tMm4L9/oQRABlcs7jsqpv4h8wXnb
         bUPPi+kWXLtBd4ygYkq4veBBcmZNHnODBK+N/CdCOzZPc6G0pfuQzU94eLlfi19LeNl5
         GaSOGgeKKuBu59MKxmerkVK68WdFpadIeYZ1SWQ/z/w/UpkjLOZD9FKNdefm2BLcppq4
         uDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iS6rIChJcSTaaI1Nz9SixMHI08wMem1DxlHDDVUuoQc=;
        b=MXakYmKyTGZSLD5lL3uva3+YJQikidxpnuqBjw9wqxmeYVwcCLbCCEz97H6FLk9QEm
         i7jBVA8Ss5SAYAQhPisJMzORLdbuLqXKjCXvvs87y4iLFJrCy1bz0za8aStzAAoTAPxu
         1cWuXjxei7a3N38jYaKhcMziWY09M7qsAnitD9fCR1tk2RkW/r/8+XSGZbzMYUwBAJDW
         hSHcPOHpi4nDziNACD1E+lnxEAk2hTP4sKos/zw9eFtcSn9VG39twrAXDg0chmuw0Z6c
         XvGvYwcmYR9EtM8anOgIR5N8Mnu0UUpcHKg6iKZtAxAkJEkTjRExJ/FQZVRmYPDC908X
         pu+w==
X-Gm-Message-State: APjAAAWKyCIROYTokQwOr4/37lMnP3Yl/KGjfvrFtv2+jpysxGJ+mLpM
        MGYIoRpKvrNujch+zEvzJa0g0Q==
X-Google-Smtp-Source: APXvYqwN7skpBywZiJr9HDS44ZkTIixbeEY5BIadBj8NT4M1HsZKHUwKNIuZyy3ViSTlyMlpZktrwg==
X-Received: by 2002:aa7:d897:: with SMTP id u23mr3077160edq.50.1581693827401;
        Fri, 14 Feb 2020 07:23:47 -0800 (PST)
Received: from [192.168.27.209] ([94.155.124.210])
        by smtp.googlemail.com with ESMTPSA id m27sm370689eda.96.2020.02.14.07.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:23:46 -0800 (PST)
Subject: Re: [PATCH V4 2/4] dt-bindings: media: venus: Add sc7180 DT schema
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
References: <1579006416-11599-1-git-send-email-dikshita@codeaurora.org>
 <1579006416-11599-3-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <dbbd3b64-e030-a2f4-992c-ff90706b0ab5@linaro.org>
Date:   Fri, 14 Feb 2020 17:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579006416-11599-3-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'll merge this through media tree but will drop interconnect properties
from example cause of failing make dt_binding_check.

We will add interconnect properties later on once the sc7180
interconnect driver is merged.

On 1/14/20 2:53 PM, Dikshita Agarwal wrote:
> Add new qcom,sc7180-venus DT binding schema.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../bindings/media/qcom,sc7180-venus.yaml          | 144 +++++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> new file mode 100644
> index 0000000..7b6a8fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/media/qcom,sc7180-venus.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Venus video encode and decode accelerators
> +
> +maintainers:
> +  - Stanimir Varbanov <stanimir.varbanov@linaro.org>
> +
> +description: |
> +  The Venus IP is a video encode and decode accelerator present
> +  on Qualcomm platforms
> +
> +properties:
> +  compatible:
> +    const: qcom,sc7180-venus
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 2
> +
> +  power-domain-names:
> +    items:
> +      - const: venus
> +      - const: vcodec0
> +
> +  clocks:
> +    maxItems: 5
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +      - const: bus
> +      - const: vcodec0_core
> +      - const: vcodec0_bus
> +
> +  iommus:
> +    maxItems: 1
> +
> +  memory-region:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: video-mem
> +      - const: cpu-cfg
> +
> +  video-decoder:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: venus-decoder
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +  video-encoder:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: venus-encoder
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +  video-firmware:
> +    type: object
> +
> +    description: |
> +      Firmware subnode is needed when the platform does not
> +      have TrustZone.
> +
> +    properties:
> +      iommus:
> +        maxItems: 1
> +
> +    required:
> +      - iommus
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - power-domains
> +  - power-domain-names
> +  - clocks
> +  - clock-names
> +  - iommus
> +  - memory-region
> +  - video-decoder
> +  - video-encoder
> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        #include <dt-bindings/clock/qcom,videocc-sc7180.h>
> +
> +        venus: video-codec@aa00000 {
> +                compatible = "qcom,sc7180-venus";
> +                reg = <0 0x0aa00000 0 0xff000>;
> +                interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +                power-domains = <&videocc VENUS_GDSC>,
> +                                <&videocc VCODEC0_GDSC>;
> +                power-domain-names = "venus", "vcodec0";
> +                clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> +                         <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> +                         <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
> +                         <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> +                         <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> +                clock-names = "core", "iface", "bus",
> +                              "vcodec0_core", "vcodec0_bus";
> +                iommus = <&apps_smmu 0x0c00 0x60>;
> +                memory-region = <&venus_mem>;
> +

>>>>

> +                interconnects = <&mmss_noc MASTER_VIDEO_P0 &mc_virt SLAVE_EBI1>,
> +                                <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_VENUS_CFG>;
> +                interconnect-names = "video-mem", "cpu-cfg";

<<<<

> +
> +                video-decoder {
> +                        compatible = "venus-decoder";
> +                };
> +
> +                video-encoder {
> +                        compatible = "venus-encoder";
> +                };
> +        };
> 

-- 
regards,
Stan
