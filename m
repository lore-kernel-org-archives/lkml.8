Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84AEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDCA206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijbmEEZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgGMN6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgGMN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:58:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB88BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:58:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x72so6040069pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RzG0gy+r2vNEcl0WaEhJKTAZVrC2Cujzezc0qgvRjCo=;
        b=ijbmEEZc0U1Ete5YLn8PkicuWLG3YXrou2hYvyV9ec8hU5Kte7VQbyw2MfVZIBHBek
         tty/agq7us/lE9p74UHCT1M+yDkFhUQcpuDXRe+JfyH1dcEm22bnNCZS2glmz4b888sI
         0RKaHKrQ1EO+/wRG6PdExlxEI/jw18O8+pY+2bgAWG0+x/O3ddw6WSFMW0k2IoolHJV2
         rxxlaleKJVj3cCvYwiPjN5zW2MOrGbkolMIcqa31IgU784oRu0kzmx1ducxhebTrYLLd
         DesIDSj7M5qAyXIb+/V6s3ICMq9i+CLspCnY3rJ3XKPNYq7dIZE6TIJTjQfpTmzrLW/N
         JVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RzG0gy+r2vNEcl0WaEhJKTAZVrC2Cujzezc0qgvRjCo=;
        b=N4qbr58ktdaQGjE3szHK5neZoKDWQ9eo3utT+rDqXdXdcl2mde/tLivBxGDw/JJkVP
         FjABll/XHV+0H1VgoiqztNFyazfUEVQRRMs2IYCYSFqy2okxj0gE0rkvj2CfFCA+ukya
         6aD9CYsmy03M0cqfZ6oEA8X6vKC0AMPoYRbq58qGEnvI/Lyaux7ImtwphxpgHzcWA/rt
         JZBxlEE01Xe3weg8IAn98BWEssinWqJAM0fD7oMECD/vGqpTPV/1mKHg6CC9BSA47gMa
         m0ei+LQhqvC0vDplggP9siBssSh5qz8jaVD0FsNeH3zkaGtM5LzQI1rJU9//51YihlmW
         BOLg==
X-Gm-Message-State: AOAM5322MK40MXQB4I4qyj+9M5DrbsLXudZ2UmO+sz7F6MI6uq9QFgNJ
        Ia/RbjLBiRx6NPh3oniLNYU=
X-Google-Smtp-Source: ABdhPJzvrT2qlr0XwqlovLD9X7yS+H5CdyQ8Zyizq+eIVQqJqzAM2v01kBJoyIvghvtNc+Kh7xl9bA==
X-Received: by 2002:a63:f814:: with SMTP id n20mr66398661pgh.92.1594648703190;
        Mon, 13 Jul 2020 06:58:23 -0700 (PDT)
Received: from blackclown ([103.88.82.220])
        by smtp.gmail.com with ESMTPSA id d18sm14498612pjz.11.2020.07.13.06.58.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jul 2020 06:58:22 -0700 (PDT)
Date:   Mon, 13 Jul 2020 19:28:08 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     Joe Perches <joe@perches.com>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] drm: core: Convert logging to drm_* functions.
Message-ID: <20200713135808.GA6783@blackclown>
References: <cover.1594136880.git.usuraj35@gmail.com>
 <20200710175643.GF17565@ravnborg.org>
 <20200711151126.GA12262@blackclown>
 <04ce5199522b4136909fa4926282b7da8abddc4a.camel@perches.com>
 <20200712185416.GC12262@blackclown>
 <bc58f9b3f11c5da224187fac0eba33f769d0fb45.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <bc58f9b3f11c5da224187fac0eba33f769d0fb45.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2020 at 12:07:45PM -0700, Joe Perches wrote:
