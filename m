Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4390BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA91206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxJ5OjO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgDGKlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:41:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42215 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgDGKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:41:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so3277043wrx.9;
        Tue, 07 Apr 2020 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=asE+SV/ivl5X4mJuxcZikDa+aRVlmYo5hGT+MmZHcYw=;
        b=SxJ5OjO1B2TTEErGWIrlHYk1EuVNmQ+0lf9Ne/2pny3Qhld4s0UI0CmCjiORnaUc4h
         mc/82067VtkPV0qP7OFbuTwb4pU+u+RhxY0Z+qnss+G3cj85KufKqd47z3ikQoU/CERb
         8Reg10MlnN0OdhHXkzS6EGsCrzyTs6fWSx08F80cCK6LRFhwS+P3uNYuNH4NpY41vkO3
         xQ0Cv07x+GPaut4XpDTfvNZElYqJBTHYEVubvYJMDTxGs9GexJp/csHqPcMA9InlsjgP
         UwaFjeQDJ5k3Q4rMoaTPE+IUF1Sy3/eto+YgKtch0MiBM6kDTUK0M1V+6b7/opRJwRIA
         RK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=asE+SV/ivl5X4mJuxcZikDa+aRVlmYo5hGT+MmZHcYw=;
        b=gDgSzLQjbALH/Tn5G/In6T2yF8yTJQqyn1lROFdwpOIZINMPQ4ugMRU1Q9i5Jja1zx
         KU5EDix2hRFA7BI92e2VLRWGe2pQbQVkFwSGB7CxPosFgcaHP2w0IF2tj3CNaMFFjxaB
         a67mi7YEotuEq8klt7Kj/dEqXnLCPrHQPedQ5ljTJXGMJZa9ID/SbuLZLuKWf7ypOZ2s
         JTwpTLrudbd7GHYm/krSRvwiahrb6D+zxxt8OJ2DFpWxiMWywuqOBHh1CG8D9kNa2lTf
         kQg9Fd/DLs/iDasqZqWP9xTuIzDXNCxMmFeWwAg6Jm/fMbQpnwvAwzxOqMq6OT5t8+y0
         KcvQ==
X-Gm-Message-State: AGi0PuYRlEroewPyfaounUbM1o1zj+rEaNRgbAkchf76LyqRmoEWRcU1
        yma8NrnJraEFw8CHzAFlQsErLIQR
X-Google-Smtp-Source: APiQypIP2QTjYaYWvWFQ/toPF5JReaWyPe1FaHRkR6w9Vy4BtM6pw8vAOZoswSpjW2GKpcQwNafeLQ==
X-Received: by 2002:a5d:4305:: with SMTP id h5mr1999853wrq.69.1586256071913;
        Tue, 07 Apr 2020 03:41:11 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id n6sm1821868wmn.10.2020.04.07.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:41:10 -0700 (PDT)
Date:   Tue, 7 Apr 2020 12:41:09 +0200
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
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ARM: tegra: Add device-tree for Acer Iconia Tab
 A500
Message-ID: <20200407104109.GC1720957@ulmo>
References: <20200406194110.21283-1-digetx@gmail.com>
 <20200406194110.21283-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <20200406194110.21283-2-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 10:41:05PM +0300, Dmitry Osipenko wrote:
