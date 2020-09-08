Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8FEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 05:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3222621D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 05:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X3wIB8dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgIHFip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 01:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgIHFig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 01:38:36 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69613C061573;
        Mon,  7 Sep 2020 22:38:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Blv883G5sz9sR4;
        Tue,  8 Sep 2020 15:38:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1599543512;
        bh=G1lV0XSZ7V2BS7SwmTnclG2eCbJThHAKlAjOPQLo3WE=;
        h=Date:From:To:Cc:Subject:From;
        b=X3wIB8dnQEhkNdSgN1WyaQgRHoR1eDyeuMAm1N9DFySXl56KGxw8idCZowOlf7uyf
         AXj46vlMm5qJvQTOBi8nF9CHsZEbeTbRrtWru/R0DE5x7V9VdkeDSN0NGWrD0MHdyI
         MU/TBetv3zMhU/Dhsbbo7hWmnqFdmpYXH90YQwzDJaQdwDqMSBqE2UrKHV86nNHfVJ
         B44vnStPnPsyf+WOkvhIY75ojeG+idKkWmHGH1Iu0/ZClEsC060TTxTN1jzA06faam
         VLyKd0kBHmdFm/lGbvt+RjCbQ4FPlFk5JMbiHdE/s5gVbwm/X+lqmfqVkDEBfXYpSi
         1iWGuGH++C8BQ==
Date:   Tue, 8 Sep 2020 15:38:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20200908153830.0a23e401@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/469xf+jwPmm.ptt0J+C9vRc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/469xf+jwPmm.ptt0J+C9vRc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

ERROR: modpost: "resched_cpu" [kernel/scftorture.ko] undefined!

Caused by commit

  20c881d0592c ("scftorture: Add an alternative IPI vector")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/469xf+jwPmm.ptt0J+C9vRc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9XGNYACgkQAVBC80lX
0GyuLwf+N9pivykTfCj4LTfoeqBIYquf5ErOYQUq4sMPbEImhWhnJqe7ltVsKAQL
X5dOVgrKd+WczCJ7p4G+3XZF+UXYHSIaCeb1pvOJreNJr7YYp3lBWXDZYbSkNKpH
hDwn2ru00ZjSozqDWimxTsJnrv/qrEyDskotrZBYyAf0VD2rH4SI93DhOQPMUWSk
uS1kz9NB24edykdejfpnIS51WDBqoOypk3y5yZbk0Q2f3BqU7RznnMBfDfdV9f4l
ztwSUBNdrgLJ44RcX9piualI6c+08/BTTVoPtRtbRBBb2Pv5ZkUvVs4I/w/hQh+X
hX2Q4WCu1ZmfZhRM+dsVUAOZISU/XA==
=MSgt
-----END PGP SIGNATURE-----

--Sig_/469xf+jwPmm.ptt0J+C9vRc--
