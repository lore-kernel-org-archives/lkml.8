Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A1DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054482064C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmqfhVFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXER2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 00:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgGXER1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 00:17:27 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7025AC0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 21:17:27 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so7013259oik.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTT73fROBVT8TZbJViXVHJt1wjzukhaNdjZMHoT4MMM=;
        b=gmqfhVFtR337ZrjFDzRLwS/pOwrr2MrmvoxgzuqKhyWihrkEJAP0OX2mekTSzg1lTh
         4OUMLj+g/asCGM5+CFRMwA6QrVEYkt9ZHV2g9Fm9li9W3qYvQhsdGA8VUsGt9XIdkYFq
         T74by6FB0sFWsSyWM35fUrjhYhFXNwswSuCi4Ikt33R2rcJ+lqyOWu9SRtUzaE2aZ5hN
         HYOCF1X8xFXcJLig8HTMcWM5ChMEUGsUHPHsPAMPZJieMCK7+Soc88nUX/ZVh39kxb52
         6IqGWyKyZurId3qZ86v4I5jdSPrXaiJgCm881mzgCp0YsCHbi3Qbay/RKd5XqVmnbqHz
         z8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTT73fROBVT8TZbJViXVHJt1wjzukhaNdjZMHoT4MMM=;
        b=eIiSVolyFQ8HfErvWgKf+3qXxhm8tQHAbz5nnHGnMDL8Q4qt98MUYmy924lRl+LBkH
         Ouzoglaew5esWmSCirvU2CfQqX5itO5oXIEjl54pLfBfhUvr4vTb8yG6AHrtfiybIyoN
         D4VHhIiJZWAGW9E5DfeEFayh5DYUX/2YIkiM0zq2doSJti690ZZ2bwoYKUpd1RZ2JCUA
         GFJWHEGOThEtpAP9Q3ib+5qA6QxQh3N2asj1k0/C+vmkVB6NHmDef8+myqc4clnkEsU6
         AU8tu720D9RWGitxBfJZt/qa0G9oKP1BMau6BWrE5p3QRFqeRLNo+FL7IC75HtMwqQQz
         zYJg==
X-Gm-Message-State: AOAM531C8kyE9BRk0CwoNHrVmuJ8wprZpFlUFzvOSeR/C881ts3MNWYS
        dr3I8Bk4jjCBNduJbQ6mgHq01Aq0LYuUz79Tf91IiA==
X-Google-Smtp-Source: ABdhPJx/agHjYflbwk6fi2xXMZqsnu4VQ0/K/yAmmSRQzS/+TjeabhqhPYBCWVJmqyU41+AcbdUgXQZnaG5C8w8nTZQ=
X-Received: by 2002:aca:2811:: with SMTP id 17mr6887468oix.166.1595564246768;
 Thu, 23 Jul 2020 21:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200722055816.20768-1-sumit.semwal@linaro.org>
 <20200722055816.20768-2-sumit.semwal@linaro.org> <20200723175552.GA602630@bogus>
In-Reply-To: <20200723175552.GA602630@bogus>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Fri, 24 Jul 2020 09:47:15 +0530
Message-ID: <CAO_48GH3btOO9JyxqC2JEcqqxnP_Fxk_u4mvuaEy22TfMZ8pqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add bindings for
 Tianma nt36672a panel
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review!

On Thu, 23 Jul 2020 at 23:25, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jul 22, 2020 at 11:28:15AM +0530, Sumit Semwal wrote:
> > The nt36672a panel from Tianma is a FHD+ panel with a resolution of 1080x2246
> > and 6.18 inches size. It is found in some of the Poco F1 phones.
> >
> > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> > Change-Id: I401dfbfe23ff2d806c956002f45e349cb9688c16
>
> You know better...
Yes - Sorry :( - will correct.
>
> > ---
> > v2: remove ports node, making port@0 directly under panel@0 node.
> > ---
> >  .../display/panel/tianma,nt36672a.yaml        | 104 ++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> > new file mode 100644
> > index 000000000000..cb1799fbbd32
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> > @@ -0,0 +1,104 @@
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
> > +
> > +  port@0:
>
> Just 'port' as there can only be 1 in this case.
>
> You can do just: 'port: true' as panel-common.yaml already has a
> definition.

Ok, let me try that and send out v3.
>
> > +    type: object
> > +    description: DSI input port driven by master DSI
> > +    properties:
> > +      reg:
> > +        const: 0
> > +
> > +    required:
> > +      - reg
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
> > +  - port@0
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |+
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    dsi0 {
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
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        port@0 {
> > +          reg = <0>;
> > +          tianma_nt36672a_in_0: endpoint {
> > +            remote-endpoint = <&dsi0_out>;
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +...
> > --
> > 2.27.0
> >
>

Best,
Sumit.
