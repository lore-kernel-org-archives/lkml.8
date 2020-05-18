Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618A8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DCE207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589799636;
	bh=wyGwJMp6JDvi1pxR/6oXX1BgJr9jWtaMspgSnt4Ppa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g+xO97jK9TiMwg5xrqCPhji9VFEmbFYMig3/5bG+7Mr4lZd53RkFBVUmMwl/U5hfS
	 eLgT/d+7Uq4c50yQv4LOYiyY+lqK44JIlZ0otMQ7wZtWqVlT8su+tGLH3zNMcZKmtq
	 tjwWilFI1hzZljHStP9w5LSptjLjBVnaO/dTanfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgERLAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgERLAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:00:34 -0400
Received: from earth.universe (dyndsl-037-138-186-253.ewe-ip-backbone.de [37.138.186.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8803B20709;
        Mon, 18 May 2020 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589799633;
        bh=wyGwJMp6JDvi1pxR/6oXX1BgJr9jWtaMspgSnt4Ppa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEWVpH2WCVwuzKm3cA49Pj6GlmuHjTAgIsG00SquIYG1ByF0c8wW4Wh0eONK45KfE
         6VllZWVL5SM+EFySBFS/yet6ysdAEZcOO5zxlzSUlAWRl/Z9EZn3aHvXSqVA0qoTit
         o8ji85g/r2LyktcsUdUP0D+blllZ6+goPlWj7FNY=
Received: by earth.universe (Postfix, from userid 1000)
        id 30ED23C08C6; Mon, 18 May 2020 13:00:31 +0200 (CEST)
Date:   Mon, 18 May 2020 13:00:31 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Message-ID: <20200518110031.tthams2r7tkcytie@earth.universe>
References: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cddvtyzylvcawpye"
Content-Disposition: inline
In-Reply-To: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cddvtyzylvcawpye
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 18, 2020 at 07:38:25AM +0000, Vaittinen, Matti wrote:
> Hello All,
>=20
> In short - I consider adding myself in MAINTAINERs for the ROHM IC
> drivers I've authored. I would like to get your opinion as subsystem
> maintainers on the area where these driver belong. If you don't care -
> then no need to read further :) If you do read, then I would appreciate
> hearing about your expectations regarding reviews, ACKs etc.
>=20
> Longer story, I have contributed drivers for ROHM PMICs
> BD71837/BD71847/BD71850, BD70528, BD71828/BD71878 and ROHM charger IC
> BD99954. I did also refactor the linear_ranges code out of the
> regulator framework. Now I am working on with another PMIC driver
> (regulators/watchdog) which I hope to end up in upstream at autumn
> after the proper testing. There is also some pieces in regmap-irq which
> I have added.
>=20
> I would like to participate in reviewing work for patches to these
> drivers (and perhaps the linear_ranges) and possibly set up some test
> jobs where I can run some tests involving some of the PMICs. I hope
> this helps the community too.
>=20
> I would also benefit from being informed when a fix is sent to one of
> these areas as I am anyways paid to be hosting some out-of-tree
> additions to these drivers. So my git tree would benefit from getting
> the odd fixes upstream is getting. Reviewing mails would serve as a
> heads up for me.
>=20
> Thus I consider adding few entries to MAINTAINERs in order to be
> getting the patches for review/test. What I don't consider doing is
> integrating the patches in "official Linux" - Eg. all patches should
> still go upstream via your trees.
>=20
> What kind of participation would you expect/appreciate from me if I
> added myself in MAINTAINERS for these drivers I authored? Any
> objections to that? (I don't really know how MAINTAINERs entries should
> be added - and I didn't [easily] find up-to-date explanation to that).
> For where I can be of help - I believe I am technically competent for
> reviewing C-code. I am not competent for reviewing all styling details
> - and I am not too useful what comes to YAML - this syntax is still
> really alien to me. Yet I think I have some insight to things the DT
> yaml is describing (meaning ROHM HW) :)
>=20
> I add below the list of files / subsystem.
>=20
> Regulator:
> bd70528-regulator.c
> bd71828-regulator.c
> bd718x7-regulator.c
> rohm-regulator.c
> (lib/linear_ranges.c
> lib/test_linear_ranges.c?
> include/linux/linear_range.h - Who should maintain these?)
>=20
> Power-supply:
> bd70528-charger.c
> bd71827-power.c
> bd99954-charger.c
> bd99954-charger.h
>=20
> MFD:
> rohm-bd70528.c
> rohm-bd71828.c
> rohm-bd718x7.c
> include/linux/mfd/rohm-shared.h
> include/linux/mfd/rohm-bd71828.h
> include/linux/mfd/rohm-bd70528.h
> include/linux/mfd/rohm-generic.h
> include/linux/mfd/rohm-bd718x7.h
>=20
> GPIO:
> gpio-bd70528.c
> gpio-bd71828.c
>=20
> RTC:
> rtc-bd70528.c
>=20
> Watchdog:
> bd70528_wdt.c
>=20
> Clk:
> clk-bd718x7.c
>=20
> DT:
> Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
> Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
> Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
> Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
> Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml
> Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
>=20
> Best Regards
> 	Matti Vaittinen

I suggest to just send something like this entry adapted to the ROHM
drivers:

------------------------------------------------------------
TI BQ27XXX POWER SUPPLY DRIVER
R:      Andrew F. Davis <afd@ti.com>
F:      drivers/power/supply/bq27xxx_battery.c
F:      drivers/power/supply/bq27xxx_battery_i2c.c
F:      include/linux/power/bq27xxx_battery.h
------------------------------------------------------------

It will result in get_maintainer.pl to output this:

$ ./scripts/get_maintainer.pl -f drivers/power/supply/bq27xxx_battery.c
"Andrew F. Davis" <afd@ti.com> (reviewer:TI BQ27XXX POWER SUPPLY DRIVER)
"Pali Roh=E1r" <pali@kernel.org> (reviewer:NOKIA N900 POWER SUPPLY DRIVERS)
Sebastian Reichel <sre@kernel.org> (maintainer:POWER SUPPLY CLASS/SUBSYSTEM=
 and DRIVERS)
linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVER=
S)
linux-kernel@vger.kernel.org (open list)

