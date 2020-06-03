Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F4FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1032087D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RTaFVOKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFCI3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:29:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58299 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCI3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:29:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49cMWf25yKz9sSd;
        Wed,  3 Jun 2020 18:29:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591172942;
        bh=rFsRVyic5t+PQE8z7w7/8FHY2+6pyoMP0um8ONOx7mg=;
        h=Date:From:To:Cc:Subject:From;
        b=RTaFVOKB6pqwEkK6zJPQSnx9o7Y+jAiUOpLPZHIF5NRvAeHoIX6dHai1rF0Y5pWqX
         MLKUITz2sKCDQ/cqcGC7IYyAgNFQYGeZFGaP6rirF3UIveRTWaQalJ/UJ1x+chUSrr
         pPjNRiHuMfyde4rY0Jyf57oL9TRzAY6ZFNwjnmyEj/V0Ihf2+VUiHLLHUimK23c6S0
         /w0lpD8tu3rASEvnB0dQ+QsO9fHdrvoW3OKsDSGw2kej+VJjhKTb1IismI5Y9+dpRL
         kWHhinMqOK5ghVr+ZRcinr+HhS3JzuwZUJYCtnk2fR6iGqL7JKwShr0EE0fTXsAiZ1
         RlPKPGzp7v/QA==
Date:   Wed, 3 Jun 2020 18:29:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: linux-next: manual merge of the akpm-current tree with the
 kselftest tree
Message-ID: <20200603182901.63dfec97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/90CMTMhmPms=PNB6l0ht5t8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/90CMTMhmPms=PNB6l0ht5t8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  tools/testing/selftests/sysctl/sysctl.sh

between commit:

  eee470e0739a ("selftests/sysctl: Fix to load test_sysctl module")

from the kselftest tree and patch:

  "tools/testing/selftests/sysctl/sysctl.sh: support CONFIG_TEST_SYSCTL=3Dy"

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/sysctl/sysctl.sh
index c3459f9f2429,ce1eeea6f769..000000000000
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@@ -112,10 -122,9 +112,10 @@@ test_reqs(
 =20
  function load_req_mod()
  {
- 	if [ ! -d $DIR ]; then
+ 	if [ ! -d $DIR -a ! -d $SYSCTL ]; then
  		if ! modprobe -q -n $TEST_DRIVER; then
- 			echo "$0: module $TEST_DRIVER not found [SKIP]"
+ 			echo "$0: module $TEST_DRIVER not found and not built-in [SKIP]"
 +			echo "You must set CONFIG_TEST_SYSCTL=3Dm in your kernel" >&2
  			exit $ksft_skip
  		fi
  		modprobe $TEST_DRIVER

--Sig_/90CMTMhmPms=PNB6l0ht5t8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7XX00ACgkQAVBC80lX
0GyJmQgAmHY1MMrKVp0GByA0eYqA8QvRT1nk9rTYiMK3yQDVjzbx1iUBrLENVJVv
+rN1poEwnMlN6rMXlR/1qoNEgBaBzeoo27/d7+4EWWL0IH4U8ShIHN8E6DwP3JqO
1R67BeaPiilVBAjYytkG15r/7VAr/Z+vpFQoPfJvjQ1dFiD5GmHPGHteNbbqfSxn
/1NHBLv9zvPLqFHq9tPFvWuTx1EBruERtamugmP5MFk8L8t7CzmlGClR6/tI9h8Q
fqxSnN9igQli9iPgyHgXGA3e64atmmsYGVw3EC2kSnsgZTd/13R4sNgLDhrWecXh
j9zqM5bWAPWS7hwb0QAKXIW6Obzdbg==
=uSow
-----END PGP SIGNATURE-----

--Sig_/90CMTMhmPms=PNB6l0ht5t8--
