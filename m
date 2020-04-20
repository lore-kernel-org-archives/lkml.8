Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB13AC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A00C20724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a5GfKUHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgDTLEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgDTLEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:04:04 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E76AC061A0C;
        Mon, 20 Apr 2020 04:04:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 495P2m22DQz9sSd;
        Mon, 20 Apr 2020 21:03:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587380640;
        bh=Y/vlJd6khtsDC5GUhHGZx+W/UfinW33BBQYv5N5jnZA=;
        h=Date:From:To:Cc:Subject:From;
        b=a5GfKUHDTKgJjY9bnoQolFrfPDFPbMQ0ppxOiLxBO6qjvgenrkoiNWt1gbZk9X9TA
         arFQVyz1eY/yTYJAgHhoIrof95Vi1sf+9R9k1YiDNkcjfO5R5Nohh0lcL9FXsPiwp3
         bnq5sXgSGY7BF/8MzGPTVuUpW8GyyTfrkuVTwMDgk8ucNJfZKdyQb/4uvD8qbM0zAw
         noRXk6AERilhFWkUh7ntK66TZiaZ9ZC8jsoq6do1AiDLEq2V13zdrmX0E3u3imfv0p
         QI44Wgr09IOMxcqdsHV92G8U/O9Alr2KmzwY4jTWR9UtH+QSugJZpGld1AybexjI+9
         1jzprhi0HpZHA==
Date:   Mon, 20 Apr 2020 21:03:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the renesas tree
Message-ID: <20200420210358.4c092dbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E5=1sohBP+IQgLOoAUcS1NC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E5=1sohBP+IQgLOoAUcS1NC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  dc7bf14a0895 ("arm64: dts: renesas: r8a77980: Fix IPMMU VIP[01] nodes")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/E5=1sohBP+IQgLOoAUcS1NC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6dgZ4ACgkQAVBC80lX
0GxlOQf/Yfy1oXQW2qfgbqZk272HtXVza0ALm/HMKtJisIl3sPgmSLkvNbTZi/k1
F0QRGgPn6Vsp5ORR5AR5Ib447UNFYgOChcUEWjUN2cDjwC/q2DpsJWa6ds66rapJ
PIWPigDBrIXLC4bNQQzbYyLqz7A6euZ04pqomT8TuDqqWhESrpRx0/lM2B7akbX/
ck3s1E3cBBhLuOJS1aivF1Ovv8GCsanZ7dvUlj/A6UXZUxjQwwOPQiZZ4yF0PKZU
LIqa3oTeR5S71isMmKaTxzLLbMxvTyXyG5d2o8zlv0zShtVZszxgssvCJD9duEGq
qDEA1fJX2sOtnlnVrKqVtVioYstlzw==
=IYWF
-----END PGP SIGNATURE-----

--Sig_/E5=1sohBP+IQgLOoAUcS1NC--
