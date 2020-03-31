Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596BFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BE920787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9vy+7bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgCaXGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:06:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55909 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgCaXGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:06:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so4515609wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R+fx+GM5hAoaEWKjhGg3UvP0B9DFwpziYoQh472BtR4=;
        b=T9vy+7biua8Aiv36sQ+6a2p+z3sHZo98US2k286lB0ReAQu7BlaC0GbytvG1iiefF3
         wFgXqp+IgJx1eAUTm9FfGuvAl3iON9HN8ScDBN1oZgsLVqOTyjCBcmeYcx+btsYyLV2O
         CHZRmoIhvimqEZBjSkRFs/10pHGolXOtLdNhHo4LhTCjIPFyI21JS/S+28rc2PMsMA2x
         p/Z1H9BB/lzJhrG4OP/amS73HskrewMHypyvK5xCcVcNeUKE5WC8v91qIrpgBy9+EXui
         GG3iDbsnE6+a+zCqCWYYiJdhk82Mm0iXY5NdA8GhaTv+Yob6jVHQ+k+cTxmlPyiPBdjG
         QE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R+fx+GM5hAoaEWKjhGg3UvP0B9DFwpziYoQh472BtR4=;
        b=eODEBWbijuuSui1hjCUkmDdy/IFGoEdQWEHLH9MGjzI0VS5wZJqNdi05xKvGMl110T
         wEPgj+m2Ly9Sfa48hF9Zo7Z1D/tAoIm6lrcqfK7Iwz+PYRVZHCj0gCTvb0n1zuzicp0j
         OtA6EwNgB9S0gnFoPv5nOdU7zsjXyzEILktobUPA+O7W85f4yB9qOVjIElcEk/ZNDAJt
         AK85tWBQEx8OfDFjTXswzot9Ymv9wRox63OJlzMZ2FifncrypCnnPDHTDU6bVeXqI7tE
         hKwPtws1akaNGvHdbcsnii1qFUWIjyBF1T3pFnzWjkhGw1qx6uZhwxFdvHHqn+GSQYpm
         X38Q==
X-Gm-Message-State: AGi0PubwVqjyfl6yzId7nq7Vk59qUcMzJWxaviF57NYzYe0VvqsHAXkX
        ogi0NDqDCXRJe+nnaDCArAk=
X-Google-Smtp-Source: APiQypLWJo2hYamjdUxeB4L8x98BY/YfOVijmY6wL9QiCg23MiDg/tiDLNDoK7cGVzuN1UyR8Wh5nw==
X-Received: by 2002:a1c:2c85:: with SMTP id s127mr1202977wms.18.1585695964640;
        Tue, 31 Mar 2020 16:06:04 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id n6sm333352wrp.30.2020.03.31.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 16:06:03 -0700 (PDT)
Date:   Wed, 1 Apr 2020 01:06:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Add debugfs support
Message-ID: <20200331230602.GC2967489@ulmo>
References: <20200331214045.2957710-1-thierry.reding@gmail.com>
 <87lfnguqky.fsf@nanos.tec.linutronix.de>
 <20200331222917.GG2954599@ulmo>
 <87d08suo0y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <87d08suo0y.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 01:01:49AM +0200, Thomas Gleixner wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
> > On Wed, Apr 01, 2020 at 12:06:37AM +0200, Thomas Gleixner wrote:
> >> It does not provide any information about the clocksource, it provides
> >> an interface to read the counter - nothing else.
> >
> > The counter is part of the information about a clocksource, isn't it?
>=20
> Sorry to be pedantic, but no. Information about a clocksource is the
> name, the type, the frequency, bitwidth etc.
>=20
> The counter file is not providing information about the
> clocksource. It's exposing an accessor to the clocksource itself.

Okay, fair enough.

> > I can also add some information about what I intend to use this for,
> > though it'll be a bit boring because I really only want this as a way
> > of testing that I'm reading from the right registers and that these
> > counters are running. A debugfs interface seemed like a better and more
> > widely useful way to achieve that than implementing some one-off hack to
> > poll those registers.
>=20
> But how much value has this interface beyond the 'hack a driver for a
> new clocksource' experience?
>=20
> To me none, but that might be my personal skewed view.

No, that's the only intended purpose. I just thought that would be nicer
than everyone having to write their own debug messages to do the same
thing.

If nobody else thinks this is useful I'll just stash it somewhere in
case I ever need it again.

Thierry

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6DzNoACgkQ3SOs138+
s6GlYRAAvnSy2MEMwL9A8IiB/7Htuz1RQVqFQ1HRr/9d7QwDPYfCcROo+XB4u8K9
w9eZ+Y+BR6Ukeku3sH0lWwuxMozz1vVBTULwUWDq0nkgrDJRvgHcrsPxjaFzluOl
/rB5NrcL8cPBkGocCV9Iwl4u/J5eRbwQEKzgva1jYDl3o3+NEUg24E5shkcBNaf0
0jaSwoc6+ClDDAtpgWhccCbBYJI4AFcSKmGabLa4lk9Zq9yzGtreCkDt1hB/aapq
tkLYZp2z+q7yJIlVQQcLezwNpPvaCoSYUDezAWSyYbafGkR1t6Hz/HTxTBQbwbk6
vjvJLNs1SF71Khnn2PPFIn6AkH9/e1bGsZsQYnbqzDwfiDoJy9a71dUzCkDMK+Ur
1UUqg3wzDqdMLvgNS5ApjvtUUrCnm15YpTYEjgyLKuNZRB/8RW9OLvoknBX95O8X
4jytvYlHQEH8LkIcH5fME0/tcfPWX9BD+JFFhgQlmtKnTAajPegpSX4d1anNMI7s
q3qu7ZpM6j3fljM5BfeGBK/K/rPbYKw9xdUDdpYrEcLs9kXg7JQ0SwbLQxjGmbxY
hBD4vLsF666qdNTlXqWTuGTDQHLM+qbmnNyHl3IIzPBCM6Un7SvMgCwEkSUK94I+
fYoWEoRYh5ssSzr0v7Z4OdMy0Pn6kXdjMszPX+qczEtwwzJ4tJ0=
=Ycfw
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
