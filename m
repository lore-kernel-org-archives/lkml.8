Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C106C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C5720706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mCD4PIpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgHXXN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:13:54 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3445C061574;
        Mon, 24 Aug 2020 16:13:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bb7Gg2h2xz9sTY;
        Tue, 25 Aug 2020 09:13:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1598310827;
        bh=ifLv7ja+Aq93zBsZtMzOydHNKEXb+JJjJEis39Q4jYo=;
        h=Date:From:To:Cc:Subject:From;
        b=mCD4PIpX4zZq+gaAhPhPdYefg9QrDDZithjdHOx1m394E+QvfA3YEs0kv9hA1kgvG
         oYBZSqnk/SrVsQQLAW4AkhjE4hfLciRq2+qul2KbKNAX6A00i1czOXeQz/tRnEUt2W
         ku7iHEkWeZbXNvTcQgj3u1nyA6KrYRU5nqdzT2C6KHBMrSdkwHDuw9mmN9zOljCk9s
         cgSvLFisOthKTRX4b9Km7t3kyFMrVmCAOKGTw8rAPlRV+4sglhYFY2c1tYWUW4VoUq
         kfp5x8vqJTMX5EAP6dcHQW084CWPjYd0aWpdZw8cKjNKQAPFD1kO0/iTcTYlzKmigy
         KQQNn4U81FOqg==
Date:   Tue, 25 Aug 2020 09:13:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the jc_docs tree
Message-ID: <20200825091346.63395129@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oAGNZb0hMR77VSkbTB.0tLa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oAGNZb0hMR77VSkbTB.0tLa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  09824ed3a906 ("Documentation/locking/locktypes: fix local_locks documenta=
tion")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/oAGNZb0hMR77VSkbTB.0tLa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9ESaoACgkQAVBC80lX
0GxEsAf+MQfnJcAXHj137awYvrci3XJ0bhuzX+i1khD2yXdZpgCin8AWEZbeYcT7
5fQpzPBaRj5bv9cO7uOTpmR4f4br3kVvh5fLZVPjRLBEtAciZn3hDSJbZ76+gw4P
2dnZM28DT5kDh8Ro1ZkdpjdomMTDq3210P6wzB965B7QI6LA+sGcRn774hCdUOop
/0NdMZ8W/bvWS9Qq1OvMzxbQLO8Zc0O9OMmlIzETjm6HtpgCqWOfOjzEEatEb6uh
AU9sqjwhm8g1yoLKmvDYz8qmE+ElWbSqiM3QsWGDgYWsPDJP6IQkqnDjhj5XySIH
jEHT3Fgn7A0K281aA5E0RXYxY2zKBA==
=yN7E
-----END PGP SIGNATURE-----

--Sig_/oAGNZb0hMR77VSkbTB.0tLa--
