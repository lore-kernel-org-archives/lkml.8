Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F917C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A1E20786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrpLtn8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgGKPLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 11:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgGKPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 11:11:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2CC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 08:11:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so3844333pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lbJbJXyaa2RJSRZCkASSTZMtfB5x5A2cZspWwqiACVA=;
        b=VrpLtn8BFfqScK+tfsGIQIM0I62BHK7OEuBdoY9pcFhvzT5ES86WFeUflbJhIgxglL
         WshaO2OUM0C2mTqYrXp2sqW0kqFZvb4CS3RkJ3Sig4YEDRprWE6SOV4U4BvjZ3DdPD7R
         I6dISToOqhIcGSxDjRRZ8gzPnrVk1mNWLDmKaXOM4INSdN6j82JACqZA1/g5ywnnHVTJ
         F5OJsx7Xf9u1Gidm0bvqOhmkh09hHlIFxSuxrt0yL7Vcm2uwdEI6/hMZK/vdiDscCkf3
         hzORaculqZoLGkYPfURxYpGwEczH9j7DAKkClcgf/bKUukWVUgovy8GYCLpghG3BJBd4
         Z23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbJbJXyaa2RJSRZCkASSTZMtfB5x5A2cZspWwqiACVA=;
        b=Jm2mTPAbLLYuIJGQ72WB0w8ExAoXdjGGn3EuaDQPDY1Y69sWAr07xXw0sLZdQVWF4w
         bhYMJA2slYGmKmhPVjVm0+W7Dzq0gna690YWCOaSLxcBuD0vq4WOrRuHtXBB0kdOuMOP
         fs+39KVQ4qV0CFQ+ylHXMOw1HvJRETlYYUVqJvUOxusIL8tkNNeMombARvd3e1YWxhSl
         9uK28/AgP2jleGoMackoHu2Ch1FVuZt80+HsIjk/vsHJUI0SY6fnL7GOFkpwSrAFXwwB
         2uourIvvDW7TjxpAKUnm0abiWsterQtZAhIXfLXcFY1uytcaKVsIJ0lmrEW0wAio+w72
         vVDw==
X-Gm-Message-State: AOAM531muiOEAKHaA5DPILLIneQLq5MTjzgZx/gnoJqnuPNWapA5Lg8m
        xFuj25O6Wc7XaoE/oeui6n8yJ/FoH7rc8Q==
X-Google-Smtp-Source: ABdhPJzB/u0gPEdFobOYA9ljn5l2yp9NGc+p6o9q5exxeNn3ErV37CKcmUyYZSxZd55mv0+Teun/kQ==
X-Received: by 2002:a17:90a:1d06:: with SMTP id c6mr11678465pjd.194.1594480302299;
        Sat, 11 Jul 2020 08:11:42 -0700 (PDT)
Received: from blackclown ([103.88.82.158])
        by smtp.gmail.com with ESMTPSA id u66sm9156189pfb.191.2020.07.11.08.11.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jul 2020 08:11:41 -0700 (PDT)
Date:   Sat, 11 Jul 2020 20:41:26 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] drm: core: Convert logging to drm_* functions.
Message-ID: <20200711151126.GA12262@blackclown>
References: <cover.1594136880.git.usuraj35@gmail.com>
 <20200710175643.GF17565@ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20200710175643.GF17565@ravnborg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 07:56:43PM +0200, Sam Ravnborg wrote:
> Hi Suraj.
>=20
> On Tue, Jul 07, 2020 at 10:04:14PM +0530, Suraj Upadhyay wrote:
> >=20
> > This patchset converts logging to drm_* functions in drm core.
> >=20
> > The following functions have been converted to their respective
> > DRM alternatives :
> > dev_info()      --> drm_info()
> > dev_err()       --> drm_err()
> > dev_warn()      --> drm_warn()
> > dev_err_once()  --> drm_err_once().
>=20
> I would prefer that DRM_* logging in the same files are converted in the
> same patch. So we have one logging conversion patch for each file you
> touches and that we do not need to re-vist the files later to change
> another set of logging functions.

