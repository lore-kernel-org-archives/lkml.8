Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4BBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5CB2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LMLZkcz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFPE5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgFPE5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 00:57:13 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E98C05BD43;
        Mon, 15 Jun 2020 21:57:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49mGCC5tpbz9sRK;
        Tue, 16 Jun 2020 14:57:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592283432;
        bh=9vH5GII9aY8OsvC1xg3ag9fv7oR/WBUw9itzf7BceGE=;
        h=Date:From:To:Cc:Subject:From;
        b=LMLZkcz/PUrcvvBLHnB3Fg7/VvHcS0fKeGAtn1ql2Jc9eUbkwTV8z9/CWnUSEP9mE
         AcV0eP3qNc3YaQ4CQKYh+ziGvft9zyWRsmtDGaVIOi7W5D+5uFHT2uxYNwuN6T9XlS
         Gucqx1f3WuozAqwWReUHnJYcX0MZlvag3YVqNzOI/J57ks/he87sxz3loY6iqQA7TU
         0RHvxJVoV3/oqULDnh//dcx0Pxp/fPZ7n3Qv7jFQ4H87i5JL4mwYLiwB6IOKto3QxL
         JdRXmsnYz/WrkNzFNVTX2ldgAT/Xc3kUS1nay5wnU3kLDca4Wi3y86uFoA8l0i2XLn
         dJZcTQV/JdcTQ==
Date:   Tue, 16 Jun 2020 14:57:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: removal of the sifive tree
Message-ID: <20200616145710.0c752d44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d.oT.vi81rp_+dcD7ywCnkk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d.oT.vi81rp_+dcD7ywCnkk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

I have removed the sifive tree
(git://git.kernel.org/pub/scm/linux/kernel/git/pjw/sifive.git#for-next)
from linux-next because it has not been updated in more than a year.
If you would like it reinstated, please just reply and let me know.

--=20
Cheers,
Stephen Rothwell

--Sig_/d.oT.vi81rp_+dcD7ywCnkk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7oUSYACgkQAVBC80lX
0GwhMQf/a4qKCA2LIMvCNoJ34q1Ygy6LC+uj7vvCXM2Gi/1lbFZTwD3zuRHxVzPc
DKa5MbuCuThjyst5scL/rMU/OqQWU+e2MGiryJkvhj2pPT+BLfFVRNkRwsIp03hQ
xKj8Dn7isLCjyj/JDtej62QbcJhsXVP7KAzt/VK4BRQX8FwslCyv/kYLdnh9ik3d
MGWjmmqCU7Q92fCsZuA8TcS9Utzn7vFxdutJT0hoxhvzIbFjpCZsTKh55TNo0Qa+
kX6owjIxF2erzUXucpM8UXtRlXBgCf7JQiYOq6S2POEBDcwTBzkwtfXcEaheag/d
W596GL/bEntKWGgnnHY99IEBYlCtIQ==
=CdhT
-----END PGP SIGNATURE-----

--Sig_/d.oT.vi81rp_+dcD7ywCnkk--
