Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A47C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B118E2495C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GRf/nCr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgEIDr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 23:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgEIDr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 23:47:56 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF2C061A0C;
        Fri,  8 May 2020 20:47:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49JtSn5Zqpz9sSc;
        Sat,  9 May 2020 13:47:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588996074;
        bh=m02LbBy2+JkWay+nbN+60O/7ljndkvEdTtHh+P7Fi64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GRf/nCr8wjkEKe6PBPDFG4gxvs3nkgeSf61uw37zBvUVk7cDfiIF9cCty6ZXbyQ0a
         pakmRxfBjm9LLv04obcyZhO5BBpX9o9eK4UX6yJfJvotU/fDU5FKvJGFuXYCS1xHJX
         rQXk/jj/IVvTMzCXsiwdhSTLteEyybT25W4mqeKOLKmKMID7H0VPF3hU/4J+lfzUX8
         k3ZdX3IlEy7dJWOQ4jTPD960BDDP58y0xIdswUtceXIlbF2MQqzGFD4+HClzWBubyD
         lec4v0vNEA+x21JT2Ttj26C5uiQrDsGsjGjSDqrgh8yKX/xSQAn5/7oMnbBdZlHyva
         SmHL0YVqBQ13A==
Date:   Sat, 9 May 2020 13:47:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sage Weil <sage@newdream.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: linux-next: new contact(s) for the ceph tree?
Message-ID: <20200509134751.147d747d@canb.auug.org.au>
In-Reply-To: <alpine.DEB.2.21.2005090103060.29336@piezo.novalocal>
References: <20200509094515.7082eb92@canb.auug.org.au>
        <alpine.DEB.2.21.2005090103060.29336@piezo.novalocal>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zo3fs2EL+RNQrQGoFzUUzST";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zo3fs2EL+RNQrQGoFzUUzST
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On Sat, 9 May 2020 01:03:14 +0000 (UTC) Sage Weil <sage@newdream.net> wrote:
>
> Jeff Layton <jlayton@kernel.org>

Done.
> On Sat, 9 May 2020, Stephen Rothwell wrote:
> >=20
> > I noticed commit
> >=20
> >   3a5ccecd9af7 ("MAINTAINERS: remove myself as ceph co-maintainer")
> >=20
> > appear recently.  So who should I now list as the contact(s) for the
> > ceph tree?

--=20
Cheers,
Stephen Rothwell

--Sig_/Zo3fs2EL+RNQrQGoFzUUzST
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl62J+cACgkQAVBC80lX
0GwqHgf/UL63SYJyh1jYF7ixBSQ5dZR7NGJIv4KGCHRX+nibjuOb6LMZfZ5hZ2o2
t3UQ/06VwyWHJFGGNPAIdS92dU7usRkUiwS6gQlW3WVTMKN9ZsdRPlRchUCAFfv6
jEckYNkjjjMizgNRnY0uIJhp7Z46JksdThcjMNyMwz4Jyn3nAxX+dp1nprwiT/Xc
U3BmbFA+nHswdA0EYIpI26SPnMXmfssZkZ0sKPsLDl1wx7GyWPDTmykhVYHiZZNj
soTxDufCvr5cifw0oJwP5nfRsEKJvwkOSQQvFg3yOtDyLfOXT9IPI96iQiSwnNvr
+OOmaIYkt8AB1cJ61KluCb44IflN7w==
=SVXX
-----END PGP SIGNATURE-----

--Sig_/Zo3fs2EL+RNQrQGoFzUUzST--
