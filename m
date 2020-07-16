Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BA1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE33D20672
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=snejp.pl header.i=@snejp.pl header.b="Q8OcFTKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGPV3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgGPV3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:29:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55323C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:29:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so9990399ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BMW25MccEXBEQKiOayk0XDiCmm5Kg67PbQTIPz8CeXU=;
        b=Q8OcFTKPw8k3z2elh+O/yAez7MPSAXdHzUNs/Ks0fOM5yKcM8I5iUWNAkZLRO8jVYV
         Bi1IGEqK4hM3tKFXoVzNwDiXw03mVBOwFZM2ZpD5QMNN8oi/tuqzs/YmofsxLwHFSanG
         rFA5u6QvyEgmg05+RjOlgBWx164bWRFwGHueXaqHiIF8IiHGDhPO43BOuPYo2ekOAeaq
         /LFBPfI0ksHYRgg/bnshjk9SVN6q5y0JnVoHg60EqQdfLl6gRSehZshGGbiyLKJw2l8v
         fBy4ebyhe6m0NS1dY1pvmnrCSLCuqHrql7lR/IcHDRjiuLewIkuNRo4sQhYFvB/xfMWW
         L78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BMW25MccEXBEQKiOayk0XDiCmm5Kg67PbQTIPz8CeXU=;
        b=njGpImF+63GvIj0YTW4cX+E/uM3TIsC8VNomCmi4ajilH0CpjYRroPfUjhjTb+n7gf
         tLk/7TCmBhHpm7d21Mi/wRXBw2LVOuFX51gpvmEP6phBn8qf/POGLic3MVr7+7qOZJVk
         5gMV0BRuJuW2PrZfBSABo1WeSRa/+TxiAcY6enqQnrk3sTfJ4t7WSB7WOeoN0fAZQLEY
         u2SpJjcVO+qMhvWZ3j9fYgMHiTs/v+lxLP3V6u7/EvQTuplrMBmIlYFvRKKIafJbqNiP
         +wCpjkIOI07TaSZs6MNePwluf1njUJKxSDNYYCgr+KSImmlhBYzqrgiphIXvCsd6HiX9
         vyeQ==
X-Gm-Message-State: AOAM532a1tX+Bfd8YNRjmUDsvRFdC6Yi/oaTSw4spU7fWOetxXpZcopB
        eOOWGKd5993D5oVVU/1HfU6XfA==
X-Google-Smtp-Source: ABdhPJzVYp/5WHye4DJHuSaRnmWrbiRRSCijThWnACJvir4tMmyzsXCyvlLmpk/vX1xE+o8oq9JMeg==
X-Received: by 2002:a2e:8296:: with SMTP id y22mr3056440ljg.238.1594934945707;
        Thu, 16 Jul 2020 14:29:05 -0700 (PDT)
Received: from PackardBell ([82.160.139.10])
        by smtp.gmail.com with ESMTPSA id k12sm1287608lfe.68.2020.07.16.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 14:29:04 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 44c50bbc;
        Thu, 16 Jul 2020 21:29:03 +0000 (UTC)
Date:   Thu, 16 Jul 2020 23:29:03 +0200
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add msm8226 pinctrl
 bindings
Message-ID: <20200716212903.GA23234@PackardBell>
References: <20200627192833.217531-1-bartosz.dudziak@snejp.pl>
 <20200627192833.217531-2-bartosz.dudziak@snejp.pl>
 <20200715202413.GA755488@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715202413.GA755488@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:24:13PM -0600, Rob Herring wrote:
> On Sat, Jun 27, 2020 at 09:28:30PM +0200, Bartosz Dudziak wrote:
> > Add device tree binding Documentation details for Qualcomm msm8226
> > pinctrl driver.
> > 
> > - Bindings documentation was based on qcom,sm8250-pinctrl.yaml by
> >   Bjorn Andersson <bjorn.andersson@linaro.org> and then modified for
> >   msm8226 content
> > 
> > Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
> > ---
> >  .../pinctrl/qcom,msm8226-pinctrl.yaml         | 123 ++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
> > new file mode 100644
> > index 0000000000..8d8dc15718
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/qcom,msm8226-pinctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Technologies, Inc. MSM8226 TLMM block
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +
> > +description: |
> > +  This binding describes the Top Level Mode Multiplexer block found in the
> > +  MSM8226 platform.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,msm8226-pinctrl
> > +
> > +  reg:
> > +    description: Specifies the base address and size of the TLMM register space
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: Specifies the TLMM summary IRQ
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    description: Specifies the PIN numbers and Flags, as defined in
> > +      include/dt-bindings/interrupt-controller/irq.h
> > +    const: 2
> > +
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +    description: Specifying the pin number and flags, as defined in
> > +      include/dt-bindings/gpio/gpio.h
> > +    const: 2
> > +
> > +  gpio-ranges:
> > +    maxItems: 1
> > +
> > +  gpio-reserved-ranges:
> > +    maxItems: 1
> > +
> > +#PIN CONFIGURATION NODES
> > +patternProperties:
> > +  '^.*$':
> > +    if:
> > +      type: object
> 
> For new bindings, do '-pins$' for the node name pattern so we don't have 
> to do this hack.
> 

I have changed the name pattern and sent a v2 patch.
