Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5D4C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EC724649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgajOmyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCIW2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:28:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33372 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCIW2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:28:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id q81so11904597oig.0;
        Mon, 09 Mar 2020 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Es47KjDK/hWadKH/v9xPd4F0lLQoQ3sr2417oAXr/tU=;
        b=MgajOmyyAtv7UmYDoPC0jd1MOj3beqW7IbyfooxKtCGGP3FkaOcT2Ovhp0Fi0/ojnT
         lGtY+8OxAz7maq86dfZDNNzRH9zLr7c1L3xiV6VYC97WdiUxW1TP2dYeItkRafKMHVXc
         n4q0/+/KaHKttvMb0Cr+khailijU+LBjcH8/Vivy13zJPV3Wa8G+jvqT80sJa9oQgNgG
         CniC59RMHaz2xDrqGnkuzFC9AKBTpVLQQ9ebjsdEplXRiA3Q9wolMM5zR0QlBIlUT4Ku
         cM/WzAeCeVWfhM8SpVls+fcztK01Ozegzsm/2RW5UGJPzRnmMTWLZUDRJhJ2GV0spdY+
         YtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Es47KjDK/hWadKH/v9xPd4F0lLQoQ3sr2417oAXr/tU=;
        b=MtUwD4n5KjjWB8W2G2zMf38qv11+CF22hxwezwq9lXIX4Z5Z4SLrwNhZVUkxTL7kS2
         oxpxmwpof/RlJpkmwbIOpWpY/eLYfnHPCpwWlTtahr/NAbfahjxBcdXZ5Q5mq0XuWYd0
         1JftOIWkNxhKolY64onwf2hpc6Q56jPREJn1gqpW8LTgZyw9BLF8hgA3xY+S7FUI6qgm
         9G5XBNEsp0C7soBoiJzHHpdatXtBH2oxT6zhHjBLhXplVXzyVGTBTgFQZ6p16CwnnMr8
         fAviQkfIAZCArPcNJuFlgoyobOgitVXuCQ62ul2GNpW/SaCq5wavUUrs1AnKU4bI0/uC
         28lw==
X-Gm-Message-State: ANhLgQ1K/WrUIIxvmwuUzOIPS3NOoMRrSMCFjYpBiPXN3GqQf0etMOy9
        f4GX+HLipCXMP+YRKSW53ZyyC1ktZlOhT5yhgk4=
X-Google-Smtp-Source: ADFU+vtU5GX2EEb6Reuz4YRODMRzYC78NkJFKaejN4jv+zCbJpOs9anR6SY8vnKCcYwgMaaXCVp7rl1Kf+AESBzJ0FQ=
X-Received: by 2002:aca:ac89:: with SMTP id v131mr1044761oie.7.1583792932582;
 Mon, 09 Mar 2020 15:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200306152031.14212-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200309203242.GA14486@bogus> <CA+V-a8uAhrkRPUaQOOAUgeKFnwH7zZOF-raQiYvtc9edUeHJ7g@mail.gmail.com>
 <20200309214739.GA11495@ravnborg.org>
In-Reply-To: <20200309214739.GA11495@ravnborg.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 9 Mar 2020 22:28:26 +0000
Message-ID: <CA+V-a8uRD2Vi05rPw2fw6SQO66EHWG=Z+ZAL23xR_9QSVz7WBw@mail.gmail.com>
Subject: Re: [RESEND PATCH v7] dt-bindings: display: Add idk-2121wr binding
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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

Hi Sam,

On Mon, Mar 9, 2020 at 9:47 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Prabhakar
>
> On Mon, Mar 09, 2020 at 09:23:24PM +0000, Lad, Prabhakar wrote:
> > Hi Rob,
> >
> > On Mon, Mar 9, 2020 at 8:32 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri,  6 Mar 2020 15:20:31 +0000, Lad Prabhakar wrote:
> > > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > >
> > > > Add binding for the idk-2121wr LVDS panel from Advantech.
> > > >
> > > > Some panel-specific documentation can be found here:
> > > > https://buy.advantech.eu/Displays/Embedded-LCD-Kits-High-Brightness/model-IDK-2121WR-K2FHA2E.htm
> > > >
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > Apologies for flooding in I missed to add the ML email-ids for the earlier
> > > > version so resending it.
> > > >
> > > > Hi All,
> > > >
> > > > This patch is part of series [1] ("Add dual-LVDS panel support to EK874),
> > > > all the patches have been accepted from it except this one. I have fixed
> > > > Rob's comments in this version of the patch.
> > > >
> > > > [1] https://patchwork.kernel.org/cover/11297589/
> > > >
> > > > v6->7
> > > >  * Added reference to lvds.yaml
> > > >  * Changed maintainer to myself
> > > >  * Switched to dual license
> > > >  * Dropped required properties except for ports as rest are already listed
> > > >    in lvds.panel
> > > >  * Dropped Reviewed-by tag of Laurent, due to the changes made it might not
> > > >    be valid.
> > > >
> > > > v5->v6:
> > > >  * No change
> > > >
> > > > v4->v5:
> > > > * No change
> > > >
> > > > v3->v4:
> > > > * Absorbed patch "dt-bindings: display: Add bindings for LVDS
> > > >   bus-timings"
> > > > * Big restructuring after Rob's and Laurent's comments
> > > >
> > > > v2->v3:
> > > > * New patch
> > > >
> > > >  .../display/panel/advantech,idk-2121wr.yaml        | 120 +++++++++++++++++++++
> > > >  1 file changed, 120 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
> > > >
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.example.dt.yaml: panel-lvds: 'port' is a required property
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.example.dt.yaml: panel-lvds: 'port' is a required property
> > >
> > This panel is a dual channel LVDS, as a result the root port is called as
> > ports instead of port and the child node port@0 and port@1 are used for
> > even and odd pixels, hence binding has required property as ports instead
> > of port.
>
> What goes wrong is that you have a ref to lvds.yaml - and thus you get
> also required from that file.
>
Agreed.

> So basically - I think this binding should not have a ref to lvds.yaml -
> as the binding needs to be different.
>
Yes makes sense, will post a v8 dropping the reference to lvds.yaml

Cheers,
--Prabhakar

>         Sam
