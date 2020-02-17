Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B4CC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBF624649
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C2RLmbDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgBQCAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:00:49 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44663 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgBQCAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:00:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48LRz31XH1z9sP7;
        Mon, 17 Feb 2020 13:00:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1581904847;
        bh=BD3CVoBvvToP7p9M+qnDvxZwxrPMfBiQ40P737FK+R0=;
        h=Date:From:To:Cc:Subject:From;
        b=C2RLmbDdjy64zyQXEi3kVnA4Eg2tdLpfHAXGYcikrrhCR9wwuF/skfGrs9GwvJpnj
         H79YCZSpum2U4s9k6SWlqKXgBfvqW+N8u97DvnK0fUbAAG1+kUGQJdt89e415y0hcM
         o6/x7enk1g6iZcx2DgQ1iWCErXVtLsXnePkk3RE9+KLmu32IpPUT9mqatX7BtgZtZc
         EyUONuQNPya7bTHeqHHazalHFhxkvXZf9o48IHO0QRYywDx3qGzLDoDha4hs80W1R3
         Gj1GsaNBFaTccLk12EFXX9kGyVcUkQXn7iZgo5t7XvCTgvT8sNDah7op8pnmNVXINb
         C0fcBK0hQWkeA==
Date:   Mon, 17 Feb 2020 13:00:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mina Almasry <almasrymina@google.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20200217130046.4c042590@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xGnHHwAOcQg/yGRlWW5yS2.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xGnHHwAOcQg/yGRlWW5yS2.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Also earlier reported by Randy Dunlap]

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from mm/migrate.c:39:
include/linux/hugetlb_cgroup.h:146:21: warning: 'struct file_region' declar=
ed inside parameter list will not be visible outside of this definition or =
declaration
  146 |              struct file_region *rg,
      |                     ^~~~~~~~~~~
include/linux/hugetlb_cgroup.h:145:63: warning: 'struct resv_map' declared =
inside parameter list will not be visible outside of this definition or dec=
laration
  145 | static inline void hugetlb_cgroup_uncharge_file_region(struct resv_=
map *resv,
      |                                                               ^~~~~=
~~~
include/linux/hugetlb_cgroup.h:233:59: warning: 'struct resv_map' declared =
inside parameter list will not be visible outside of this definition or dec=
laration
  233 | static inline void hugetlb_cgroup_uncharge_counter(struct resv_map =
*resv,
      |                                                           ^~~~~~~~

Introduced by commits

  0b42cb2e47b6 ("hugetlb_cgroup: add reservation accounting for private map=
pings")
  881818698361 ("hugetlb_cgroup: add accounting for shared mappings")

--=20
Cheers,
Stephen Rothwell

--Sig_/xGnHHwAOcQg/yGRlWW5yS2.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5J884ACgkQAVBC80lX
0GwBFQgAkpukfhtP6i55Zh8+aplTtAf8K6TLlawkke/4Vi/c0AVUlUA+kGG1M7yS
rn2pqMo2M95bKf10XmtdAKRsqAyvb+KSpTsmGmvD/gjhFnwuRCxfczd4E3pOAz9G
YzJvsepPhn2ykZJFuWnfHEUxVo8FonWeFknXz6b3a+kv+E123kpWFoCtULqR1OYu
HmiRHdmn1uaRZm1UdQb3cHktCi8dyfSoRZLiY9QBhOay2oioOxppnaFU1Mzah3mB
L4MLQzUJQejWpGME1+jlL4vFSjWGxBNI0sm9/QwDAKhyXqYq72c2DakXpKOs+UTg
1/pM+xDa8nMOpGmQf5L4/UJuY3CYmQ==
=3Wf8
-----END PGP SIGNATURE-----

--Sig_/xGnHHwAOcQg/yGRlWW5yS2.--
