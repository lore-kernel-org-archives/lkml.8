Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0DCC47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5072173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HdcxtBBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgD3VAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgD3VAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:00:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECA3C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:00:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so9010858wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUATwzpZxjtae1A7cwapMNJ5haJlC5HtdIYeEo2bhyI=;
        b=HdcxtBBTqr/xUzKOPsewGq+KhFdgf5wvseNGI2ZEIOXDWE46bkbjUocRTAcZ2uNLHp
         nForatMzsdPs8+L0IrFQikDJm2msJs+d9Tzz4+5/fMT652hPt+HIxLSJ02HdCHigVrN/
         9SAhr5CAesG8XtrGURdnaEgujEBNdBceBnfew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUATwzpZxjtae1A7cwapMNJ5haJlC5HtdIYeEo2bhyI=;
        b=szfyj5khk13T0KcGGD/u+I8xTfHd/yFOmm6nyR5KCGsDDv7za5HmhtQ4a75NrkVQSQ
         1+92tmlhdGM1R5uyjwoCRcEj6r7pZK87FXZhB8APoDPO5cVDPW/hUSU7s+Y+6VguzEa0
         x6oG4Litb0RdTSerPWrhukGyEO7HrS/4yBx1PfSlEBDbp+ySuIM29GOp12TTOBANru6v
         6nFy8D0fZUl4GPZFlwYElljMvyYRt9Z+4m0axk75pybL1ciErgb8tyBGuW1Ys1FqfjKn
         Ulxe+3Ies/ucNOxWvChi8CdSunl3EW8VnGJ6/LTcBYbe+/4Kce3WXZQL2/fjxvh280Ai
         uV9A==
X-Gm-Message-State: AGi0Pubpgw68gwOkKF3jSD4u5mobU6gmId4t7ESysNmR8LH7DGFOcAV3
        ccSBs1VCNgOdfODUnw9k5hNqM1Amet4IzKjmZCdnmA==
X-Google-Smtp-Source: APiQypKv2reBsz0zsRnGDK76QZ4WHS1pIYRkKF7BUdppHJAInOIMuK9/LUue0hxUkkq3QrQxmOz7Y/HtoRhuAgd7rtY=
X-Received: by 2002:adf:f1c5:: with SMTP id z5mr504368wro.100.1588280448870;
 Thu, 30 Apr 2020 14:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200430185522.4116-3-james.quinlan@broadcom.com> <20200430203252.GA62266@bjorn-Precision-5520>
In-Reply-To: <20200430203252.GA62266@bjorn-Precision-5520>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 30 Apr 2020 17:00:36 -0400
Message-ID: <CA+-6iNwnMjAYZzYedBqooeJAbot_5A=9C8iFNMc=vdpnzmzVrw@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: brcmstb: enable CRS
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 4:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Apr 30, 2020 at 02:55:20PM -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Configuration Retry Request Status is off by default on this
> > PCIe controller.  Turn it on.
>
> Are you talking about CRS itself, i.e., the ability of a Root Port to
> deal with Completions with Configuration Retry Request Status?  That
> really shouldn't be switchable in the hardware since it's a required
> feature for all PCIe devices.
>
> Or are you talking about CRS Software Visibility, which is controlled
> by a bit in the PCIe Root Control register?  That *should* be managed
> by the PCI core in pci_enable_crs().  Does that generic method of
> controlling it not work for this device?
>
My mistake; the commit will be dropped.

Thanks,
Jim
> It looks like maybe the latter, since the generic:
>
>   #define  PCI_EXP_RTCTL_CRSSVE   0x0010
>
> matches your new PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK.
>
> If pci_enable_crs() doesn't work on this device, it sounds like a
> hardware defect that we need to work around, but I'm not sure that
> just enabling it unconditionally here is the right thing.
>
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 5b0dec5971b8..2bc913c0262c 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -34,6 +34,9 @@
> >  #define BRCM_PCIE_CAP_REGS                           0x00ac
> >
> >  /* Broadcom STB PCIe Register Offsets */
> > +#define PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL                    0x00c8
> > +#define  PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK    0x10
> > +
> >  #define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1                              0x0188
> >  #define  PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK       0xc
> >  #define  PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN                       0x0
> > @@ -827,6 +830,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >                pci_speed_string(pcie_link_speed[cls]), nlw,
> >                ssc_good ? "(SSC)" : "(!SSC)");
> >
> > +     /* Enable configuration request retry (CRS) */
> > +     tmp = readl(base + PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL);
> > +     u32p_replace_bits(&tmp, 1,
> > +                       PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK);
> > +     writel(tmp, base + PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL);
> > +
> >       /* PCIe->SCB endian mode for BAR */
> >       tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
> >       u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
> > --
> > 2.17.1
> >
