Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC608C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8531620657
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SWk1cfAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgEPMLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726206AbgEPMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:11:30 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018B5C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:11:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49PPJb0pgSz9sTC;
        Sat, 16 May 2020 22:11:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1589631087;
        bh=0qptuvL/ogERi8QFjBlKHJwx/qBuiWd+7r1LimEKccU=;
        h=From:To:Cc:Subject:Date:From;
        b=SWk1cfAIwhbOy8POEPE+YefX6aiXtHektYCJm69+vhEReb0AEm0LtH/4atV115U0R
         NusnDfQxbcvj/HR1K3KqYbRu3R7lYCdS/r9iCKOB8ywxvK2EMQToEV3+VBn27TIOje
         nGQJTPToF195WQ7sw1qUXsuk9WczLlOFliS3JumRAWfFcpPUEcnvfB88caNU8kROM3
         AANE6hkJZ5vfO7vl+zLnv1Lq2TbdA7A6UeVRucnLuoolOQvOVMrgfWVcSOmN4vrNOu
         rOm7Q1GAUk1NDsOqvsWSsVD4ZZSOzX3p40CgHMGCT+zo2uCzY0F6YJedG+Gbjkm9ps
         akhRDle8oXErw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@c-s.fr, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nayna@linux.ibm.com, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-4 tag
Date:   Sat, 16 May 2020 22:11:47 +1000
Message-ID: <87pnb49j0c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.7.

This is actually three weeks worth of fixes, I was going to send most of them
last week but my build box had a hiccup so I didn't. ie. we haven't just found
all these just before rc6.

cheers


The following changes since commit 5990cdee689c6885b27c6d969a3d58b09002b0bc:

  lib/mpi: Fix building for powerpc with clang (2020-04-24 13:14:59 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-4

for you to fetch changes up to 249c9b0cd193d983c3a0b00f3fd3b92333bfeebe:

  powerpc/40x: Make more space for system call exception (2020-05-12 21:22:11 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.7 #4

A fix for unrecoverable SLB faults in the interrupt exit path, introduced by the
recent rewrite of interrupt exit in C.

Four fixes for our KUAP (Kernel Userspace Access Prevention) support on 64-bit.
These are all fairly minor with the exception of the change to evaluate the
get/put_user() arguments before we enable user access, which reduces the amount
of code we run with user access enabled.

A fix for our secure boot IMA rules, if enforcement of module signatures is
enabled at runtime rather than build time.

A fix to our 32-bit VDSO clock_getres() which wasn't falling back to the syscall
for unknown clocks.

A build fix for CONFIG_PPC_KUAP_DEBUG on 32-bit BookS, and another for 40x.

Thanks to:
  Christophe Leroy, Hugh Dickins, Nicholas Piggin, Aurelien Jarno, Mimi Zohar,
  Nayna Jain.

- ------------------------------------------------------------------
Christophe Leroy (3):
      powerpc/32s: Fix build failure with CONFIG_PPC_KUAP_DEBUG
      powerpc/vdso32: Fallback on getres syscall when clock is unknown
      powerpc/40x: Make more space for system call exception

Michael Ellerman (2):
      Merge KUAP fix from topic/uaccess-ppc into fixes
      powerpc/64s: Fix unrecoverable SLB crashes due to preemption check

Nayna Jain (1):
      powerpc/ima: Fix secure boot rules in ima arch policy

Nicholas Piggin (4):
      powerpc/uaccess: Evaluate macro arguments once, before user access is allowed
      powerpc/64/kuap: Move kuap checks out of MSR[RI]=0 regions of exit code
      powerpc/64s/kuap: Restore AMR in system reset exception
      powerpc/64s/kuap: Restore AMR in fast_interrupt_return


 arch/powerpc/include/asm/book3s/32/kup.h  |  2 +-
 arch/powerpc/include/asm/hw_irq.h         | 20 +++++++-
 arch/powerpc/include/asm/uaccess.h        | 49 ++++++++++++++------
 arch/powerpc/kernel/entry_64.S            |  4 +-
 arch/powerpc/kernel/exceptions-64s.S      |  1 +
 arch/powerpc/kernel/head_40x.S            |  3 +-
 arch/powerpc/kernel/ima_arch.c            |  6 +--
 arch/powerpc/kernel/syscall_64.c          | 20 ++++----
 arch/powerpc/kernel/vdso32/gettimeofday.S |  6 +--
 9 files changed, 78 insertions(+), 33 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl6/2FcACgkQUevqPMjh
pYAKFQ/9EnGGclynmL6LtPGZwUx85SjGDlWSLTL3edJFQZ4x66QkSBT2R6HF9PYA
HMNC8ei5gTUBOSM9SBtapbYPfVrPO0PtjLzCIKASXpr/vmh7wPN9Fs0kcofKcRoi
p0fnxabTxFMRjOljAsywhbNBMzT5YFN91E0Ab20x/TKsh4PbXm1NfOvHy5R1J/Hw
EcomxGwp6yLEGGMl6hshEmPI49C2+BchO5rUxEYziGQmnfoG3QtPMLg3f9Spe764
MdkPd9lLgP/jLSBdIIG/qGg8OT3O3tN6l/cXZE6nHri7qHAe/1UubXQ4R5zzCmut
4hKwmDIugRdaX0MX55NKq1DRAvw6txK596Gfcas4ooO+4CXYD+0kmIcMTQsQyWxg
SY5ZpHyrU6GTvvcvAR7NVKZVDrw/xrnlpxE5L2lqRE41BUWj1dRmU3NCRpny/otp
WuXqi9rKeFJrPIO2ziBbj3a/205BbkYmVz+kDhemWQ7nh137ryUlaXGTbUfqgE3z
sTNyw84Sc1NTbd5QfFABJDDIMT3kotyDgWeLiMuTw0u6FPcaixpYCSO/DcoxxrZr
2Q6G/4QEgm6lT1tDZ0Te3dStT6PKCg6YjiC7mefMeo3OnnWJGIE3iVJJTwtDDv3a
kuzhIMynKpNZ/26kAmydpEYjFHxmyX0nwzb8704aL6WxgGhVyTw=
=LCRY
-----END PGP SIGNATURE-----
