Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5CCC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 01:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FFE21739
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 01:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RJhq8Mah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgA2BZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 20:25:41 -0500
Received: from ozlabs.org ([203.11.71.1]:44195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgA2BZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 20:25:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 486m5C6Pkyz9s29;
        Wed, 29 Jan 2020 12:25:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580261138;
        bh=bNk4+04lZrrQBvhTZxDuTUNrFeZd4M8y80KF6+f/G6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RJhq8MahjkRuDkbjdqvqJykdgLR1D6IR0d68XayASh7HLJfyn9+T60k6mCM5iNIUO
         OfFlyna5UmHE68VHPs/z5usSUyaK3Mba1fW67SnzOyxs7FRkPg9s7CxryAJ5mY4fCp
         WoNbFgPNHtM6DBm8u63UeEqAwssBeJx+y0M3dAqsI3wvWybdGm8eynWiQAHgA0d58j
         KHifPwPkIN5rwDy1w0tLroznv/dPbO58/ZDgo0J9qJs5UoqwsHb5A2Cu4nHq/7nojP
         zpy9z0MrovXjIY1BAmg1Nf2SCu5zgLqUICZMgyd2H9SRiY6Nm3f1eHXEN80qMhF1rC
         JvxRjy4q62EFA==
Date:   Wed, 29 Jan 2020 12:25:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jamorris@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: linux-next: manual merge of the selinux tree with the keys tree
Message-ID: <20200129122530.7d4659f6@canb.auug.org.au>
In-Reply-To: <20191210105037.085b3418@canb.auug.org.au>
References: <20191210105037.085b3418@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AqXG295sS9XOYlLq+q3g.f+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AqXG295sS9XOYlLq+q3g.f+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 10 Dec 2019 10:50:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the selinux tree got a conflict in:
>=20
>   include/linux/lsm_audit.h
>=20
> between commit:
>=20
>   59336b0f8000 ("smack: Implement the watch_key and post_notification hoo=
ks")
>=20
> from the keys tree and commit:
>=20
>   59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
>=20
> from the selinux tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc include/linux/lsm_audit.h
> index 734d67889826,99d629fd9944..000000000000
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@@ -74,7 -74,7 +74,8 @@@ struct common_audit_data=20
>   #define LSM_AUDIT_DATA_FILE	12
>   #define LSM_AUDIT_DATA_IBPKEY	13
>   #define LSM_AUDIT_DATA_IBENDPORT 14
>  -#define LSM_AUDIT_DATA_LOCKDOWN 15
>  +#define LSM_AUDIT_DATA_NOTIFICATION 15
> ++#define LSM_AUDIT_DATA_LOCKDOWN 16
>   	union 	{
>   		struct path path;
>   		struct dentry *dentry;

This is now a conflict between the keys tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/AqXG295sS9XOYlLq+q3g.f+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4w3woACgkQAVBC80lX
0GzElAf+KEy7SHAbO38xCJdlsXNy/wNDUDp5cWwrraYJbV1gXViajkHtlPBsTDre
P8AJsXSBLbLUg0glDpIFJfVueC6P5y5JacBrcOh2vRjq96K2KnHdwTY7GZfdYb8y
re4mkNQsblh6pjRZAWpjwOn0I/n79fiPZD1nSBIvQnA29cU7CMd/G2JyQG/Njdc6
IYQBMhfXDOU7jQmFOIHWOISqTYFYufxIIZvnUqJBvh8YIQ2AXqwAt+jw2IYzx6Og
S6Csu00TYvzQ+HLE9V90kc/KEzfCM0hsb2zvFhaIIoWJiV9Upv3cZOwe5HMSCHDf
UlhhcIoYtZuYbCI+sVRDjJ23OZwOVA==
=/lgy
-----END PGP SIGNATURE-----

--Sig_/AqXG295sS9XOYlLq+q3g.f+--
