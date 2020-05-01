Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B8CC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F5820787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qzf1LECE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEABGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbgEABGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:06:03 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A5C035494;
        Thu, 30 Apr 2020 18:06:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49CvFh1bFHz9sTH;
        Fri,  1 May 2020 11:05:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588295160;
        bh=v0flVtzu+OavK2MLo/UvmLQv3IBkly+1Z+AnmWJBmJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qzf1LECEWDCYn5EzTf2NN6FOMkTyVJNTbGuWRYVc6X9GdIncXWOFmHTgdSZHCTWfO
         redUMu6pK2GtpOoBPoOC5+lFRaQEYqnHD0EULtVYhcpR6NjX38ReMtNMLFsAVszfHk
         Npi4HpXrk96KbnxL7RLgQ72at+zhR9hSV++ss+HzjxLx4ILyZ4WcNUHeELOTwWcmWj
         hVd6VHcOcCGqgeKcnVWAtBc4EyyVk++pJEQo7toPRHPL3AhOsCcqFiLWaJe8M5xYWd
         omuo8PJ7FWwlNcM3NU6o9GgLuJZ90IZJmvlUXFTX9g6xz43CfEz1tWCA63IRuaedzx
         Fqf6TOU7MJG0w==
Date:   Fri, 1 May 2020 11:05:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: linux-next: manual merge of the btrfs tree with the btrfs-fixes
 tree
Message-ID: <20200501110558.586c1d07@canb.auug.org.au>
In-Reply-To: <20200501102453.4b80d290@canb.auug.org.au>
References: <20200501102453.4b80d290@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/va71cq3bBRr9/2=c_pZ7P_h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/va71cq3bBRr9/2=c_pZ7P_h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 1 May 2020 10:24:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the btrfs tree got a conflict in:
>=20
>   fs/btrfs/transaction.c
>=20
> between commit:
>=20
>   fcc99734d1d4 ("btrfs: transaction: Avoid deadlock due to bad initializa=
tion timing of fs_info::journal_info")
>=20
> from the btrfs-fixes tree and commit:
>=20
>   f12ca53a6fd6 ("btrfs: force chunk allocation if our global rsv is large=
r than metadata")
>=20
> from the btrfs tree.
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
> diff --cc fs/btrfs/transaction.c
> index 2d5498136e5e,e4dbd8e3c641..000000000000
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@@ -666,15 -674,17 +672,26 @@@ got_it
>   		current->journal_info =3D h;
>  =20
>   	/*
>  +	 * btrfs_record_root_in_trans() needs to alloc new extents, and may
>  +	 * call btrfs_join_transaction() while we're also starting a
>  +	 * transaction.
>  +	 *
>  +	 * Thus it need to be called after current->journal_info initialized,
>  +	 * or we can deadlock.
>  +	 */
>  +	btrfs_record_root_in_trans(h, root);
>  +
> + 	 * If the space_info is marked ALLOC_FORCE then we'll get upgraded to
> + 	 * ALLOC_FORCE the first run through, and then we won't allocate for
> + 	 * anybody else who races in later.  We don't care about the return
> + 	 * value here.
> + 	 */
> + 	if (do_chunk_alloc && num_bytes) {
> + 		u64 flags =3D h->block_rsv->space_info->flags;
> + 		btrfs_chunk_alloc(h, btrfs_get_alloc_profile(fs_info, flags),
> + 				  CHUNK_ALLOC_NO_FORCE);
> + 	}
> +=20
>   	return h;
>  =20
>   join_fail:


I fixed the missing comment start in my resolution ...
--=20
Cheers,
Stephen Rothwell

--Sig_/va71cq3bBRr9/2=c_pZ7P_h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6rdfYACgkQAVBC80lX
0Gxakwf/QA2erjzSaF7RPztxlQrDk7k5yWcSE2BtbOf0ufq/FaDVozQZnhn58iJ6
XlRGOcUYhEBeZ7MnrM9l3L5Vi3b47AIAUFm347fp7PkMthIFp4yxBFSKBL03btqx
P783I/p7l9GvJjMqtJF9heh9k6TG+2omjvYxIMvCyVTz9bqm9xfZNqO4EHxafFOx
1aoUpT1AYPifbaisxlTDtMP5PRnHht7cFCDiqSSRevplkqdRa0nKM92nNg3iQtdW
LoyfPW8ma3OBFg65IdpZJVc/NJNPWVRbWUemlVHYJd7M5rGOUuFIi6OJyrd/oQn7
rx7hajxBBVeLmgioBIWLKEKTBY7SLQ==
=Q1Nt
-----END PGP SIGNATURE-----

--Sig_/va71cq3bBRr9/2=c_pZ7P_h--
