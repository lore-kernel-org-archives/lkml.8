Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3429C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A9824649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNpqJ4H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCIVXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:23:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43874 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:23:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id a6so3223313otb.10;
        Mon, 09 Mar 2020 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60mtLRBTUGDAGEj9S+E+BacY2yBoes/RyfYQD2sha5w=;
        b=uNpqJ4H5j7CHmuE/rB7F61LMk0uUS39z4LbdTUguTFFIO6LT4Z3RjkDmMMeYpdJMd4
         kDETIuUwWnOOHvM3AV5d2iwDizGvqCsKSC1GiZuga5vJmL0JGp2K7bhg+wTuCNKKap4C
         xk+yfeYnfHRnNaXX/tL1LGfMvI+tGcRcgMgI7HVZs7ILHSrs3xg0iYdYtm2Gt5cPDd06
         txhcFOOWUXb0OlRqrmFWPD5zLZ4AUpXfo9A8bJOqb0X7Ny4FeIcjxeYHvLU1b03tJ9ai
         ezMqRXnTjHPToungkje0TMOsYDWl9CE5kVY/utn9sJEA+tB5dajOW3Y605MotvK38q74
         ji2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60mtLRBTUGDAGEj9S+E+BacY2yBoes/RyfYQD2sha5w=;
        b=q/XYsjxJvPMyAZGpt5J5SVMG3E85KSGM/B0b1fHv2KF8WM6Goi1Qr19Qzfdb9A+d1H
         WpQngr+K7cTkHluVLAmNUSsTAt5hPWpNSnqvW6qHXwAh+xRfojqJbMW+d4H7FMi+iBF6
         oaU0yDZw1aqsWeCh7rEgP5HJiSwBqlABgTrnyIDzZKnYs6qIL4zy3e1SosHXQssMOkiR
         0ojoXiIe5dKvzKAv2DmXD1eL+ogH3vgETWXTJOIKE0ws86gxT9F7/OcaMe+11Vz5gZkR
         BXOmxcJ/3n9pp8nAjx9VbPJgykg5M5JIXHLhhQxzWiVermwc6/edlTrFi2TQPyjQ2qJv
         ZYPg==
X-Gm-Message-State: ANhLgQ3zLbUD5zZ10CgYG3AT1otAZZ35EOGHpGPW+6qzbBo39pztPqdV
        Uc+7MY3gMFj28KWS4pMPTQlmdztshxOHwaz5DQ0=
X-Google-Smtp-Source: ADFU+vsnq8F5RsqgkD+u2jIs+ixTXB5m/pE4+STbQz3EG0F3FtB21RUH829nSz2B+EjxGxc4zpuwK5RVKPeHRfqY318=
X-Received: by 2002:a9d:64cd:: with SMTP id n13mr14626799otl.274.1583789030439;
 Mon, 09 Mar 2020 14:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200306152031.14212-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200309203242.GA14486@bogus>
In-Reply-To: <20200309203242.GA14486@bogus>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 9 Mar 2020 21:23:24 +0000
Message-ID: <CA+V-a8uAhrkRPUaQOOAUgeKFnwH7zZOF-raQiYvtc9edUeHJ7g@mail.gmail.com>
Subject: Re: [RESEND PATCH v7] dt-bindings: display: Add idk-2121wr binding
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        dri-devel@lists.freedesktop.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Mar 9, 2020 at 8:32 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri,  6 Mar 2020 15:20:31 +0000, Lad Prabhakar wrote:
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > Add binding for the idk-2121wr LVDS panel from Advantech.
> >
> > Some panel-specific documentation can be found here:
> > https://buy.advantech.eu/Displays/Embedded-LCD-Kits-High-Brightness/model-IDK-2121WR-K2FHA2E.htm
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Apologies for flooding in I missed to add the ML email-ids for the earlier
> > version so resending it.
> >
> > Hi All,
> >
> > This patch is part of series [1] ("Add dual-LVDS panel support to EK874),
> > all the patches have been accepted from it except this one. I have fixed
> > Rob's comments in this version of the patch.
> >
> > [1] https://patchwork.kernel.org/cover/11297589/
> >
> > v6->7
> >  * Added reference to lvds.yaml
> >  * Changed maintainer to myself
> >  * Switched to dual license
> >  * Dropped required properties except for ports as rest are already listed
> >    in lvds.panel
> >  * Dropped Reviewed-by tag of Laurent, due to the changes made it might not
> >    be valid.
> >
> > v5->v6:
> >  * No change
> >
> > v4->v5:
> > * No change
> >
> > v3->v4:
> > * Absorbed patch "dt-bindings: display: Add bindings for LVDS
> >   bus-timings"
> > * Big restructuring after Rob's and Laurent's comments
> >
> > v2->v3:
> > * New patch
> >
> >  .../display/panel/advantech,idk-2121wr.yaml        | 120 +++++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.example.dt.yaml: panel-lvds: 'port' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.example.dt.yaml: panel-lvds: 'port' is a required property
>
This panel is a dual channel LVDS, as a result the root port is called as
ports instead of port and the child node port@0 and port@1 are used for
even and odd pixels, hence binding has required property as ports instead
of port.

Cheers,
--Prabhakar

> See https://patchwork.ozlabs.org/patch/1250384
> Please check and re-submit.
