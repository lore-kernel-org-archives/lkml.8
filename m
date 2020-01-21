Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34F8C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC55124655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579629452;
	bh=N1ByJboh9etCauJIpBnoIxPYjFw6LrjcIDQeMUgD/0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OMtf4dpM0aFOkflFMP4zTSGzupiwNu45FHLituD6iJQpJPY7VClhSHGG22Oxfm1UH
	 GDogEe5WBOC4H0iJdcLRxhY60gh12V6MIz/BIY4qkl9aX4OBlumPnMEglrvZuNa69I
	 EBAA+pnwb6DOhjKSZ3iXHxprA1qEEPD08vfXfT9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAUR5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAUR5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:57:32 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A9A24655;
        Tue, 21 Jan 2020 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579629451;
        bh=N1ByJboh9etCauJIpBnoIxPYjFw6LrjcIDQeMUgD/0I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qos0rbbiJj3cgXk//m1aSZmk9oIDKZ3rgaN9BM/PN8+gxyZACjeaa5Ix+gapZTu8s
         4+pFOS1KisXJErzfyisirnX3Ov1ARIfrRxu4xSpB8HtWo1JfgXPjDoSgECUcbHgOZR
         6Ico5ulbmJ/LWoXHPQ/RQZty0L1Am9v9kwbBmP+E=
Received: by mail-qk1-f181.google.com with SMTP id q15so2884562qke.9;
        Tue, 21 Jan 2020 09:57:30 -0800 (PST)
X-Gm-Message-State: APjAAAWPLZmVxVL/uvk0TPHPwCUhHlE5jVhpOpeXv+wFR7iCLEDr+spY
        vw5yAAqb6L96aT36J01AJ6rgM4acrNNwFDwzbw==
X-Google-Smtp-Source: APXvYqyRmUYoX+Rv5wUpjNRs1vQFxqO3DHQ3ad4AHZ0Q+B/L9k1IDRQlZN802njJ44dzDDj2PCkQc+TLozLvMqX3he8=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr5347069qkl.119.1579629450069;
 Tue, 21 Jan 2020 09:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20200108111830.8482-1-rogerq@ti.com> <20200108111830.8482-3-rogerq@ti.com>
 <20200115014724.GA20772@bogus> <1c55f0a8-99e3-934f-e8b8-d090df06a12e@ti.com>
In-Reply-To: <1c55f0a8-99e3-934f-e8b8-d090df06a12e@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Jan 2020 11:57:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfJDN2LnqWHehFiM-SQyeqQAk2wjoKRbBiPy4tc5OkMQ@mail.gmail.com>
Message-ID: <CAL_JsqLfJDN2LnqWHehFiM-SQyeqQAk2wjoKRbBiPy4tc5OkMQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: ti: k3-j721e-main: Add serdes_ln_ctrl
 node to select SERDES lane mux
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:10 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 15/01/20 7:17 AM, Rob Herring wrote:
> > On Wed, Jan 08, 2020 at 01:18:27PM +0200, Roger Quadros wrote:
> >> From: Kishon Vijay Abraham I <kishon@ti.com>
> >>
> >> Add serdes_ln_ctrl node used for selecting SERDES lane mux.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 26 +++++++++++
> >>  include/dt-bindings/mux/mux-j721e-wiz.h   | 53 +++++++++++++++++++++++
> >>  2 files changed, 79 insertions(+)
> >>  create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >> index 24cb78db28e4..6741c1e67f50 100644
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
> >> @@ -19,6 +21,30 @@
> >>              };
> >>      };
> >>
> >> +    scm_conf: scm_conf@100000 {
> >
> > Don't use '_' in node names.
>
> Okay.
> >
> >> +            compatible = "syscon", "simple-mfd";
> >
> > Needs a specific compatible especially since the child node doesn't have
> > one.
>
> Child node has "mmio-mux" as compatible no? Are you referring to
> something else here?

I'm referring to exactly what I quoted, but that's also a generic
compatible, so you'd never be able to match any of this block to a
specific driver or handle any quirks.

Rob
