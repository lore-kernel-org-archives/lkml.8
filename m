Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE60C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E7920747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vuwi+lAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbgELXDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:03:30 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B74C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:03:29 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id w188so3797018vkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5FetxvGPLFWpsF7g0nhJxUni2v4MfzWKsEb+uV6F5g=;
        b=Vuwi+lAx5qAhG+ORwRRDlUSpm7T4YexVmx8bD0gPLnVVjYZvL3BNJcMQ2iWO4IfwCn
         R29kGOxoF0L/2YE19OWsp/s/2fAHmGjXUwFvWjbVG+mTmsqUnyNj9NwFzoGmSbPO0zI2
         6orwbCaFgjpEMwMixF3eAx0GccTMbCDY13kn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5FetxvGPLFWpsF7g0nhJxUni2v4MfzWKsEb+uV6F5g=;
        b=i4Kil7r+ITZsN0qYBxME5/OJ9XFNntbRIctY/Ren77MTU0Pr9gshUeN/ffcmSOc4IG
         MKq4cDP5v/NYZRhqDJydDrzHauVXSf+u0E8ywxp9rM6hSAWHkzL/6TQJG8PwEyfUXMmP
         7ONKLXippGm4xLkvsNjEtXX6OiT1ndY3bjSxXgS7CSxpYZyfwOBEwi8Ph/6G714E3Ofl
         jJo1Ca8um2nmU5xxoDSEBs2/HN/MVqxEEl37LX9W+nogiUYo1hpmv09m/NzPQELS+Plb
         rCVG+FizfkwSbX8YOQYlcnFByAimOG7twHfrIFQEIyHoyzbWwPowXlNeR0aEyCq6nXMI
         uG9g==
X-Gm-Message-State: AGi0PuYfgzBsK2Q0dwWwr4gyVJvPIjYTvKjQVd1xiunDUHvu+gNYpyVH
        AGQ6w9nznNLeLgY2UnQItaGAuKSa8xw=
X-Google-Smtp-Source: APiQypLxaJRXKwoz31LBfeBPjoDekPQ6+s7+wfys+pNxh4vs2Tgy/T5RCyTqzefZSGKuhRoSdzaCwA==
X-Received: by 2002:a1f:cd06:: with SMTP id d6mr18034092vkg.94.1589324608020;
        Tue, 12 May 2020 16:03:28 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id f16sm10907255uaq.3.2020.05.12.16.03.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 16:03:27 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id v23so3773807vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:03:27 -0700 (PDT)
X-Received: by 2002:a1f:4e46:: with SMTP id c67mr7154245vkb.92.1589324606642;
 Tue, 12 May 2020 16:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org> <1589307480-27508-2-git-send-email-rbokka@codeaurora.org>
In-Reply-To: <1589307480-27508-2-git-send-email-rbokka@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 May 2020 16:03:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wp5-=YgvaopeXROAfE5PESaghcthpFNy1qt4Zo5c-UkA@mail.gmail.com>
Message-ID: <CAD=FV=Wp5-=YgvaopeXROAfE5PESaghcthpFNy1qt4Zo5c-UkA@mail.gmail.com>
Subject: Re: [RFC v1 1/3] dt-bindings: nvmem: Add devicetree bindings for qfprom-efuse
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 12, 2020 at 11:18 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
>
> This patch adds dt-bindings document for qfprom-efuse controller.
>
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> ---
>  .../devicetree/bindings/nvmem/qfprom-efuse.yaml    | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
>
> diff --git a/Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml b/Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
> new file mode 100644
> index 0000000..d262c99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/qfprom-efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc, QFPROM Efuse bindings
> +
> +maintainers:
> +  - Ravi Kumar Bokka <rbokka@codeaurora.org>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc7180-qfprom-efuse
> +
> +  reg:
> +    maxItems: 3

Instead of this, add descriptions for the 3 items.  AKA:

reg:
  items:
    - description: The base of the qfprom.
    - description: The start of the raw region.
    - description: The start of the mem region.

...but do you really need to break this down into 3 ranges?  Why can't
you just do:

reg = <0 0x00780000 0 0x2100>;

Then you really don't need any description and you'd just have:

reg:
  maxItems: 1


> +

Need something for clocks and clock-names, like:

clocks:
  maxItems: 1

clock-names:
  items:
  - const: sec


> +required:
> +   - compatible
> +   - reg
> +   - clocks
> +   - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
> +
> +    efuse@780000 {
> +       compatible = "qcom,sc7180-qfprom-efuse";
> +        reg = <0 0x00780000 0 0x100>,
> +              <0 0x00780120 0 0x7a0>,
> +              <0 0x00782000 0 0x100>;
> +        clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
> +        clock-names = "secclk";

nit: Folks usually don't like the names of clocks to end in "clk".  We
know it's a clock.  Just name this "sec" or even a local name like
"core".
