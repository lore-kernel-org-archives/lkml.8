Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A488EC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733B720760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSloKlf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgGPMiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgGPMiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:22 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB5C061755;
        Thu, 16 Jul 2020 05:38:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id h28so4659920edz.0;
        Thu, 16 Jul 2020 05:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jKqK8Huj6moWWcQgWnH1SnDeVFeNIv6+mXlAUJIGGqw=;
        b=RSloKlf3CFNtY1uyN0P5mNCnu4ofV3lTYnzLUbFojw2bDDEG+8iV+E35d0Al0sTAgM
         BRzK5cImLzi5CH2PmjO+zwEYfObOZClg553J0Jh8q3aRuEq0MyXrRfJvrtnCCQN3aUGv
         5jdE5+Ba16OylOmgBJtLZdBCAmihM/+kp1js6iIMB8blbzv7Kzse1IU0rQu43ThgbFF8
         d4S9WxPWng8cxcECfaoDakrm85slIMSIth/ENUUE7UCkhbWBtDxQlvXVL3pOH0vl03S6
         zWjlh0fsMTGaXtUxcORS1vlgdbEz7anaSnzgzScr/b60xegCPiAcA5j4XQhulWScQWlL
         Pwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jKqK8Huj6moWWcQgWnH1SnDeVFeNIv6+mXlAUJIGGqw=;
        b=dhwe3yzNG+r/ZTv5Iw5XdTINH7ey9vyYtk4bxFFOqQdMfOx9UIduZ5+OF3hz1HaOXn
         fSw5RxvKVbgPj4tK55bD6AqKj1jgVeOqsQU53B9O5K8sX8GhyqzH3pdIHYxUJBdCgoSE
         VW2CLcFRnRbjDLXfjaHJ2iUoobIY8k7dTTsywsMRK+StA3Ql9kJ0C8qCce+hV7kO121q
         BS7efMD3NaGdWzuoOiyo+k9pAkDlhsFlYtnbaZp0ZgBvqVZtQ/9U54ZYpXcuDa9MNtet
         vbISyWoWCIYjDSJr1bXayEhZ4S01AUdiLuVcyGBrYUwvr3OYnJEup+KBdlS8WLjRNffN
         Hi+A==
X-Gm-Message-State: AOAM532wG0sZB1r/th3QiwTUEZrhLVsz3NXKHVIpasSHcvofXQQgraCG
        AlaIRcL73Dy4ZEOSsmMc1cc=
X-Google-Smtp-Source: ABdhPJzOlR4MMyi9BOH2/djs6obvbsoU6//gPGkt0+Rh+L9vcjs5hxPLLSyGPF2jLXC5UeFEFyQ1Rg==
X-Received: by 2002:a05:6402:306a:: with SMTP id bs10mr4221941edb.51.1594903100860;
        Thu, 16 Jul 2020 05:38:20 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f17sm4987204ejr.71.2020.07.16.05.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 05:38:15 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:38:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Pedro =?utf-8?Q?=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7
 devices
