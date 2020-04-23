Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F7EC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461BD20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fh0fZr67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgDWROj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgDWROj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:14:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6506C09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:14:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so2769731pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImuquuX0o7pPZ9bGea3cOCMdcWyQffNkeX4qWUmGnVg=;
        b=Fh0fZr67sNv4FZXbdb2Lcuj0w/6m5469ARU5b3Jv/J3awFsgvnHW3GBDZFtirwtTBQ
         VEnYdEMOXA7GOEJ772QwCTyKtnMRkhQGc274PhNw5eueSePwxSpYDaiovIpiQwbjJpk7
         A+JstF5rX7YaXE7oR/EIxsG2+WhCAhxk2uvkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImuquuX0o7pPZ9bGea3cOCMdcWyQffNkeX4qWUmGnVg=;
        b=K0zplu1hzVMIYyDiKGA51mWwf8uV2j46xbYcy+P6kJODOmzZTTd9LrBtYi2Ha4gxQj
         Siy2NcVsI/5DUb3eJyKauvu7KikXShoFXHSV1B46XdHrorivKFTKSSP+n+0ubEPbhBhy
         HpTXVYdwiUCL9GCxzM//Ud8X8eBmLACceSCXW9+mUZoJTTi3jmXl+XLqnClPUDdqM1TF
         k8ysyQQcVAbJaABWDzh1ZVf+Mesc8rkE6rgNi28SBULdEjFIcoiIkEXKt+z9Awf0+Mow
         kbVbZgNE6xisKx92vTf9b9zo5gBjvnq4ATUXlgyCaLl+viJkH2HVoMqV3+1vDldMaKJy
         T+mQ==
X-Gm-Message-State: AGi0PuZsdjoUTL+umJtEwaopqI3yWo0aJRcDFqde8Z6bl1V1tq/gwpYx
        KMYO9cD2cg54oPo+F2E45y3kkA==
X-Google-Smtp-Source: APiQypIk9MvasGQWk+XnO6jWjIG+YouGIGQ62gjIE7RPw9r/JY+62QVCBe9Tpk5sU4R2pFA0IkyAPQ==
X-Received: by 2002:a17:902:70c1:: with SMTP id l1mr4519146plt.298.1587662078207;
        Thu, 23 Apr 2020 10:14:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id d12sm2950227pfq.36.2020.04.23.10.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 10:14:37 -0700 (PDT)
Date:   Thu, 23 Apr 2020 10:14:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>, robdclark@gmail.com,
        abhinavk@codeaurora.org, nganji@codeaurora.org,
        jsanka@codeaurora.org, aravindh@codeaurora.org,
        hoegsberg@google.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 1/3] dt-bindings: phy: qcom,qmp: Convert QMP PHY
 bindings to yaml
Message-ID: <20200423171436.GJ199755@google.com>
References: <1585809534-11244-1-git-send-email-sanm@codeaurora.org>
 <1585809534-11244-2-git-send-email-sanm@codeaurora.org>
 <158689927748.105027.5367465616284167712@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158689927748.105027.5367465616284167712@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

On Tue, Apr 14, 2020 at 02:21:17PM -0700, Stephen Boyd wrote:
> Quoting Sandeep Maheswaram (2020-04-01 23:38:52)
> > Convert QMP PHY bindings to DT schema format using json-schema.
> > 
> > Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> > ---
> >  .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 332 +++++++++++++++++++++
> >  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 242 ---------------
> >  2 files changed, 332 insertions(+), 242 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > new file mode 100644
> > index 0000000..18a8985
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > @@ -0,0 +1,332 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/phy/qcom,qmp-phy.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Qualcomm QMP PHY controller
> > +
> > +maintainers:
> > +  - Manu Gautam <mgautam@codeaurora.org>
> > +
> > +description:
> > +  QMP phy controller supports physical layer functionality for a number of
> > +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,ipq8074-qmp-pcie-phy
> > +      - qcom,msm8996-qmp-pcie-phy
> > +      - qcom,msm8996-qmp-ufs-phy
> > +      - qcom,msm8996-qmp-usb3-phy
> > +      - qcom,msm8998-qmp-pcie-phy
> > +      - qcom,msm8998-qmp-ufs-phy
> > +      - qcom,msm8998-qmp-usb3-phy
> > +      - qcom,sdm845-qhp-pcie-phy
> > +      - qcom,sdm845-qmp-pcie-phy
> > +      - qcom,sdm845-qmp-ufs-phy
> > +      - qcom,sdm845-qmp-usb3-phy
> > +      - qcom,sdm845-qmp-usb3-uni-phy
> > +      - qcom,sm8150-qmp-ufs-phy
> > +
> > +  reg:
> > +    minItems: 1
> > +    items:
> > +      - description: Address and length of PHY's common serdes block.
> > +      - description: Address and length of the DP_COM control block.
> 
> This DP_COM block is only for one compatible. Is it possible to split
> that compatible out of this binding so we can enforce the reg property
> being either one or two items?
> 
> In addition, I don't quite understand how this binding is supposed to
> work with the DP phy that sits inside qcom,sdm845-qmp-usb3-phy and then
> gets muxed out on the USB pins on sdm845 and sc7180 SoCs. Can you fill
> me in on how we plan to share the pins between the two phys so that all
> the combinations of DP and USB over the type-c pins will work here? My
> understanding is that the pins that are controlled by this hardware
> block are basically a full USB type-c connector pinout[1] (except that
> D+/D- isn't there and the VBUS and CC lines go to the PMIC). Either way,
> we get the TX1/2 and RX1/2 pins to use, so we can do 4x lanes of DP or
> 2x lanes DP and 2x lanes of USB. There's also a type-c orientation
> flipper bit that can flip the DP and USB phy lanes to the correct TX/RX
> pins on the SoC. And then the DP phy has a lane remapper to change the
> logical DP lane to the physical DP lane. It's a complex piece of
> hardware that isn't fully represented by this binding.
> 
> [1] https://en.wikipedia.org/wiki/USB-C#/media/File:USB_Type-C_Receptacle_Pinout.svg

Could you please answer Stephen's questions? It would be great to move
forward and get support for SC7180 landed.
