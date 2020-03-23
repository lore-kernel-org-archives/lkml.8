Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5455EC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218CF2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="AytY9mV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="13xQaVbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgCWIkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:40:52 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49873 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbgCWIkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:40:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id CB3CC5803F3;
        Mon, 23 Mar 2020 04:40:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 23 Mar 2020 04:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fHWUKXGid2zJLklqRrQVAqJyxWO
        RDMns591d25tofu0=; b=AytY9mV4LMIsxZFCbDZA1rPAfWPiUSkl1yJA9yHT1Dg
        U5C+aUFEt02ihAk22pTPK6Fh4tafs9ajDlc1CK+G2FC+2mCT6Z4vEsUAyS9IQY3J
        xK+dL0sMH+E/zP3SIVoaLTDOqbOvsWTZc+nR3Pg2ttHj+49aHMiHtOyVwPeA2vX+
        dyR9ftC7te7emHVAM+iNZgQmopr2XzgAlV6GflYm68dwIu7qfB12W3Z01fO15PrV
        tG7KBgpiqU2S4r/6ibfcusZYyv0VIHHsaTQoWGU+yvBpyVTD50KiL2aJ3ozreXPI
        opTOdNar82f6rA2NtlVIDaDN3eSsSnabPH+fF47z97w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fHWUKX
        Gid2zJLklqRrQVAqJyxWORDMns591d25tofu0=; b=13xQaVbcSm9Niz4m5vzzXm
        dE1Pl+K/uMotiDU9ENoRL6+BFM9fImRCyrqrTerOO1E9oNkQThz7bUtuSYy0SMI4
        ShMTIK5nUHmArDiEgUBDC2eGbML4bvZRbhqSiQadTfxn0rpSFK+m8DnZkA1tRzZa
        JhPgyzpDE5IzuC43V1n0E7VfhWWLQIFk0/NAb/zUHYuC5gke5qLCm46PtXQ+wj4m
        AJiOGMyA6WkPdgrzY8u2SPfZ0zKSWM+sTJBWdtNgVWUYfGgqCEYzJd5C+RP7yhpf
        h7hQgERaHdSDs1Vj3s3lOhTK02++5awDp1/Y73ZHSigcCy5W3Ant/D3D7OpiwExQ
        ==
X-ME-Sender: <xms:DnZ4Xp7cMc482V-wIbnsLigZckbRgSxzztsFBJJdyBVjupHEgSl8NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegjedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrg
    hinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:DnZ4XrzWaf-48WNPSb1IujStB9_zZoiw5q2rWcsoqsM3NT2-1yqRhg>
    <xmx:DnZ4XuBmeSwX5ZaCJALhNaazY51wZCnKu-_vJcEUOkd8zT9LQYUodQ>
    <xmx:DnZ4XkPdQCUogMWWnuQJMdbKWUvk0ya5D6OqVcEw-DStuo0JDp9xOg>
    <xmx:EXZ4Xtj7Mq5CRPJR9l5TUXx2Q7DRAiUWa2VOIHN6_9U4_FhRjw56lA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 83F373280059;
        Mon, 23 Mar 2020 04:40:46 -0400 (EDT)
Date:   Mon, 23 Mar 2020 09:40:44 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 12/12] dt-bindings: arm: bcm: Convert BCM2835 firmware
 binding to YAML
Message-ID: <20200323084044.dziwbk7pugoy73yh@gilmour.lan>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
 <20200204235552.7466-13-f.fainelli@gmail.com>
 <20200206192333.GA30325@bogus>
 <47e12841-d9bb-3204-76c0-5bc0ef74b094@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wwybpixyqgd42xes"
Content-Disposition: inline
In-Reply-To: <47e12841-d9bb-3204-76c0-5bc0ef74b094@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wwybpixyqgd42xes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian,

On Sun, Mar 22, 2020 at 02:35:17PM -0700, Florian Fainelli wrote:
>
>
> On 2/6/2020 11:23 AM, Rob Herring wrote:
> > On Tue, Feb 04, 2020 at 03:55:52PM -0800, Florian Fainelli wrote:
> >> Convert the Raspberry Pi BCM2835 firmware binding document to YAML.
> >> Verified with dt_binding_check and dtbs_check.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  .../arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 --------
> >>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 33 +++++++++++++++++++
> >>  2 files changed, 33 insertions(+), 14 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> >>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> >> deleted file mode 100644
> >> index 6824b3180ffb..000000000000
> >> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> >> +++ /dev/null
> >> @@ -1,14 +0,0 @@
> >> -Raspberry Pi VideoCore firmware driver
> >> -
> >> -Required properties:
> >> -
> >> -- compatible:		Should be "raspberrypi,bcm2835-firmware"
> >> -- mboxes:		Phandle to the firmware device's Mailbox.
> >> -			  (See: ../mailbox/mailbox.txt for more information)
> >> -
> >> -Example:
> >> -
> >> -firmware {
> >> -	compatible = "raspberrypi,bcm2835-firmware";
> >> -	mboxes = <&mailbox>;
> >> -};
> >> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> >> new file mode 100644
> >> index 000000000000..db355d970f2b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> >> @@ -0,0 +1,33 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/arm/bcm/raspberrypi,bcm2835-firmware.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Raspberry Pi VideoCore firmware driver
> >> +
> >> +maintainers:
> >> +  - Eric Anholt <eric@anholt.net>
> >> +  - Stefan Wahren <wahrenst@gmx.net>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: raspberrypi,bcm2835-firmware simple-bus
> >                                           ^
> >
> > I need to check for spaces with the meta-schema...
>
> I believe I had tried to use:
>
> const: raspberrypi,bcm2835-firmware
> const: simple-bus
>
> but this did not work, and I had to resort to doing this.

That would be:

compatible:
  items:
    - const: raspberrypi,bcm2835-firmware
    - const: simple-bus

It changes slightly from what the initial binding was saying though,
since it wasn't mentionning simple-bus at all? Is that on purpose?

Maxime

--wwybpixyqgd42xes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXnh2DAAKCRDj7w1vZxhR
xWPgAQDElnAp04YnCuO+jkIJku1JVizkv38k3ww8QABe4VX0xQD/arimv4bGqD7V
epzB2XkOyomNsyh7Rg3ODKZa7PzqxgM=
=r/Q5
-----END PGP SIGNATURE-----

--wwybpixyqgd42xes--
