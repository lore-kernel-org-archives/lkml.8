Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F181C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FCD2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgEYIJu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgFHKiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgFHKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:38:19 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A04C08C5C3;
        Mon,  8 Jun 2020 03:38:19 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w18so9166653iom.5;
        Mon, 08 Jun 2020 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFGDEiFCI8TsMWMIzZyvQUxGXy/3QcSkytw+qRIuNg0=;
        b=mgEYIJu9CycDnuVvMb2HkAkKQHsierheTRAAn+r8uyQYd5AYnrd+4kzO1xnrMylkfS
         aIgGqaj1S6y5ywsoiD9XFNvYYumLCj16bBPehuP1S9htxMOdqkVvQpCtr0Gb3xHCi9vo
         cVcsu8ukum6yw7tVfNZviKPEOuAREGTaoyUf0R9SpdRdZlfg9KqgA0w8vv7vz4/Q6LEz
         RG06wTVCmMSWFGG2WRcyGzaKcScXDEW4nONoZqtfqUo7zyBjBdWcodm3CUCwS0cqQEWh
         yIUip9TFhEQFQN7/pxWjwXYQeR1Si6h90ElwnojQba4pCtedrDrXr5LPdjvIJz5YCKkw
         8SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFGDEiFCI8TsMWMIzZyvQUxGXy/3QcSkytw+qRIuNg0=;
        b=MqV7LVpg8QpdBBWdcmpJLZ3+Y4ut5FxK4CFP+7caKplD8C6BJZGi5fyoH47cLRbFdr
         zlBiyEiLgzv1xgb1abvQXaYdNX0dm1C+dXHNaYYQPWARu8h1aYFT/vPYZuZjjOn6OrDT
         wvsDP4fYGuaAN99iKD7ce3ougpgm+3fLok1jRGX5syJQWgNKFlbsUROpKD1Wc/jdWzRe
         3MqQa4wq9xApxJit5Klv8fMe/A8hMyzpvecTQjIg9azIJK284V+JaPpd8b7kuBT71nJp
         9lFEm+DpeAoFRDsOy/oSuJYNhcCP1Mn1zMkSHupbxKHZBuSWqkKHRXIJSEaa9Mcz+8jU
         9+oA==
X-Gm-Message-State: AOAM533WtaQMNc9gvr78C5r6Fz5sdC0LusVSscV0a1XJlBCAaPjXbZoF
        UgPYGCMQvnq5kg7PWBUSOORceZUrFjfTehkY22NmHGj7F6A=
X-Google-Smtp-Source: ABdhPJxQvsGmDayuQnB3yzpdYEuEcsrE4hiOH+fuLClO9hFRqWUQ9X2/WU/ZE9TmBVXvUl4AO6vXuZ7wXv64lY/hiIg=
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr10428987iow.147.1591612698290;
 Mon, 08 Jun 2020 03:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <1583920112-2680-1-git-send-email-simhavcs@gmail.com>
 <20200312151752.GA7490@bogus> <CAGWqDJ7DP3DuR7EWT6Ni8YxN3Adg3RgJZut6+AtpAak_HB=QCQ@mail.gmail.com>
 <CAGWqDJ4cAU98_xMk6f-bsT5LF5cD2JJk8_JCykwM=cd6CCfWtw@mail.gmail.com> <20200317142702.GA16338@ravnborg.org>
In-Reply-To: <20200317142702.GA16338@ravnborg.org>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Mon, 8 Jun 2020 16:08:06 +0530
Message-ID: <CAGWqDJ6MP0gEpL3FTXPH4jGaqM4PBOhZCQ=h99FJCPxVcVdWBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-binding: Add DSI/LVDS tc358775 bridge bindings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sam,

This is my latest yaml file
https://github.com/vinaysimhabn/kernel-msm/blob/5.6.0-rc3-d2l-wip/Documentation/devicetree/bindings/display/bridge/toshiba%2Ctc358775.yaml

 make CROSS_COMPILE=$TC64 ARCH=arm64
DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
dt_binding_check
i am getting these errors
Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.example.dt.yaml:
lvds-out: 'data-mapping', 'height-mm', 'panel-timing', 'width-mm' do
not match any of the regexes: 'pinctrl-[0-9]+'
Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.example.dt.yaml:
lvds-out: compatible: Additional items are not allowed ('panel-lvds'
was unexpected)
Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.example.dt.yaml:
lvds-out: compatible: ['auo,b101xtn01', 'panel-lvds'] is too long

Please suggest how to add the references of panel/lvds.yaml or
panel/panel-common.yaml and panel/advantech,idk-2121wr.yaml in my yaml
file.

