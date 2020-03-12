Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B004C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB2120674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/GTFAZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCLKXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:23:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35282 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:23:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so6327572wrc.2;
        Thu, 12 Mar 2020 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R39Tv+SJk1mlAAPLn4Outf5Cn4fszK3o5vE5appptCQ=;
        b=m/GTFAZpm1PoK9CRxkedOWz96yiMDrmJ4OJvKUBr+fD9DtdQvxc/2FFDnQEt0YStqY
         x9SfI6ajDaK+qNuJbOFFNFVKgFEj++WBuJnMDyLLE74P628Mvp/VhGWeuX7NsqW1lexS
         IB/gOlQ+QDU93dhY624kh22HQ7u4NKtKUweQAhTkzFPsfUbB5gaF/5IS7oGAsBPNEVF7
         krYB/h8Capx3EfkVzEKZrKCjppeElKO4u/h4aNGiQBl90nCAp2gqRZeh8y1BDnjkqB5C
         EFcNfeCEv9KhtVv8bhS56hRrmoHrr3M81QhL1gfOdYG2cnNmPihuI2XJu/bRry6j8WN3
         f4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R39Tv+SJk1mlAAPLn4Outf5Cn4fszK3o5vE5appptCQ=;
        b=e2NXQAvOeaFjiJxHdjpxqFtM6HQZvnLXNvUJeFbpa2zo+7UDGJwZj4kVKJZVQiu+Mq
         PyvMd8+0tStFO4dYDdbfMjCn0le81x5Kbr8Zt7antyAMul13qQGUL5vEn8D1wv1G76WE
         zZwh81z4Nb5KQ98J7G3uGdVfqvIlQQDesu2eujGZ3qFmgUBBvJqA7YhLAxxesxcIQumO
         aXoelmhXf+mK/BQSPGQLn8Hho6QvDugpeUrr2TFa8MAsoACCvsYXeO5Z874I3atetb1+
         8KTa0iBGR0xK2N2enZnDhb651MBwSo6AjyIpATViKJaGHJ6z5zCHULkcl+OX9JWNSpbA
         i9gA==
X-Gm-Message-State: ANhLgQ3WoqaEWrC0UYlXvVwBTV9z37pQTwqlMKd2zl/h3q299MdtFy68
        6dhVtz0i+IoSciUddLgjdBo=
X-Google-Smtp-Source: ADFU+vvIPiE9oEe1sZdLC6ETn26Bj3DUmMFh6IUf3SyWaySqtKrgHzYOT/xCRJ9z9STnzL9EAcaYgA==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr10378257wrx.341.1584008579775;
        Thu, 12 Mar 2020 03:22:59 -0700 (PDT)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id 98sm13500854wrm.64.2020.03.12.03.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:22:56 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:22:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     JC Kuo <jckuo@nvidia.com>, robh@kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        felipe.balbi@linux.intel.com
Subject: Re: [PATCH v1] dt-binding: usb: add "super-speed-plus"
Message-ID: <20200312102244.GC1199023@ulmo>
References: <20200113060046.14448-1-jckuo@nvidia.com>
 <20200210185821.GA1057764@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20200210185821.GA1057764@kroah.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 10:58:21AM -0800, Greg KH wrote:
> On Mon, Jan 13, 2020 at 02:00:46PM +0800, JC Kuo wrote:
> > This commit adds "super-speed-plus" to valid argument list of
> > "maximum-speed" property.
> >=20
> > Signed-off-by: JC Kuo <jckuo@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/usb/generic.txt | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> What ever happened to this?  Did the DT developers see it?
>=20
> I suggest resending please so it gets into their queue to review.

It's been a while and you probably noticed by now, but in case you
haven't: Rob picked this up into the devicetree tree a few weeks ago, so
no need to worry about this any longer.

Thierry

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5qDWgACgkQ3SOs138+
s6FY5xAAwR85ce936jWef2QohmCJ3TQFWmFhJT5xrR4lenXt/X/5CRqHrY/UhFp6
JDh8UTQytoqUiFBx6qEP6zb7uj1VsrA/dD8vw03/a8mJwSWw7P2sXZc0eSRrSC35
G2AAq6JLGMDMcXvIGB8mwGrcrbp717KTYD8umwiBUc7qK5U1STNbMS75FzO6bRtN
7xVk57ED6K9qA76oNVZ2EidzVPTC7l0w/5jBkNwBc3bFwPlxNL/ULtgBYjJAz041
0s069xWv+OGZyxkG10CaRPCi2erXwYiX2WHivnQJQReY1YHVVqmOOJPTeR11YhTc
K01Yc+bbKIpyjAPywPDV0oQrOpMb4QPPCjRFzYVJKK66UfNc/ihmlCdXFlN/51/V
lrV/1/onTP0VKho5LJWfL7S0gJLusbhCBe0TnSnBKpF/R1PW65e6oHqvLUX+Rh/V
dZMF90Z2JzKzMBSeh4y66GXYzyikFqqAGDt7nEPLTarIyBQD4bbggg0nF7ADVzj7
HhfSGyCjLVlz8V4G3FN2JHguA1Htjl4We/D5BjghRWQJFBxAvVphJTFi9PDrc/yw
CH7P4dL1INI4BqJQhxQwpXjJDs4KwS5P4axnBXx9iqXQFTYEWVxOHaX9pKOsI+ix
cEjOltNEzaPJNS13Zm9Z+aWSdG/3BGLbFOwX7Jfuv1ISOcmBNYc=
=k0XA
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
