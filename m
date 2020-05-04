Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DC7C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BD5206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuMrxmsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgEDPug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgEDPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:50:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FBC061A0E;
        Mon,  4 May 2020 08:50:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so34053wmg.1;
        Mon, 04 May 2020 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gDbxAIGwkGFnO7JdYjM4B8UxbcSuztivvzfmZ25PAKM=;
        b=YuMrxmske+uyYkS7RaNS2eWyAMMxL9tD7Ndbb5B8pxET/eDcQRjDJwGxveHTXZC72e
         d1mdIOfVzXVMQkwxD+B2Myi/b7dtW1YprPR7Xa3Dj0H4rRznOqiBdE7Oh3YanteLiHRk
         alV9ml8VIeIQuo/c/npYQEyNL6rce/3M2/EV+KGs0xEXD30Eh55prXUkwd+HK9nP38yO
         n+9ifcJR4XDyMxzt83rm3dQiiaVxoDLbTs++EGsuS+ThOVwMh+azVNVvXoFYYiMSTeN+
         +FF1Q5Gon7AEQOZs9Ji/EicTuocvvMohwr6QA5QTr7SBeQ4E1zJtjyHpJ+GFJ8Q8/2FZ
         jsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gDbxAIGwkGFnO7JdYjM4B8UxbcSuztivvzfmZ25PAKM=;
        b=YD9ZdQ0xhOX36IMQ1BykKJnMqjl3vXngJectz4F1wvDwhvQz/EW8j8aFvc3LHxi4xt
         SesGEBtaGil4/4Q33mk+ZFFMDAR+SO7TLCOakGH20vY1UUwV8pm2xv5x9orILlmcCV0Y
         L3mhb5T+5rI+AC5Npy2UOnP+vC9rXtaoNGbb87a1ulfqz7DUIzHDIqv/SD4h1RDURHdT
         JHZpoYlEsGfaYV8vlBVcqkAxt2M0AApuQXLETygaleFRWjjGsqjgLF4vX5enDDTuZm9B
         e6fH267E/Hojs35BRzH8Jvd8fWT+0CVJ/U8hELOs/gq/D1cndEslB20z6KS5URK6lw8H
         JTxw==
X-Gm-Message-State: AGi0PuZWkHgrkf2CFExuyLTPNDks6fbXbmwoO/sxCiA86xQOR8ZcpASe
        MyQFABp8xG2yevqlRrzL34Q=
X-Google-Smtp-Source: APiQypKnJGn1vS4Eg8RCc1KXF7sKTOKAxbim0Q3sWmDU+fYHki26sF37pi8iDVNMNQKQoi+WdX0yIw==
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr14487577wml.166.1588607432993;
        Mon, 04 May 2020 08:50:32 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id d1sm18696767wrx.65.2020.05.04.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:50:31 -0700 (PDT)
Date:   Mon, 4 May 2020 17:50:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 6/8] phy: tegra: xusb: Add support for charger detect
Message-ID: <20200504155029.GB614153@ulmo>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-7-git-send-email-nkristam@nvidia.com>
 <20200428105510.GH3592148@ulmo>
 <ea0f5906-4681-8b84-a55a-e959ce40aece@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <ea0f5906-4681-8b84-a55a-e959ce40aece@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 02:32:51PM +0530, Nagarjuna Kristam wrote:
> >On 28-04-2020 16:25, Thierry Reding wrote:
> > > On Wed, Apr 15, 2020 at 01:55:06PM +0530, Nagarjuna Kristam wrote:
[...]
> > > diff --git a/drivers/phy/tegra/xusb-tegra-cd.c b/drivers/phy/tegra/xu=
sb-tegra-cd.c
> > > +static void tegra_xusb_padctl_utmi_pad_dcd(struct tegra_xusb_padctl =
*padctl,
> > > +					      u32 index)
> > > +{
> > > +	u32 value;
> > > +	int dcd_timeout_ms =3D 0;
> > > +	bool ret =3D false;
> > > +
> > > +	/* Turn on IDP_SRC */
> > > +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index=
));
> > > +	value |=3D OP_I_SRC_EN;
> > > +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> > > +
> > > +	/* Turn on D- pull-down resistor */
> > > +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index=
));
> > > +	value |=3D USBON_RPD_OVRD_VAL;
> > > +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> > > +
> > > +	/* Wait for TDCD_DBNC */
> > > +	usleep_range(10000, 120000);
> >  From the comment this looks like we're waiting for some hardware
> > condition. Can we somehow obtain this rather than implementing a fixed
> > sleep? Especially since the range here is so large.
> >=20
> As per data sheet we need to wait for 10 micro seconds as settle time.

Okay, so TDCD_DBNC is a value that comes from a timing diagram in a
datasheet? Seems fine to leave it as-is then. Perhaps add parentheses
and mention which exact datasheet that's from, and perhaps which figure
so that people can more easily reference it. Provided there is a
publicly available datasheet, of course.

Actually, one other thing: If the data sheet says to wait 10 us, why do
you use an upper range of 120 us? Shouldn't a range of 10-20 us be good
enough?

> > > +	/* Wait for TVDPSRC_ON */
> > > +	msleep(40);
> > Again, is this a hardware condition that we can wait on by polling a
> > register?
> >=20
> It HW settle time before reading registers.

Again, perhaps link to the datasheet, or alternatively describe in the
comment what this is waiting for. That is, something like:

	/* wait for TVDPSRC_ON (wait for hardware to settle) */

or similar.

> > > +		if (tegra_xusb_padctl_utmi_pad_secondary_charger_detect(padctl,
> > > +									index))
> > > +			chrg_type =3D CDP_TYPE;
> > > +		else
> > > +			chrg_type =3D DCP_TYPE;
> > > +	} else {
> > > +		chrg_type =3D SDP_TYPE;
> > > +	}
> > > +
> > > +	dev_dbg(&port->dev, "charger detected of type %d", chrg_type);
> > Do we have a string representation of this?
> >=20
> No String representation available. Shall i add one for wasy reading ?

Yeah, I think that'd be nice.

Thierry

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6wOcQACgkQ3SOs138+
s6Gczw/8DmZ+CrTXiEWQGprlWVnXJRhLbaMmN3d2ncl3kdUo2Me244NGxLhb2lvj
IsO26k9RgdiXF0gfwWIK1J7swxrrczwbR6Y4xqRcZ1uKL4qDj3WLSZXqRBZs2ZeX
T58TaRJDoN8CQcN+2EV0lLVL5nWYBxR8NJGsN6Gfh9T2DUeZ5Yyx10an/ircSPoY
wQuHi991cScgvK+y0poOFTs2p74T2/YRZ1fEFRmJLVzSuACpHLypBRbafUdz3wNE
NS4dgf+OE05fI2OfW4gugPirVzrxOl76WEQ5HGb/eYBXBT5EOp/dLxiJPf9T8zHj
L8qDO7BJY/Fwa1067zXsukpvTUTOoryRjXF3dwoHT3/Iix+WvU9Rq8pVc0zrxGYl
0vWPaPNtZ+r5C2iQZtfQO/IjGSPIo+DU/lQkjvUKSYyZCVWjiJnjiM674wbSNzVT
N3bPf3F7W4XXYYjVD5LzEBKPBEWXgfrocrcYf4rjzpm26UZd9mO52ASJiH4jvE4e
tYNSjE2FgJuR4ZRAfgsYTxiTlsx6Nh7hVaID9esAENxxHDl4hzVFnxJA2q5FhE+K
JVA+3dL5gL+WtQsRbUiu8aYttGKMUfJNUqrYGHDUklQwgzdXkot0thPLV8zHBu95
RsKP9+USnAiI3QYo89cZnnnkn5UXpE51rSVEh18RwCM7vpTfja0=
=j6Ma
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
