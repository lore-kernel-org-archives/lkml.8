Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9552CC47409
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2D0214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kVPYNx8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgBGGqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:46:54 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:29208 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgBGGqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:46:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581058012; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=oRZTjl7wX0gMUshuocGpEAyXrjo3f1MY/QRXGnPUZTI=;
 b=kVPYNx8eYrCY69mZmPpkC8KDYZZNw+jhh2Fggw5+S1kj0i5Ucq3Q2TdcF3MY17JdoPlOIny8
 6UIth2mtBRhVoRHkDJHZAhzKiDRm8CYZttEwCq7BBOH6gFoVzYgEpYHLlaG7mq3tW1Vlt/+h
 q9GDiqi7UMRS5LmMXATpJhlgT5g=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3d07d8.7fa318378110-smtp-out-n03;
 Fri, 07 Feb 2020 06:46:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4E60BC447A0; Fri,  7 Feb 2020 06:46:47 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FFD8C43383;
        Fri,  7 Feb 2020 06:46:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Feb 2020 12:16:46 +0530
From:   kgunda@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V3 1/2] mfd: qcom-spmi-pmic: Convert bindings to .yaml
 format
In-Reply-To: <20200206220638.GA28227@bogus>
References: <1580997328-16365-1-git-send-email-kgunda@codeaurora.org>
 <5e3c63d0.1c69fb81.c2bba.0957@mx.google.com> <20200206220638.GA28227@bogus>
Message-ID: <1d7e38197bcaec99dd4e669b5dc8e31c@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-07 03:36, Rob Herring wrote:
> On Thu, Feb 06, 2020 at 11:06:55AM -0800, Stephen Boyd wrote:
>> Quoting Kiran Gunda (2020-02-06 05:55:26)
>> > Convert the bindings from .txt to .yaml format.
>> >
>> > Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> > ---
>> 
>> Did something change? Is there a cover letter?
>> 
>> > diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>> > new file mode 100644
>> > index 0000000..affc169
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>> > @@ -0,0 +1,115 @@
>> > +# SPDX-License-Identifier: GPL-2.0-only
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/bindings/mfd/qcom,spmi-pmic.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Qualcomm SPMI PMICs multi-function device bindings
>> > +
>> > +maintainers:
>> > +  - Lee Jones <lee.jones@linaro.org>
>> > +  - Stephen Boyd <sboyd@codeaurora.org>
>> 
>> Please change this to sboyd@kernel.org
> 
> Should be the h/w owner, not applier of changes.
> 
Ok.. I will remove it in next post.
>> 
>> > +
>> > +description: |
>> > +  The Qualcomm SPMI series presently includes PM8941, PM8841 and PMA8084
>> > +  PMICs.  These PMICs use a QPNP scheme through SPMI interface.
>> 
>> This first sentence will need continual updating. Please drop it.
>> 
>> > +  QPNP is effectively a partitioning scheme for dividing the SPMI extended
>> > +  register space up into logical pieces, and set of fixed register
>> > +  locations/definitions within these regions, with some of these regions
>> > +  specifically used for interrupt handling.
>> > +
>> > +  The QPNP PMICs are used with the Qualcomm Snapdragon series SoCs, and are
>> > +  interfaced to the chip via the SPMI (System Power Management Interface) bus.
>> > +  Support for multiple independent functions are implemented by splitting the
>> > +  16-bit SPMI slave address space into 256 smaller fixed-size regions, 256 bytes
>> > +  each. A function can consume one or more of these fixed-size register regions.
>> > +
>> > +properties:
>> > +  compatible:
>> > +    enum:
>> > +      - qcom,pm8941
>> > +      - qcom,pm8841
>> > +      - qcom,pma8084
>> > +      - qcom,pm8019
>> > +      - qcom,pm8226
>> > +      - qcom,pm8110
>> > +      - qcom,pma8084
>> > +      - qcom,pmi8962
>> > +      - qcom,pmd9635
>> > +      - qcom,pm8994
>> > +      - qcom,pmi8994
>> > +      - qcom,pm8916
>> > +      - qcom,pm8004
>> > +      - qcom,pm8909
>> > +      - qcom,pm8950
>> > +      - qcom,pmi8950
>> > +      - qcom,pm8998
>> > +      - qcom,pmi8998
>> > +      - qcom,pm8005
>> > +      - qcom,spmi-pmic
>> 
>> I think we want qcom,spmi-pmic to be there always. To do that we need 
>> it
>> to look like:
>> 
>>   compatible:
>>     items:
>>       enum:
>>         - qcom,pm8941
>>         ...
>>       enum:
>>         - qcom,spmi-pmic
> 
> Yes, but missing '-' before the enum's.
> 
Will add it in next post
>> 
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +    description:
>> > +      Specifies the SPMI USID slave address for this device.
>> > +      For more information see Documentation/devicetree/bindings/spmi/spmi.txt
>> > +
>> > +patternProperties:
>> > +  "^.*@[0-9a-f]+$":
> 
> You are going to need to define the specific child nodes with the
> schemas for them, but a SPMI bus schema may be useful.
> 
Ok.. I will add it in next post.
>> > +    type: object
>> > +    description:
>> > +      Each child node of SPMI slave id represents a function of the PMIC. In the
>> > +      example below the rtc device node represents a peripheral of pm8941
>> > +      SID = 0. The regulator device node represents a peripheral of pm8941 SID = 1.
>> > +
>> > +    properties:
>> > +      compatible:
>> > +        description:
>> > +          Compatible of the PMIC device.
>> > +
>> > +      interrupts:
>> > +        maxItems: 2
>> > +        description:
>> > +          Interrupts are specified as a 4-tuple. For more information
>> > +          see Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>> 
>> Just make this bindings/spmi/qcom,spmi-pmic-arb.txt so that  we don't
>> have to worry about it. Why is max items 2? Isn't it 4? Is this 
>> property
>> supposed to be specified at all?
>> 
>> > +
>> > +      interrupt-names:
>> > +        description:
>> > +          Corresponding interrupt name to the interrupts property
>> 
>> Does this need to be specified either?
>> 
>> > +
>> > +    required:
>> > +      - compatible
>> > +
>> > +required:
>> > +  - compatible
>> > +  - reg
>> > +
>> > +examples:
>> > +  - |
>> > +    spmi {
>> > +        compatible = "qcom,spmi-pmic-arb";
>> > +        #address-cells = <2>;
>> > +        #size-cells = <0>;
>> > +
>> > +       pm8941@0 {
>> 
>> pmic@0
>> 
>> > +         compatible = "qcom,pm8941";
>> > +         reg = <0x0 0x0>;
>> 
>> Why not include the header file to get the SPMI_USID macro?
>> 
>> > +
>> > +         rtc {
>> > +           compatible = "qcom,rtc";
>> > +           interrupts = <0x0 0x61 0x1 0x1>;
>> > +           interrupt-names = "alarm";
>> > +         };
>> > +       };
>> > +
>> > +       pm8941@1 {
>> 
>> pmic@1
>> 
>> > +         compatible = "qcom,pm8941";
>> > +         reg = <0x1 0x0>;
>> > +
>> > +         regulator {
>> > +           compatible = "qcom,regulator";
>> > +           regulator-name = "8941_boost";
>> > +         };
>> > +       };
>> > +    };
>> > +...
>> > --
>> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> >  a Linux Foundation Collaborative Project
