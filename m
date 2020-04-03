Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B5BC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE2420659
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="1V68tdUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403951AbgDCMLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:11:54 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43062 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403942AbgDCMLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:11:53 -0400
Received: by mail-vs1-f67.google.com with SMTP id w185so4733859vsw.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYEUwgGx/wc/zC1RH6EQ9oeCu6zgO1eYOfdLmoIOI0s=;
        b=1V68tdUmUpbPdxA9zVxDDj5a0Gt3IA+mKy1UZgQpP1+s+p7SHY+hCfoSfggwMPCWCF
         187ZVFfoz/dAxM4C1T8BUOpJ/gxEFWKho/+9dL1xwTzkR//877DID9MVeJJpgmbgxkpN
         OrDMiTQ8CjeKbYd1Iq8xgpABspcAH+aQu3TPLETjLdwo6H0DEYcgB92V720q2g4eLjVJ
         hIU7rUbarY6sk4Ku+glgJdjWBG+rJEE3bLxdnkKm5RC12WSbVf98PmBiHLkClMfhajuK
         4kRzabP+D+MPAvRO68fHdHZqmiqT3jyzIVRTu5Yd+RjjvI35OEPE2vpclKvBUqgffr1H
         Ij9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYEUwgGx/wc/zC1RH6EQ9oeCu6zgO1eYOfdLmoIOI0s=;
        b=bnjBeRSnq4L5igFMM5LXD/fcaVXZy+F14JIZqW4u6lWSF4F2WO7nbsihD1OTbmgnHz
         WCpn/IO69O1VuhhmkSFqa+YJ0bKKLkS9ZK6K++qqEvNiJuzl5LZr2juhOaOTZ9Nq1+Sy
         iNnZx96c8segNrW1RqP6oVUl9m/Dqipa5yRvETN5uF1qEOWd/y0ATmxb67xU/ctZw3C0
         AACwE1u8eqvDg8c9gXdfSjyqYJZ4UOFU7lrUndZelLXsBnRW9JQpSU/t2D3Lr1xXTeYx
         NFkUhwzqazkWh2CmRW36haBKuJNOA415l8veIMTewttZwLIw0Y8Oljz/KHbmu+0KfiMJ
         noLQ==
X-Gm-Message-State: AGi0PuZRbJTNuEQweDhtjOxhtSbsW7OpnO2T2bWxg8DCmA00wNTylE1W
        16l5hAmZnRx+cKT2eOV5dZZYO2ZKCnBuirbEMp4Vng==
X-Google-Smtp-Source: APiQypIyBKqzVPKfYyIMWPApMpq5/DhtKduEKFwFD63nSwRmOIgdEA4YlJ78wS4L/6ay0AGmpiwfUA5Pxq0Y1D0WRMI=
X-Received: by 2002:a67:870f:: with SMTP id j15mr5840117vsd.95.1585915910577;
 Fri, 03 Apr 2020 05:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org> <1585064650-16235-3-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1585064650-16235-3-git-send-email-jprakash@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 3 Apr 2020 17:41:39 +0530
Message-ID: <CAHLCerO6GY4pNAxZucCOv3wSDweA1MsuPh5bGjSWoEUauv0iFA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: Add PMIC7 ADC bindings
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jishnu,

On Tue, Mar 24, 2020 at 9:15 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> Add documentation for PMIC7 ADC peripheral. For PMIC7 ADC, all SW
> communication to ADC goes through PMK8350, which communicates with
> other PMICs through PBS.

What is PMK8350? What is PBS? Please expand the acronyms and describe
more verbosely.


>
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 28 ++++++++++++++++------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index 72db14c..20f010c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -13,7 +13,7 @@ maintainers:
>  description: |
>    SPMI PMIC voltage ADC (VADC) provides interface to clients to read
>    voltage. The VADC is a 15-bit sigma-delta ADC.
> -  SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
> +  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
>    voltage. The VADC is a 16-bit sigma-delta ADC.
>
>  properties:
> @@ -23,6 +23,7 @@ properties:
>        - qcom,spmi-adc5
>        - qcom,spmi-adc-rev2
>        - qcom,pms405-adc
> +      - qcom,spmi-adc7
>
>    reg:
>      description: VADC base address in the SPMI PMIC register map
> @@ -65,6 +66,8 @@ patternProperties:
>          description: |
>            ADC channel number.
>            See include/dt-bindings/iio/qcom,spmi-vadc.h
> +          For PMIC7 ADC, the channel numbers are specified separately per PMIC
> +          in the PMIC-specific files in include/dt-bindings/iio/.
>
>        label:
>          description: |
> @@ -72,7 +75,7 @@ patternProperties:
>              For thermistor inputs connected to generic AMUX or GPIO inputs
>              these can vary across platform for the same pins. Hence select
>              the platform schematics name for this channel. It is required
> -            for "qcom,spmi-adc5" and "qcom,spmi-adc-rev2".
> +            for "qcom,spmi-adc5", "qcom,spmi-adc7" and "qcom,spmi-adc-rev2".
>          allOf:
>            - $ref: /schemas/types.yaml#/definitions/string
>
> @@ -85,6 +88,8 @@ patternProperties:
>                of 512 will be used.
>              - For compatible property "qcom,spmi-adc5", valid values are 250, 420
>                and 840. If property is not found, default value of 840 is used.
> +            - For compatible property "qcom,spmi-adc7", valid values are 85, 340
> +              and 1360. If property is not found, default value of 1360 is used.
>              - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
>                512 and 1024. If property is not present, default value is 1024.
>          allOf:
> @@ -109,11 +114,11 @@ patternProperties:
>                channel calibration. If property is not found, channel will be
>                calibrated with 0.625V and 1.25V reference channels, also
>                known as absolute calibration.
> -            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
> -              if this property is specified VADC will use the VDD reference (1.875V)
> -              and GND for channel calibration. If property is not found, channel
> -              will be calibrated with 0V and 1.25V reference channels, also known
> -              as absolute calibration.
> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
> +              "qcom,spmi-adc-rev2", if this property is specified VADC will use
> +              the VDD reference (1.875V) and GND for channel calibration. If
> +              property is not found, channel will be calibrated with 0V and 1.25V
> +              reference channels, also known as absolute calibration.
>          type: boolean
>
>        qcom,hw-settle-time:
> @@ -135,6 +140,12 @@ patternProperties:
>                Certain controller digital versions have valid values of
>                15, 100, 200, 300, 400, 500, 600, 700, 1, 2, 4, 8, 16, 32, 64, 128 ms
>                If property is not found, channel will use 15us.
> +            - For compatible property "qcom,spmi-adc7", delay = 15us for
> +              value 0, 100us * (value) for values < 8, 1ms for value 8
> +              and 2ms * (value - 8) otherwise.
> +              Valid values are: 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000,
> +              4000, 8000, 16000, 32000, 64000, 128000 us.
> +              If property is not found, channel will use 15us.
>          allOf:
>            - $ref: /schemas/types.yaml#/definitions/uint32
>
> @@ -147,6 +158,9 @@ patternProperties:
>              - For compatible property "qcom,spmi-vadc", valid values
>                are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
>                If property is not found, 1 sample will be used.
> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7"
> +              and "qcom,spmi-adc-rev2", valid values are: 1, 2, 4, 8, 16.
> +              If property is not found, 1 sample will be used.
>          allOf:
>            - $ref: /schemas/types.yaml#/definitions/uint32
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
