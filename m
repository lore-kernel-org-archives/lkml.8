Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DA9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A9720829
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHQIIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:08:02 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52071 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgHQIIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:08:02 -0400
X-Originating-IP: 93.34.118.233
Received: from uno.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BB259FF80B;
        Mon, 17 Aug 2020 08:07:55 +0000 (UTC)
Date:   Mon, 17 Aug 2020 10:11:38 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: media: ov772x: Document endpoint
 properties
Message-ID: <20200817081138.dog5lhpmszbu2mgc@uno.localdomain>
References: <1596454753-13612-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1596454753-13612-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8sjxL-rbYAti8Djj2ch2+Zf+88_wNjbZHzKVBB66aZJ0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+V-a8sjxL-rbYAti8Djj2ch2+Zf+88_wNjbZHzKVBB66aZJ0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prabhakar,

On Sat, Aug 15, 2020 at 11:34:33AM +0100, Lad, Prabhakar wrote:
> Hi Jacopo,
>
> On Mon, Aug 3, 2020 at 12:39 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Document endpoint properties required for parallel interface
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/media/i2c/ov772x.txt     | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> I see you already have a patch for YAML conversion for OV772x binding
> [1], if you plan to post a v2 would you be OK to pick these changes as
> part of your conversion changes ?

Sure thing, I'll add the following properties to the series!

Thanks
  j

>
> [1] https://www.spinics.net/lists/linux-media/msg173201.html
>
> Cheers,
> Prabhakar
>
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ov772x.txt b/Documentation/devicetree/bindings/media/i2c/ov772x.txt
> > index 0b3ede5b8e6a..1f4153484717 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/ov772x.txt
> > +++ b/Documentation/devicetree/bindings/media/i2c/ov772x.txt
> > @@ -21,6 +21,22 @@ subnode for its digital output video port, in accordance with the video
> >  interface bindings defined in Documentation/devicetree/bindings/media/
> >  video-interfaces.txt.
> >
> > +Endpoint node required properties for parallel connection are:
> > +- remote-endpoint: a phandle to the bus receiver's endpoint node.
> > +- bus-width: shall be set to <8> for 8 bits parallel bus
> > +            or <10> for 10 bits parallel bus
> > +- data-shift: shall be set to <2> for 8 bits parallel bus
> > +             (lines 9:2 are used) or <0> for 10 bits parallel bus
> > +- hsync-active: active state of the HSYNC signal, 0/1 for LOW/HIGH respectively.
> > +               (Not required for bus-type equal 6)
> > +- vsync-active: active state of the VSYNC signal, 0/1 for LOW/HIGH respectively.
> > +               (Not required for bus-type equal 6)
> > +- pclk-sample: sample data on rising (1) or falling (0) edge of the pixel clock
> > +              signal. (Not required for bus-type equal 6)
> > +- bus-type: data bus type. Possible values are:
> > +           5 - Parallel
> > +           6 - Bt.656
> > +
> >  Example:
> >
> >  &i2c0 {
> > --
> > 2.17.1
> >
