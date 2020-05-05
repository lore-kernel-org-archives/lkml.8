Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A7CC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC90206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPT/dcuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgEEMMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728837AbgEEMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:12:29 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C6BC0610D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 05:12:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d25so1141256lfi.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Q1oIBidrac3ZpT+HqALm45OEqYcdapj+GCOvfIEi3M=;
        b=MPT/dcuC6j/g/wxBK43rwGsF2iR8c/I+QNZ6Z2SCpb6JphvZ/tYzP14cjXHTcuwPzr
         kgdXsSrRMie/swEidbHTpoqYx3wWwE6tyvUIhFjXy5G46NZdYuSr/5moZjGDWUKjHTS9
         Xl1f0KfDJ93DFGfClHNZgm2/6q9FVfuJClncFFOFeEDVjHhRtOOG9TTFMwohA2MOeo3a
         bP1hLiNdnbFMKfiDAzAa0TVYpMG8Le7Gbg8cdLnQmGJqZjnP5T8hcQ8LYaTbZypq/pdD
         RQtPCvVfotDAMWYvMdwNGRYUizwbanWzdLRUcNXng2IE8fF3X+00+1fyF2G3vB+m2r0D
         ZziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Q1oIBidrac3ZpT+HqALm45OEqYcdapj+GCOvfIEi3M=;
        b=G2NtOnUxElP/9iuE6wOpgJ34rtmCbjEkK6rtpikNnpmZTXDeehbgYosBmOFVZLNr90
         r9NX5vzgeOSHkgesRkG8HT1pYBOdKBnYLOjj9Q8JbfQUp0d7wDBRcjvnMS1ynQDQs1Tk
         x2EYhfqxMUwtdsFXbY4tRi/Waw5yn/2xrqy/LFujDYzrAn6zg25a6bZn8xG3B2kffuJL
         afoAWBbaNevD3zNNfyVRiEpjQVxFM80W25fAb2N8dEdi6ZSqeQUyD2E5lp+lNS+o2UDi
         ChF53axuulMkje4QPfHXIkBx/bOYdKBluUXMSKTakTaZCrA0L6j62eGc5Dzb/Y+//rPd
         3Odg==
X-Gm-Message-State: AGi0PubpbUhoCT2heicXECDnu+AGhPj2rylzCz/3s9VJ0a0jJh2FlHoo
        o+6Q/MceXYZ476Y4X1Zp1iH/IFoVXkAXmM3RrsGbqw==
X-Google-Smtp-Source: APiQypJuMSHXNquobFYCWB9hv5q4xyLAPwqp5lGXvMhYky2m73bM5OmseIAgrQSDZ6rhqun7GXGUfaIlEQC+ebQyhYk=
X-Received: by 2002:a05:6512:1044:: with SMTP id c4mr1581833lfb.7.1588680747672;
 Tue, 05 May 2020 05:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200505111204.963-1-manafm@codeaurora.org> <20200505111204.963-3-manafm@codeaurora.org>
In-Reply-To: <20200505111204.963-3-manafm@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 5 May 2020 17:41:55 +0530
Message-ID: <CAP245DX2=bY4kCERgnm_L26o9mY7CoOZRScXmXwfe-bAYczOnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Add zeroc interrupt
 support in yaml
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:43 PM Manaf Meethalavalappu Pallikunhi
<manafm@codeaurora.org> wrote:
>
> Add 0C (zeroc) interrupt support for tsens in yaml.
>
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 2ddd39d96766..8a0893f77d20 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -52,12 +52,14 @@ properties:
>      items:
>        - description: Combined interrupt if upper or lower threshold crossed
>        - description: Interrupt if critical threshold crossed
> +      - description: Interrupt if zeroC threshold is crossed
>
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: uplow
>        - const: critical
> +      - const: zeroc
>
>    nvmem-cells:
>      minItems: 1
> @@ -168,8 +170,9 @@ examples:
>                   <0xc222000 0x1ff>;
>
>             interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> -                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> -           interrupt-names = "uplow", "critical";
> +                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 510 IRQ_TYPE_EDGE_RISING>;
> +           interrupt-names = "uplow", "critical", "zeroc";


Add a new example for v2 with 0C interrupt here instead of reusing the old one.

>             #qcom,sensors = <13>;
>             #thermal-sensor-cells = <1>;
> --
> 2.26.2