For drivers with a dedicated reviewer I wait some time for their
feedback.

For the DT YAML bindings you don't need to do anything:

https://lore.kernel.org/lkml/e85006456d9dbae55286c67ac5263668a72f5b58.15880=
22228.git.joe@perches.com/

-- Sebastian

--cddvtyzylvcawpye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7CascACgkQ2O7X88g7
+pq1zA//cxJzaXoirmekFTa4rdDkDs9iinYvoN1j3hqvuCO9he6IcSs3w+0vzPSm
Vi9lTdohxM0KsNP01lEmc6PnlU9jEHqiQAFDMJZ3+WsBAD48MmLHk/GuCKRdSuHo
OBH0YEamwveu7YOqS934HjywHd1tYciiwDU/xOCZENNoR8TS53LuuXEya98uhtxJ
juZ7qc5fLs1K/xKxHCR80gUjQhgKR/BOyY+/vpsL00GTRzIA6pkOmziSHo7Alhml
WNIR40TjBmRE4dKPepxHJXd0jL7XN4gSzn5ZJuF7Gx06yhENE/sapleGB0V2plEy
SF4sbkYNRZv+uSjl8Be5MjYmGojCDHCWijmxtguyN2/QR3/XKl1k1rHRq9agGKb9
GYE3WZpJFUsLPV9X4uDxyuskYKFVk6ylJwZJvbkHvK7gkzclgYG+B1SvJQzltkLS
436IejS7NDIAJAGnGrTyKWJMOz0Zt36GulQeviSenknPzMydhWI/p887CutWMCIb
lMTM2A7gNspoWMvNGrO1MvmwHayji4nfgddEwQhIvhAoLz2SBCttnq/roaJyBh3Y
zyDa7bmp9CD0UAWL3j6UWUArsxfyTD/Eg/3Va3UYfkrMXm+3q9DnqEEFRZrA7mrB
gREFOTMvPNsMrlLeEIRp5gll7TX4Vtp6IQ8RndHmJnPXR/KMfuA=
=X4FG
-----END PGP SIGNATURE-----

--cddvtyzylvcawpye--
