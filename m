Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:11926 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgCKMoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:44:03 -0400
Subject: Re: [RFC v2 6/8] MIPS: DTS: jz4780: account for Synopsys HDMI driver and LCD controller
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=iso-8859-1
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1583177253.3.5@crapouillou.net>
Date: Wed, 11 Mar 2020 13:43:46 +0100
Cc: Paul Boddie <paul@boddie.org.uk>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        MIPS Creator CI20 Development
        <mips-creator-ci20-dev@googlegroups.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F29E9DCC-29BC-4B88-9288-3E53BF8423C6@goldelico.com>
References: <cover.1582913973.git.hns@goldelico.com> <04b485165f38744816a0446e95150cafdeb716ee.1582913973.git.hns@goldelico.com> <1583177253.3.5@crapouillou.net>
To: Paul Cercueil <paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311124346.OGN5sCJvrFzOQP3U-w4J4icRPVKNdFWuI6hC373PX68@z>

Hi Paul,

> Am 02.03.2020 um 20:27 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
>=20
> Le ven., f=E9vr. 28, 2020 at 19:19, H. Nikolaus Schaller =
<hns@goldelico.com> a =E9crit :
>> From: Paul Boddie <paul@boddie.org.uk>
>> A specialisation of the generic Synopsys HDMI driver is employed for =
JZ4780
>> HDMI support. This requires a new driver, plus device tree and =
configuration
>> modifications.
>> Signed-off-by: Paul Boddie <paul@boddie.org.uk>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/mips/boot/dts/ingenic/jz4780.dtsi | 32 =
++++++++++++++++++++++++++
>> 1 file changed, 32 insertions(+)
>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi =
b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> index f928329b034b..391d4e1efd35 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> @@ -433,4 +433,36 @@
>> 		status =3D "disabled";
>> 	};
>> +
>> +	hdmi: hdmi@10180000 {
>> +		compatible =3D "ingenic,jz4780-dw-hdmi";
>> +		reg =3D <0x10180000 0x8000>;
>> +		reg-io-width =3D <4>;
>> +
>> +		clocks =3D <&cgu JZ4780_CLK_HDMI>, <&cgu =
JZ4780_CLK_AHB0>;
>> +		clock-names =3D "isfr" , "iahb";
>> +
>> +		assigned-clocks =3D <&cgu JZ4780_CLK_HDMI>;
>> +		assigned-clock-rates =3D <27000000>;
>=20
> I *think* this should go to the board file.
>=20
>> +
>> +		interrupt-parent =3D <&intc>;
>> +		interrupts =3D <3>;
>> +
>> +		/* ddc-i2c-bus =3D <&i2c4>; */
>> +
>> +		status =3D "disabled";
>> +	};
>> +
>> +	lcd: lcd@13050000 {
>=20
> The node name should be 'lcd-controller'.
>=20
>> +		compatible =3D "ingenic,jz4740-lcd";
>=20
> The JZ4780's LCD controller is much newer than the JZ4740 one, so even =
if it works with the "ingenic,jz4740-lcd" compatible string, you want it =
as a fallback.
> So this should be: compatible =3D "ingenic,jz4780-lcd", =
"ingenic,jz4740-lcd".
>=20
> That means the YAML should be updated too.

I have started to look into jz4780 HDMI setup again.

Well, there is no driver compatible to "ingenic,jz4780-lcd" so far
and it is questionalbe if we need a different one.

I think we should rather make the driver also compatible
than adding a fallback to ingenic,jz4740-lcdto the DTS.

The reason why this is better even if both LCDC are almost
compatible is that the jz4780 allows for much bigger displays
and therefore should have its own jz_soc_info with 4k x 2k
as maximum.

Next I tried to find out if the LCDC are really compatible.

Well the jz4780 has two lcdc instances but they are separated
by the reg addr. Next, there are unique features (like picture in
picture with alpha blending) but those are probably disabled
if not programmed from reset state. This may become a reason
to separate or augment the driver for the jz4780 but at the
moment we can ignore that.

There are also subtly different bit definitions and register
widths (e.g. 24 bit in addition to 16/18 bit modes or more bits
for the sync position) but it looks as if the ingenic_drm
driver already handles this.

Then I tried to read back the registers. Strangely they
are all 0x00000000. So there is no programming of the
lcd-controller in our DT setup with HDMI at all!

I also checked that ingenic_drm_probe() is called and
returns successfully 0. It also reports that a /dev/fb
has been created:

[    7.908830] ingenic-drm 13050000.lcd-controller: fb0: ingenic-drmdrmf =
frame buffer device

But for example ingenic_drm_encoder_atomic_mode_set() is
never called which should write some registers of the LCDC.

I only did see some calls to ingenic_drm_encoder_atomic_check().

This of course explains why we have no HDMI signals despite
proper HPD and a /dev/fb0. Because the LCDC is not being
programmed.

Any ideas / hints how to check or improve?

BR and thanks,
Nikolaus