> On Mon, 2020-07-13 at 00:24 +0530, Suraj Upadhyay wrote:
> > On Sat, Jul 11, 2020 at 11:16:33AM -0700, Joe Perches wrote:
> []
> > > Perhaps change the __drm_printk macro to not
> > > dereference the drm argument when NULL.
> > >=20
> > > A trivial but perhaps inefficient way might be
> > > used like:
> > >=20
> > > 	drm_<level>(NULL, fmt, ...)
> []
> > > diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> []
> > > @@ -395,8 +395,8 @@ void drm_dev_dbg(const struct device *dev, enum d=
rm_debug_category category,
> > > =20
> > >  /* Helper for struct drm_device based logging. */
> > >  #define __drm_printk(drm, level, type, fmt, ...)			\
> > > -	dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
> > > -
> > > +	dev_##level##type((drm) ? (drm)->dev : NULL, "[drm] " fmt,	\
> > > +			  ##__VA_ARGS__)
> > > =20
> > >  #define drm_info(drm, fmt, ...)					\
> > >  	__drm_printk((drm), info,, fmt, ##__VA_ARGS__)
> > >=20
> >=20
> > Hi Joe,
> > 	Thanks for your input.
> > But I don't think that this change would be a good idea as we are
> > supposed to find or make a substitute of WARN_* macros which
> > take a `condition` as an argument and check for its truth.
> > And I guess passing a NULL to dev_<level> would cause a format warning.
> >=20
> > Also, the WARN_* macros are doing their job fine, and passing a NULL
> > value everytime you want to warn about a certain condition at a
> > particular line, doesn't seem good to me.
> >=20
> > Thus, I think that WARN_* macros should be untouched.
>=20
> So do I but the suggestion was not about WARN macros
> only about drm_<level> macros and possibly unnecessary
> conversions to dev_<level> when a drm_device context
> is unavailable.
>=20
> Also, you don't have to guess, the code is there for
> you to inspect.
>=20
> dev_<level> when a NULL is used as the first argument
> emits "(NULL device *)" instead of dev_driver_string(dev)
> and dev_name(dev).
>=20
> See: drivers/base/core.c::__dev_printk()

Yes, Thanks my bad.
But the dev_<level> usages in drm/* always have a context and doesn't need
NULL to be passed, i.e. some of them have only a `struct device` context wh=
ich
cannot be simply converted into drm_<level> since they take a struct
pointer with a `dev` member and not a `dev` itself.
What we can convert is calls to dev_<level> with a drm_device context or
with a struct pointer which has a dev member.

And, I really want the MAINTAINERS to look into it.

Thanks and Cheers,

Suraj Upadhyay.


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8MaGgACgkQ+gRsbIfe
744wlg/4wLZwyKHITLM4bm58CN5ce653ijU+CbcHY0YzLQIbmTbueBCyt+3O0erS
lyjdwQa9l9IUjrD2+466ZhJuwggkb/3UvRAdxh1IeB1v7i4rhpSbCr+zF1akPFnj
GMCfi7+iHUjFDTG/L7wPkuLE+jpxI0E/QcLka1C2eiPRUTIxz1Kkmpzq0FpDGrEn
n4pofZtfhK6kz0OBTl7IUhOmeP4iIEhwmJFOBv4rwrbaUKQIQcSyf2jYwUhyNg4y
QefVf5RwkKQokrpZnz2BOyX28OLJ0orQkeqTr6TlX5XV7dcP0SeIN4ozPkZ2cIpQ
YKgsosAAecPHrfrU89IzowxOSL4QIzw7qzG0jsSdp3DFfkLUvpo8mP3ftmFlhrq+
tgViXEDt26XmlUetfQIykNTwMPWgptaW6sOlukfbDo1wQWDPEyn5S5XGF4syIanl
tAEbR5UDRkKcI9TA0uhgA9mIwFw6G3qQESES3VkYERSYkfhPlfgqlx/DViqt7gWP
22YXc8PrVvaAfmjcXSEgSnReKmlMOJQwMSVqKLk6MyX0B6QItlqB8zTzeG3SmRTh
NPgxsZNnMq3oQE/JkBGSeKFSDBeq9ScUiXsZskm3r564spfoAuRUq1C21HupibeZ
5ZksYld07k4GrjPalQLybnoKs7IBwTQl27WnxnfOwOHJcqYeIA==
=gvrt
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
