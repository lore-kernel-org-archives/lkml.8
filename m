Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8213AC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589E9215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587759338;
	bh=l1O/C/hTo/zI0Ev9A/bDkK/3yYR6GXm/DdmR6fsA29s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MReKfzcbhoMrEwPXe2RJhXt+e1EVXjK8N+zSBC5BwTC6kY2BkOEC6UKwnv0/ArSa5
	 u9GlxONu3y2yNPXqDVd/btMvXgsedKhOkgg3ByZ9jJtHcKnSK1EjiTt2AWn8YcBHDw
	 gj6cU1ek/OgLw0tQQuY73doPwot004lsYA+/xnmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgDXUPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgDXUPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:15:37 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 183DC214AF;
        Fri, 24 Apr 2020 20:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587759336;
        bh=l1O/C/hTo/zI0Ev9A/bDkK/3yYR6GXm/DdmR6fsA29s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NBnwn88Vlic+UNRF5aueaudOU5sbWrzLDfkLeKYUyHCWJbKYoNZe32+TpmXVrWBnJ
         QZB7fkY7cZYVsxh/Q1GFdstcKCvlduZ4BkSpbg7gA8K39ftS5Aq1PIegU3l/wijsz1
         UQPcWA+RGXSkhWauwPwfx6wVI1yXoG9sHDd6cL2g=
Received: by mail-qv1-f41.google.com with SMTP id y19so5334700qvv.4;
        Fri, 24 Apr 2020 13:15:36 -0700 (PDT)
X-Gm-Message-State: AGi0PubU+CcX3khF4IFP6m8rmd6U9CSfjXGLFhxIjFzthxcmtGmWLgxX
        F1h1QfP6g540mP0xc4La4HOFXd5fa1o8C0yT7A==
X-Google-Smtp-Source: APiQypJ0f0ryj35lZZuNDRfB/EETxfcGPsUXh+hylvj1RxjuVyiDMzn7WSvH4H7yXAhIT+IJy7JbwU9WDjK9j+kOM08=
X-Received: by 2002:a0c:b651:: with SMTP id q17mr10460047qvf.135.1587759335207;
 Fri, 24 Apr 2020 13:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200303101722.26052-1-rogerq@ti.com> <20200303101722.26052-4-rogerq@ti.com>
 <20200310210904.GA11275@bogus> <247a115e-6b44-2906-07cf-771236d492d6@ti.com>
In-Reply-To: <247a115e-6b44-2906-07cf-771236d492d6@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Apr 2020 15:15:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUk2DJ-i9bemAO9FKmYUP5sgxyjzGpBPVpdv08bwZEJQ@mail.gmail.com>
Message-ID: <CAL_JsqLUk2DJ-i9bemAO9FKmYUP5sgxyjzGpBPVpdv08bwZEJQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: ti: k3-j721e-main: Add serdes_ln_ctrl
 node to select SERDES lane mux
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 5:32 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 11/03/20 2:39 am, Rob Herring wrote:
> > On Tue, Mar 03, 2020 at 12:17:19PM +0200, Roger Quadros wrote:
> >> From: Kishon Vijay Abraham I <kishon@ti.com>
> >>
> >> Add serdes_ln_ctrl node used for selecting SERDES lane mux.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 27 ++++++++++++
> >>  include/dt-bindings/mux/mux-j721e-wiz.h   | 53 +++++++++++++++++++++++
> >>  2 files changed, 80 insertions(+)
> >>  create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >> index cbaadee5bfdc..c5d54af37e91 100644
> >> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >> @@ -5,6 +5,8 @@
> >>   * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
> >>   */
> >>  #include <dt-bindings/phy/phy.h>
> >> +#include <dt-bindings/mux/mux.h>
> >> +#include <dt-bindings/mux/mux-j721e-wiz.h>
> >>
> >>  &cbass_main {
> >>      msmc_ram: sram@70000000 {
> >> @@ -19,6 +21,31 @@
> >>              };
> >>      };
> >>
> >> +    scm_conf: scm-conf@100000 {
> >> +            compatible = "syscon", "simple-mfd", "ti,j721e-system-controller";
> >
> > Wrong ordering. Most significant first.
> >
> >> +            reg = <0 0x00100000 0 0x1c000>;
> >> +            #address-cells = <1>;
> >> +            #size-cells = <1>;
> >> +            ranges = <0x0 0x0 0x00100000 0x1c000>;
> >> +
> >> +            serdes_ln_ctrl: serdes-ln-ctrl@4080 {
> >
> > Your syscon.yaml change is not valid if you have child nodes. Do a
> > specific binding for this block.
>
> Do you mean in addition to having platform specific binding for
> scm-conf, I need to have platform specific binding for serdes-ln-ctrl.

I mean 'dt-bindings: syscon: Add TI's J721E specific compatible string'.

While not currently enforced because 'unevaluatedProperties: false'
doesn't yet do anything, the intent with syscon.yaml is child nodes
are not allowed. If you have child nodes, you need your own schema.

Rob
