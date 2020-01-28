Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F13C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE29524685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580226031;
	bh=vIQFlgFBXBFq03FtrTUcYLipjkKDm0tJv3h8aZx/qh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2YGDbHuG+4C2h5nxLDHmL4hhYRmNi/XYjMYEyJ+JtzWYzfxmQAPfGkgZ5oDCZY+DB
	 b8dQgSdPmKoPoaPGMZLwaL3pDCF+vOiDPJ6lCTv5MGmInLVmJFQXGZVRTdWAY0keg/
	 1Sxt3r6rNZAbmtbxyQg4weqIFvW6vBU/UCUDK6bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgA1Pka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgA1Pka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:40:30 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380E02468A;
        Tue, 28 Jan 2020 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580226029;
        bh=vIQFlgFBXBFq03FtrTUcYLipjkKDm0tJv3h8aZx/qh4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VE88acMmglXD5DNpUqw6gBfh7OAT6VN26cGhD6BTnko4ya3ck8v2LEaIo7jwAjPi7
         M0n15l6uLrj64WmJsAFgx4SWdbbxYXQprIBUfKNhMxtLIQFXkYHpoSNzFg4GGdWD+l
         ZAEH5QVvdcQw/WhBWVlXPf00pVqLGBMdrTGw8mPM=
Received: by mail-qk1-f173.google.com with SMTP id d10so13779871qke.1;
        Tue, 28 Jan 2020 07:40:29 -0800 (PST)
X-Gm-Message-State: APjAAAUa02KlhuFWtcwXDjdrmsOG7EloisJUN2ABH+fscVXRmF1unmh/
        ZT5w6yn7XbnnAJX0SrNm9EpECg85Tx6Kdm3tng==
X-Google-Smtp-Source: APXvYqwwiFahkoxmuc163fTarevKuM1kql9XD48hlQ7trUe56xmd3XOmWMviv3V7Mu7y1iKxkwylIC3mc3ktXc5v1t4=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr23193589qkg.152.1580226028149;
 Tue, 28 Jan 2020 07:40:28 -0800 (PST)
MIME-Version: 1.0
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
 <1579689918-7181-14-git-send-email-yamonkar@cadence.com> <20200127164235.GA7662@bogus>
 <3e5d7620-d1ec-ba37-0b5b-e28ed74e49d9@ti.com>
In-Reply-To: <3e5d7620-d1ec-ba37-0b5b-e28ed74e49d9@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Jan 2020 09:40:16 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+UrxAL9DEB3E-o0fWEK3QNhWiYQnGDZ3asRoQLb61Cjg@mail.gmail.com>
Message-ID: <CAL_Jsq+UrxAL9DEB3E-o0fWEK3QNhWiYQnGDZ3asRoQLb61Cjg@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] dt-bindings: phy: phy-cadence-torrent: Add
 subnode bindings.