Agreed.

> If possible WARN_* should also be converted to drm_WARN_*
> If patch is too large, then split them up but again lets have all
> logging updated when we touch a file.
>=20
> Care to take a look at this approach?
>

Hii,
	The problem with WARN_* macros is that they are used without any
drm device context. For example [this use here](https://cgit.freedesktop.or=
g/drm/drm-misc/tree/drivers/gpu/drm/drm_edid.c#n1667) in drm_edid.c,
doesn't have a drm device context and only has one argument (namely !raw_ed=
id).
There are many more such use cases.

And also there were cases where dev_* logging functions didn't have any
drm_device context.

I would be very glad, if we came up with a possible solution to this
problem. I think we should develop drm_* logging APIs which could print
contextless logs (which would possibly be midlyering) or give every situati=
on a context.

> Also please consider if coccinelle can make this job easier.
> There is a lot of files...

I totally agree with you. I will remember this next time.

But here, in this patchset I have tried to convert all possible
cases of conversion, i.e. I have changed logging wherever there was a
drm_device context.

Thanks.

> 	Sam
>=20
> >=20
> > Suraj Upadhyay (4):
> >   drm: mipi-dsi: Convert logging to drm_* functions.
> >   drm: mipi-dbi: Convert logging to drm_* functions.
> >   drm: edid: Convert logging to drm_* functions.
> >   drm: fb-helper: Convert logging to drm_* functions.
> >=20
> >  drivers/gpu/drm/drm_edid.c      |  7 +++----
> >  drivers/gpu/drm/drm_fb_helper.c |  2 +-
> >  drivers/gpu/drm/drm_mipi_dbi.c  |  4 ++--
> >  drivers/gpu/drm/drm_mipi_dsi.c  | 15 +++++++--------
> >  4 files changed, 13 insertions(+), 15 deletions(-)
> >=20
> > --=20
> > 2.17.1
> >=20
> >=20
>=20
>=20
>=20
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8J1pYACgkQ+gRsbIfe
746Vlw/8CtZ9XbPZ/Iyno9amywRwx9keWlGzO8cypYgKaz46i/ez9jMqhkgsOvm8
EFv/TYk5rNnxe46XDSMM1NL+HhrXjZMBtu9eMLQNV/MlA8U/bgxLZVDo7BOizIk9
eBVDF9U8rvw3Y5HjUP6v0pDoHpKiR0r6/Zxa7AvGh6uFugIfCUU/qelBkFoAnlkA
3KHTnqgHZTlpdmMgmIwpasya1bPvm4TV60m5WaN+Gz1pWbqyAOqlroKOaHqoFRcs
yWCqUw109yOQqHVFJ1SHFTAsBtUcrx3ndbSj4GiWsprQBI1OFBngxfFjprxgTD6a
lyp2c8tWDm1kwJv8HHfFGyUG8uYaUfjxQw9bstkPdhp9z0YaAUOlpXj9uf/bQRIV
71M6febZ1+zEyEm+sVgbgxGwLz7GBc9Efp0tNryDXGfkZBXilxzi7MDEKm/M6SW7
OEXqls0XJS9kwLd8APdIokiWvM/3KJ9o65MPn6kvztcoXkoc8sxyUhKC8QmCMX7T
ijdanU91MirbNlgF/mAnLXSHSDfm2lh3xUWHgAPkvOe/tIb9j16P+71yM9bZdmj1
fS3dpzlRrHGEFQTRvBRMwr5X4HyrF9YNCe6gn46TzW6GQmdFnG6F0rngd7p8vN/9
g/hAC8NcFwnS5eVhVecAUp33OkxIy4x26F0CuONdbP7GXHvhdew=
=XNjR
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
