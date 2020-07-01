Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6BB2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593644660;
	bh=xADYpuPcpB9DnBYMeATixm96pornbZSwD9fsbA/EkUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z98+3APR00KyaUobDguY5FWtK0qrvC6xl+X9l63V4tAua7aKdGT/S5qaC57DM5EXm
	 IzCEhJoXaBr6KbDGdDudrkoClfOvnp7fLDk/PQiTJbUpop4/2tm71GwAyde5t7v7g9
	 SBC0IYglqs5lz/2NOJz8LaPzDWUkHjZS6mtaS9us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGAXET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgGAXER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:04:17 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE20520853;
        Wed,  1 Jul 2020 23:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593644656;
        bh=xADYpuPcpB9DnBYMeATixm96pornbZSwD9fsbA/EkUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N4WNCnlwW75STaBoM4nESPdYa3CEtERMYwop9249GPhVHfGR/w7wlwAGvYNvcO/+V
         6jUvxCzg7xX4Kkw9SgD0W8OIL4ofT7AO8D3KIMBAiTnQWAHid3rx51RLC9KfEKgfUc
         hvU6M9DkgqZxP2UJ9OWSglDXbdCSipx+uBBPjNJg=
Received: by mail-ot1-f50.google.com with SMTP id n5so22762606otj.1;
        Wed, 01 Jul 2020 16:04:16 -0700 (PDT)
X-Gm-Message-State: AOAM533rXeBskMwaXamzRVUfX+5jah51/FQjzU4gWJssmJhDKwjMC2ip
        mcwPVteoVZGcj2IuNaD8t8ab01tFa+DLIwHL9A==
X-Google-Smtp-Source: ABdhPJyEtcPiWAoCtMCBP6uB56H3qK7DoNTRwDqON+PKC/OAKNp/yWDzuj7/GTBSB3meXGy8rQ/y733j1qkw4KLrBec=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr24919702ots.192.1593644656059;
 Wed, 01 Jul 2020 16:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200629120054.29338-1-laurent.pinchart@ideasonboard.com>
 <20200629120054.29338-2-laurent.pinchart@ideasonboard.com>
 <20200629223011.GA3074548@bogus> <20200701133317.GD27013@pendragon.ideasonboard.com>
In-Reply-To: <20200701133317.GD27013@pendragon.ideasonboard.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Jul 2020 17:04:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJaL3avLf6YGhAbSezykKi+hmCZWM0S1VZRdZSiBtkVbA@mail.gmail.com>
Message-ID: <CAL_JsqJaL3avLf6YGhAbSezykKi+hmCZWM0S1VZRdZSiBtkVbA@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 7:33 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> On Mon, Jun 29, 2020 at 04:30:11PM -0600, Rob Herring wrote:
> > On Mon, 29 Jun 2020 15:00:52 +0300, Laurent Pinchart wrote:
> > > From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > >
> > > Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> > > Processing System Gigabit Transceiver which provides PHY capabilities to
> > > USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> > >
> > > Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Changes since v8:
> > >
> > > - Rebase on phy/next
> > >
> > > Changes since v7:
> > >
> > > - Switch to GPL-2.0-only OR BSD-2-Clause
> > >
> > > Changes since v6:
> > >
> > > - Fixed specification of compatible-dependent xlnx,tx-termination-fix
> > >   property
> > > - Dropped status property from example
> > > - Use 4 spaces to indent example
> > >
> > > Changes since v5:
> > >
> > > - Document clocks and clock-names properties
> > > - Document resets and reset-names properties
> > > - Replace subnodes with an additional entry in the PHY cells
> > > - Drop lane frequency PHY cell, replaced by reference clock phandle
> > > - Convert bindings to YAML
> > > - Reword the subject line
> > > - Drop Rob's R-b as the bindings have significantly changed
> > > - Drop resets and reset-names properties
> > > ---
> > >  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 105 ++++++++++++++++++
> > >  include/dt-bindings/phy/phy.h                 |   1 +
> > >  2 files changed, 106 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > >
> >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.example.dt.yaml: example-0: phy@fd400000:reg:0: [0, 4248829952, 0, 262144] is too long
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.example.dt.yaml: example-0: phy@fd400000:reg:1: [0, 4248633344, 0, 4096] is too long
> >
> >
> > See https://patchwork.ozlabs.org/patch/1319269
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure dt-schema is up to date:
> >
> > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> >
> > Please check and re-submit.
>
> Sorry :-S I've updated the schema now. The patch has already been
> merged, so I'll submit a fix.

No worries, it's a moving target. The check just got added to the schemas.

Rob
