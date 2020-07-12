Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15883C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E198C20702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuuR4XSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgGLSyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgGLSy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 14:54:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8E6C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 11:54:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so4978150pfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n32EN2ylhUwy1ghntvoX1CHEHXLSWX9Bi5IxzncMNMI=;
        b=nuuR4XSJJ3pEKcLfOKloPVp3SXKRx0h0Cu52boGomkqOORU5EYxnYVs+Ay3ak6UBRC
         HtgZqysyH+8XrFIjPeOVKQ3Cz3VYLVAsyvLotSJFhdmDqWg/jnKQtAi8fAk8qEsM7cyz
         rPzMt6PD6TP15r5hsE+F9eyTVhoyh1hBQpRkpPGc67aaocK0p61a148Kqc0p2i0+oI3K
         5dE20wnNUBIyShmkfZuq3b1eOxlk2T2H+WlbjtrKNoAwAmVCH1lJPy8dx/0qYB+BTN6w
         V6SDRUpDx4qS+kKUmS9YIyz0Qzi7SQw9yPBUSbL20z9SselPLBXOuLwlyhhBiP6MHiI3
         Z2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n32EN2ylhUwy1ghntvoX1CHEHXLSWX9Bi5IxzncMNMI=;
        b=fIrb5pHKMLn0PrXz9MYX9z9VSMHOvjUXHvDUIKOHGOgGFefHRY/7tB2e2+oV5S+TxL
         9JSdRYg4kl0NfJ/OTSgpAYd3yKdga1mSH9NwWm12IS3+5XakDdQwkTtI0lA2pxRGS2q6
         GJHn7iL4o4qfAymf1zymfXyNBCpgM/n4xkO+FZGZwwr2WvTGLxtgOAvrX3SyFAejgoyG
         NNHtjhdtgUgrYLt8l/KblSyHiY7iLEA9JcMY3UDo+3JDu5aYppih6sH+p3PILe+1L7+U
         PNGz83O/3Ze1pcoNDh0Dz5Nc54Ql4BL64bQHdjbxkUYxhriaKKM+ZjSkY9gjFdpVRAps
         4OYg==
X-Gm-Message-State: AOAM531M3/3Xz9e/T5HL2EsQKY9g/lUNUOsLkhA+xsC/NVhNZenKx2DC
        VVQ7a2XWvNWzfe70uec1pTw=
X-Google-Smtp-Source: ABdhPJzUVRCNub7yfyzNy0oAepww7YlSL6cOD8vM16LjGvvoFUjcBqWRdkxdmYDiSsyjmtI1zpSzIg==
X-Received: by 2002:a62:f202:: with SMTP id m2mr60977323pfh.157.1594580066066;
        Sun, 12 Jul 2020 11:54:26 -0700 (PDT)
Received: from blackclown ([103.88.82.220])
        by smtp.gmail.com with ESMTPSA id t20sm12532065pfc.158.2020.07.12.11.54.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 11:54:25 -0700 (PDT)
Date:   Mon, 13 Jul 2020 00:24:16 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     Joe Perches <joe@perches.com>, sam@ravnborg.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] drm: core: Convert logging to drm_* functions.
Message-ID: <20200712185416.GC12262@blackclown>
References: <cover.1594136880.git.usuraj35@gmail.com>
 <20200710175643.GF17565@ravnborg.org>
 <20200711151126.GA12262@blackclown>
 <04ce5199522b4136909fa4926282b7da8abddc4a.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <04ce5199522b4136909fa4926282b7da8abddc4a.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2020 at 11:16:33AM -0700, Joe Perches wrote:
