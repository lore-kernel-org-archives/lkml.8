Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6260C2BBD0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C6A2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJ5s0TM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgIHKHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgIHKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:07:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58742C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 03:07:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so3530622pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 03:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hU3oOvvnKV3sVS60ywXkD1wU0kB70X7AUVyTyZd2RY4=;
        b=AJ5s0TM9s5OJw66KaolPB8BsjovKw8GrEqoKSEGdJRI8ZS3Xh22wOFQ72Jp5UEz9QT
         QL14QkPFwkvl96bfp3dchyut4RLzlQqsVf5x1mwYYY1ZUo/vcJBg5evkvgZMdz+OZiFO
         ejQuvUh9+00emp0HrgEBJePDPEjuP9ERlmDgq2vfWH8a+TJqz3lUit2tW6+d9KqCszKf
         x3B0HD2+XG0KZZl3Ov/+RAv9oldBfoGC04efRlw9TosIeO3L9TtIjALv2b5zw/qnxOa2
         effhj1ijvXKzFiSKxYItEwdlRgjXYWztCYzBFmRwBEPppenKGFSdDN0Sg7r4aaqZVssz
         yk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hU3oOvvnKV3sVS60ywXkD1wU0kB70X7AUVyTyZd2RY4=;
        b=j6JT8vkPVeetlfHa3el9KLJtxNWsTt+FsSfB9/9GFU/um9qnCo3tqWz3OeQf9ilNhl
         H/+Q/OpFLfRGyGDLIRIqsXyO2Bzp5nfi8BoPhcRh23Nmpal0zvB4BbuZ2eQwDVjOsRRX
         EzI/rActbchtJgTanRa0lWCMPAp8gWhy1X95cP6cxg1dcgaz3sVgRerUHUQYx+gcJWCX
         /Y9D7+HYDjw1s7CSvRaLldLmBYQGAWlmCvp0xU1i3YR6+J1Z3xlWrR2McJdH6trapJ8g
         1jvc92gh4wc60FQ7bm/E0l9mMnsGzZQRMYfXqqqIcFSfNyGxFkUmhy0oDLeOo8ZDfkzc
         zPzA==
X-Gm-Message-State: AOAM53293Yxeis8KG3ABjPpxsRey+hFrd35oBneToDdhyN30XpS90Tm5
        bvgHE8/T5GcCoPz5NBpcJ1o1GA==
X-Google-Smtp-Source: ABdhPJweEpB8wgJ9j3N1o+hvbAzIUldosNCWC9AYOg0yuTLIAoB7iMZYQXNSkkxkjZQyFOSNJIhNnw==
X-Received: by 2002:a65:6545:: with SMTP id a5mr20129366pgw.43.1599559661151;
        Tue, 08 Sep 2020 03:07:41 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id s198sm14749540pgc.4.2020.09.08.03.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 03:07:40 -0700 (PDT)
Date:   Tue, 8 Sep 2020 15:37:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v4 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20200908100733.pbizjorq3lmn7bew@vireshk-i7>
References: <1599550547-27767-1-git-send-email-hector.yuan@mediatek.com>
 <1599550547-27767-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599550547-27767-3-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 15:35, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  141 ++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> new file mode 100644
> index 0000000..5be5867
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/cpufreq-mediatek-hw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek's CPUFREQ Bindings
> +
> +maintainers:
> +  - Hector Yuan <hector.yuan@mediatek.com>
> +
> +description:
> +  CPUFREQ HW is a hardware engine used by MediaTek
> +  SoCs to manage frequency in hardware. It is capable of controlling frequency
> +  for multiple clusters.
> +
> +properties:
> +  compatible:
> +    const: mediatek,cpufreq-hw

Missing "" here ?

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Addresses and sizes for the memory of the HW bases in each frequency domain.
> +
> +  reg-names:
> +    items:
> +      - const: "freq-domain0"
> +      - const: "freq-domain1"
> +    description: |
> +      Frequency domain name. i.e.
> +      "freq-domain0", "freq-domain1".
> +
> +  "#freq-domain-cells":
> +    const: 1
> +    description: |
> +      Number of cells in a freqency domain specifier.
> +
> +  mtk-freq-domain:
> +    maxItems: 1
> +    description: |
> +      Define this cpu belongs to which frequency domain. i.e.
> +      cpu0-3 belong to frequency domain0,
> +      cpu4-6 belong to frequency domain1.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#freq-domain-cells"
> +
> +examples:
> +  - |
> +    cpus {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            cpu0: cpu@0 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                mtk-freq-domain = <&cpufreq_hw 0>;
> +                reg = <0x000>;
> +            };
> +
> +            cpu1: cpu@1 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                mtk-freq-domain = <&cpufreq_hw 0>;
> +                reg = <0x100>;
> +            };
> +
> +            cpu2: cpu@2 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                mtk-freq-domain = <&cpufreq_hw 0>;
> +                reg = <0x200>;
> +            };
> +
> +            cpu3: cpu@3 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                mtk-freq-domain = <&cpufreq_hw 0>;
> +                reg = <0x300>;
> +            };
> +
> +            cpu4: cpu@4 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                mtk-freq-domain = <&cpufreq_hw 1>;
> +                reg = <0x400>;
> +            };
> +
> +            cpu5: cpu@5 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a55";
> +                enable-method = "psci";
> +                mtk-freq-domain = <&cpufreq_hw 1>;
> +                reg = <0x500>;
> +            };
> +
> +            cpu6: cpu@6 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a75";
> +                enable-method = "psci";
> +                mtk-freq-domain = <&cpufreq_hw 1>;
> +                reg = <0x600>;
> +            };
> +
> +            cpu7: cpu@7 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a75";
> +                enable-method = "psci";
> +                mtk-freq-domain = <&cpufreq_hw 1>;
> +                reg = <0x700>;
> +            };
> +    };
> +
> +    /* ... */
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        cpufreq_hw: cpufreq@11bc00 {
> +            compatible = "mediatek,cpufreq-hw";
> +            reg = <0 0x11bc10 0 0x8c>,
> +               <0 0x11bca0 0 0x8c>;
> +            reg-names = "freq-domain0", "freq-domain1";
> +            #freq-domain-cells = <1>;
> +        };
> +    };
> +
> +
> +
> +

I would need Ack from Rob for this.

-- 
viresh
