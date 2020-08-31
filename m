Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B7C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BFF2098B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ4KqbNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHaL7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaL7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:59:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48036C061573;
        Mon, 31 Aug 2020 04:59:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c8so1519596edv.5;
        Mon, 31 Aug 2020 04:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ykiShrw6bxhIypPHvE5LttRsRsZen1FO3FKIqs9CWQ0=;
        b=fJ4KqbNOkfyF+3ZdPXYbwLy44hmBg1Tivk3Zfvin3k+//S7ZifWvZ6t+Y5O4u19HY0
         ZmwYn3ngNhBW1qh74QZ1fZ5Xktu52VuGnOro4a9EHhMUVjpgvBcw70tsIpa6wU/HoMoU
         KCwD6WCZxJE3k7enVg89JQHTz37A/ejCBbygeMDuoCwaYorxTrhpd1weJVUbtjHa/2V1
         SkdMbrN0UsxgbrA6ltbDfVG3NBn2Z7wJHjtxZodCQyBvvj5J+wg6D4z6+r1y7+UIO366
         7POCXR0DUUVXC90LJ/O8mQ6Ozvxj3nD6ioUYQqwGxYcf2BFLxoTZMuJF6leu4mtvw/L9
         gBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ykiShrw6bxhIypPHvE5LttRsRsZen1FO3FKIqs9CWQ0=;
        b=EKWULt6wtX0xtTBaVF6v31/3H1q1chFUKbrXCBQWTHEg0XFEo7DCX0ei6g2p0TfnaH
         2AJmChHuDKZ6U2+OGNFVYt6NWZ8w8/S2uuAvUS5cahJeiOzHRDEZ8ML11hQzumiu2zWv
         OMfPuJDmNcufUoj73v9FDHAB4Cm1Fu4QwCYqcpP13ab4uqrRQl8dRZDmBp2vH2hfNFQl
         zORKF7hujqMKpIqNNDXpgKLqBi1lcNuzEtk/ABaa0hLBJKsRmbZ18unv3yXry6wuUd7v
         ohl70siBJWX+geVv2hFynFGSyEjtg2R237s7gIny0vrRxXS0kkTgw/nYY4GtNQ8Tc9uD
         Dm+w==
X-Gm-Message-State: AOAM531CRiQjXLwYOPIVOVutX60wh0yRW8q4tijgjM/us6dVOOVS7rlj
        73/r3cn2wGsZTVHBCrV336kNkbd9PnUaug==
X-Google-Smtp-Source: ABdhPJwWc9p4KFa3upTd2QiNJtoMpLtA6Eb/+F5bg1FC0O4KE4g7LqIkCi18snad5YgU97VqLq8I/A==
X-Received: by 2002:a05:6402:a46:: with SMTP id bt6mr884982edb.269.1598875140015;
        Mon, 31 Aug 2020 04:59:00 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id oi24sm7919016ejb.69.2020.08.31.04.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:58:58 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:58:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v2 05/12] phy: tegra: xusb: add sleepwalk and
 suspend/resume
Message-ID: <20200831115857.GC1689119@ulmo>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-6-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20200831044043.1561074-6-jckuo@nvidia.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Again, use a capital letter to start the subject after the prefix.

On Mon, Aug 31, 2020 at 12:40:36PM +0800, JC Kuo wrote:
> This commit adds sleepwalk/wake and suspend/resume interfaces
> to Tegra XUSB PHY driver.
>=20
> Tegra XUSB host controller driver makes use of sleepwalk functions
> to enable/disable sleepwalk circuit which is in always-on partition
> can respond to USB resume signals when controller is not powered.

"and can respond to ..."?

> Sleepwalk can be enabled/disabled for any USB phy individually.

"USB PHY"

>=20
>   - tegra_xusb_padctl_enable_phy_sleepwalk()
>   - tegra_xusb_padctl_disable_phy_sleepwalk()
>=20
> Tegra XUSB host controller driver makes use of wake functions to
> enable/disable/query wake circuit which is in always-on partition
> can wake system up when USB resume happens.
> Wake circuit can be enabled/disabled for any USB phy individually.

"USB PHY"

Thierry

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M5gEACgkQ3SOs138+
s6GNGhAAtD/MM6G/93WyWLJxQKN2+HjJXdkYSw8dtZ63vdet0kn74caMljKlEWLp
PzQ0KHRho3lVLKDiDMolJlKnqk1b9DYZZz83W2vK9noRUDCyEQkgQ342paazKJk5
/9GfGEJ0E9QnuySJ2wisfZVoJ+yKZHMaL6zdmaD0pXdiin9OQRA3oMcubTkhHCzY
XMtdFqwAjePwgHP02Qbi2gI2Npzy++q6/kGwVStBW0DdTn7d3Sq9pGeyuzUSi333
fCKTmWUDISVKa6tjreO5hW6au9F0Q5nC3Pe4ypQ3yUmBFFicxuy0w8VwR5bAEmbw
XVeLGqAAfoLvJdos2BBNC9fKQM7OvPyj8tE4BypSj4BRwKFa9Fut21W/ZSGYrfO+
0ntLTl1LIvpbRoA8e3JodATIrcJ82dTb8ehWDErSjbPXcCsCyejm7w7NOU4wSMgN
KoZpYJFiitdfhOJ26agBRGI3oAsXTPKmqkH18wx9IH9AuRCXOKVSqdQHz41i0nhN
xuAZ/MAa+AB2gV1W/Ii8co5c0CBKmH5PraVfsfROB03KdZNedmjvHkji17WfAygH
aqEOky3ZGTYZb85NuIAbsDhTzqD7qt6pdnRqee1kGuXBMm09X41PjP1JEHxDXhpY
Of5T0djDWkN7hV0QQPlj8TJsREUO3F73ybQLEUcKpleta5lochI=
=UVSr
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