To:     Jyri Sarha <jsarha@ti.com>
Cc:     Yuti Amonkar <yamonkar@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 4:04 AM Jyri Sarha <jsarha@ti.com> wrote:
>
> On 27/01/2020 18:42, Rob Herring wrote:
> > On Wed, Jan 22, 2020 at 11:45:17AM +0100, Yuti Amonkar wrote:
> >> From: Swapnil Jakhade <sjakhade@cadence.com>
> >>
> >> Add sub-node bindings for each group of PHY lanes based on PHY
> >> type. Only PHY_TYPE_DP is supported currently. Each sub-node
> >
> > What the driver supports is not relevant to the binding. Define all
> > modes.
> >
> >> includes properties such as master lane number, link reset, phy
> >> type, number of lanes etc.
> >
> > Given the conversion and this have no compatibility, just make the
> > commits delete the old binding and add this new binding. I'd rather not
> > have reviewed what just gets deleted here.
> >
> >>
> >> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> >> ---
> >>  .../bindings/phy/phy-cadence-torrent.yaml          | 90 ++++++++++++++++++----
> >>  1 file changed, 73 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> >> index dbb8aa5..eb21615 100644
> >> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> >> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> >> @@ -19,6 +19,12 @@ properties:
> >>        - cdns,torrent-phy
> >>        - ti,j721e-serdes-10g
> >>
> >> +  '#address-cells':
> >> +    const: 1
> >> +
> >> +  '#size-cells':
> >> +    const: 0
> >> +
> >>    clocks:
> >>      maxItems: 1
> >>      description:
> >> @@ -41,44 +47,94 @@ properties:
> >>        - const: torrent_phy
> >>        - const: dptx_phy
> >>
> >> -  "#phy-cells":
> >> -    const: 0
> >> +  resets:
> >> +    description:
> >> +      Must contain an entry for each in reset-names.
> >> +      See Documentation/devicetree/bindings/reset/reset.txt
> >
> > How many reset entries? Needs a 'maxItems: 1' or an 'items' list if more
> > than 1.
> >
> >>
> >> -  num_lanes:
> >> +  reset-names:
> >>      description:
> >> -      Number of DisplayPort lanes.
> >> -    allOf:
> >> -      - $ref: /schemas/types.yaml#/definitions/uint32
> >> -      - enum: [1, 2, 4]
> >> +      Must be "torrent_reset". It controls the reset to the
> >
> > Should be a schema, not freeform text. However, not really a useful name
> > as there's only 1, so I'd just remove 'reset-names'.
> >
>
> This binding is trying to follow "cdns,sierra-phy-t0" binding [1] when
> it makes sense. Sierra defines two resets here. But if we can not name
> the other reset now (at least I can not), I guess we can just drop the
> reset-names here.
>
> >> +      torrent PHY.
> >>
> >> -  max_bit_rate:
> >> +patternProperties:
> >> +  '^torrent-phy@[0-7]+$':
> >> +    type: object
> >>      description:
> >> -      Maximum DisplayPort link bit rate to use, in Mbps
> >> -    allOf:
> >> -      - $ref: /schemas/types.yaml#/definitions/uint32
> >> -      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
> >> +      Each group of PHY lanes with a single master lane should be represented as a sub-node.
> >> +    properties:
> >> +      reg:
> >> +        description:
> >> +          The master lane number. This is the lowest numbered lane in the lane group.
> >
> > Why not make it the list of lane numbers. Then you don't need num-lanes.
> >
>
> Sierra binding already defines this method [1] and my plan was to rely
> on this method when selecting the lane types in the
> "ti,phy-j721e-wiz"-driver [2].
>
> IOW, I would like the both Sierra and Torrent bindings (which both are
> wrapped by the wiz wrapper IP) to be compatible enough for wiz driver to
> peek the lane types from the wrapped phy-node.

Okay.

> >> +      resets:
> >> +        description:
> >> +          Contains list of resets to get all the link lanes out of reset.
> >
> > Needs a schema for how many? 1 per lane?
> >
>
> That is what the current implementation is, but do we have to lock it
> down in the binding? There can hardly be more than 1 / lane, but I can
> imagine it to be just one for a number of lanes.

Yes, you have to define it in the schema. If not, there's really no
point in doing schemas.

> >> +      "#phy-cells":
> >> +        description:
> >> +          Generic PHY binding.
> >
> > Not a useful description. Remove.
> >
> >> +        const: 0
> >> +
> >> +      cdns,phy-type:
> >> +        description:
> >> +          Should be PHY_TYPE_DP.
> >
> > Sounds like a constraint.
> >
>
> I do not think there is point to limit this to PHY_TYPE_DP only. The
> current implementation may not support anything else but DP, but we
> should not limit the binding because of it. I think referring to the
> include/dt-bindings/phy/phy.h header here would be appropriate.

Referring to the include is still not a constraint. You need const,
enum, or minimum/maximum.

Rob
