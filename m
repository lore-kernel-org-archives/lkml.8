Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7DCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD492177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EfHCEHgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgHEEVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 00:21:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgHEEVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 00:21:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BLz355RxNz9sR4;
        Wed,  5 Aug 2020 14:21:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596601298;
        bh=9/Ju+/Xussb/ote8CHBRpX6DLYqDGs3gDRp1ZF8tC9s=;
        h=Date:From:To:Cc:Subject:From;
        b=EfHCEHgy3+2g+UIRvE75Exr0psERtp+ObDAw/ZhdGsL4YtNUTagdya4f6D3c9+Y6F
         +yOfzi65SsVO85mBwobqzTiyMjqlyDKeTab4CZXYNKKbRdPHFpyeGvNoj8UQp04piO
         zEimRaelUnN82DhFYfh65Ds9o4sSy4EndUuesPNf43ze1PMInjGRuWZEUPSHdBKldV
         mBS+6kVZT236knSwOhnWqQ1LrwGwaurgQJ5rzlaPtO5ojbw/qPL27H18vKreCi9SKT
         6JFHcA2aE2MiVR7z+T/lurKfYFKiavUk8iuRBA0vbsH2rz/Q9qO9/1KuhVhlhQv1ky
         4gErIZcxQ54ow==
Date:   Wed, 5 Aug 2020 14:21:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: linux-next: build warning after merge of the ftrace tree
Message-ID: <20200805142136.0331f7ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_///VPlk6Nxq/A0GAJG8zzfE=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_///VPlk6Nxq/A0GAJG8zzfE=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ftrace tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

kernel/kprobes.c: In function 'kill_kprobe':
kernel/kprobes.c:1116:33: warning: statement with no effect [-Wunused-value]
 1116 | #define disarm_kprobe_ftrace(p) (-ENODEV)
      |                                 ^
kernel/kprobes.c:2154:3: note: in expansion of macro 'disarm_kprobe_ftrace'
 2154 |   disarm_kprobe_ftrace(p);
      |   ^~~~~~~~~~~~~~~~~~~~

Introduced by commit

  0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_han=
dler")

--=20
Cheers,
Stephen Rothwell

--Sig_///VPlk6Nxq/A0GAJG8zzfE=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8qM9AACgkQAVBC80lX
0GyeIAf/WyTt45Mf+MRVtcBLBOvHjIGybGiZLBcnGwu2RZNuHU17bpMJHpt4MbSP
0r3sSn+j/JnfCeblyjJUU11X2Z741AcZsSeQBx9hiKXJHPqQHjzJvvBEja4bWD39
4kbEtgT04kOm/3BocwksplMJBs72Ebgpb2N2q9x/NQR6FH7kAbAjx/CO4jSs94mP
7N2mA82PRUdHq62Zfuj0hqidj/OECfsZE9TVcHxg6YApB5JthWuQ/D0T2OXTKVt7
+QL2vkCNVdFIS5m5Y6a1eBCVgZwqoL5A4/BNp5s/B5Aze5aic/PdPu5KxNGDKdWh
y9q023WXEJLWtp8ZVRcl5xZD+uMHcA==
=18AG
-----END PGP SIGNATURE-----

--Sig_///VPlk6Nxq/A0GAJG8zzfE=--
