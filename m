Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3736EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0645207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599716270;
	bh=KzFX2IztZLgcyzVWfGl7cz8XwjZrrz4gFgRo0cURvB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Xe1r3mMC0UakFmghIYN7HhgNPLjNmRF0sTQTZfjzVaUvVL/Py+mnXETwvZ7P5TAfH
	 IgaIi5KuHBMM98vhN8Oit6366P5cvTNtJbuRa1safwb3E68HPBtAUEaDoAiOUgcPuw
	 PZXcEG9nyptccvDjIdVVLk8IZfp1+PaVmFAJsNlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIJFhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgIJFhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:37:45 -0400
Received: from coco.lan (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B967420731;
        Thu, 10 Sep 2020 05:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599716264;
        bh=KzFX2IztZLgcyzVWfGl7cz8XwjZrrz4gFgRo0cURvB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1zVWi5PB9CkoW9yI3AUBiTPFFGMxrlMoEu79augE+lBa93iLIJJs4LtaiOXIDBRkN
         vpvGtmYQEPBauJRpvx10hH3oROMrKG4J96ZeTDeUl8v1hXLMeN5mjXwK00MeIyvtK4
         q4MbEfXhKt879bi4ysUnugjbQVg679A9F/IPddaI=
Date:   Thu, 10 Sep 2020 07:37:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [RFC 03/10] phy: hisilicon: phy-hi3670-usb3: use a consistent
 namespace
Message-ID: <20200910073738.0d472fde@coco.lan>
In-Reply-To: <CAL_Jsq+e44-_AFqKEkUAKKWapMB7wHCPDCtuWrPvn__NMpNxOw@mail.gmail.com>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
        <58d6b31d0134448a35c47e822c887e994164228b.1599214329.git.mchehab+huawei@kernel.org>
        <CAL_Jsq+e44-_AFqKEkUAKKWapMB7wHCPDCtuWrPvn__NMpNxOw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 9 Sep 2020 14:15:59 -0600
Rob Herring <robh+dt@kernel.org> escreveu:

> On Fri, Sep 4, 2020 at 4:23 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Rename hikey970 to hi3670, in order to use a namespace
> > similar to hi3660 driver.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../bindings/phy/phy-hi3670-usb3.txt          |  4 +- =20
>=20
> Bindings should be a separate patch.

Ok. I'll split it.

>=20
> >  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 98 +++++++++----------
> >  2 files changed, 51 insertions(+), 51 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt =
b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> > index 4cb02612ff23..2fb27cb8beaf 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> > @@ -2,7 +2,7 @@ Hisilicon Kirin970 usb PHY
> >  -----------------------
> >
> >  Required properties:
> > -- compatible: should be "hisilicon,kirin970-usb-phy"
> > +- compatible: should be "hisilicon,hi3670-usb-phy" =20
>=20
> Unless this is unused, we can't just change it. It's an ABI.

=46rom upstream PoV, this binding is for a new driver that will be added
via this patchset.=20
>=20
> >  - #phy-cells: must be 0
> >  - hisilicon,pericrg-syscon: phandle of syscon used to control phy.
> >  - hisilicon,pctrl-syscon: phandle of syscon used to control phy.
> > @@ -14,7 +14,7 @@ Refer to phy/phy-bindings.txt for the generic PHY bin=
ding properties
> >
> >  Example:
> >         usb_phy: usbphy {
> > -               compatible =3D "hisilicon,kirin970-usb-phy";
> > +               compatible =3D "hisilicon,hi3670-usb-phy";
> >                 #phy-cells =3D <0>;
> >                 hisilicon,pericrg-syscon =3D <&crg_ctrl>;
> >                 hisilicon,pctrl-syscon =3D <&pctrl>; =20



Thanks,
Mauro
