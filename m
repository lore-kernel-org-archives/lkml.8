Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2487C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B52C2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gEp8EKx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgBEFpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 00:45:21 -0500
Received: from ozlabs.org ([203.11.71.1]:40697 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgBEFpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 00:45:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 48C9Wd28wGz9sSX; Wed,  5 Feb 2020 16:45:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1580881517;
        bh=/noY0+RuU8DVdLLYBpqd52ZZqO1Trq7Gfq6vEaa+fYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEp8EKx/wFQtxFRErKJAOn30RfGAUoWR3Vdhua/241KyEfi9OeJXXJRCZFUmhurtw
         TPKXC0Ld9l9g41GeNMnWS9DOYxAEZz/eGGVa8frzkOnThqh65hLd2y5BG0m/A7z/CY
         yLIdOd4XmlYaVkJz25vX/Mv9uPUcb5deNl9UhvSo=
Date:   Wed, 5 Feb 2020 16:45:08 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] libfdt: place new nodes & properties after the parent's
 ones
Message-ID: <20200205054508.GG60221@umbus.fritz.box>
References: <CGME20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd@eucas1p1.samsung.com>
 <20200204125844.19955-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <20200204125844.19955-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 01:58:44PM +0100, Marek Szyprowski wrote:
> While applying dt-overlays using libfdt code, the order of the applied
> properties and sub-nodes is reversed. This should not be a problem in
> ideal world (mainline), but this matters for some vendor specific/custom
> dtb files. This can be easily fixed by the little change to libfdt code:
> any new properties and sub-nodes should be added after the parent's node
> properties and subnodes.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

I'm not convinced this is a good idea.

First, anything that relies on the order of properties or subnodes in
a dtb is deeply, fundamentally broken.  That can't even really be a
problem with a dtb file itself, only with the code processing it.

I'm also concerned this could have a negative performance impact,
since it has to skip over a bunch of existing things before adding the
new one.  On the other hand, that may be offset by the fact that it
will reduce the amount of stuff that needs to be memmove()ed later on.

> ---
>  libfdt/fdt_rw.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/libfdt/fdt_rw.c b/libfdt/fdt_rw.c
> index 8795947..88c5930 100644
> --- a/libfdt/fdt_rw.c
> +++ b/libfdt/fdt_rw.c
> @@ -189,19 +189,27 @@ static int fdt_add_property_(void *fdt, int nodeoff=
set, const char *name,
>  			     int len, struct fdt_property **prop)
>  {
>  	int proplen;
> -	int nextoffset;
> +	int offset, nextoffset;
>  	int namestroff;
>  	int err;
>  	int allocated;
> +	uint32_t tag;
> =20
>  	if ((nextoffset =3D fdt_check_node_offset_(fdt, nodeoffset)) < 0)
>  		return nextoffset;
> =20
> +	/* Try to place the new property after the parent's properties */
> +	fdt_next_tag(fdt, nodeoffset, &nextoffset); /* skip the BEGIN_NODE */
> +	do {
> +		offset =3D nextoffset;
> +		tag =3D fdt_next_tag(fdt, offset, &nextoffset);
> +	} while ((tag =3D=3D FDT_PROP) || (tag =3D=3D FDT_NOP));
> +
>  	namestroff =3D fdt_find_add_string_(fdt, name, &allocated);
>  	if (namestroff < 0)
>  		return namestroff;
> =20
> -	*prop =3D fdt_offset_ptr_w_(fdt, nextoffset);
> +	*prop =3D fdt_offset_ptr_w_(fdt, offset);
>  	proplen =3D sizeof(**prop) + FDT_TAGALIGN(len);
> =20
>  	err =3D fdt_splice_struct_(fdt, *prop, 0, proplen);
> @@ -321,6 +329,7 @@ int fdt_add_subnode_namelen(void *fdt, int parentoffs=
et,
>  	struct fdt_node_header *nh;
>  	int offset, nextoffset;
>  	int nodelen;
> +	int depth =3D 0;
>  	int err;
>  	uint32_t tag;
>  	fdt32_t *endtag;
> @@ -333,12 +342,21 @@ int fdt_add_subnode_namelen(void *fdt, int parentof=
fset,
>  	else if (offset !=3D -FDT_ERR_NOTFOUND)
>  		return offset;
> =20
> -	/* Try to place the new node after the parent's properties */
> +	/* Try to place the new node after the parent's subnodes */
>  	fdt_next_tag(fdt, parentoffset, &nextoffset); /* skip the BEGIN_NODE */
>  	do {
> +again:
>  		offset =3D nextoffset;
>  		tag =3D fdt_next_tag(fdt, offset, &nextoffset);
> -	} while ((tag =3D=3D FDT_PROP) || (tag =3D=3D FDT_NOP));
> +		if (depth && tag =3D=3D FDT_END_NODE) {
> +			depth--;
> +			goto again;
> +		}
> +		if (tag =3D=3D FDT_BEGIN_NODE) {
> +			depth++;
> +			goto again;
> +		}
> +	} while (depth || (tag =3D=3D FDT_PROP) || (tag =3D=3D FDT_NOP));
> =20
>  	nh =3D fdt_offset_ptr_w_(fdt, offset);
>  	nodelen =3D sizeof(*nh) + FDT_TAGALIGN(namelen+1) + FDT_TAGSIZE;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl46VmMACgkQbDjKyiDZ
s5KD3A//U4sv8jVoLxP+/L5hprNKU/EkWN2F3K31m0Tw7YXZeL3SyPV5rbzVqsHW
lYZ/VxuBU0huHffaPnSsXe7JOwmr8VZB+aueXNbFtgxggAqa2b+o8XZ2ILYEBufU
DjiZdN90fPalirsO9duLSTSVPCdZ9qEzgf9l5ts/xnrDNMngDfs2ZXjbJ+IcFEAs
G72pB+PGFz1s5FRLxMQBwlS32om4zQ5sGmYxLkt0C1b7i4hkRhU+aWJyAfLnak7i
8DZyJMXeC9wue4u4/4Z+rx/cRESXHvaRya8vtRQN/dVeOliI2PTw4rv9K3Hvtojg
v/ibSIK/9fIIz/4s1i585QInjsSoOHuQXRdy7y+MOfXKdpbWZaQVzS8Ya7IDLOo1
zxyv1InDzp72gWos2ZPd0KlPict2sFzZx6ua2DPWuguvO5b3kk44y+tmfKhqIX5j
gtchr6iRQK5HTfGPmyCDDhmzY1rpeA23keKHyALlrk08BgCYdnCN3ZsJ0jLKGrU7
Pk/nBi/UUc+seVy34TDLtCp+sL5E8UP14hFymSXeDFY10b+JzRXEvzjjE8U5hjeA
rUnOKvpTTSGaY3b/ZQKWx28OL3G1riWHCbh7y4xGmft9KH5jM7RuGbOyb1j/ERKD
YyOpNvvwTA9eCMgOsygwcoZzW/66ag5304TELK+ejdN90Pk9ttg=
=3XED
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
