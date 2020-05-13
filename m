Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9740C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD7720753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="xE/MdHK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbgEMIYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:24:39 -0400
Received: from www.zeus03.de ([194.117.254.33]:36988 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgEMIYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=TuuMRaC6ph+2soX/VtZ+XJ7juSkj
        B9c3VyHsHvBaQxE=; b=xE/MdHK7z/Wn74c0o8OnDPeLSj2yPM1dE4i9T34Tfxoa
        R01Ontr2TqdtPeP8tdGNKsQoHDGugL1gatwMRnQALOrD2pq6e8Kiy+krZ3rbOHwO
        kuPUV+vVCB2VpkYmRYuWUwubIUL2TVbbMySkqZ04KLw93pgvIh2MrkOtclRSA4g=
Received: (qmail 3264941 invoked from network); 13 May 2020 10:24:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 May 2020 10:24:36 +0200
X-UD-Smtp-Session: l3s3148p1@3JWDT4Ol8NcgAwDPXwcWAIZZjypw6UMc
Date:   Wed, 13 May 2020 10:24:36 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mfd: htc-i2cpld: convert to use
 i2c_new_client_device()
Message-ID: <20200513082436.GB1043@ninjato>
References: <20200326211009.13411-1-wsa+renesas@sang-engineering.com>
 <20200326211009.13411-2-wsa+renesas@sang-engineering.com>
 <20200415110442.GK2167633@dell>
 <20200512162602.GH13516@ninjato>
 <20200513075659.GC3548@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20200513075659.GC3548@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Haven't pushed for a while.  Should be there when -next is rebuilt.

Thanks, Lee!


--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl67rsAACgkQFA3kzBSg
KbY69BAAgPjqtYCxF1XOt6GPAhgEpYDhwT9r/MnRCdA7j3+Za6738hgijNOlKDCB
Ya8c/7sjowc+a4VwG+TEj8wOEakHeIu/0eZZsL8iIjXjE+yfFDDct8UzDZ6Q8p74
Iv+oXGaE2nlEM/1QzXaA9FmkFnxvdKijT2gQhjj4s1ydTWqZZ/kj+JyOCK4NZ16r
UqK/agkj9C07+j0zAqFqRsmGNbJrjBezG5Gnk/lNUFc29cSmaLtLi3skT9/l6KHX
uEvhSnTfLs/zDYA+R7cJULqINuuCK3yzKrCdNhEQV0rhCv+9so6uYM2MzT4NkR/v
5HNA3LdZKaXPXWapR5yNh+OGPTp8XHac5QUnm0YhtZtrBjZcatqM3zCLwxZwvCxU
0lsYuWuVvSeg5CR8D8uOSvKIxbyD/lYRUMdmIpt7AIALbQcVZmdutFwLVUSvo2eJ
zQUthbm2D0ZJJ1RExYYOQ9BxI3JcBEx+e2C990ziMOYs2FlCR9UN80h0TCgjm4GP
PXgjb7WPu+Yc18NIy6PIdkRGTp6LXs04uXnVgyT3EkRvoDChql4N69vXZZynNvfa
YNCy9kEs5d+n7kFZpnCLVDXgvgezUi2faJsWVfZJgZORitd1rGzjDhWxBuvCDoPG
9sQbLD07pAkrjwaONR0OsEqOjiYIgTm36FPoN7iMnkss90NmC9U=
=LXTR
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
