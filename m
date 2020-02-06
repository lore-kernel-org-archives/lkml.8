Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2FC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCA420659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GCt8JJ62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBFTHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:07:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40266 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgBFTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:06:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id z7so3198697pgk.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:cc:to:from:user-agent:date;
        bh=JH73fAwhfkMNbW4kUyEFGAKqreY4Y4GoPK5G9xNxjhs=;
        b=GCt8JJ62GzWZuf0t6fb8CNqtqnybSN/RQrt9/vyiGSVnlmRxprreQ6vYGYBLZdfolo
         sHhU6AXhdZIFrqMi/FUvbt1k5jTH38l1icqf3JcbmWzVv1kjuyWfRfKQXCd+BcXjPh4P
         jiIqx1nFMHebC14BN9dvDGQySMksuDH7bNu80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:cc:to:from
         :user-agent:date;
        bh=JH73fAwhfkMNbW4kUyEFGAKqreY4Y4GoPK5G9xNxjhs=;
        b=cMezW4E0ghCUfK2itW7oCqXgT1SjKVEROfqJDsd6/AGq1w1LYJ0830qWcrjB+NlKrB
         FsumJhqYWcTand0NS49GPS3Qye5jzZR+zfozo0wU81eKiy9xa22aVmV9WLcn6ZfdlTWd
         MzEPz/OP2sdqchSso/PcIh7Zqv1DhFGUFXdwrWzt0RX/H9eX8NSzFHFIQernDzNy/YbW
         fIrCUrQ3D2vPUYKAozYO/y8TRrhUzsWTwmNjxdqBUoFWzUpMaMVEGkG99J7G36GSAXUX
         jmxatr/GLWTYhiemmKOvpSZgEJ4b2my0WPN/2N9NiGI6k+fKmvG7unJCJLnd7SipJYDR
         VyvQ==
X-Gm-Message-State: APjAAAXh+R4oSXbsWlp35EW7DdEDGBv6ovg70E1wHttTKZFBPEjrti77
        AvzImvT3bC0sSJRD2t9Q4IFyCw==
X-Google-Smtp-Source: APXvYqw13PzKBtXxqtku7lejhAKgAkYAo6T15zKICPanBOblwrSQ6Ohs1LKkVfctX9Ze/u1B5LaNRQ==
X-Received: by 2002:a63:7c2:: with SMTP id 185mr5133841pgh.446.1581016017057;
        Thu, 06 Feb 2020 11:06:57 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 199sm156429pfv.81.2020.02.06.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:06:56 -0800 (PST)
Message-ID: <5e3c63d0.1c69fb81.c2bba.0957@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1580997328-16365-1-git-send-email-kgunda@codeaurora.org>
References: <1580997328-16365-1-git-send-email-kgunda@codeaurora.org>
Subject: Re: [PATCH V3 1/2] mfd: qcom-spmi-pmic: Convert bindings to .yaml format
Cc:     rnayak@codeaurora.org, Kiran Gunda <kgunda@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 06 Feb 2020 11:06:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kiran Gunda (2020-02-06 05:55:26)
> Convert the bindings from .txt to .yaml format.
>=20
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---

Did something change? Is there a cover letter?

> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/=
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> new file mode 100644
> index 0000000..affc169
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/mfd/qcom,spmi-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPMI PMICs multi-function device bindings
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Stephen Boyd <sboyd@codeaurora.org>

Please change this to sboyd@kernel.org

> +
> +description: |
> +  The Qualcomm SPMI series presently includes PM8941, PM8841 and PMA8084
> +  PMICs.  These PMICs use a QPNP scheme through SPMI interface.

This first sentence will need continual updating. Please drop it.

> +  QPNP is effectively a partitioning scheme for dividing the SPMI extend=
ed
> +  register space up into logical pieces, and set of fixed register
> +  locations/definitions within these regions, with some of these regions
> +  specifically used for interrupt handling.
> +
> +  The QPNP PMICs are used with the Qualcomm Snapdragon series SoCs, and =
are
> +  interfaced to the chip via the SPMI (System Power Management Interface=
) bus.
> +  Support for multiple independent functions are implemented by splittin=
g the
> +  16-bit SPMI slave address space into 256 smaller fixed-size regions, 2=
56 bytes
> +  each. A function can consume one or more of these fixed-size register =
regions.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8941
> +      - qcom,pm8841
> +      - qcom,pma8084
> +      - qcom,pm8019
> +      - qcom,pm8226
> +      - qcom,pm8110
> +      - qcom,pma8084
> +      - qcom,pmi8962
> +      - qcom,pmd9635
> +      - qcom,pm8994
> +      - qcom,pmi8994
> +      - qcom,pm8916
> +      - qcom,pm8004
> +      - qcom,pm8909
> +      - qcom,pm8950
> +      - qcom,pmi8950
> +      - qcom,pm8998
> +      - qcom,pmi8998
> +      - qcom,pm8005
> +      - qcom,spmi-pmic

I think we want qcom,spmi-pmic to be there always. To do that we need it
to look like:

  compatible:
    items:
      enum:
        - qcom,pm8941
        ...
      enum:
        - qcom,spmi-pmic

> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Specifies the SPMI USID slave address for this device.
> +      For more information see Documentation/devicetree/bindings/spmi/sp=
mi.txt
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Each child node of SPMI slave id represents a function of the PMIC=
. In the
> +      example below the rtc device node represents a peripheral of pm8941
> +      SID =3D 0. The regulator device node represents a peripheral of pm=
8941 SID =3D 1.
> +
> +    properties:
> +      compatible:
> +        description:
> +          Compatible of the PMIC device.
> +
> +      interrupts:
> +        maxItems: 2
> +        description:
> +          Interrupts are specified as a 4-tuple. For more information
> +          see Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.=
txt

Just make this bindings/spmi/qcom,spmi-pmic-arb.txt so that  we don't
have to worry about it. Why is max items 2? Isn't it 4? Is this property
supposed to be specified at all?

> +
> +      interrupt-names:
> +        description:
> +          Corresponding interrupt name to the interrupts property

Does this need to be specified either?

> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    spmi {
> +        compatible =3D "qcom,spmi-pmic-arb";
> +        #address-cells =3D <2>;
> +        #size-cells =3D <0>;
> +
> +       pm8941@0 {

pmic@0

> +         compatible =3D "qcom,pm8941";
> +         reg =3D <0x0 0x0>;

Why not include the header file to get the SPMI_USID macro?

> +
> +         rtc {
> +           compatible =3D "qcom,rtc";
> +           interrupts =3D <0x0 0x61 0x1 0x1>;
> +           interrupt-names =3D "alarm";
> +         };
> +       };
> +
> +       pm8941@1 {

pmic@1

> +         compatible =3D "qcom,pm8941";
> +         reg =3D <0x1 0x0>;
> +
> +         regulator {
> +           compatible =3D "qcom,regulator";
> +           regulator-name =3D "8941_boost";
> +         };
> +       };
> +    };
> +...
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
