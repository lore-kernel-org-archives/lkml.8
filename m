Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ED7C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925BC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mwHkXGrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgBZClo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:41:44 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:32949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgBZClo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:41:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48S0S44MKKz9sRG;
        Wed, 26 Feb 2020 13:41:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1582684900;
        bh=6CeLDGBmf/v4Dv6Gn21sA3lm6q6Y7v6mvEneUpmqp2g=;
        h=Date:From:To:Cc:Subject:From;
        b=mwHkXGrWEO+ay0dPaSsD4F7KzSQu76s02t2PjC70c2VStk3YP1AkNSxnyVALj2O1t
         qzXsGlHvUS+M+dartEa/wrg/30wJGD2/9YObxq4yYBvjixGXnzXTQ6zvWNuW/pb3t6
         wxUGNpxFGShcvPEahPnopFH91AZbKFPJ8aXSvccdlMWdyFiZ0qYF336Z3yueh0QNWo
         /HAWbiTaR2ozvUuBQAm6Lv26/dVK7FhwUPGCLjxU82r0VT1wz5SnPAb4o3UVtE9KbJ
         NpfHCxtnoeZ2j22GPNpWUnCRuh92ukb+7CPAEC9+7DBfVNPRrzB26XH9BrQ3NATJC5
         DIrV3Y17SnstA==
Date:   Wed, 26 Feb 2020 13:41:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jouni Malinen <jouni@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20200226134137.77445e2f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NHNuz1LW4.GGZwbla3Ej=CD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NHNuz1LW4.GGZwbla3Ej=CD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/cfg80211.h:3407: warning: bad line:

Many times.

Introduced by commit

  56be393fa8b4 ("cfg80211: Support key configuration for Beacon protection =
(BIGTK)")

I assume that all it needs is a leading " *" on that line.

--=20
Cheers,
Stephen Rothwell

--Sig_/NHNuz1LW4.GGZwbla3Ej=CD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5V2uEACgkQAVBC80lX
0GyROAf9GvV7PuBfpBVXVaeBf0KyW1iB4UAQ3fw2nvfFDfZ3uuEUrccfWwtXzCrM
COG2h6ZiFsgvQ8kB/wR0JnuU4rm0OjTINLBXAK8WLovAhcQdbR4n72Ze6kDq+Sac
ShgnNVf0JATkLKrKrtsKYrRx9h4nDuLHZAIOlpk7FjsJ1QMBLQMSbb62A9F/IoH2
fMcqGpxhrIVVGG3MFchSDpDIk2l0MRTGHhc+5HCSdZo0OTidUFwQpiBok4hvrT1R
oINurB/xz+/+7V+DOb84J6Flp/JlBpxYVnjd93ZVgz4BVAlviRYkDmrpT6Dc167b
nVFKaLnTrKMgSaNzWHunytCbLNIK1Q==
=sjwb
-----END PGP SIGNATURE-----

--Sig_/NHNuz1LW4.GGZwbla3Ej=CD--
