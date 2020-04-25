Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEBCC54FD0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 02:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3403E20748
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 02:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonedaddy.net header.i=@bonedaddy.net header.b="SvleyPmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDYCqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:46:48 -0400
Received: from smtp.bonedaddy.net ([45.33.94.42]:52940 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgDYCqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 22:46:47 -0400
Received: from chianamo (n58-108-4-64.per1.wa.optusnet.com.au [58.108.4.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id 4605B18003F;
        Fri, 24 Apr 2020 22:46:45 -0400 (EDT)
Authentication-Results: smtp.bonedaddy.net; dmarc=fail (p=none dis=none) header.from=bonedaddy.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonedaddy.net;
        s=mail; t=1587782808;
        bh=9/eYPdM9A/BRpPvuz618cds4AcWdwHEn8lAc2Evji0g=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date;
        b=SvleyPmiCv9TuTuDHW3fIMBPSXiknzz/HLuFwJZu04FkDjB9RMbTDj7XGgti6Rckr
         ZcgJgKKCbHpqRrwl1T2TaCpRq5EVSz5ObUMdsIBFf+kj3Qa46z9seKhW3cARW7HMP4
         bt7KCvRvcJgTGyau+ES8Ca/Sac6hsTAqUiGJi6q59IHqJ5J7lK9JvswWChrDR7Hzrw
         RoU1gVo6xiK68T/BGWcwH2zVu1/HGIUVZCidvGceCV51GigPgjEchsoSRl89/QTMlM
         jTq6lQ/E3z7wNRBXg2qJrNp9MemOcOo30cepYKUNXe1ekcwBuAlGyiJSBG7jxdBOam
         QBYCNn4+P+Wyg==
Message-ID: <92911928f258ce7d1649b138e71abff90cdf660d.camel@bonedaddy.net>
Subject: Re: [PATCH 0/3] dm raid/raid1: enable discard support when any
 devices support discard
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200419131908.GA22398@redhat.com>
References: <20200419073026.197967-1-pabs3@bonedaddy.net>
         <20200419131908.GA22398@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-yBq2dcpBngBNf7Rpu8FT"
Date:   Sat, 25 Apr 2020 10:46:40 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.36.1-2 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yBq2dcpBngBNf7Rpu8FT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-04-19 at 09:19 -0400, Mike Snitzer wrote:

> You went overboard with implementation before checking to see if your
> work would be well received.
...
> I haven't looked closely at MD raid in this area but if you trully think
> underlying MD raid can cope with issuing discards to devices that don't
> support them (or that it avoids issuing them?) then please update
> dm-raid.c to conditionally set ti->discard_supported (if not all devices
> support discard).  That is how to inform DM core that the target knows
> better and it will manage discards issued to it.  It keeps the change
> local to dm-raid.c without the flag-day you're proposing.

So, now that I know that my approach to this was completely bogus,
what *is* the correct way to safely enable mixed-discard support?

It seems to me that the right way would be one of these options:

 * a sysfs toggle for the block layer
 * an=C2=A0lvchange based option for the dm layer

I'm leaning towards the latter for my personal use-case but the former
would make Linux much more flexible but would touch more code and have
the potential for more damage.

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-yBq2dcpBngBNf7Rpu8FT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAl6jpIwACgkQMRa6Xp/6
aaOrrg/+JpSOuup2HurdD9NIAtht/hAlQukVyB8jLF79Y7TiRBj/bGBL3bNFyeu9
9onyY8oKkJNxz2lDP8TX/RthuQQPe4mKIK1naHwZn2v1HGSCCCT0+QuzNOks4FEi
Az+GqNWR3ICss7z59I+4Llq4iLpZx+Zpwe0RtRb9wHoml+RmIN15fh4LzyHlL/+N
go55fQ7wgTcd2V8q0yeleOa6GGpJSr4wAX3GfS7CKHMRunT7TSBrlJnI8Qqt3G9i
+92GpoPbpHBDszeLbTNllCBrx5XsJjdBC5CxTuin4MS1LFZpgEHJpKKePyF5mPge
XlzvbPQlqh6CXNfsGx1c89CEkITvPkmd9ROdSliFE2Gmu8kDN9lWhf3Vhu9GCAzH
7qaJPzK5zYOmQXxRmyaqZ2fqMckWnJhm14toMtb8bIHapwCVXBGfpsBrk6hsXlwB
Ur8nCiDZJAhnrwfPp0VmGpi917vSOF0sp+t9MkdSoj40b58hhwoyyH9rnrtmpEAH
9GE9Cg7iad5fs4+JEyOIXu3HIyoRpCMIAAvvohJltXSSkrN/ww0qr5WOef9amVKs
q/lhcKixRahAn3kfuLd8ecAaPOVlhx/CqB0X/D5xTS+1KFVOdnE2FDbsGKpXRVwA
VSq68JP+twI1qoGxaC+wuH3iPFHAVXgRsRDzMQ0kjEfzS1gN7D4=
=XHKy
-----END PGP SIGNATURE-----

--=-yBq2dcpBngBNf7Rpu8FT--

