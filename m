Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02013C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F562465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="skwfrOr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgCJC1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:27:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgCJC1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:27:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48bzWL28SJz9sRY;
        Tue, 10 Mar 2020 13:27:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1583807230;
        bh=TcEm2jElDtda0OnJoa/Kb42gHbOESR+FN7DCdczoA+M=;
        h=Date:From:To:Cc:Subject:From;
        b=skwfrOr54sltbhn4/QAAFHC3RYdTZF6qpD/tq6Ygm/jcenlBBALKNkMCA9Bq9UhZ6
         O2eGsQdHRNwAGMBmWyzZLGJU7VKo54tuSikmIfFpalPvluoGJ/X/U1km5uOc8uOwaG
         mAb/0Kd5Q2W2xh2lbFtswB8p6TMeqaMyb4c3lIKuGTl+eC0UMkufcSLOVd7cKGYiVn
         seIuMsWWNr5d85st8gpSiqxUV8D2XROoIvuWYpGsdi+KbY39Alc90M/WNMLwTnTwRm
         4QbszmG3VoW3ui7pH65T0KQ0jKZtwFVSe3LkZZ1QSe8cl4GP5gBIys8RN4PT8eKNBf
         uGETxEfOZz/LA==
Date:   Tue, 10 Mar 2020 13:27:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the rcu tree
Message-ID: <20200310132709.3b5c6abe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QkSvzejC3hMJ5tN920fwy8Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QkSvzejC3hMJ5tN920fwy8Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

WARNING: "rcu_tasks_rude_wait_gp" [vmlinux] is a static EXPORT_SYMBOL_GPL

Introduced by commit

  cbd703932774 ("rcu-tasks: Add an RCU-tasks rude variant")

Why is all that code in a header file?  Do you intend to have those
functions defined in each C file that includes kernel/rcu/tasks.h?

--=20
Cheers,
Stephen Rothwell

--Sig_/QkSvzejC3hMJ5tN920fwy8Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5m+v0ACgkQAVBC80lX
0GxrGQf/VeuDxyFSS7muQBK5vie3WSBJDxNXY0G+U0hygFVeb1VwtLNS3fVSQndp
D8v2BYAw0p46jioLjh9BMyQXTpxWgxCcCvb9XRRaxoRbpA/tRif06HK9S9OHuAfk
wdfTZGMiNxOEdEC3VT4IRuDsdK90VUSBFTmu1hIszwB1hjx2uItNUKNBNeeft3GC
AxEj+MdS+0i/dZq0bQwBBrzYoYUpblsWpK3IJnes8w+MwNSrYYL6ljIe3VP4wGTw
wIDdZtHf/mMDwdOS43kkeGhj5TlqHzHs/XV1LX3ST59+mO8ZRyXJVDS0ttGuq6dt
cPE6UmpBTOno2zAMaLOldVcvEd0Xdw==
=hKUV
-----END PGP SIGNATURE-----

--Sig_/QkSvzejC3hMJ5tN920fwy8Z--
