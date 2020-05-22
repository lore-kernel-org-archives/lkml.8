Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD81C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331FD2176B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WK99tbW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgEVOGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:06:41 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1225C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:06:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49T7Zh23lMz9sRW;
        Sat, 23 May 2020 00:06:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590156397;
        bh=9XdBfu5nekIGtDkEUofNMJ8BY7msGaFJ0KoVdLZTEcU=;
        h=From:To:Cc:Subject:Date:From;
        b=WK99tbW9akmKDF/RAZoZo0SxSq/W5+6ttzw7I402bZpallYgSrhJComdgb77SRCDN
         WU7YrgtSOgtPtLiEPeiJniP7vBGgwWM8MtEMtd4+RUj4Rm+dBUsD66knL6IZ0xJOna
         SOK5YH5CPF2I/d4MK1ZtOROyXEkKQw8dK6arRwv6TGNF9UhVAwX3Dl+8YUrq7SiKKw
         BdHhQz8//+Zl2FXntjIBU/8/c6JvfRWvO3br3BTAxjkNXPrCz0SPN+bZMdFPN9XxRM
         3z8BmSG1/g8BPx3H2eimysS5Ul+B9Xa00UneXVua5emdSPj8m/JO5s+5VnVlkEt+sa
         iH7qTcE8PjdEA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-5 tag
Date:   Sat, 23 May 2020 00:06:55 +1000
Message-ID: <87sgfsf4hs.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.7:

The following changes since commit 249c9b0cd193d983c3a0b00f3fd3b92333bfeebe:

  powerpc/40x: Make more space for system call exception (2020-05-12 21:22:11 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-5

for you to fetch changes up to 8659a0e0efdd975c73355dbc033f79ba3b31e82c:

  powerpc/64s: Disable STRICT_KERNEL_RWX (2020-05-22 00:04:51 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.7 #5

A revert of a recent change to the PTE bits for 32-bit BookS, which broke swap.

And a "fix" to disable STRICT_KERNEL_RWX for 64-bit in Kconfig, as it's causing
crashes for some people.

Thanks to:
  Christophe Leroy, Rui Salvaterra.

- ------------------------------------------------------------------
Christophe Leroy (1):
      Revert "powerpc/32s: reorder Linux PTE bits to better match Hash PTE bits."

Michael Ellerman (1):
      powerpc/64s: Disable STRICT_KERNEL_RWX


 arch/powerpc/Kconfig                      |  2 +-
 arch/powerpc/include/asm/book3s/32/hash.h |  8 ++++----
 arch/powerpc/kernel/head_32.S             |  9 ++++++---
 arch/powerpc/mm/book3s32/hash_low.S       | 14 ++++++++------
 4 files changed, 19 insertions(+), 14 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl7H3DQACgkQUevqPMjh
pYCc6RAAtxBm0aHlZsitFfLGRVWjXAanWlstF0Gnd/uOT+OLERE7MCD4PQzISKU8
XeHJORzhnfBgcN596vE5EHvTPNkZQdd+VW1Fxp9Pw1wcfZi0XACOdA5YrSN6nDlH
vWUFE0WdcX7MksaviX8AnTmjK9MmHiKySZnTZ5cKlFcJWuawy4mjmK/L1y2DbAId
YdGPJ/Yptda/aZbgi4hV8T1fhgl7odqKhrFf+I5SRojL6M2hnt0mSpUq5shk4Zsw
YZtz86o10CLHpyXdi7zcJb0h7n8JLX3mB+veNVHrQ2o+NeSkwEhQJFYq2CzmTZSK
n79vjG9iCg5KQIQ513cwPjJuo9tIoFULuBPomWiKQ8z/wAyJwzApAJ9y3YWTpQ3e
MBo/rvhMCJvlDt2uAKp8DVMCaXdG8zeE/2iGcnvbQ5l9RwJDEUO8IcUHCdUyZchF
erIjeGLodqB4Vm9+v8gOSjAL4CRrgVRHX6ZDZdOMoHkQBc36mMIu3/X4LfknZ1PT
6TR6AK+DQXY5pguiUeutHPEjzB+f5dgjueTnU4yjOST07xq28dRfeBvRAWdnH5ev
bzQ/VAShdQBLTuwOcYajvYh9HCzcTvuRDOj4LrPRud/qIBECKjB9QlqbsWIPM1Vv
RBX79Fs2ML1Lz3GtVXKUy+9n+KncCEC7H0YkbYiVRZdbYQBbw/U=
=KT4L
-----END PGP SIGNATURE-----
