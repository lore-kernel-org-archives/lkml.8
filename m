Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D2C54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED87320735
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YaAje7XV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCXUpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:45:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgCXUpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:45:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48n3Cb6Z11z9sP7;
        Wed, 25 Mar 2020 07:44:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585082701;
        bh=uxfXdme7kSOo5ScY047l1y4mJDhdqgK2wQe3px6SZRw=;
        h=Date:From:To:Cc:Subject:From;
        b=YaAje7XVBnKutLEhBTf4J9DSu2chxI3Q4Cebpn20SfqvKlKEjo07PXPZRb0Qg5aIF
         WuI/DNCfcxWOUuVs0wCqdKUOeusqwMsVIvK4f1vvO+Si5inHotgFCkJQWKuRXboVxH
         eIdf8xFXZG9urCCkZpDbiXol9rFK4AckRi5TR6M5+t81M3JAFclpEEceg0nuxp0lWo
         CxGOLwVT+0u9XoDoPPtSie3/w1TtJM7jvyzXrPIb4Fueu7cvhGhaaEQ/JR0wxueM/P
         MmbYBXJTdEu1NKDZueBUeLPIOE9oQyBMM4w8Z5dam58ic66/XkCoFuGlG4y+n+kWfB
         JGt+UfOFloxcw==
Date:   Wed, 25 Mar 2020 07:44:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20200325074453.5c1a9faa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o1HzDvp8R3YRp29je81zzK5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o1HzDvp8R3YRp29je81zzK5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d8a738689794 ("x86/optprobe: Fix OPTPROBE vs UACCESS")

Fixes tag

  Fixes: ca0bbc70f147 ("sched/x86_64: Don't save flags on context switch")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 64604d54d311 ("sched/x86_64: Don't save flags on context switch")

--=20
Cheers,
Stephen Rothwell

--Sig_/o1HzDvp8R3YRp29je81zzK5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl56cUUACgkQAVBC80lX
0Gxj2QgApKY/mZqHeLD6ERGFWppRl3HP6T9OFrHPwmFw57vBPmM3G1fw/fek4kwv
3M93KE29KX4zDtGn0Lku2QL+MBlern+hCA2I50T9rfWvqjUFOw7XcWYfmKpXiNdS
69NbsWh4OToshPt7FWvfGJsj5GTlQsEh0BhPTXzOFDi9XgZvfxtWz5DotD5jO/3n
9bW08Q2sjoBPS9yTwagMVfmjvFNxyAvRFS8mCvqZRZ3hC54iWPeNlnYStRbh32pQ
cXChV7MlKF5Ardn83m/cYVr8A1BHgWQCdGwhv6BC1G9QCiB+GxgE6ee95BkAzIhp
PSWXXPIhRWSLiaiC/RImcoyWwYeckA==
=+X7r
-----END PGP SIGNATURE-----

--Sig_/o1HzDvp8R3YRp29je81zzK5--
