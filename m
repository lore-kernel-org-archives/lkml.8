Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC675C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88902072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ps0PSNmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgG0WGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0WGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:06:00 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B5C061794;
        Mon, 27 Jul 2020 15:05:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFv5J6Z96z9sRN;
        Tue, 28 Jul 2020 08:05:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595887557;
        bh=5Xgk6T29gT4r7qEJskUynBAKA/63XfobTqWY/vGkWtk=;
        h=Date:From:To:Cc:Subject:From;
        b=ps0PSNmyX5Biz2JN/zsbcWAR17F9L8CuKk1GIKyFLBZATuYVdrhkG60z/PkG4f/wA
         H6aJ7VPTocC3R2xmZHF8d+Ry+BXEfZROu8duwBlmKWihBMvweigyVmv27kKoV8Xigg
         b7FcQBmaa9vhfkWICpUc/UqbuvJkin9nlHrGkFfUq0lvvSMT+OdcfHEqH2KC9SgDpM
         iJmqmeimjELKqraGaWhEai57Phm/jfmT6Iz4FL+SkWgPx9PyeRIPiCnQCcZ13a8iqZ
         rHJuiBwfY6GbrFxTmNlIOKLf2NoqwfqyqdHai/+Y693x3WZe3xpibjOKZpSduztWIA
         0y2n/h/WSmfUA==
Date:   Tue, 28 Jul 2020 08:05:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20200728080556.447ba206@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_iYXZsDZiIk.98+epKb.6UF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_iYXZsDZiIk.98+epKb.6UF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

ommit

  ed944d574cc7 ("ack! virtio: VIRTIO_F_IOMMU_PLATFORM -> VIRTIO_F_ACCESS_PL=
ATFORM")

is missing a Signed-off-by from its author and committer.

I have never seen an empty commit like this before - I assume it is just
a way to add an Reviewed-by to a previous commit without rebaseing
the tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/_iYXZsDZiIk.98+epKb.6UF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8fT8QACgkQAVBC80lX
0Gx7oAgAi3Yl36WvbxdjGo1Mmq+CZEK2eGeV7e9OEq1+sVULWB7+J/owkizFatnZ
FyLaToLVp1Ywj9xKUuTyplBtYOYCO0us609Dj1urgOmOVBXhJR6yuRyuPG6gIojv
iB2caUs+RjMblXeHekNSU3kpnh9zcIwbF6ovSZbaXBGEfN7jYGif7cuegRNbZu9j
BeBQch8Yv9vCPyCwlVn7BO1k9ruhu6RLqAruaRHPbk6vJqbM3lnH24zObXgrIozA
ps+NqdG17C4kfcSSLHLJdQLWyylJhbUq2SIaKEdOv1EnqatdQOeBYSdu7dsyUYHf
oLwSGJNI08jXfDgh5DW9mqcv1+co0A==
=3HhI
-----END PGP SIGNATURE-----

--Sig_/_iYXZsDZiIk.98+epKb.6UF--
