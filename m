Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA02C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7731720753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584723217;
	bh=SUbZeebq2OONQq8LMWFOH9NX2Sbm+ozg8Th8tzFckYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fKdVzZpbDt2sCem/NczIt4KmmXjgG7Id6s8p7Z+j2nQNhaOf9xRan4XebLnwlZoaN
	 iJ/fdAUVZ2kQsDc7t8sWZT9LaTfQqSTCUcx2zPNddAUuPGjjq6L7E45X3U9oj+6xnp
	 zEKPR+WAEda6/p1hlelXLKYYVMMtQw8FkQJfVnhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgCTQxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbgCTQxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:53:18 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EBE22076F;
        Fri, 20 Mar 2020 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584723197;
        bh=SUbZeebq2OONQq8LMWFOH9NX2Sbm+ozg8Th8tzFckYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bTH3vd97Pt8kd9zl64OoU6o+cL0J2/cFcPZlPRLd5crl6MsogX1+Q+qRTK1MvnW56
         SjtaeD2M78vXw5bVqKf8PrkOcMh9ZGR8xKkXhTjPbI28erlEKLHmADMmo645RUAeIo
         M57crmxqMKjEYnJMw9my6FHHFbUaa6i+T+vCbrCg=
Received: by mail-qv1-f50.google.com with SMTP id o18so3323642qvf.1;
        Fri, 20 Mar 2020 09:53:17 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3H1uaNjRGw7xXO56ZpbLl/FP3sFCXvWDEAHflBB6SNQBgSz5WA
        Pu63FYXkqjCsq6/gBxE7WJ8UxiRT5Jac9/H/Hw==
X-Google-Smtp-Source: ADFU+vsMjlPOxytEUWukU50ZVC3dzXv3n2NYqa5n45Md60Vhbk7YA2fh97wZC7a46wDxIGTK9RSllaTWR6GMaB3eFaY=
X-Received: by 2002:ad4:4766:: with SMTP id d6mr8592149qvx.136.1584723196260;
 Fri, 20 Mar 2020 09:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200311103252.17514-1-laurent.pinchart@ideasonboard.com>
 <20200311103252.17514-2-laurent.pinchart@ideasonboard.com>
 <20200320023520.GA18490@bogus> <20200320095036.GA5193@pendragon.ideasonboard.com>
In-Reply-To: <20200320095036.GA5193@pendragon.ideasonboard.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Mar 2020 10:53:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYUooc-9i6U6Br9DQKPHZMrLJf3f883PeM4Ctbwycs8w@mail.gmail.com>
Message-ID: <CAL_JsqLYUooc-9i6U6Br9DQKPHZMrLJf3f883PeM4Ctbwycs8w@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 3:50 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> On Thu, Mar 19, 2020 at 08:35:20PM -0600, Rob Herring wrote:
> > On Wed, Mar 11, 2020 at 12:32:50PM +0200, Laurent Pinchart wrote:
> > > From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > >
> > > Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> > > Processing System Gigabit Transceiver which provides PHY capabilities to
> > > USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> > >
> > > Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
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
> > >  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 104 ++++++++++++++++++
> > >  include/dt-bindings/phy/phy.h                 |   1 +
> > >  2 files changed, 105 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > > new file mode 100644
> > > index 000000000000..9948e4a60e45
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > > @@ -0,0 +1,104 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > For new bindings:
> >
> > (GPL-2.0-only OR BSD-2-Clause)
> >
> > Though I guess Anurag needs to agree.
>
> There's an ongoing similar discussion regarding the DPSUB (DRM/KMS)
> bindings. Hyun is checking with the Xilinx legal department. If they
> agree, I'll change the license here, otherwise I'll keep it as-is.

TBC, the choice is change it or take your toys elsewhere and play by
yourself. I don't really want to end up with whatever each submitter
desires. I don't expect there's many companies that object to a
permissive license.

> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/xlnx,zynqmp-psgtr.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Xilinx ZynqMP Gigabit Transceiver PHY Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > +
> > > +description: |
> > > +  This binding describes the Xilinx ZynqMP Gigabit Transceiver (GTR) PHY. The
> > > +  GTR provides four lanes and is used by USB, SATA, PCIE, Display port and
> > > +  Ethernet SGMII controllers.
> > > +
> > > +properties:
> > > +  "#phy-cells":
> > > +    const: 4
> > > +    description: |
> > > +      The cells contain the following arguments.
> > > +
> > > +      - description: The GTR lane
> > > +        minimum: 0
> > > +        maximum: 3
> > > +      - description: The PHY type
> > > +        enum:
> > > +          - PHY_TYPE_DP
> > > +          - PHY_TYPE_PCIE
> > > +          - PHY_TYPE_SATA
> > > +          - PHY_TYPE_SGMII
> > > +          - PHY_TYPE_USB
> > > +      - description: The PHY instance
> > > +        minimum: 0
> > > +        maximum: 1 # for DP, SATA or USB
> > > +        maximum: 3 # for PCIE or SGMII
> > > +      - description: The reference clock number
> > > +        minimum: 0
> > > +        maximum: 3
> >
> > Humm, interesting almost json-schema. I guess it's fine as-is.
> >
> > I would like to figure out how to apply a schema like this to the
> > consumer nodes. We'd have to look up the phandle, get that node's
> > compatible, find the provider's schema, find #.*-cells property, and
> > extract a schema from it. Actually, doesn't sound too hard.
>
> That would be nice :-)
>
> > > +
> > > +  compatible:
> > > +    enum:
> > > +      - xlnx,zynqmp-psgtr-v1.1
> > > +      - xlnx,zynqmp-psgtr
> > > +
> > > +  clocks:
> > > +    minItems: 1
> > > +    maxItems: 4
> > > +    description: |
> > > +      Clock for each PS_MGTREFCLK[0-3] reference clock input. Unconnected
> > > +      inputs shall not have an entry.
> > > +
> > > +  clock-names:
> > > +    minItems: 1
> > > +    maxItems: 4
> > > +    items:
> > > +      pattern: "^ref[0-3]$"
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: SERDES registers block
> > > +      - description: SIOU registers block
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: serdes
> > > +      - const: siou
> > > +
> > > +required:
> > > +  - "#phy-cells"
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +
> > > +if:
> > > +  properties:
> > > +    compatible:
> > > +      const: xlnx,zynqmp-psgtr
> > > +
> > > +then:
> > > +  properties:
> > > +    xlnx,tx-termination-fix:
> > > +      description: |
> > > +        Include this for fixing functional issue with the TX termination
> > > +        resistance in GT, which can be out of spec for the XCZU9EG silicon
> > > +        version.
> > > +      type: boolean
> > > +
> > > +additionalProperties: false
> >
> > This won't work with 'xlnx,tx-termination-fix'. You need to move it to
> > the main properties section and then do:
> >
> > if:
> >   properties:
> >     compatible:
> >       const: xlnx,zynqmp-psgtr-v1.1
>
> It doesn't make a big difference as only two compatible values are
> allowed, but is there a way to express the condition the other way
> around, if (compatible != "xlnx,zynqmp-psgtr") ?

if:
  properties:
    compatible:
      not:
        const: xlnx,zynqmp-psgtr

I think if: { not: ... } would also work. You'll have to test them out.

> > then:
> >   properties:
> >     xlnx,tx-termination-fix: false
>
> This works.
>
> > I think this would also work:
> >
> >   not:
> >     required:
> >       - xlnx,tx-termination-fix
>
> I've tested it and it works, but I'm not sure why, given that the
> property isn't required required in the first place. Could you enlighten
> me ?

'required' is true or false based on presence or absence of properties
in the list. If 'xlnx,tx-termination-fix' is present, then 'required'
evaluates to true. And the inverse is true. Then we take the inverse
of of that with 'not'.

The first case is what trips me up more because a property not present
evaluates to true. So if you look at 'select' schemas, we have to make
any properties we list (compatible typically) required.

Rob
