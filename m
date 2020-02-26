Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B27C4BA20
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785E724656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="c7+W49bu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYHFGe+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBZSZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:25:41 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48297 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgBZSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:25:41 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A03BA5DE4;
        Wed, 26 Feb 2020 13:25:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 26 Feb 2020 13:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=bgkHWQTmHEiViwvr869uqRi6nVM
        rcwasF+PgK3ShVG4=; b=c7+W49bus2wIQgGp34JAJIonDWp7s4fejaT21E6cE2U
        rblPKtjCnfsKPTwzUMXX/HisuSXeWLAWhpdKT1l1BdiPzF8f6nvhq1SFnrUnE3mf
        RKalhrtRmtWMfT2yQRE36oIHlzf7GiAaY3cgCdL53917J1w9bIjPuBwtr14XTkr6
        M7UdikY8wjbYUN5lRAj+xcNNJEd0ng1VzNYDr8/BQqCZ7ANLrHO7r1fO/I+E7KOe
        QlGT+Tokw2JI21e6/TYt+DSxDFOxLmPF/GjMYVib63BBNI4wR2w5d1iLc4bLWBVZ
        xkR9FAI7gGeSIkZuDaZXRojuN2yalGz895Lb4O9Iivg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bgkHWQ
        TmHEiViwvr869uqRi6nVMrcwasF+PgK3ShVG4=; b=OYHFGe+8SGnpweNTbI2IpL
        FX5hgcYHi+iDJW1ktg8Y3wC2k+UZ0/NgQQxIWKt3y3SpilehRHAcVH64J4+h+aiU
        uw6OuQfn93vMTS60tGQBERITm+rL4TyhSx64sac0AhrjWUn/GCFhXKiUDUmQuuuk
        9bq3/DSGWnBbNhksU0IBj1LcySxJTkbJYqLC9RfzRpQxBqwm2ebsgyZbV1qoLvGW
        HNGEuF+PR8BC9WdTqZzHp1pJ/CSI7yuZJnAoRpyGTclRLpxicOHezLxggP0CnSY8
        boQnTxPQNMVCbuXybO3MJSGBt3TDTzwHuqKuArgeleMu4xpixBawCOVTdjQcJVNQ
        ==
X-ME-Sender: <xms:IbhWXlBstt-bP_Nt4XrNRmjDX6tgf5SlPf_kSrfdScT_PNhjO2QTXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeeltddr
    keelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IbhWXqf_TlmSNf4SDHddw9Ci3NQy_br5uurW3Dj6WiibjLXvdRzJkw>
    <xmx:IbhWXnCPBwzMKUa8q8P8ko9euyui-Oqc6NU0u3HImzjdFEQEV-7ajw>
    <xmx:IbhWXuS7yYZGea6tqrSAbdLwINrTguJ8fdwfUxDCCrGNUGl2hSLaJg>
    <xmx:I7hWXuBhG7AHoaSXyrHIe106JrUPuLxnzTnxsZv2q1fDDzHiyXumUQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB150328005D;
        Wed, 26 Feb 2020 13:25:36 -0500 (EST)
Date:   Wed, 26 Feb 2020 19:25:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Richter <rric@kernel.org>,
        soc@kernel.org, Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 06/13] dt-bindings: sata: Convert Calxeda SATA controller
 to json-schema
Message-ID: <20200226182534.rjdzoam4zdyduvos@gilmour.lan>
References: <20200226180901.89940-1-andre.przywara@arm.com>
 <20200226180901.89940-7-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="avyufeofezvwvp7g"
