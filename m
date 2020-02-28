Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE24A24672
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWhYv4ZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgB1GiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:38:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44439 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgB1GiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:38:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so843967plo.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B81jjG7Hk3J3frhk/XVj8Dy5/T3tme0LCbkoaSFMVc0=;
        b=zWhYv4ZT3MiFrZuMf4/LLp/RUv2+5hBuXv04XwMHpL0c1pV11naD1rDJOevfSzviww
         ZkwkBC3bdMc3WIcgDGvWu5KPhj8b6tUfey2Bkx/v02w2HkX/7WYmCe4VwcNVB535fFwX
         dBjm5TNMUrNVu3pr58qM3BQspcDF7b//v58rhBSWhC93eQIOMNzaj8tczcpmkRHr6ayn
         SJQQy1ppDOHMATApTfEjO37NgUmzRfnC2/J5dcj6NVaqQyBkyiXHhx7SwDmqX1faFQqE
         CL3T0GeYkkj8t83Bx3H46Yt3V/0/yezv4tL87YggrX2gagqL5HE4m8FjOWIoWxiptKJK
         FfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B81jjG7Hk3J3frhk/XVj8Dy5/T3tme0LCbkoaSFMVc0=;
        b=gznc+xU4ji4w25bceGPmDDaEAN+zaxEOMK1n/+YeC9DdsgrWcOR5qSmH/TY7KxmDpJ
         ZgGupwRB9ggegYv/PdM4c2KZPRwSp9+xb/ElsVYnFmZXkCgb7SSUWeD6kWOZ8OwM8YfT
         +1rO4cGU1wI9ULozQcZu0weiEZP75GPprVTFABbg9i3mt25BXq5So+iW9uaT0+U8/Pqz
         ZQdn02T0JrTl8hdaUflmxcuS0S7U4niCfk+RM6CwbavQXDV1WUKVCmigoqqmRywmbdcn
         QQZQuAvNrSdiO9BdjvKIpDUohZmqP/dGnk34mwGnwtYbtVghJR+Sd5JGLqmG02uFdiXM
         zwog==
X-Gm-Message-State: APjAAAXN/IdaWG5uf6TmtwrnfQYVP6wEi6gje1c9Wn+9EW2CvCsQC4Ij
        mzXT2YfsZGR/r/6SqoIUYbjkcQ==
X-Google-Smtp-Source: APXvYqyssrTG+x5Ahix9/bSswB+gFBN+/jwi+lhdxr8DsRLdMO/VHrlf15QrntRS5UE9HXMw2d252Q==
X-Received: by 2002:a17:90a:5d97:: with SMTP id t23mr3010033pji.61.1582871893597;
        Thu, 27 Feb 2020 22:38:13 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m18sm8341758pgd.39.2020.02.27.22.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:38:13 -0800 (PST)
Date:   Thu, 27 Feb 2020 22:38:11 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: Introduce soc sleep stats bindings
 for Qualcomm SoCs
Message-ID: <20200228063811.GC857139@builder>
References: <1582274986-17490-1-git-send-email-mkshah@codeaurora.org>
 <1582274986-17490-2-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582274986-17490-2-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Feb 00:49 PST 2020, Maulik Shah wrote:

> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Add device binding documentation for Qualcomm Technology Inc's (QTI)
> SoC sleep stats driver. The driver is used for displaying SoC sleep
> statistic maintained by Always On Processor or Resource Power Manager.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  .../bindings/soc/qcom/soc-sleep-stats.yaml         | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> new file mode 100644
> index 00000000..50352a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/soc/qcom/soc-sleep-stats.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. (QTI) SoC sleep stats bindings
> +
> +maintainers:
> +  - Maulik Shah <mkshah@codeaurora.org>
> +  - Lina Iyer <ilina@codeaurora.org>
> +
> +description: |
> +  Always On Processor/Resource Power Manager maintains statistics of the SoC
> +  sleep modes involving powering down of the rails and oscillator clock.
> +
> +  Statistics includes SoC sleep mode type, number of times low power mode were
> +  entered, time of last entry, time of last exit and accumulated sleep duration.
> +  SoC sleep stats driver provides debugfs interface to show this information.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,rpmh-sleep-stats
> +      - qcom,rpm-sleep-stats
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  # Example of rpmh sleep stats
> +  - |
> +    rpmh_sleep_stats: soc-sleep-stats@c3f0000 {
> +      compatible = "qcom,rpmh-sleep-stats";
> +      reg = <0 0xc3f0000 0 0x400>;
> +    };
> +  # Example of rpm sleep stats
> +  - |
> +    rpm_sleep_stats: soc-sleep-stats@4690000 {
> +      compatible = "qcom,rpm-sleep-stats";
> +      reg = <0 0x04690000 0 0x400>;
> +    };
> +...
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
