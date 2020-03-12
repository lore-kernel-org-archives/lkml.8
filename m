Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD965C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895A120637
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584054890;
	bh=9wDFf+oPT1U99O9sM6O9KnkAPcMBEuhgp2SaIbrm4eE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=VXilqOY/pHjyW9Pq0G7mzTGSlLFpq55+J4QwSyN2rx1d6WyVdisaKrRUfQjVQeN0i
	 nY/B0M3ibwWaSgZI61KomWTyuJjYfQhoCdGEu97BV7vWWrUyeDtp4Ug5uJbsfeuZd/
	 BsWnUyKw8i5DOkMhEdEbxO6XIsyrFUtpO0FifD+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCLXOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgCLXOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:14:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6984B20637;
        Thu, 12 Mar 2020 23:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584054888;
        bh=9wDFf+oPT1U99O9sM6O9KnkAPcMBEuhgp2SaIbrm4eE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eBjMpPYNRMtMMOO+Je+Uv9X+IIIE/u9hx+i+qeMpUqYR0USWNjiHUCPdOnXJmifhY
         8CEgsN6jvV0Xl1MU+3wXgqt6Nh6+OKLhkwAiSoR9Zx7XJ6fycaasZgA5tueX31XFWb
         kPu34sZ/q/rBoiU42hawDEleNmQOjM4HUqz/sdWU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200225181654.GA694@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <9166f3acdc2a64e3f3ca1cd2e283005ee2df37c9.1582533919.git-series.maxime@cerno.tech> <20200225181654.GA694@bogus>
Subject: Re: [PATCH 06/89] dt-bindings: clock: Add a binding for the RPi Firmware clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
To:     Maxime Ripard <maxime@cerno.tech>, Rob Herring <robh@kernel.org>
Date:   Thu, 12 Mar 2020 16:14:47 -0700
Message-ID: <158405488765.149997.7323586314054590516@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2020-02-25 10:16:54)
> On Mon, Feb 24, 2020 at 10:06:08AM +0100, Maxime Ripard wrote:
> > The firmare running on the RPi VideoCore can be used to discover and
> > change the various clocks running in the BCM2711. Since devices will
> > need to use them through the DT, let's add a pretty simple binding.
> >=20
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.ya=
ml | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi=
,firmware-clocks.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,firmwa=
re-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,firmwa=
re-clocks.yaml
> > new file mode 100644
> > index 000000000000..d37bc311321d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/raspberrypi,firmware-cloc=
ks.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/raspberrypi,firmware-clocks.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RaspberryPi Firmware Clocks Device Tree Bindings
> > +
> > +maintainers:
> > +  - Maxime Ripard <mripard@kernel.org>
> > +
> > +properties:
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  compatible:
> > +    const: raspberrypi,firmware-clocks
> > +
> > +  raspberrypi,firmware:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: >
> > +      Phandle to the mailbox node to communicate with the firmware.
>=20
> Can't this be a child node of the phandle instead? Or just add=20
> '#clock-cells' to the firmware node.

Yeah, just add the clock-cells to the firmware node unless that doesn't
work for some reason?