Content-Disposition: inline
In-Reply-To: <20200226180901.89940-7-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--avyufeofezvwvp7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 06:08:54PM +0000, Andre Przywara wrote:
> Convert the Calxeda Highbank SATA controller binding to DT schema format
> using json-schema.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  .../devicetree/bindings/ata/sata_highbank.txt | 44 ---------
>  .../bindings/ata/sata_highbank.yaml           | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.yaml
>
> diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.txt b/Documentation/devicetree/bindings/ata/sata_highbank.txt
> deleted file mode 100644
> index aa83407cb7a4..000000000000
> --- a/Documentation/devicetree/bindings/ata/sata_highbank.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -* Calxeda AHCI SATA Controller
> -
> -SATA nodes are defined to describe on-chip Serial ATA controllers.
> -The Calxeda SATA controller mostly conforms to the AHCI interface
> -with some special extensions to add functionality.
> -Each SATA controller should have its own node.
> -
> -Required properties:
> -- compatible        : compatible list, contains "calxeda,hb-ahci"
> -- interrupts        : <interrupt mapping for SATA IRQ>
> -- reg               : <registers mapping>
> -
> -Optional properties:
> -- dma-coherent      : Present if dma operations are coherent
> -- calxeda,port-phys : phandle-combophy and lane assignment, which maps each
> -			SATA port to a combophy and a lane within that
> -			combophy
> -- calxeda,sgpio-gpio: phandle-gpio bank, bit offset, and default on or off,
> -			which indicates that the driver supports SGPIO
> -			indicator lights using the indicated GPIOs
> -- calxeda,led-order : a u32 array that map port numbers to offsets within the
> -			SGPIO bitstream.
> -- calxeda,tx-atten  : a u32 array that contains TX attenuation override
> -			codes, one per port. The upper 3 bytes are always
> -			0 and thus ignored.
> -- calxeda,pre-clocks : a u32 that indicates the number of additional clock
> -			cycles to transmit before sending an SGPIO pattern
> -- calxeda,post-clocks: a u32 that indicates the number of additional clock
> -			cycles to transmit after sending an SGPIO pattern
> -
> -Example:
> -        sata@ffe08000 {
> -		compatible = "calxeda,hb-ahci";
> -		reg = <0xffe08000 0x1000>;
> -		interrupts = <115>;
> -		dma-coherent;
> -		calxeda,port-phys = <&combophy5 0 &combophy0 0 &combophy0 1
> -					&combophy0 2 &combophy0 3>;
> -		calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
> -		calxeda,led-order = <4 0 1 2 3>;
> -		calxeda,tx-atten = <0xff 22 0xff 0xff 23>;
> -		calxeda,pre-clocks = <10>;
> -		calxeda,post-clocks = <0>;
> -        };
> diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.yaml b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
> new file mode 100644
> index 000000000000..392a3efc9833
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/sata_highbank.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Calxeda AHCI SATA Controller
> +
> +description: |
> +  The Calxeda SATA controller mostly conforms to the AHCI interface
> +  with some special extensions to add functionality, to map GPIOs for
> +  activity LEDs and for mapping the ComboPHYs.
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +properties:
> +  compatible:
> +    const: calxeda,hb-ahci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +  calxeda,pre-clocks:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Indicates the number of additional clock cycles to transmit before
> +      sending an SGPIO pattern.
> +
> +  calxeda,post-clocks:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Indicates the number of additional clock cycles to transmit after
> +      sending an SGPIO pattern.
> +
> +  calxeda,led-order:
> +    description: Maps port numbers to offsets within the SGPIO bitstream.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 8
> +
> +  calxeda,port-phys:
> +    description: |
> +      phandle-combophy and lane assignment, which maps each SATA port to a
> +      combophy and a lane within that combophy
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - minItems: 1
> +        maxItems: 8
> +
> +  calxeda,tx-atten:
> +    description: |
> +      Contains TX attenuation override codes, one per port.
> +      The upper 24 bits of each entry are always 0 and thus ignored.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 8
> +
> +  calxeda,sgpio-gpio:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      phandle-gpio bank, bit offset, and default on or off, which indicates
> +      that the driver supports SGPIO indicator lights using the indicated
> +      GPIOs.

Ditto, this is being checked already:
https://github.com/devicetree-org/dt-schema/blob/master/schemas/gpio/gpio.yaml#L37

--avyufeofezvwvp7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXla4HgAKCRDj7w1vZxhR
xXwXAP9E9Nhzi9/iGC+DcEi2dO3dN9AdHfN5WZ299wBfbz7logD9FWasp+ZIwAPI
gZzzMwdkwUcsGs8WM6shA0zZiW2XNg0=
=oHQS
-----END PGP SIGNATURE-----

--avyufeofezvwvp7g--