[...]
> diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/b=
oot/dts/tegra20-acer-a500-picasso.dts
[...]
> +	host1x@50000000 {
> +		dc@54200000 {
> +			rgb {
> +				status =3D "okay";
> +				nvidia,panel =3D <&panel>;
> +
> +				port@0 {
> +					lvds_output: endpoint {
> +						remote-endpoint =3D <&lvds_encoder_input>;
> +						bus-width =3D <18>;
> +					};
> +				};
> +			};
> +		};

This seems a little strange to me, though, admittedly, I've never worked
with these types of bridges before, so I may be misunderstanding this. I
was under the impression that we could obtain the panel by traversing an
OF graph, so that we didn't have to have that extra nvidia,panel
property. As it is, you seem to describe two different paths, one that
goes from the RGB output to the panel directly, and another that goes
=66rom the RGB output to the LVDS encoder and then to the panel.

It doesn't seem to me like a direct link from RGB output to panel does
actually exist in this setup.

[...]
> +	pwm: pwm@7000a000 {
> +		status =3D "okay";
> +		power-supply =3D <&vdd_3v3_sys>;
> +	};

I don't see power-supply defined as a property for the PWM controller.
Why do you need this?

[...]
> +	sdhci@c8000000 {
> +		status =3D "okay";
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		max-frequency =3D <25000000>;
> +		keep-power-in-suspend;
> +		bus-width =3D <4>;
> +		non-removable;
> +
> +		mmc-pwrseq =3D <&brcm_wifi_pwrseq>;
> +		vmmc-supply =3D <&vdd_3v3_sys>;
> +		vqmmc-supply =3D <&vdd_3v3_sys>;
> +
> +		/* Azurewave AW-NH611 BCM4329 */
> +		WiFi@1 {

I think these names are supposed to be lowercase.

> +			reg =3D <1>;
> +			compatible =3D "brcm,bcm4329-fmac";
> +			interrupt-parent =3D <&gpio>;
> +			interrupts =3D <TEGRA_GPIO(S, 0) IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "host-wake";
> +		};
> +	};
[...]
> +	clocks {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		clk32k_in: clock@0 {
> +			compatible =3D "fixed-clock";
> +			reg =3D <0>;
> +			#clock-cells =3D <0>;
> +			clock-frequency =3D <32768>;
> +			clock-output-names =3D "tps658621-out32k";
> +		};
> +
> +		rtc_32k_wifi: clock@1 {
> +			compatible =3D "fixed-clock";
> +			reg =3D <1>;
> +			#clock-cells =3D <0>;
> +			clock-frequency =3D <32768>;
> +			clock-output-names =3D "kk3270032";
> +		};
> +	};

Are these clocks going to the PMIC and RTC, or are they generated by the
chips? If they are generated by the chips, which sounds like they might
be, wouldn't it be better to represent them as children of the
corresponding chips?

There's probably no infrastructure to do this, so maybe that would be
overkill. But for clarity it might be worth documenting here where
exactly these clocks come from.

[...]
> +	memory-controller@7000f400 {
> +		nvidia,use-ram-code;
> +
> +		emc-tables@elpida-8gb {

I don't think unit-addresses are supposed to be freeform text like
above. These should always reflect the value of the "reg" property,
though in this case we don't have one...

> +			nvidia,ram-code =3D <0>;

In retrospect it might have been better to just reuse the reg property
for this.

I think in this case it might be best to reflect the RAM code in the
unit-address. At least that way we conceptually get things right since
it's the RAM code that selects which of these tables is used, much like
a register, I2C slave address, or SPI chip select would select which of
the subdevices are targetted.

Thierry

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6MWMMACgkQ3SOs138+
s6GytQ//ZZ3c5eWdkrzwNHUhF5xtBVLu/a9zvBw0MdzqVso74mZps2WOLQf0jM71
ke7Wd3iRqOYZRqP2XraP+uJekAcnGwORDmme8rKYvdXetOgpowCG0izz1b4toqRj
4j2WLMcB4/UJ2ZfC4HgsmXlSUITfWrH3P5XACli+RhApBT7mpk+f7NpnPNp1/3kB
c0gEEjVvNHwIY75IkdXWVblpVKKRsrzgRCUQQVKq9uEoUZW2DwOd0ZkDuefAelVn
P9MwdZ/Vd2lf4O6Doh4HApZo2oBW0UwQr8ZpGy7ALisAjwHtDoCqXntQY77Q3BUD
1+9a3yfDNJf2etfEKP7hUTp8AnUYqfcSgH7H8WscRr1fIFDKefEzZRKHtsFDYsIh
DVREr/Y8vnErTnrSDhkAonmDisZGbFOv3QFAPQWz6WSLpqZ6Y868tqUK65L51W7G
pzVSBJvCBTnxZrKUvBIR2dRDhgnqcVuGnxhhHyPzI+xQD4xiDO1CIoXUTivKwLI0
hclweROsRf7XPvcBVbqvkgPfD3Vmtqali7jylhaCJxicNeAKiHCrpPVSz+Je7fh9
7lihBH1OrmxJhX7mA725U7M3kIFE16VQkHVnn85SQQ8bVZyUyr3D8j8NlXI8IvZx
gnyd2tiHpEY64UeNo75wFwGR6PZzDPNqHVSFyehw0A4G3nnRo2g=
=JDmV
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
