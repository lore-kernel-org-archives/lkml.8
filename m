Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD65CC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817E7207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kvhOJMfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgCaI4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:56:17 -0400
Received: from ozlabs.org ([203.11.71.1]:57847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCaI4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:56:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48s38Z73C3z9sR4;
        Tue, 31 Mar 2020 19:56:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585644975;
        bh=KqGbhMnBF2j9YnXQQuOMYuwr0ZhKMQgkIB87z8RrPhc=;
        h=Date:From:To:Cc:Subject:From;
        b=kvhOJMfT1PVSNBlWl/czsJ8Ts24c+9meGPOhkwP9eYvvkHvt9NyaMBPEnlbEAob3u
         /OadihYFkLnGe5LS+F6GvHhlL2gX8EHotWf7ZpYAwsxGxDFuMc/Bh1m7ZMclFXdX1h
         WkXh4DpD86RjKplyh81q5Lq1nNWUxFLF6iFez8c8yknNZpDxoOyQUns02aiTMrQlh1
         LHr1XFiYq19rg08BF/fTKUQCFPLyVNKRdjF7NWvWmZkGxjXn0XeQ4CuJ2JYM8+Zfke
         A1qUb3amxqOIbhCjZxZiAIEExOMCNXcftpB4/HtnGn222HE2JWAgqgyE6A1Shfll9K
         wjYL8sCObVhnA==
Date:   Tue, 31 Mar 2020 19:56:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Longpeng <longpeng2@huawei.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20200331195612.64c06485@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zjBK/bv5oO=dW4e0jKXEPR=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zjBK/bv5oO=dW4e0jKXEPR=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (i386
defconfig) produced this warning:

mm/hugetlb.c: In function 'huge_pte_offset':
cc1: warning: function may return address of local variable [-Wreturn-local=
-addr]
mm/hugetlb.c:5361:14: note: declared here
 5361 |  pud_t *pud, pud_entry;
      |              ^~~~~~~~~
cc1: warning: function may return address of local variable [-Wreturn-local=
-addr]
mm/hugetlb.c:5360:14: note: declared here
 5360 |  p4d_t *p4d, p4d_entry;
      |              ^~~~~~~~~

Introduced by commit

  826ddc88e2cf ("mm/hugetlb: fix a addressing exception caused by huge_pte_=
offset")

--=20
Cheers,
Stephen Rothwell

--Sig_/zjBK/bv5oO=dW4e0jKXEPR=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6DBawACgkQAVBC80lX
0GzuMwf9HnMeZGRTCVTyUMkj09xSVS7eZTYfC/WzQzG7HczBUVXkqIdqxXwQSHKg
2NlWyMW7vyvn4ILTnoDoZwIc1twb7SRynr52SG+uDs75LrjPuEKBhkbZPwAH541/
yaf5NvPIYC/g+pfW7GpmguBRpHf3VBe1XlyaxkMbQ09l+wmL+J/sBNloaBUay8+O
xGUDNvPgtRdKSr8rztJgZ+jJiwI1KuCesJiKMHeKELlmLJ5B8NdY03ycePut32c2
5kTzyJYAsNkkmvtBNYmZSKccgPSAy4nYuKrH6gqa5F2kl6SN1UW1PDJt8sf7kZAc
LYQRjoZxQpW1W+01u/FcXvFnoFRBNw==
=o7iV
-----END PGP SIGNATURE-----

--Sig_/zjBK/bv5oO=dW4e0jKXEPR=--