On Tue, Mar 17, 2020 at 7:57 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Vinay.
>
> On Tue, Mar 17, 2020 at 12:25:42PM +0530, Vinay Simha B N wrote:
> > sam,
> >
> > i need some inputs on the below  error. I had created this file
> > Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
> > by using vim editor. Do we have any tool to create yaml file?
>
> I use vim myself, but is careful to follow the right syntax.
>
> >
> > i do not get the error when running 'make dt_binding_check' in my
> > build environment
> > Documentation/devicetree/bindings/display/bridge/toshiba-tc358775.yaml
> >
> > is there any tool available similar to  scripts/checkpatch.pl -f
> > <file> , for yaml files?
>
> Please read Documentation/devicetree/writing-schema.
> Here you can find general info + instruction how to install the tools
> required for "make dt_binding_check".
>
> I could reproduce the error reported by Rob.
> I gave your binding file a shot - there were a lot of smaller issues:
>
> - do not use tabs in yaml files
> - be consistent in indent
> - vendor prefixed properties needed some extra care
> - example was full of bugs
>   - "..."
>   - no need for status = "okay";
>   - properties spelled wrong
>
> For the example I adjusted it to use indent of 4 spaces, which IMO
> is more readable than the two spaces used in the other parts of the
> file.
>
> I have attached the updated binding file - please review and fix.
> This is just a quick shot, I did not do a proper review.
>
> Please rename the file, other files in same dir are named "toshiba,xxx",
> so replace '-' with ','.
>
> And try to introduce bugs in the example - and check that the tooling
> catches the bug.
>
> hint:
>
>     make DT=.../foo.yaml dt_binding_check
>
> is a qucik way to check only your binding.
>
> And for new bindings the preferred license is: (GPL-2.0-only OR BSD-2-Clause)
>
>         Sam
>
> # SPDX-License-Identifier: GPL-2.0
> %YAML 1.2
> ---
> $id: http://devicetree.org/schemas/display/bridge/toshiba-tc358775.yaml#
> $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>
> title: Toshiba TC358775 DSI to LVDS bridge bindings
>
> maintainers:
>   - Vinay Simha BN <simhavcs@gmail.com>
>
> description: |
>   This binding supports DSI to LVDS bridge TC358775
>
> properties:
>   compatible:
>     const: toshiba,tc358775
>
>   reg:
>     maxItems: 1
>     description: i2c address of the bridge, 0x0f
>
>   toshiba,dsi-lanes:
>     allOf:
>       - $ref: /schemas/types.yaml#/definitions/uint32
>       - minimum: 1
>         maximum: 4
>         default: 1
>     description: bla bla
>
>   toshiba,dual-link:
>     $ref: /schemas/types.yaml#definitions/flag
>     description: bla bla
>
>   vdd-supply:
>     maxItems: 1
>     description: 1.2V LVDS Power Supply
>
>   vddio-supply:
>     maxItems: 1
>     description: 1.8V IO Power Supply
>
>   stby-gpios:
>     maxItems: 1
>     description: Standby pin, Low active
>
>   reset-gpios:
>     maxItems: 1
>     description: Hardware reset, Low active
>
>   ports:
>     type: object
>
>     properties:
>       port@0:
>         type: object
>         description: |
>           DSI Input. The remote endpoint phandle should be a
>           reference to a valid mipi_dsi_host device node.
>       port@1:
>         type: object
>         description: |
>           Video port for LVDS output (panel or connector).
>
>     required:
>       - port@0
>       - port@1
>
> required:
>  - compatible
>  - reg
>  - tc,dsi-lanes
>  - vdd-supply
>  - vddio-supply
>  - stby-gpios
>  - reset-gpios
>  - ports
>
> examples:
>   - |+
>     #include <dt-bindings/gpio/gpio.h>
>
>     i2c@78b8000 {
>         #address-cells = <1>;
>         #size-cells = <0>;
>
>         /* On High speed expansion */
>         label = "HS-I2C2";
>         status = "okay";
>
>         tc_bridge: bridge@f {
>             compatible = "toshiba,tc358775";
>             reg = <0x0f>;
>
>             tc,dsi-lanes = <4>;
>             tc,dual-link = <0>;
>
>             vdd-supply = <&pm8916_l2>;
>             vddio-supply = <&pm8916_l6>;
>
>             stby-gpios = <&msmgpio 99 GPIO_ACTIVE_LOW>;
>             reset-gpios = <&msmgpio 72 GPIO_ACTIVE_LOW>;
>
>             ports {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 port@0 {
>                     reg = <0>;
>                     d2l_in: endpoint {
>                         remote-endpoint = <&dsi0_out>;
>                     };
>                 };
>
>                 port@1 {
>                     reg = <1>;
>                     d2l_out: endpoint {
>                         remote-endpoint = <&panel_in>;
>                     };
>                 };
>             };
>         };
>     };
>
>     panel: auo,b101xtn01 {
>         status = "okay";
>         compatible = "auo,b101xtn01", "panel-lvds";
>         power-supply = <&pm8916_l14>;
>
>         width-mm = <223>;
>         height-mm = <125>;
>
>         data-mapping = "jeida-24";
>
>         panel-timing {
>             /* 1366x768 @60Hz */
>             clock-frequency = <72000000>;
>             hactive = <1366>;
>             vactive = <768>;
>             hsync-len = <70>;
>             hfront-porch = <20>;
>             hback-porch = <0>;
>             vsync-len = <42>;
>             vfront-porch = <14>;
>             vback-porch = <0>;
>         };
>
>         port {
>             panel_in: endpoint {
>                 remote-endpoint = <&d2l_out>;
>             };
>         };
>     };
>
>     mdss {
>         dsi@1a98000 {
>             ports {
>                 port@1 {
>                     dsi0_out: endpoint {
>                         remote-endpoint = <&d2l_in>;
>                         data-lanes = <0 1 2 3>;
>                     };
>                 };
>             };
>         };
>     };
>
> ...



-- 
regards,
vinaysimha
