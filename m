Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF317C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52FD246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MctIsrXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgB1Efp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:35:45 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:47963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730800AbgB1Efo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:35:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48TGtj6nKXz9sP7;
        Fri, 28 Feb 2020 15:35:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1582864542;
        bh=o5exsgAAp151ds41PjkAUqIozPruPAUIKNBr3jGMf+A=;
        h=Date:From:To:Cc:Subject:From;
        b=MctIsrXy6/bptovpzjZbuKVeOY+iUFpkpbano9DF1qYxcqXk4J59Ot+xrAgOtI3gF
         F49LnKaDRdAXEU2sfSCRdK/4mhJN76WRI/jsgkSbfdPxAPwQsKr0tAFPJoDNlt5bnj
         DErMg/0ebbHXLxfiqQzTTRN6Bl2odShiNuNi1UDInpVBsxZzFnAKwdLfnNVkqUXMUk
         NU92ZSE3rYlxcTDisYt3FpvtHp0M1LcDyDZSfYe3wpGcN95YKEyyakdljOSx24GVM8
         CsJGiRg9RYeaVGqQ2wV3xW9fvK0Q7rwxam3YXSd8KKAjlhwN51yeTHwW4xoLlCV02T
         MLdzBbd9SxRzA==
Date:   Fri, 28 Feb 2020 15:35:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arjun Roy <arjunroy@google.com>
Subject: linux-next: build warning after merge of the akpm tree
Message-ID: <20200228153532.1c0fa33f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.xVBs+ewrCK/BVnJ=8HdE9z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.xVBs+ewrCK/BVnJ=8HdE9z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm tree, today's linux-next build (sparc defconfig)
produced this warning:

mm/memory.c:1463:12: warning: 'insert_page_in_batch_locked' defined but not=
 used [-Wunused-function]
 static int insert_page_in_batch_locked(struct mm_struct *mm, pmd_t *pmd,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  4a879e02dd49 ("mm/memory.c: add vm_insert_pages()")

--=20
Cheers,
Stephen Rothwell

--Sig_/.xVBs+ewrCK/BVnJ=8HdE9z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5YmJQACgkQAVBC80lX
0Gx4Vgf9Hv8bgyf0xRo2OPnKXT7QqCkkaZpuNKuCsg57kbqeL4TQ9F/zAcdgS5nJ
RJ+ZVvn7oQt2SnUR+X5h3NMKsGfe1idL2kSc3+DG/VU0c5uw91SC3nW2LQQd3s+9
XLXzQh07jDuupFwZECqWeklRssa+Iuw5EV50cc4y7EN2TGk/bk5gkrlLRybaeXhk
5cAgJU3ljWo0+YeYGvq/1d/mA52ntsrXDqDArYkXRZXmer6jjx888WER6Tddulqv
rWfG49089DTpYGTQYCPhSLf9276NVf7dUEWbn6gn6IP56fja9QHVp7OTuZ0QQLQi
lvupmCzG6cGIOEYjsXOEh9bYphe35w==
=71oQ
-----END PGP SIGNATURE-----

--Sig_/.xVBs+ewrCK/BVnJ=8HdE9z--