Message-ID: <20200716123814.GB535268@ulmo>
References: <20200629025456.28124-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20200629025456.28124-1-digetx@gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 05:54:50AM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> This series introduces upstream kernel support for Acer Iconia Tab A500
> and ASUS Google Nexus 7 tablet devices. Please review and apply, thanks
> in advance.
>=20
> Changelog:
>=20
> v10:- Rebased on a recent linux-next which got some device-tree changes:
>=20
>         - Renamed sdhci@ DT nodes to mmc@
>         - Removed simple-busses from DTs
>         - Checked DTBs using upcoming YAML bindings from Thierry Reding
>=20
> v9: - Nexus 7 memory timings are moved out to a separate dtsi file to ease
>       reviewing of the device-trees since the sparse definition of the ti=
mings
>       within multiple DT files created some unnecessary confusion.
>       Thanks to Micha=C5=82 Miros=C5=82aw for the suggestion.
>=20
> v8: - The eMMC voltage regulator is now marked as always-ON in all
>       device-trees because turned out that some bootloader versions have
>       assumption about the enabled regulator at a boot time. This fixes
>       machine hanging on a warm reboot, it's also matching the downstream
>       kernel regulator configuration.
>=20
>     - The core regulator of the Ti PMIC Nexus 7 variant is now limited
>       to a 1.35V, which is a more realistic limit than 1.5V that was borr=
owed
>       from the Cardhu device-tree. Now both Maxim and Ti variants have the
>       common limits.
>=20
>     - Added acks from Rob Herring.
>=20
> v7: - This version brings support for a Nexus 7 variant that uses Ti PMIC
>       instead of the Maxim PMIC. Previously we assumed that variant with
>       the Ti PMIC doesn't exist in a wild, but turned out that it was a
>       wrong assumption. In a result the device-trees are separated into
>       more DTSI pieces, which combined together form the final device-tre=
e.
>       Thanks to Zack Pearsall for testing the Ti version!
>=20
>     - The camera voltage regulator is now preset to a correct 1.8v in the
>       Nexus 7 device-tree.
>=20
> v6: - Corrected PMIC's RTC alias in the DTs. Sometime ago I renamed the
>       PMIC's node to match the modern upstream styling, but forgot to cha=
nge
>       the RTC alias. Now PMIC RTC alias uses node's handle instead of str=
ing.
>=20
>     - Removed "panel: " handle from device trees, which became unused aft=
er
>       v5 and I just missed to remove it.
>=20
> v5: - After spending some more time on adding LVDS encoder bridge support
>       to the Tegra DRM driver, I'm now having a second thought and agree
>       with Thierry Reding that in a longer run it should be better not to
>       mix old nvidia,panel with new output graph in device-tree. So the
>       nvidia,panel phandle is removed now in both A500 and Nexus 7 DTs.
>=20
> v4: - Corrected CPU's thermal zone on both A500 and Nexus 7, which
>       should use the remote thermal sensor (Tegra chip) instead of the
>       local ("skin" temperature).
>=20
>     - Added default PMIC pinmux state on Nexus 7, for completeness.
>=20
>     - Added PMIC cpu_pwr_req GPIO hog on Nexus 7, for completeness.
>=20
>     - Renamed thermal sensor node label to NCT72 on Nexus 7 to match the
>       actual hardware (NCT72 is compatible with NCT1008). For completenes=
s.
>=20
>     - Added always-on USB AVDD regulator on Nexus 7, which is controlled =
by
>       the PMIC GPIO. For completeness.
>=20
>     - Added PMIC GPIO enable-control to the 3v3_sys regulator on Nexus 7,
>       for completeness.
>=20
>     - Added CONFIG_NAMESPACES, CONFIG_USER_NS, CONFIG_SECCOMP and
>       CONFIG_PINCTRL_MAX77620 to the tegra_defconfig. The first three
>       options are must-have for the modern userspace, the last is somewhat
>       actual now since the default PMIC pinmux state is added to the N7 D=
T.
>=20
> v3: - Improved device-tree node-names in accordance to review comments th=
at
>       were made by Thierry Reding to v2.
>=20
>     - Corrected LVDS encoder powerdown-GPIO polarity on both A500 and Nex=
us 7
>       because I implemented the DRM bridges support in the Tegra DRM driv=
er
>       and found that there was a mistake in the device-trees. The updated
>       polarity also matches the boards schematics. Now DRM bridges support
>       becomes mandatory since LVDS is getting disabled during of the enco=
der
>       driver probing. I'll send the DRM patch separately from this series.
>=20
>     - Replaced recently deprecated CONFIG_DRM_LVDS_ENCODER with the new
>       CONFIG_DRM_LVDS_CODEC in tegra_defconfig.
>=20
>     - Added more config options to tegra_defconfig, like pstore and therm=
al.
>=20
>     - Added atmel,cfg_name to the A500 DT, which is a new upcoming proper=
ty
>       in 5.8+ that allows to specify the per-board hardware config file n=
ame.
>=20
> v2: - Corrected "volume down" key-label in the grouper's device-tree and
>       improved some other names in device-trees.
>=20
>     - Added optional (upcoming in 5.8+) VDD/AVDD regulators to the touchs=
creen
>       node in A500 device-tree.
>=20
> Dmitry Osipenko (6):
>   ARM: tegra: Add device-tree for Acer Iconia Tab A500
>   ARM: tegra: Add device-tree for ASUS Google Nexus 7
>   dt-bindings: Add vendor prefix for Acer Inc.
>   dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
>   dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
>   ARM: tegra_defconfig: Enable options useful for Nexus 7 and Acer A500
>=20
>  .../devicetree/bindings/arm/tegra.yaml        |   10 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  arch/arm/boot/dts/Makefile                    |    4 +
>  .../boot/dts/tegra20-acer-a500-picasso.dts    | 1438 +++++++++++++++
>  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |    9 +
>  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |    9 +
>  .../tegra30-asus-nexus7-grouper-common.dtsi   | 1232 +++++++++++++
>  ...egra30-asus-nexus7-grouper-maxim-pmic.dtsi |  185 ++
>  ...30-asus-nexus7-grouper-memory-timings.dtsi | 1565 +++++++++++++++++
>  .../tegra30-asus-nexus7-grouper-ti-pmic.dtsi  |  149 ++
>  .../boot/dts/tegra30-asus-nexus7-grouper.dtsi |  149 ++
>  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |    9 +
>  ...30-asus-nexus7-tilapia-memory-timings.dtsi |  325 ++++
>  .../boot/dts/tegra30-asus-nexus7-tilapia.dtsi |  235 +++
>  arch/arm/configs/tegra_defconfig              |   42 +
>  15 files changed, 5363 insertions(+)
>  create mode 100644 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.d=
ts
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-PM269.d=
ts
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.=
dtsi
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-p=
mic.dtsi
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-memory-=
timings.dtsi
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic=
=2Edtsi
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-E1565.d=
ts
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-memory-=
timings.dtsi
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi

