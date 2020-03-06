Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D769BC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF26E2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTpAGJks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFQSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:18:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45228 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgCFQSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:18:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id b13so2329169lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 08:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=Z+TJMGEeVoGtC49ptXlQFv7le4nU8temgCblUT4vbVU=;
        b=mTpAGJks0WsFlELSXp3Du/jidQlD93dWjc024/xOuNY30kBjARicDYFfvmosqSZXyq
         IDx7jqBxS5J0xYtZe5jG8pEPuKBu/z6SNrj52+Bz9YmP0+nWu9kP60a57/4W4TqkLv+9
         yvCmE6DDVl5vEy36xyI0gv68OW3yDlcKJ00hDSQNEBUqBoQhAYfllOVlQ62fQtad5Hhn
         WIqGlIDQSbO7Nvp9Q2aGjkRGlxGxV1nVe4Xs4JXRuJEDT0Smb65gC5Bb8tSz1aX+73io
         b/Cdxdkkqg9u1B0i5fYuaRtR+7NTH6brln6Zg0pnSQql7QdNlM6ktmv/0s6X0QFmCg2d
         XKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=Z+TJMGEeVoGtC49ptXlQFv7le4nU8temgCblUT4vbVU=;
        b=a0wPEMKADjKQcYAJi+tUpJiB4qYBZb21hyJlfEFta3HAAXn27oaiYV/ib1f74ULi6w
         s1wIvtpSQoQpdfo5aMEeHsjy5hM09ihH81SD0+bLIMwMg78vdKCO/W9R/q4Aw67lDI/5
         L/Nnr3sjnlTHgQGl5lL9xtdykqX8odLGhDAlyurGipc1POI2xlMYhi0CAIhd7Ih8tEdi
         qlbqLsCETTo2MFqOiB3FXQp0stZrHWVhX/0W7ThzIZQnfvCQWprKNzylKHLkNYF6vv2z
         kxSrc5/A+CzK9TrvnRfj9y2O5UTg6f0AX+QkWlzhecuNNnsFL8R1z3NNYHFdqTVeeEt7
         HHtg==
X-Gm-Message-State: ANhLgQ13MbanWOclvLpsjCwTQTz20zzis/55pF37c+CMsu+ch89t8l6W
        I52jp0V9NtSzM8wOl8lisr4=
X-Google-Smtp-Source: ADFU+vuwI6V8yMCkBVEfEewYfNim0qzEgKl4clXc2U7TnaM4A3YLgo87+3yB8AqQvMGoDHbSLJ1YPA==
X-Received: by 2002:a05:6512:108a:: with SMTP id j10mr2458169lfg.35.1583511478908;
        Fri, 06 Mar 2020 08:17:58 -0800 (PST)
Received: from eldfell.localdomain ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id j26sm17383971lfm.3.2020.03.06.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 08:17:58 -0800 (PST)
Date:   Fri, 6 Mar 2020 18:17:47 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] drm/fourcc: Add modifier definitions for describing
 Amlogic Video Framebuffer Compression
Message-ID: <20200306181747.5dbda69d@eldfell.localdomain>
In-Reply-To: <27d09559-055a-7bf3-0f23-9948da0e1f76@baylibre.com>
References: <20200221090845.7397-1-narmstrong@baylibre.com>
        <20200221090845.7397-2-narmstrong@baylibre.com>
        <20200303121029.5532669d@eldfell.localdomain>
        <20200303105325.bn4sob6yrdf5mwrh@DESKTOP-E1NTVVP.localdomain>
        <CAKMK7uFgQGrnEkXyac15Wz8Opg43RTa=5cX0nN5=E_omb8oY8Q@mail.gmail.com>
        <20200303152541.68ab6f3d@eldfell.localdomain>
        <20200303173332.1c6daa09@eldfell.localdomain>
        <20200306101328.GR2363188@phenom.ffwll.local>
        <27d09559-055a-7bf3-0f23-9948da0e1f76@baylibre.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QRgxWOW3=LdfxDd168gPaIX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QRgxWOW3=LdfxDd168gPaIX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Mar 2020 15:40:01 +0100
Neil Armstrong <narmstrong@baylibre.com> wrote:

> Hi Pekka, Brian, Daniel,
>=20
> On 06/03/2020 11:13, Daniel Vetter wrote:
> > On Tue, Mar 03, 2020 at 05:33:32PM +0200, Pekka Paalanen wrote: =20

...

> >> Sorry, it's waypipe, not pipewire:
> >> https://gitlab.freedesktop.org/mstoeckl/waypipe/ =20
> >=20
> > I do think this is very much something we want to make possible. They
> > might pick a silly modifier (compression modifiers only compress bw, by
> > necessity the lossless ones have to increase storage space so kinda dumb
> > thing to push over the network if you don't add .xz or whatever on top)=
. =20
>=20
> The AFBC, and Amlogic FBC are not size optimized compressions, but really
> layout and memory access optimized compressions, without a proper network
> size compression, transferring plain NV12 would be the same.

FWIW, waypipe is not intended to be the most efficient network
streaming protocol, but it is intended to be a direct Wayland protocol
proxy (X11 forwarding, anyone?), which means that it needs to be able to
transmit also dmabuf buffers as is. It does not want to understand
modifiers but just send opaque data.

It may or may not do lossless compression of the data it sends over the
wire, but it will replicate the dmabuf on the remote end.

Or so I'm told.


Thanks,
pq

--Sig_/QRgxWOW3=LdfxDd168gPaIX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl5id6sACgkQI1/ltBGq
qqd8PhAArj8wtOHDFlSHaRYFMSEtCurAGSLkUTpmQWl6J1kvS7Stv5XI9jgfSCws
IITQFVQc/DxIvzf4KO9zECMi+oIrhw3vyrvJEIErhE6LuZdqgR2MNP3ATNBKU8WR
OTEawk87ZvZQENGUYPiV9R3uF0+yr2Qlz2FqmizM8lD6fmWXV1QBBKr8AgkZ+/qK
E4e6GRAn+3mBZLS4dxEeU/pATGoZNnOoMpmp/z27AIaibtN88Qpzxy+WtyYUREGm
oTjidQaSOgwEt8nDdhdTFCfZcN4HwH8n5p5JleSvKVziTQlTy5IQZasa5ViuX0wB
eC+x6OmdrxZ0wBuDfZBp26jKmWP3QDxfwaL+QCRnor+9Ao7Tty9MoGVAbPuy1mwc
SzJpjIYsY0OGIjp6OL/Isi5wPZbawkeifutoPVdo9o9PdRIzhR3PJtoOZPN8Ywva
yFP28GivCkapKxSlM3NDDjzA5dT+rUFEeBGurXuZqPZe9rKocN2CmXQ96wsmYJ/a
WMsJNg7EiswQoUf/JadWfm5dpSK42wyGGs9M1i6yRpTo+QGGzQVkmT5Kx7uLAd+p
vuYVc+bNjwNeELU4UhEBXZVWM3n7l7OIcL38NshrnBhdOs0Zy/ElXnSmHkgpccbv
sfZp+i8Id5jdyzKGwzbFsG8OQ/zlUyM9B7yhHhejzP7Q482a3gA=
=KY6f
-----END PGP SIGNATURE-----

--Sig_/QRgxWOW3=LdfxDd168gPaIX--
