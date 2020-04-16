Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E272076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8+oqw36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440001AbgDPHxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439413AbgDPHxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:53:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50138C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:53:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so3717290wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWi7tVEBK3eitiTUkTDRlr7CasUjEy622sMKla6hhbQ=;
        b=C8+oqw36oJHPQWBehGKoAApS/MFiHO7b0MVSIU+V6o04EGH/VaPug3ziLVikMNYA1P
         STwXn0xGCjfODeWLAB13n2if2+hkIs5ysxJB0DbATwGVp+AhO+tjU71tHKlHiIE+CkXe
         CkGOuWjjSHkI8AgZVLvF+u84Y/lBhFEoqr6IPEHGfSMNMWStg/j8py06ywhF/S31k4w8
         bcOo8DeV9S50b9WskmtzGIRmcelCuPwcqziLxv3T0S9vxTZbT7ii/S/QY0noDkbzwRre
         7CEUWcbTBOZGBj6E/wOt4ggFrRnFdbfu89+UMhVtmG4wzHCcV6IYFBdIwel3ugf576lp
         S57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWi7tVEBK3eitiTUkTDRlr7CasUjEy622sMKla6hhbQ=;
        b=kDtfFGGdtGc8vvDfk2/+kqoAxATXMLfH7ErNRLUNEN/hWqoQxQXVfW8lhI9jBP0F9F
         kAMYtDmYsrxIsF/1iULTf9XJlP4hiJcQq2S6OjkoURBKKd78ejc5nTLSUBJPBjhgp6b5
         s6Jrj91Zp+jt0YxvZOLGBuvfGbJcc0bP+RRaNVI1gjvLIR/d4J5lvMySJesLmvKAMJSP
         g/Pdw7q4jEwq+pkxvHk3Fmqn5zOZwKjJ1VKabhOGk3pyuaTd5m8PEsCRjZlC/JhTdBIO
         d2qIoWMQabe+Ynxryg/gHIWuceK38eJPp+E4YB8FyMtUu4JHEneIvwRYK3CxQ9NLqoiu
         amjQ==
X-Gm-Message-State: AGi0PuZZpsSvx0nEhxm4NPSo5TPLiV/QNqfzpFEyff0vPhd3AE7rP8OH
        gg22jkFJ/oxPI7JxjToC6kWh2A==
X-Google-Smtp-Source: APiQypIpE/EyngqUd44ClVrvD6VWg2YGYs9jTPQIY8VDcn00qitNWr0dRPjhaREYy8l7+q2q69nPtQ==
X-Received: by 2002:a1c:2d02:: with SMTP id t2mr3481404wmt.98.1587023596882;
        Thu, 16 Apr 2020 00:53:16 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a1sm17396190wrn.80.2020.04.16.00.53.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 00:53:16 -0700 (PDT)
Subject: Re: [PATCH 01/11] Documentation: device-tree: sound: Update lpass-cpu
 driver binding
To:     Ajit Pandey <ajitp@codeaurora.org>, alsa-devel@alsa-project.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
 <1586592171-31644-2-git-send-email-ajitp@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f0ce184d-ad24-fe4a-8ad1-b9a9bf47f33b@linaro.org>
Date:   Thu, 16 Apr 2020 08:53:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1586592171-31644-2-git-send-email-ajitp@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2020 09:02, Ajit Pandey wrote:
> Done the required cleanups to update lpass-cpu binding with newer
> yaml formats.
> 
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>


> ---
>   .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 158 ---------------------
>   .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 103 ++++++++++++++
>   2 files changed, 103 insertions(+), 158 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
> deleted file mode 100644
> index a49b878..00000000
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
> +++ /dev/null
> @@ -1,158 +0,0 @@
> -* Qualcomm Technologies LPASS CPU DAI binding
> -
> -Low-Power Audio SubSystem (LPASS) consist of MI2S interfaces for audio data
> -transfer on external codec. LPASS cpu driver is a common code to configure
> -MI2S related CPU dai's across different version of LPASS architecture.
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: compatible string corresponds to lpass variants driver
> -		    must be "qcom, lpass-cpu-sc7180" for sc7180 lpass
This patch will not apply on mainline, looks like this was done on top 
of your local repo, please fix this!

