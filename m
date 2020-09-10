Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69132C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF4B221EC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SJrDcskd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgIJWD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIJWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:03:24 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD1C061573;
        Thu, 10 Sep 2020 15:03:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BnXvR65Khz9sPB;
        Fri, 11 Sep 2020 08:03:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1599775396;
        bh=3NqPjWCWO0eILX/tPHCOekFvAUV/DGtpIqVNRDlAPg4=;
        h=Date:From:To:Cc:Subject:From;
        b=SJrDcskd6rLN+/3sidQF2aNSuZ9KBwk4yZccnN/K4/FWmpKJmEl/9j6W+J7NLtCOH
         hSzVhGH2qMxX80au9gzvQjhqCiXSqrgjolz60wAcO3E7VpkyaCAYtmdTlAzCiDJLqa
         58zCVI0SMKOqt2gNOoy/43WwaaCIoTyi/g61IeMTrRKpYqaJyJHsetQgCioEM2Fo+2
         aMuLJ5V+GsmiGSw8YgSP7EwbKVeOTKMOpnWnPt0Yxqu+8rQnXx6rJQpVGbmDrNZPJ/
         znhnUsgm8P8Bw9UNJpOB9ik8O70BLLVQYUlzarHWnjH1gHQLOc4IgZEBOy33SCLC7P
         UfT3qL+hRsGYw==
Date:   Fri, 11 Sep 2020 08:03:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the iomap tree
Message-ID: <20200911080314.4849d3b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IKT4oF+sNwN2uzi8Ckm17k5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IKT4oF+sNwN2uzi8Ckm17k5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  3e88e7243277 ("xfs: don't crash with assfail")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/IKT4oF+sNwN2uzi8Ckm17k5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9aoqIACgkQAVBC80lX
0GwjFQf+IjLu9sHlOWyZ0kI3400ptFAx7YpPfBsTnRC5jvZebpb98dNg8I9CSRHR
H6TU3zK51EjSZ0ZK0FbzElzSXtMgmrJ/bXIQrEalBT1AxnYKnvoQqUyEX096H6aB
LADw8YYlhuZBtrWl1tORWsHA59DKYKosJTN8D1jL8SOz467cbj4N1nKEboOAWbDx
UqVcc5Fuoc+n9uc4exIeRohgHWkxPG16/gO5VOXDTxS2y/B7pp/6pLZ9QDc8KapL
g4J8+cUu2ElGlrsFVckPlj1U5nFlTt1YrBinBTS8Fy7dRb514Dh6/7kUgc1Id8f5
V7wkQ2y1iIjI+J4PBCqSfvJfFA4FWw==
=Oe4V
-----END PGP SIGNATURE-----

--Sig_/IKT4oF+sNwN2uzi8Ckm17k5--