Applied, thanks.

Thierry

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8QSjYACgkQ3SOs138+
s6EfUw//biPjXK8M9ypgA0pXxiTgljq+2TokuNQcd4/sD9EuB57e3mq6QLKbMu+U
nb7fslhobWWnQ5vvqzY/bYkQKVsGTGvNucXe1Hi8xGKzD9OIgUIQAu1jXpOjyfoR
9G8/iCcoTwPtpetmVlvJCHBQAL9ng1wwLWpvjYhuxsG6lwknup7YRgs/TkAEQBGR
X9H4de1hygzy2OP1CDARsaYkb3WDsUykUN58EGET9+U4lEdYfZ8dT8kW3u3v2MrI
OJRowcSItrfa53TrhBxzbRVeDQshSJ73lc1IN5qLJEQ2wgZXcjsO/mZ4xw1XTp7m
2JU0WYYmxrhrqhMCWl0E5x6MBq3yjCydx+RaNvx/USdB5wWCGeWgAOooB0YIBXkD
p4OCapyfdzWHRISnXD5Gl0HOgeBQ0SCXF2m7SwZVIHfZ37qvOfrGqNelO8xIRBCY
XHnc810M7JC+P/uvS1+RHiwGZWH7wR9GbuC7U0BOpBpkJR6F2pJ2OgaGVUjwPMbt
m/mfAlqp4WGd54LtoCMBYkIJc+a+5WYhduRmcseSrKsNFJ0BpIfFR+zDLSjL2W3n
4x4jAWZCLLhjHjMKBiXhYEWj+RpBzx76kx8J1k20AGlD8iCVOtR6R76Z0spYftHx
llIHlnzdnqY+VLKhxVRc0KjumZTIhSPkhdOOp+zHAZeox4u3L0k=
=793C
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