Best thing would be rebase patches top of 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-next

Secondly, Split this patch into two,
1> converting in to yaml
2> adding new changes
so that it will be easy to see what exactly changed.

thanks,
srini

> -		    must be "qcom,apq8016-lpass-cpu" for apq8016 lpass
> -- reg:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: must specify the base address and size of the LPAIF CORE
> -		    region of lpass variant.
> -- reg-names:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "lpass-lpaif"
> -
> -- iommus:
> -        Usage: required for "qcom, lpass-cpu-sc7180" compatible string
> -        Value type: <prop-encoded-array>
> -        Definition: sid mask for lpaif memory region to apps_smmu
> -                    must be <&apps_smmu 0x1020 0>
> -
> -- power-domains:
> -	Usage: required for "qcom, lpass-cpu-sc7180" compatible string
> -	Value type: <phandle>
> -	Definition: reference to power-domains
> -		    must be <&lpass_hm LPASS_CORE_HM_GDSCR>
> -
> -- clocks:
> -        Usage: required
> -	Value type: <phandle>
> -	Definition: reference to the clocks that match clock-names
> -
> -- clock-names:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: The clocks needed depend on the compatible string:
> -	qcom,lpass-cpu-apq8016:
> -		must be "ahbix-clk", "mi2s-osr-clk", "mi2s-bit-clk0",
> -		mi2s-bit-clk1", "mi2s-bit-clk2", "mi2s-bit-clk3",
> -		"pcnoc-mport-clk", "pcnoc-sway-clk"
> -	qcom, lpass-cpu-sc7180:
> -		must be "noc", "audio-core", "mclk0", "sysnoc_mport",
> -		"pri_ibit", "sec_ibit"
> -
> -- #sound-dai-cells
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Must be 1
> -
> -- interrupts:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: reference to the interrupts that match interrupt-names
> -
> -- interrupt-names:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "lpass-irq-lpaif"
> -
> -- qcom,adsp:
> -        Usage: optional
> -        Value type: <phandle>
> -	Definition: Phandle for the audio DSP node
> -
> -= MI2S DAIs (Digial Audio Interface)
> -"dais" child node of the lpass node. It represents mi2s dais, each mi2s dai is
> -subnode of "dais" representing board specific dai setup & required dai clocks.
> -"dais" node should have following properties.
> -
> -- id:
> -	Usage: required for mi2s interface
> -	Value type: <u32>
> -	Definition: Must be dai id defined in lpass bindings like MI2S_PRIMARY
> -
> -- qcom,bitclk-name:
> -	Usage: required for mi2s interface
> -	Value type: <stringlist>
> -	Definition: bitclk name corresponds to MI2S of lpass version
> -
> -- qcom,mclk-name:
> -        Usage: optional for mi2s interface
> -        Value type: <stringlist>
> -        Definition: external mclk name corresponds to MI2S of lpass version
> -
> -- qcom,osrclk-name:
> -        Usage: optional for mi2s interface
> -        Value type: <stringlist>
> -        Definition: osrclk name corresponds to MI2S of lpass version
> -
> -- qcom,spkmode-mask:
> -        Usage: optional for mi2s interface
> -        Value type: <u32>
> -        Definition: board specific property to change default spkmode mask
> -                    of MI2S dai based on dataline connection on board.
> -
> -- qcom,micmode-mask:
> -        Usage: optional for mi2s interface
> -        Value type: <u32>
> -        Definition: board specific property to change default micmode mask
> -                    of MI2S dai based on dataline connection on board.
> -
> -- qcom,loopback-mask:
> -        Usage: optional for mi2s interface
> -        Value type: <u32>
> -        Definition: board specific property to change default loopback mask
> -                    of MI2S dai as per requirement.
> -
> -- qcom,wssrc-mask:
> -        Usage: optional for mi2s interface
> -        Value type: <u32>
> -        Definition: board specific property to change default wssrc mask
> -                    of MI2S dai based as per requirement.
> -
> -Example:
> -
> -lpass_cpu: lpass {
> -	compatible = "qcom, lpass-cpu-sc7180";
> -
> -	reg = <0 0x62F00000 0 0x29000>;
> -	reg-names = "lpass-lpaif";
> -
> -	iommus = <&apps_smmu 0x1020 0>;
> -
> -	power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
> -
> -	clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
> -		 <&lpasscorecc LPASS_AUDIO_CORE_CORE_CLK>,
> -		 <&lpasscorecc LPASS_AUDIO_CORE_EXT_MCLK0_CLK>,
> -		 <&lpasscorecc LPASS_AUDIO_CORE_SYSNOC_MPORT_CORE_CLK>,
> -		 <&lpasscorecc LPASS_AUDIO_CORE_LPAIF_PRI_IBIT_CLK>,
> -		 <&lpasscorecc LPASS_AUDIO_CORE_LPAIF_SEC_IBIT_CLK>;
> -
> -	clock-names = "noc", "audio-core", "mclk0", "sysnoc_mport",
> -		      "pri_ibit", "sec_ibit";
> -
> -	#sound-dai-cells = <1>;
> -
> -	interrupts = <0 160 IRQ_TYPE_LEVEL_HIGH>;
> -	interrupt-names = "lpass-irq-lpaif";
> -
> -	prim-mi2s@0 {
> -		id = <MI2S_PRIMARY>;
> -		qcom,bitclk-name = "pri_ibit";
> -		qcom,mclk-name = "mclk0";
> -	};
> -
> -	sec-mi2s@1 {
> -		id = <MI2S_SECONDARY>;
> -		qcom,bitclk-name = "sec_ibit";
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> new file mode 100644
> index 00000000..a87a406
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,lpass-cpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm LPASS CPU dai driver bindings
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +  - Ajit Pandey <ajitp@codeaurora.org>
> +
> +description: |
> +  Qualcomm SOC Low-Power Audio SubSystem (LPASS) that consist of MI2S interface
> +  for audio data transfer on external codecs. LPASS cpu driver is a module to
> +  configure Low-Power Audio Interface(LPAIF) core registers across different
> +  IP versions.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,lpass-cpu
> +      - qcom,apq8016-lpass-cpu
> +
> +  reg:
> +    items:
> +      - description: LPAIF core registers
> +
> +  reg-names:
> +    items:
> +      - const: lpass-lpaif
> +
> +  clocks:
> +    items:
> +      - description: AHBIX core clock for IPQ806X
> +      - description: oscillator clock for MI2S external interfaces
> +      - description: Bit clock for single MI2S dai in IPQ806X
> +      - description: Bit clock for MI2S_PRIMARY dai interface
> +      - description: Bit clock for MI2S_SECONDARY dai interface
> +      - description: Bit clock for MI2S_TERTIARY dai interface
> +      - description: Bit clock for MI2S_QUATERNARY dai interface
> +      - description: NOC MPORT clock of LPASS core
> +      - description: NOC SWAY clock of LPASS core
> +
> +  clock-names:
> +    items:
> +      - const: ahbix-clk
> +      - const: mi2s-osr-clk
> +      - const: mi2s-bit-clk
> +      - const: mi2s-bit-clk0
> +      - const: mi2s-bit-clk1
> +      - const: mi2s-bit-clk2
> +      - const: mi2s-bit-clk3
> +      - const: pcnoc-mport-clk
> +      - const: pcnoc-sway-clk
> +
> +  interrupts:
> +    items:
> +      - description: LPAIF DMA buffer interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: lpass-irq-lpaif
> +
> +  qcom,adsp:
> +    maxItems: 1
> +    description: Phandle for the audio DSP node
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - sound-dai-cells
> +
> +optional:
> +  - qcom,adsp
> +
> +examples:
> +  lpass@28100000 {
> +	compatible = "qcom,lpass-cpu";
> +	clocks = <&lcc AHBIX_CLK>,
> +		 <&lcc MI2S_OSR_CLK>,
> +		 <&lcc MI2S_BIT_CLK>;
> +
> +	clock-names = "ahbix-clk",
> +		      "mi2s-osr-clk",
> +		      "mi2s-bit-clk";
> +
> +	interrupts = <0 85 1>;
> +	interrupt-names = "lpass-irq-lpaif";
> +
> +	reg = <0x28100000 0x10000>;
> +	reg-names = "lpass-lpaif";
> +	#sound-dai-cells = <1>;
> +	qcom,adsp = <&adsp>;
> +
> 
