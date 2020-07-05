Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AAAC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F6A20786
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pfbwCs8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGECMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 22:12:22 -0400
Received: from ozlabs.org ([203.11.71.1]:44165 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgGECMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 22:12:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49zsfB2YCNz9sDX;
        Sun,  5 Jul 2020 12:12:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593915139;
        bh=vwnnKMyZrTpW7w+SdE5IXRrmpVoxMrOeXk7C5SUmqrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pfbwCs8G5THIaqEn8nMjErW3AjeCdWX/YxzdjoppDLbbKsd9/44jTqGC9FC5nFqjW
         /YVGIHffs2zFwZo0uofv2zcxX2nrZRIgMuK9gdhGWHhiykeIc1AaUAALrMN3wZWc6D
         unaJHa59+BtLwUD049fema02KiZlmg46hMiXgEkKHbd04rYcuIwq+ouFk+PE6XmQLN
         G95lf+Of1aRje3/fZoUUSkHaQIblpCsCPhoTcHE780dUjV0ydQe1hJxro9M8KHu8lg
         dy4YLd85l4UGg99Ho6M4He0S1e8rggVaQ68bHCsn4U20HApeVpiTX0Iiq71v6xivsC
         YJcpMvl5akZcw==
Date:   Sun, 5 Jul 2020 12:12:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200705121216.2ce2dd46@canb.auug.org.au>
In-Reply-To: <CAPM=9txOgRYc7RM3fzohB4=Ejcp_xMGLBX_OOCOD=r+W6D678A@mail.gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20200705064348.71d4d51f@canb.auug.org.au>
        <CAPM=9txOgRYc7RM3fzohB4=Ejcp_xMGLBX_OOCOD=r+W6D678A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CqvUgYhwibKZHF3CRkWP5Zx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CqvUgYhwibKZHF3CRkWP5Zx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sun, 5 Jul 2020 09:34:57 +1000 Dave Airlie <airlied@gmail.com> wrote:
>
> On Sun, 5 Jul 2020 at 06:45, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
> >
> > On Sat, 04 Jul 2020 13:02:51 -0700 Dan Williams <dan.j.williams@intel.c=
om> wrote: =20
> > >
> > > +The Linux kernel is a global software project, and in 2020 there was=
 a
> > > +global reckoning on race relations that caused many organizations to
> > > +re-evaluate their policies and practices relative to the inclusion of
> > > +people of African descent. This document describes why the 'Naming' =
=20
> >
> > I feel a need to point out that racial issues are wider than just
> > people of African descent ...  Also, others have pointed out that
> > slavery is not just restricted to those of African descent. =20
>=20
> The racial issues are wider than that, and even wider again I'm sure,
> but in 2020 this is as good a place to start as any, and the trigger
> as that sentence says was in 2020, there was a reckoning about it
> mainly due to people of African descent. That trigger has had flow on
> effects in other countries, but I'm not sure that sentence in any way
> diminishes that, it's merely an introduction to why this change is
> happening now.

And reading it again in the (actual) light of day, I see you are right
and I misinterpreted this.

> As for the non-black slavery, others have never pointed this out

(I did not say "non-black")

> before in 30 years of master/slave terminology? surely if white
> slavery was as big a problem, they be as supportive of this, even more

(nor did I say "white slavery")

> so. It speaks volumes that I've never heard white slavery as a problem
> once in 30 years, but now I'm hearing about it a few times, and
> somehow as an excuse not to support this.

I was merely referring to some of the posts in the
users@linux.kernel.org mailing list.  Also, I made no statement about
my support (or otherwise) for any of this.

--=20
Cheers,
Stephen Rothwell

--Sig_/CqvUgYhwibKZHF3CRkWP5Zx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8BNwAACgkQAVBC80lX
0GzhnAgAjQB3N5aV+x1W1bH5/WwgEKcf2RvK87COk/sRZC5uYF3pYb1eqhRkf5DQ
hkvx3PD+AaTWAm1aADbqHiCuqX4lwr84yGyPmSKQD59yX3sX1YTv0Es3PsdYUmTJ
hx6d+oaUdg7wdP5plhYLtu3ywPgP4jNQQ/h822JUkyBYngjKylvbpwUQOiR9bpNS
n50BKQRU4zcRFO51B0toKLCJtCwn/FWz0UHUEqurp9sdFcsNCgLA/XVbRHhbgVgc
kkv7ZkriIWb/ENiu91yDDq8lHfKHFBp0sQZGy7nm08JtpEdwCxRLTSwHF0P8e5hH
EqeOc77j8/zBdGjCL3v46WZJai8FHQ==
=oAjh
-----END PGP SIGNATURE-----

--Sig_/CqvUgYhwibKZHF3CRkWP5Zx--