> On Sat, 2020-07-11 at 20:41 +0530, Suraj Upadhyay wrote:
> > On Fri, Jul 10, 2020 at 07:56:43PM +0200, Sam Ravnborg wrote:
> > > Hi Suraj.
> > >=20
> > > On Tue, Jul 07, 2020 at 10:04:14PM +0530, Suraj Upadhyay wrote:
> > > > This patchset converts logging to drm_* functions in drm core.
> > > >=20
> > > > The following functions have been converted to their respective
> > > > DRM alternatives :
> > > > dev_info()      --> drm_info()
> > > > dev_err()       --> drm_err()
> > > > dev_warn()      --> drm_warn()
> > > > dev_err_once()  --> drm_err_once().
> > >=20
> > > I would prefer that DRM_* logging in the same files are converted in =
the
> > > same patch. So we have one logging conversion patch for each file you
> > > touches and that we do not need to re-vist the files later to change
> > > another set of logging functions.
> >=20
> > Agreed.
> >=20
> > > If possible WARN_* should also be converted to drm_WARN_*
> > > If patch is too large, then split them up but again lets have all
> > > logging updated when we touch a file.
> > >=20
> > > Care to take a look at this approach?
> > >=20
> >=20
> > Hii,
> > 	The problem with WARN_* macros is that they are used without any
> > drm device context. For example [this use here](https://cgit.freedeskto=
p.org/drm/drm-misc/tree/drivers/gpu/drm/drm_edid.c#n1667) in drm_edid.c,
> > doesn't have a drm device context and only has one argument (namely !ra=
w_edid).
> > There are many more such use cases.
> >=20
> > And also there were cases where dev_* logging functions didn't have any
> > drm_device context.
>=20
> Perhaps change the __drm_printk macro to not
> dereference the drm argument when NULL.
>=20
> A trivial but perhaps inefficient way might be
> used like:
>=20
> 	drm_<level>(NULL, fmt, ...)
>=20
> ---
>  include/drm/drm_print.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 1c9417430d08..9323a8f46b3c 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -395,8 +395,8 @@ void drm_dev_dbg(const struct device *dev, enum drm_d=
ebug_category category,
> =20
>  /* Helper for struct drm_device based logging. */
>  #define __drm_printk(drm, level, type, fmt, ...)			\
> -	dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
> -
> +	dev_##level##type((drm) ? (drm)->dev : NULL, "[drm] " fmt,	\
> +			  ##__VA_ARGS__)
> =20
>  #define drm_info(drm, fmt, ...)					\
>  	__drm_printk((drm), info,, fmt, ##__VA_ARGS__)
>=20

Hi Joe,
	Thanks for your input.
But I don't think that this change would be a good idea as we are
supposed to find or make a substitute of WARN_* macros which
take a `condition` as an argument and check for its truth.
And I guess passing a NULL to dev_<level> would cause a format warning.

Also, the WARN_* macros are doing their job fine, and passing a NULL
value everytime you want to warn about a certain condition at a
particular line, doesn't seem good to me.

Thus, I think that WARN_* macros should be untouched.

I would like to hear what the MAINTAINERS think.

Thanks and Cheers,

Suraj Upadhyay.


--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8LXE4ACgkQ+gRsbIfe
745luw//XyPTBf7oQOkicJ4KxNNtyTCASs6bhytn8IYynA1Xx6AZ0rAxED3RNegH
oNQ5Iaf/thg65FjD6hv8luJn+vai+rpwwwyJWQSYHdJ1Voa3I9o1umRz38+6AOtD
Xi/Udi3dTm7sRA6e3hVfEdw8Oro08kSkiAQyqaAQjY+cA19FnCjx+zCBBWbSRPd4
i2LemGcIGTdOF7zS5An8+eV6D2mtO+CFidoCLNNEoubBiOqJxYrgAtxEmsIWt5FW
U5g9pQ4eTkAwpPpfbXWq2azG6anxd1IIA04GlIkercseoWviKtQEv7VmGuToUnEu
ViSmIF3/sFwBWpTmkpoPz0DXMK4RWtxLORV/xGevFcdBY/pSSjHGD9brQ8apGtq6
LO9GBGlrXl0MnJsk73jADc2mpFfHevRoiz+DjY6o6D59wCDdNTR0MK3nhBr/aFth
iC30g1yNFPcYal8Lt0g98SeVB1ytQXdXVOefEqhkwLBjv7RcRLs/OovACUQaq3XQ
GO5baQN6oTbfV6ToZdpWkN9foP8wDFFHLw4sJ/JSj+bkJ2tFOoEe32nm7OtinqQs
PROgh9fkRDPSHwYf/17/KtJf1XrOLO6xJtEpLKIi4tfENvilYxZMaRcbp3TgLd7U
2QtxC1i78zDIz1Kifug8j18f+QLrlGmTQyaV8SckZ7ulH5phSuI=
=v7Do
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
