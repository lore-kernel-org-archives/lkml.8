Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BDCC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7652073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UPVzKhW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGRNBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:01:53 -0400
Received: from ozlabs.org ([203.11.71.1]:36413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgGRNBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:01:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B87Rg57KHz9sRR;
        Sat, 18 Jul 2020 23:01:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595077311;
        bh=Tck+ElnB3vYA1eqWx+n2MI0v/mg4OzY5dIVkDQmoU40=;
        h=From:To:Cc:Subject:Date:From;
        b=UPVzKhW6PQeX6tyxhgTTSD65yIeSWW4QV1ZqzeN/l+T9gIKLL/Wzm5luPQLV61k6t
         QbAO5Iqbf/ng+r4nR3STK/dLIK38+Macs8+J48dcpad+0OMdogUqFXrNwBTJH/4F1V
         Zr1xMjAqASlHxej1aDPF6rhWJniDXK8zWj04NwLNBuQnfgKjLJ2ZjV8SLeQMx7sV19
         zhERgbfG/lBEMfTFMlHfDrI/Ot5XYfeUVoda/c8aF/fxGR9/YQ9o5S6AWNgQhOcSY0
         Z2+WB7I+KtwLQ8imwEimvL3XJCY+asYaZB7qK0tOM6Q5VsV5zSNwhG6efNLW+NXzu4
         uyUAqBsQQJyjg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sathnaga@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-7 tag
Date:   Sat, 18 Jul 2020 23:01:51 +1000
Message-ID: <87k0z1t1s0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.8:

The following changes since commit 4557ac6b344b8cdf948ff8b007e8e1de34832f2e:

  powerpc/64s/exception: Fix 0x1500 interrupt handler crash (2020-07-08 20:41:06 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-7

for you to fetch changes up to f0479c4bcbd92d1a457d4a43bcab79f29d11334a:

  selftests/powerpc: Use proper error code to check fault address (2020-07-15 23:10:17 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.8 #7

A fix to the VAS code we merged this cycle, to report the proper error code to
userspace for address translation failures. And a selftest update to match.

Another fix for our pkey handling of PROT_EXEC mappings.

A fix for a crash when booting a "secure VM" under an ultravisor with certain
numbers of CPUs.

Thanks to:
  Aneesh Kumar K.V, Haren Myneni, Laurent Dufour, Sandipan Das, Satheesh
  Rajendran, Thiago Jung Bauermann.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/book3s64/pkeys: Fix pkey_access_permitted() for execute disable pkey

Haren Myneni (2):
      powerpc/vas: Report proper error code for address translation failure
      selftests/powerpc: Use proper error code to check fault address

Satheesh Rajendran (1):
      powerpc/pseries/svm: Fix incorrect check for shared_lppaca_size


 Documentation/powerpc/vas-api.rst                    |  2 +-
 arch/powerpc/include/asm/icswx.h                     |  2 ++
 arch/powerpc/kernel/paca.c                           |  2 +-
 arch/powerpc/mm/book3s64/pkeys.c                     | 12 +++++++-----
 arch/powerpc/platforms/powernv/vas-fault.c           |  2 +-
 tools/testing/selftests/powerpc/nx-gzip/gunz_test.c  |  4 ++--
 tools/testing/selftests/powerpc/nx-gzip/gzfht_test.c |  4 ++--
 7 files changed, 16 insertions(+), 12 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl8S8nIACgkQUevqPMjh
pYCxFQ//X8A9GN94Yj4AroV4WR1nhcYOGFJw++FBjWWIE/3HnUmYKKP0aZ2Vd9DW
bjkJvhWLThV6P7lrDG2jOAp4g9ByDi6Syk0VbUxO0Vr2XMFqExoYe3hPSQysbvwM
ajMZWsvyI3wndXgS0HL3/zSkio0DyMyDVqGAPd7G3V+U/B8OM2WvBkoEtoWlcu0t
sFoqGPz02e9FX1jJsuVpBopWnaK2mtUX9CbPxeMQ9yxq7MXnkM/ynKIKdFHj5G7Q
9s2f7Pe6hF+SMu+KqZBvtQ0U8u/YNxTZR305l6ymq1aOERSy51o+ft9vMCD8xrPN
FCQpKqTk8LP0xYLLqZMEHLloYYBQ7R4eSmvleRNMKctodOca1ACMWGkT3otsGPUN
li3HJd9ktaXWK9l9Pf2VZGJF2Ge9tudjSrPJjhZlnZIp1S9JvjqJKtlSaMMsVNrD
doC9TAym2GLjaOTZ4qTiIEnO5ds2VvkRDdgsklpAyNJr8xrT8VYR2teInLro8sD9
m0z7JYGXQAL0Tm5YcuzrVqFllwtFsaUtcLkxW9tfFijmVfdGL24pxvIm6M8X5Kko
2eoa+M7DJzn+oWOFlVdzzq4zRxbUIHkzkvF1aROt7a/8G2bJb0J4ruwXJBnTsFi7
uSuPDNc8dpYKh9WikiIioUhV4XEDdllWMqaEOA19muny/ui5iVM=
=wk5N
-----END PGP SIGNATURE-----
