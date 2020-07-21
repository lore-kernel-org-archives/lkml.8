Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1008C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC7C21702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BG35BdvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgGUMQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGUMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:16:32 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:16:32 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r8so16993774oij.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tj0YIElsm/HeEdxHt1th62ZXmZMXZLHwFI4YkjRLTkY=;
        b=BG35BdvFgBIhVOcdziHOXibKbCb5GtjXDtlWr2qAdaS+a1hXrW20zoBQnecaEZ+HSa
         ofXv8y+dlK8kApzfUtejG9Yw3oo4bM6ewEbMekzD6uZAbw1g/gVihT1vEB6f+eRA1JVh
         Xx93rVMtHX2vpoRbWUYqBXYfk32r8lzhptDCAXXrmdW6rwQwhnu39Fy/+Lq7ik8OpGgW
         YN+0M2jGozU+HpOwZIpT7cJX2zT7jOSKjZYpQczR6rtuin0uy+01I5zcUvrVcbLs9JV6
         5qtz7kMahyFdJrgm4Ac5qhrO7kyiDpajM/IlLSfOrr5NtAinHGEhB6254DTtVFjFttLC
         BlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tj0YIElsm/HeEdxHt1th62ZXmZMXZLHwFI4YkjRLTkY=;
        b=Z/sH3YiVCUM7PXTx+7C9vqnp48z8DnT2BSXRTSDiv07yrK5K4eOOrvXr/j70BjFxUn
         mhKKSprr0o06zYbFlARekfTTHknks2J4LqYDfB1eDXQiOmqFrUE+K23InONxQ0vZhsNN
         g83SPM1ZJVdn3ioHnkbFxFPg0celSd3Vgvae2qnf+0MggksR3wCIUyd0vFSAp/EsGdNR
         xUOaqW8wH14hiK0HiT+UuzPsqtgtILX+01/TPo+vtrEB2VqcEYtSKDSN0sPIpnesOrbw
         4xTyhnhOP1TKMP0deB6Yz92MJgbbnVpMpEtL2MBSSXv+XO3PhesZkRspBW2h36a+pdJJ
         BC9Q==
X-Gm-Message-State: AOAM531KNJxgmgw7H0fvTqzsPKpRqoo48ZYVB+wYB3pipjHWgv3x3Z6E
        cU4NJEgsivTvkfvBr3waKxfozGfsOBddl//ldvySoQ==
X-Google-Smtp-Source: ABdhPJy7skUMTTFe9eMztqkjUQzK3SGXa8K9qJK6R1zk8g6dESlbOvXxjD+GaAh0s5BIlZfxJljITdtcursSIjP6m+A=
X-Received: by 2002:aca:f184:: with SMTP id p126mr2826593oih.76.1595333791831;
 Tue, 21 Jul 2020 05:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200716153858.526-1-sumit.semwal@linaro.org> <20200716153858.526-2-sumit.semwal@linaro.org>
 <20200721033328.GA3492972@bogus>
In-Reply-To: <20200721033328.GA3492972@bogus>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 21 Jul 2020 17:46:20 +0530
Message-ID: <CAO_48GFREVQ8q=thFw4gJp0wu1MYHkxHi3sxDr8ejRyyY-6_0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add bindings for Tianma
 nt36672a panel
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thanks for the review!
On Tue, 21 Jul 2020 at 09:03, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jul 16, 2020 at 09:08:57PM +0530, Sumit Semwal wrote:
> > The nt36672a panel from Tianma is a FHD+ panel with a resolution of 1080x2246
> > and 6.18 inches size. It is found in some of the Poco F1 phones.
> >
> > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> > ---
> >  .../display/panel/tianma,nt36672a.yaml        | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> > new file mode 100644
> > index 000000000000..3c583ca926ee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/tianma,nt36672a.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Tianma model NT36672A DSI Panel display driver
> > +
> > +maintainers:
> > +  - Sumit Semwal <sumit.semwal@linaro.org>
> > +
> > +description: |
> > +  The nt36672a panel from Tianma is a FHD+ LCD display panel with a resolution
> > +  of 1080x2246. It is a video mode DSI panel.
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: tianma,nt36672a
> > +
> > +  reg:
> > +    description: DSI virtual channel of the peripheral
> > +
> > +  reset-gpios:
> > +    description: phandle of gpio for reset line - This should be 8mA, gpio
> > +      can be configured using mux, pinctrl, pinctrl-names (active high)
> > +
> > +  vddio-supply:
> > +    description: phandle of the regulator that provides the supply voltage
> > +      Power IC supply
> > +
> > +  vddpos-supply:
> > +    description: phandle of the positive boost supply regulator
> > +
> > +  vddneg-supply:
> > +    description: phandle of the negative boost supply regulator
> > +
> > +  pinctrl-names:
> > +    description: Pinctrl for panel active and suspend
> > +
> > +  pinctrl-0:
> > +    description: Active pinctrls
> > +
> > +  pinctrl-1:
> > +    description: Suspend pinctrls
>
> I think the pinctrl should go in the DSI controller node, not the
> display unless it is settings for 'reset-gpios'.
Yes, from the downstream code, this seems to be for reset-gpios.

>
> > +
> > +  ports:
> > +    type: object
> > +    properties:
> > +      port@0:
> > +        type: object
> > +        description: DSI input port driven by master DSI
> > +        properties:
> > +          reg:
> > +            const: 0
> > +
> > +        required:
> > +          - reg
>
> For a single port, you can do just 'port' (without ports node).
Thanks; will update in next version.
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vddi0-supply
> > +  - vddpos-supply
> > +  - vddneg-supply
> > +  - reset-gpios
> > +  - pinctrl-names
> > +  - pinctrl-0
> > +  - pinctrl-1
> > +  - ports
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |+
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    dsi0 {
>
> dsi {
>
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      panel@0 {
> > +        compatible = "tianma,nt36672a";
> > +        reg = <0>;
> > +        vddi0-supply = <&vreg_l14a_1p88>;
> > +        vddpos-supply = <&lab>;
> > +        vddneg-supply = <&ibb>;
> > +
> > +        reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> > +
> > +        pinctrl-names = "panel_active", "panel_suspend";
> > +        pinctrl-0 = <&sde_dsi_active>;
> > +        pinctrl-1 = <&sde_dsi_suspend>;
> > +
> > +        ports {
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          port@0 {
> > +            reg = <0>;
> > +            tianma_nt36672a_in_0: endpoint {
> > +              remote-endpoint = <&dsi0_out>;
> > +            };
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +...
> > --
> > 2.27.0
> >

Best,
Sumit.
