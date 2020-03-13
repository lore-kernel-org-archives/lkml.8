Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A80C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5AA206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584110898;
	bh=Jb0CrveDwyKlE1dVdK6ad0RU8fp4lk2yrLfBv/BLK5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=NqUubhXCOVZVASLL+cSm2VvSoZ3Aj/uRivN5E1v/ZEX68qqLx8m7BJWRH6VaB+f2c
	 uMyQIHjDG+DoDZAKMf3767HxAaLDgnfBrgxzIvlpaq9Leg84vMoMqPwhL9txaiIVCd
	 nhD3O4+WLJoZqoAnnMdYr9jHtfqvLUP7Gl7xGtxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCMOsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:48:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37485 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMOsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:48:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so10838970ljd.4;
        Fri, 13 Mar 2020 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OXNW+qbkifm22DDftJr72ZNJUFSaznw2nYVEJ5BnOxE=;
        b=PfkIXQ3pBeYomndl5GR8VhLHQLpXDfE3PxhidQPKtZSFhuDSPagci8oHW4bZTPB2Cr
         bSnmxTitHyyoHq4mc1YGFjZvwgrvZvWnZAK5Fa6vG0ymoJK3EmAQN4R64wLCDeEzvxVa
         r6INAlU2pMfrB0kaT81Frbmif/tieFnHZq9UMxf1CPBv4ccRxjQNNdMIdkM7ujLAGmiz
         Fsze6+1b1fwYZq/rdtLKTSgfBUkNR8MaYR3X4VbLOVyrzA6y2X5PqgXR9aX/D08ifBEw
         sOYNA5SOjE2/n/x2/m98HBzvI0sR59T4iyTCGBaf/6TjR61dHom6JSZRr/gYUdiek0FU
         DvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=OXNW+qbkifm22DDftJr72ZNJUFSaznw2nYVEJ5BnOxE=;
        b=ZyZHdo/A+SsaJ38INuv6JU/mUXBkYONuiDNyPeY04mgks4PR6YXwJBazKw7u4H1QM4
         dtAGdw+IetbAliIpyRZXBEniNO6Eq0IfSj0SmSWmMNOGOYydgI+GIsiGhpd4QIOcYwQ6
         gAJN12hsnBPZQWhIMBmg7KavpZ1NochRhII6+anDBub5sFao7QtzWlRPeT5A1vCwHUgm
         QuJLWtsRVYvfuHj5nEK7ehkLbreigoHibk3ry7PweS2Mbxm7kshtcj5OH/mzMA660Ojs
         4ajmEuacHMUZs6j4cW2shApA0J4OQpOYCtXUqM1OE1Mcx8VAMAco9aNphNEWkO7s3Av+
         0vfw==
X-Gm-Message-State: ANhLgQ1QQxrU/uCXVugzYasRFXlkH6RRBrK9M/JTrylAHnrzk6w1Mv79
        wzqJ++/gz5IxlRn1LkHX7u2QRTvOyg8=
X-Google-Smtp-Source: ADFU+vuJuYPtQvhZNicE9knXkDuF5e6nkLWn3JOtaxSks+6bSsih9Fg+Op+kMyc5+TogPdovtFYiKg==
X-Received: by 2002:a2e:9f0e:: with SMTP id u14mr8187467ljk.142.1584110891962;
        Fri, 13 Mar 2020 07:48:11 -0700 (PDT)
Received: from saruman (88-113-215-213.elisa-laajakaista.fi. [88.113.215.213])
        by smtp.gmail.com with ESMTPSA id w28sm1722544lfn.29.2020.03.13.07.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 07:48:10 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 00/21] Tegra XUSB OTG support
