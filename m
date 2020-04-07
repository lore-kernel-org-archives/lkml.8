Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B74C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0E52074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbob5IWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgDGKIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:08:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35534 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:08:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id r26so1199076wmh.0;
        Tue, 07 Apr 2020 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9FaJuBCa/BT+mcCfha6DjAg3gctMk4+x7nK6u0p3Vvw=;
        b=hbob5IWsIb9yOV+Jnhn6ZBGOYp5AVNgSywpZoGjEiFZ4T1oc/aKvE723RQO+2g3RKi
         RY7U5Awqzca+QrpnFJmCNSyOxaI4h/am+clzCax4X6MAYQF8iiJ3oVelhQWvAwlPowNE
         Tz4KwFc03VvsfszVSKCt7f4y9Us2IGVFDMHfXqyXcOK6JYeQqODxnKisbT3hWdzgyjYV
         uWV1Eyzop5EK6BtfPuYkvFKBfknHLLoYDzjCjvG9Fqh0XOTBsIS+R6goXdb9Z0xlRth0
         wPZVB1KHmvx1Rr7LRhPr1WhvSGNp5jMfJvrCjOPtdLIrWkTUvrdnQuz/hBoDeL3M+QvA
         3oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9FaJuBCa/BT+mcCfha6DjAg3gctMk4+x7nK6u0p3Vvw=;
        b=XC5c6SI7oAit1EGYZ1MOb8swTE5WtEHu7nief0LL/cFWePR3kC+OpJJojzz3HMFS9O
         p/zI3/L1onABhjlcQ8tfaPfNkaGWUFxTD4seS1pS9xsWqF7bBsn2fWhNPbJfxpw/y20Q
         IoWTPIvYenPTQ9kLrp3bB1AGh4d8OTiYtRF+zsmD+8cZs3qQmbssddCtlt3eUX0VoLZl
         GBflpMaqCZhy0IItJyNwG2v2ngWwVIgKnG9uCp5I4NhYaBKsn5BFiINgIBXyYtGXh73A
         Kuj2eJ/43MQ0TS12poi9ZbdAq3+4lxLNY2HuXvfo5nqb0O9PI2OF8YxmD8LCcrpdaxR7
         HwDA==
X-Gm-Message-State: AGi0PuZMa9wKzVhnKWpNmrgW25OB970j+uSCuqEbtzQmmDNwFkspkzvm
        xUUBuq2fqw0800cG0aL0jOM=
X-Google-Smtp-Source: APiQypLhaC4G+o0dezQfQTWzuc1LY8gxh+bdoi/g5NA0mpkwMMnaYJEm4vbohom0C314D2GoTk17qg==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr1663085wmc.105.1586254112064;
        Tue, 07 Apr 2020 03:08:32 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id 25sm1634823wmf.13.2020.04.07.03.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:08:30 -0700 (PDT)
Date:   Tue, 7 Apr 2020 12:08:29 +0200
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
Subject: Re: [PATCH v2 6/6] ARM: tegra_defconfig: Enable options useful for
 Nexus 7 and Acer A500
Message-ID: <20200407100829.GB1720957@ulmo>
References: <20200406194110.21283-1-digetx@gmail.com>
 <20200406194110.21283-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20200406194110.21283-7-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 10:41:10PM +0300, Dmitry Osipenko wrote:
> Enable several drivers for hardware that is found on Nexus 7 and Acer A500
> tablet devices. Please note that some drivers may require firmware files
> extracted from original Android image.
>=20
> Link: https://github.com/digetx/linux-firmware

What's the license for these files? Can they be made available through
the official linux-firmware repository?

Thierry

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6MUR0ACgkQ3SOs138+
s6GEow/+PCRBWMRHZqrLzXaBLfVmbh6Jl87RzDZcnbNzyKRyQvcbBcaPWsXf9tLh
LlXh/OInkWgYIfU+Skqi0BmHHATWq+XfHzLzQfkkujSAa8QafRKVtGTV0e+beQFD
2BrixFkH0TllbiYxaDdu9iZXxW0+/Bx5s/9AZYQFNerWoQ3NqqqrFhXNcyAbbVUO
Y46sRJy0uCNObGlyUdKCupug8fbyciPSzbhYIE2ZWmjSIKzJNPCgk/FlJrQRcyRu
5bcWkS7uwedPwmuzQMQrOW2m0FYOZ+UU01aMur7s7mPNp0cFY4dZlI/hzO3JDh4W
oTOvtjnlJodHnaQlDQijCQtukKDiTfiOlU4ZfXna6cN1T2fzaYNaCLRPWzhu4K23
1F3UTp6+UXGF2+H83jeAgcpKHGmkXrNjn4KNIDt6rIMyEnz2RJ8II4wYhJH/Oza1
Lbf+26X650r2CwOAUhSyDtAgo2Mt58GTDztVMIJStpap3A+UT+clWmoG+eYOZGMR
mVBL9UWowL1dkvjrjXmlOsqcN0OfWtmazA2rQAurS0NU2Aq1hoffcx73gWCJE5B/
9z0RHHQUUVMGFNSYQiZxpTIKsBIu+iTHZ99q29RPBK5wye5sIKjFTogylTvzh6wk
78XF5M1Ndf+6LQaxvgNXHZsGkb1sdjAgbz1f2JMQmDrtSH7RNoc=
=kOsC
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
