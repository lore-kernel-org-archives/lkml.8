Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A607C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2225B2465A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCIVrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:47:48 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:47536 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:47:47 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8915A20021;
        Mon,  9 Mar 2020 22:47:40 +0100 (CET)
Date:   Mon, 9 Mar 2020 22:47:39 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
Subject: Re: [RESEND PATCH v7] dt-bindings: display: Add idk-2121wr binding
Message-ID: <20200309214739.GA11495@ravnborg.org>
References: <20200306152031.14212-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200309203242.GA14486@bogus>
 <CA+V-a8uAhrkRPUaQOOAUgeKFnwH7zZOF-raQiYvtc9edUeHJ7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8uAhrkRPUaQOOAUgeKFnwH7zZOF-raQiYvtc9edUeHJ7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
        a=yC-0_ovQAAAA:8 a=NcFk6D9gAAAA:8 a=S6n1fyGeoZp7psgl2-IA:9
        a=CjuIK1q_8ugA:10 a=gDps05xe3HUA:10 a=-FEs8UIgK8oA:10 a=CojVow1nldcA:10
        a=NWVoK91CQyQA:10 a=AjGcO6oz07-iQ99wixmX:22 a=QsnFDINu91a9xkgZirup:22
        a=dT0RXAwTRpxWjiziVLXF:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar

On Mon, Mar 09, 2020 at 09:23:24PM +0000, Lad, Prabhakar wrote:
> Hi Rob,
> 
> On Mon, Mar 9, 2020 at 8:32 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri,  6 Mar 2020 15:20:31 +0000, Lad Prabhakar wrote:
> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >
> > > Add binding for the idk-2121wr LVDS panel from Advantech.
> > >
> > > Some panel-specific documentation can be found here:
> > > https://buy.advantech.eu/Displays/Embedded-LCD-Kits-High-Brightness/model-IDK-2121WR-K2FHA2E.htm
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > Apologies for flooding in I missed to add the ML email-ids for the earlier
> > > version so resending it.
> > >
> > > Hi All,
> > >
> > > This patch is part of series [1] ("Add dual-LVDS panel support to EK874),
> > > all the patches have been accepted from it except this one. I have fixed
> > > Rob's comments in this version of the patch.
> > >
> > > [1] https://patchwork.kernel.org/cover/11297589/
> > >
> > > v6->7
> > >  * Added reference to lvds.yaml
> > >  * Changed maintainer to myself
> > >  * Switched to dual license
> > >  * Dropped required properties except for ports as rest are already listed
> > >    in lvds.panel
> > >  * Dropped Reviewed-by tag of Laurent, due to the changes made it might not
> > >    be valid.
> > >
> > > v5->v6:
> > >  * No change
> > >
> > > v4->v5:
> > > * No change
> > >
> > > v3->v4:
> > > * Absorbed patch "dt-bindings: display: Add bindings for LVDS
> > >   bus-timings"
> > > * Big restructuring after Rob's and Laurent's comments
> > >
> > > v2->v3:
> > > * New patch
> > >
> > >  .../display/panel/advantech,idk-2121wr.yaml        | 120 +++++++++++++++++++++
> > >  1 file changed, 120 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.example.dt.yaml: panel-lvds: 'port' is a required property
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.example.dt.yaml: panel-lvds: 'port' is a required property
> >
> This panel is a dual channel LVDS, as a result the root port is called as
> ports instead of port and the child node port@0 and port@1 are used for
> even and odd pixels, hence binding has required property as ports instead
> of port.

What goes wrong is that you have a ref to lvds.yaml - and thus you get
also required from that file.

So basically - I think this binding should not have a ref to lvds.yaml -
as the binding needs to be different.

	Sam