In-Reply-To: <20200312092232.GA1199023@ulmo>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com> <20200217085130.GJ1339021@ulmo> <20200227173226.GA1114616@ulmo> <20200304070100.GA1271591@kroah.com> <20200312092232.GA1199023@ulmo>
Date:   Fri, 13 Mar 2020 16:48:06 +0200
Message-ID: <87r1xwfh09.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Thierry Reding <thierry.reding@gmail.com> writes:
> On Wed, Mar 04, 2020 at 08:01:00AM +0100, Greg Kroah-Hartman wrote:
>> On Thu, Feb 27, 2020 at 06:32:26PM +0100, Thierry Reding wrote:
>> > On Mon, Feb 17, 2020 at 09:51:30AM +0100, Thierry Reding wrote:
>> > > On Mon, Feb 10, 2020 at 01:41:26PM +0530, Nagarjuna Kristam wrote:
>> > > > This patch series adds OTG support on XUSB hardware used in Tegra2=
10 and
>> > > > Tegra186 SoCs.
>> > > >=20
>> > > > This patchset is composed with :
>> > > >  - dt bindings of XUSB Pad Controller
>> > > >  - dt bindings for XUSB device Driver
>> > > >  - Tegra PHY driver for usb-role-switch and usb-phy
>> > > >  - Tegra XUSB host mode driver to support OTG mode
>> > > >  - Tegra XUSB device mode driver to use usb-phy and multi device m=
ode
>> > > >  - dts for XUSB pad controller
>> > > >  - dts for xudc for Jetson TX1 and TX2
>> > > >  - dts for Jetson-TK1
>> > > >  - dts for Jetson-Nano
>> > > >=20
>> > > > Tegra Pad controller driver register for role switch updates for
>> > > > OTG/peripheral capable USB ports and adds usb-phy for that corresp=
onding
>> > > > USB ports.
>> > > >=20
>> > > > Host and Device mode drivers gets usb-phy from USB2's phy and regi=
sters
>> > > > notifier for role changes to perform corresponding role tasks.
>> > > >=20
>> > > > Order of merging Patches:
>> > > > Please merge DT changes first followed Tegra PHY driver changes an=
d then
>> > > > USB driver changes.
>> > >=20
>> > > Felipe, Greg, Kishon,
>> > >=20
>> > > Given the runtime dependencies between these various parts, I could =
pick
>> > > these up into the Tegra tree if you provide an Acked-by.
>> >=20
>> > Ping. Are you guys okay if I pick these up into the Tegra tree?
>>=20
>> That's up to Felipe, I have no opinion :)
>
> Felipe, Kishon,
>
> I've picked up the device tree changes into the Tegra tree. Let me know
> if you also want me to pick up the USB and PHY driver changes.

Sorry for the super long delay, no problems if you want to pick it
through your tree:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5rnSYACgkQzL64meEa
mQbcOw/+PHC2C6s2hZma+wKIIWRf2etmytep7PH5htS6qBEqiZclRJChw9ks8nh6
87xBYHbPcR3ajUbf/qLdU53B/P/fv18aBnG+v26qoE6KusJ/SwIuo7IqMtxS4h1e
SteaHHsqvsQuYpq2Jy10nHTGLszKzjkjKt/ZGgyZ9Naq5IT9A/dyWPjkwOr1Cfen
ufJ+uqH/aEMcrfL/ejGJLZMVvmi8hIppZnld02J02/Ip4pzp+fSn4/NhXDUlnIa3
Ru9Zdzs5upEva8KZb7oUiWqZLEUIXHPP4tGDl6AaXmR774EhPXD4vCEo+8SIX2NI
gQ8zODCKOfEwYCblxhwI5AK+W2i6BEqeKUo+H7PdyU5lFA/SvKnEvrlmL9XECnSL
2+boUbAC4VdDRQ0ZE4jMep8ehPTBK7SyUVYYGI5TOC4p6O8JvdlSIJS9Bbemo0Lj
7Z+/zyumOuy4WHe0w6I357LpTv8M6N2jEgOLHqQXqs7ROgQKo8EBgFT9n1lmYZAs
0zWLZioos7Vy31c3MWWTQdwtvCBz8iSlW+EciKcoYEZt27i2petNrQh0i7hTSyfv
rakKekvpyBXXSt5BITvCpP0SuvJ6IwXpeWZq7v38juDR2wYh6qWnogSww0pRmjqc
PMyDMRHSu9WpmR2a+ftAvFmEhIkBV/9bPb10jWwWcXdiwCPhLjM=
=6Pve
-----END PGP SIGNATURE-----
--=-=-=--
