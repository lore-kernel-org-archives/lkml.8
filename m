Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6872072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WmNJz59I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgEUVsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgEUVs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:48:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3FCC05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:48:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h17so8129503wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1FrDzsjYEcXgrfssVNqqByxFp+Ac+Iq6mZixETRuPi4=;
        b=WmNJz59ItRug2cC5INbpwDKpcDmMtgi6jVU9u719g067ES93QLe8eqTMGzSES6EhYV
         mdMc2M6PGzOF/Q5wqmdP/+0piv/rNvkgZr7PxPh5g3wVI+f0b7hBEdreqS8AJ+DrIblE
         ofDD7ndpAcgLcQ/PBOeUaeUwNJgP5BaLTIZNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1FrDzsjYEcXgrfssVNqqByxFp+Ac+Iq6mZixETRuPi4=;
        b=uP1V4zbWVwys3B86/AOujb+6Ibk37aqDl0mSnIaPnmez/gp+8PmqMM0q/7a20SV+jl
         uMsKK6MxeYOW8RS/iSAW7VtiwhShN8S3tKoe8UhxeTpHPIy9xbNLEyigcG8opHN04Dg0
         yIimWoJMgpRTp2HS3o6YniIYICh/026u7dAxd50Jl8z9aE57rNGbTGUHehpJ8At4iQYZ
         ifj2etLEzsAcRYY0muQNuxZjoQXM/LYAs0tuN/6K8S9VRuWh/314BAfoWN/FgdNX5eUc
         /zw9609y7uVcUYrC5tVgdrE008kxwWnhbvHxMl3u8oDO5SNngvNsO/ww1fyKTnuSj50Q
         2T4w==
X-Gm-Message-State: AOAM533GjIQdyiMRm+2+PwMH8Ige3sSPQqKDkI47Q3wxwjlhHIQmzoVO
        tU3kfKRoMuBMqzupFru7efxOj6L/LWaN0hr77cTkFQ==
X-Google-Smtp-Source: ABdhPJzO8QjCrwiMc96gkFPxC2xNsu+AaIKQ54rCen8kgp3Tra5gNG8QuZwpex0i5HD/wL/RicupKUhSYd6aPhEXMJ8=
X-Received: by 2002:adf:e688:: with SMTP id r8mr509896wrm.274.1590097708107;
 Thu, 21 May 2020 14:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-8-james.quinlan@broadcom.com> <20200520072747.GB5213@pengutronix.de>
In-Reply-To: <20200520072747.GB5213@pengutronix.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 21 May 2020 17:48:15 -0400
Message-ID: <CA+-6iNxtW66QLrb5BaOOCPJwG-1fShdfZqiLSkKfi6Y669dn5w@mail.gmail.com>
Subject: Re: [PATCH 07/15] PCI: brcmstb: Add control of rescal reset
To:     Philipp Zabel <pza@pengutronix.de>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 3:27 AM Philipp Zabel <pza@pengutronix.de> wrote:
>
> Hi Jim,
>
> On Tue, May 19, 2020 at 04:34:05PM -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Some STB chips have a special purpose reset controller named
> > RESCAL (reset calibration).  This commit adds the control
> > of RESCAL as well as the ability to start and stop its
> > operation for PCIe HW.
> >
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 81 ++++++++++++++++++++++++++-
> >  1 file changed, 80 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 2c470104ba38..0787e8f6f7e5 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> [...]
> > @@ -1100,6 +1164,21 @@ static int brcm_pcie_probe(struct platform_devic=
e *pdev)
> >               dev_err(&pdev->dev, "could not enable clock\n");
> >               return ret;
> >       }
> > +     pcie->rescal =3D devm_reset_control_get_shared(&pdev->dev, "resca=
l");
> > +     if (IS_ERR(pcie->rescal)) {
> > +             if (PTR_ERR(pcie->rescal) =3D=3D -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +             pcie->rescal =3D NULL;
>
> This is effectively an optional reset control, so it is better to use:
> =E2=86=B5
>         pcie->rescal =3D devm_reset_control_get_optional_shared(&pdev->de=
v,
>                                                               "rescal");=
=E2=86=B5
>         if (IS_ERR(pcie->rescal))
>                 return PTR_ERR(pcie->rescal);
>
> > +     } else {
> > +             ret =3D reset_control_deassert(pcie->rescal);
> > +             if (ret)
> > +                     dev_err(&pdev->dev, "failed to deassert 'rescal'\=
n");
> > +     }
>
> reset_control_* can handle rstc =3D=3D NULL parameters for optional reset
> controls, so this can be done unconditionally:
>
>         ret =3D reset_control_deassert(pcie->rescal);=E2=86=B5
>         if (ret)=E2=86=B5
>                 dev_err(&pdev->dev, "failed to deassert 'rescal'\n");=E2=
=86=B5
>
> Is rescal handled by the reset-brcmstb-rescal driver? Since that only
> implements the .reset op, I would expect reset_control_reset() here.
Where exactly?  "reset.h" says that "Calling reset_control_rese()t is
not allowed on a shared reset control." so I'm not sure why  you would
want me to invoke it.
> Otherwise this looks like it'd be missing a reset_control_assert in
> remove.
I can add this.
Thanks,
Jim
>
> regards
> Philipp
