Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE335C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEC620724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cl+jNt7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDTLqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726209AbgDTLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:46:14 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47960C061A0C;
        Mon, 20 Apr 2020 04:46:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 495PzR6DxYz9sP7;
        Mon, 20 Apr 2020 21:46:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587383172;
        bh=rYA37vpdMZ6Kzw5PBJIBUkD+KbN6CKQMbo7WfkOgxyM=;
        h=Date:From:To:Cc:Subject:From;
        b=Cl+jNt7ugSPR+4363I19TYOXf0mf7SVtEytP8ydHiLc7FLzeFlFrk93mjBQktlp0l
         YwhyvU7JMLgwKgRwI7fTH7sDPAIZkJVVRVoC6QQslwEtTZ3iYaVhCYoSNH3kLciNcS
         BGauCrtx+SdbSARQ+t66ZewqimvPU3wf0MZ5B/qttS6DHbjvKY0jLhQJtr3Ya1b8Ql
         +cA8SKxos1Aahrz/P120gVL8DYT2AsvrR14Zo+B+4g8hGSImSygKYaC8sMtN+D2U2U
         iXFIpRAob2WfBrVY6ORewFT+MfiTkyz0bvlvk7XQTGja668B/WchHF4C6WRiebaCNT
         ROb+xy3FYT2Zg==
Date:   Mon, 20 Apr 2020 21:46:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: linux-next: build failure in Linus tree
Message-ID: <20200420214611.17a6411f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ddFbppuYT7RYq=5e82jxPkw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ddFbppuYT7RYq=5e82jxPkw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[reported by kernelci.org bot]

For a while now, building Linus' tree, the linux-next build (arm
qcom_defconfig) fails like this:

ERROR: modpost: "rd_full" [drivers/gpu/drm/msm/msm.ko] undefined!

Caused by commit

  e515af8d4a6f ("drm/msm: devcoredump should dump MSM_SUBMIT_BO_DUMP buffer=
s")

--=20
Cheers,
Stephen Rothwell

--Sig_/ddFbppuYT7RYq=5e82jxPkw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6di4MACgkQAVBC80lX
0Gx/ewf8DfMP18h16dr1/hnjFwLP+kTSwFPbISESZcrRWHP13ACa7U2IwUWYcqYg
bcQCAw1rTgsBpIk//D6dop8QZcKtJ65/LMOlfPLlEc5dIpaKPdAkWdwzcdBwq/EH
n4QltD7w6EUqX0rLE4puBiG5Qm4JITr1k9pqyk4TF56ySmBnlaAXfWaPnpEIl1O5
UQcRq2DPKUoPIQ39gtqaw2NGMlQ8f1MXbICOTOeOA3B4TPiAU8eQKu8KyEIOBEPT
F+hR22fdiFWRuB6BJgQmuUS84+sLI6Og0nc+1QgxMBUbc31pQmHlFgiCqQeMklqL
aL5xNufi2a9EIX0YypQZAk6PhC/hqg==
=4WOX
-----END PGP SIGNATURE-----

--Sig_/ddFbppuYT7RYq=5e82jxPkw--
