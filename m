Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8579C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A91E214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 12:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JIgXg6C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgH3M1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 08:27:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgH3M1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 08:27:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BfXf93h19z9sSP;
        Sun, 30 Aug 2020 22:27:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1598790450;
        bh=2MLIj4dW/5jOfVSMbtoRZCbtssdTQ2QkrOKiGG+EQmU=;
        h=From:To:Cc:Subject:Date:From;
        b=JIgXg6C7KmIiic0G2rxmWJ50eqP3NCYv1uOQVZ0Pk6b7gP/yrYy5nfyCchZsJr2h5
         OCUBn4z5xh7ywixHI5W0AET2GcO5/zyUP8CO+ss+GXDQjyrWfYQjHyTyrsrOmvhnWz
         +klauMlKPt5J2yByk7F0ChQnN9BmTcxQ3k18t8WFa7HCNKPR6mwJg4vkE0YANKQOnd
         2mysd10zaxHGGiijvgD3TY4RiJbcnpthJxokEM53bE5qjIg3LrxI2ZB7qzx60TSbBX
         qaSAqBCMGzywR6YncRH3hikGalTBfSPLSmq5wDk0JDuiN0RE3ObryEncr2KXYODjrS
         YMG6CHAff4fsQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aik@ozlabs.ru, atrajeev@linux.vnet.ibm.com,
        b.zolnierkie@samsung.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, psampat@linux.ibm.com, rdunlap@infradead.org,
        shawn@anastas.io
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.9-4 tag
Date:   Sun, 30 Aug 2020 22:27:25 +1000
Message-ID: <877dtg2uaa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.9:

The following changes since commit 64ef8f2c4791940d7f3945507b6a45c20d959260:

  powerpc/perf/hv-24x7: Move cpumask file to top folder of hv-24x7 driver (2020-08-21 23:35:27 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-4

for you to fetch changes up to 4a133eb351ccc275683ad49305d0b04dde903733:

  powerpc/32s: Disable VMAP stack which CONFIG_ADB_PMU (2020-08-28 12:03:18 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.9 #4

Revert our removal of PROT_SAO, at least one user expressed an interest in using
it on Power9. Instead don't allow it to be used in guests unless enabled
explicitly at compile time.

A fix for a crash introduced by a recent change to FP handling.

Revert a change to our idle code that left Power10 with no idle support.

One minor fix for the new scv system call path to set PPR.

Fix a crash in our "generic" PMU if branch stack events were enabled.

A fix for the IMC PMU, to correctly identify host kernel samples.

The ADB_PMU powermac code was found to be incompatible with VMAP_STACK, so make
them incompatible in Kconfig until the code can be fixed.

A build fix in drivers/video/fbdev/controlfb.c, and a documentation fix.

Thanks to:
  Alexey Kardashevskiy, Athira Rajeev, Christophe Leroy, Giuseppe Sacco,
  Madhavan Srinivasan, Milton Miller, Nicholas Piggin, Pratik Rajesh Sampat,
  Randy Dunlap, Shawn Anastasio, Vaidyanathan Srinivasan.

- ------------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/perf: Fix crashes with generic_compat_pmu & BHRB

Athira Rajeev (1):
      powerpc/perf: Fix reading of MSR[HV/PR] bits in trace-imc

Christophe Leroy (1):
      powerpc/32s: Disable VMAP stack which CONFIG_ADB_PMU

Michael Ellerman (2):
      video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
      powerpc/64s: Fix crash in load_fp_state() due to fpexc_mode

Nicholas Piggin (1):
      powerpc/64s: scv entry should set PPR

Pratik Rajesh Sampat (1):
      Revert "powerpc/powernv/idle: Replace CPU feature check with PVR check"

Randy Dunlap (1):
      Documentation/powerpc: fix malformed table in syscall64-abi

Shawn Anastasio (3):
      Revert "powerpc/64s: Remove PROT_SAO support"
      powerpc/64s: Disallow PROT_SAO in LPARs by default
      selftests/powerpc: Update PROT_SAO test to skip ISA 3.1


 Documentation/powerpc/syscall64-abi.rst       |  4 +-
 arch/powerpc/Kconfig                          | 12 ++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  8 ++--
 arch/powerpc/include/asm/cputable.h           | 10 ++---
 arch/powerpc/include/asm/mman.h               | 31 ++++++++++++--
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  2 +
 arch/powerpc/include/uapi/asm/mman.h          |  2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c             |  2 +-
 arch/powerpc/kernel/entry_64.S                |  4 ++
 arch/powerpc/kernel/process.c                 | 12 ++++--
 arch/powerpc/mm/book3s64/hash_utils.c         |  2 +
 arch/powerpc/perf/core-book3s.c               | 19 ++++++---
 arch/powerpc/perf/imc-pmu.c                   |  4 +-
 arch/powerpc/platforms/Kconfig.cputype        |  2 +-
 arch/powerpc/platforms/powernv/idle.c         |  2 +-
 drivers/video/fbdev/controlfb.c               |  2 +
 include/linux/mm.h                            |  2 +
 include/trace/events/mmflags.h                |  2 +
 mm/ksm.c                                      |  4 ++
 tools/testing/selftests/powerpc/mm/.gitignore |  1 +
 tools/testing/selftests/powerpc/mm/Makefile   |  4 +-
 tools/testing/selftests/powerpc/mm/prot_sao.c | 43 ++++++++++++++++++++
 22 files changed, 144 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/prot_sao.c
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl9LmmkACgkQUevqPMjh
pYBw8w//RQpss9mLAe8NTVBF9bV6sMRWaTugjaRwQIIzbhu21eygaIcW9d4XFtXz
xVB83HHRoD4ND+DH/7rOq6ZCIzusbfeqhm0uRBzkrlwVZuo4Y/ZuCvW+0Bo06qRp
nkayAtpoI1wGoeWQcHUpHunZgwQTbWVNAo1yRo4cm8ux5wP88E1iEiZdNXcP/IPr
V3p0BGYpCrwuNUKE54N3JPOHRP1UILBff1agjfhfctTTVY+tUB5katgMxYh8Euv+
HVTm7U5QHnvkqhLSxdP76UP6R1DCN+E8GruXbDpR+ofJ5PLd1TgY5w3CLNjE88Pn
fnM7GigG6xB3x/DunbVOD3RRGKKg6FFJIRvJ6YrSEWkf84IUKxsQ6Y0Noeb2bLs9
04C5hN0d7GBi7JSjW0nZZvB3jZT0ptiAl3BggEhOshfaqyloogOHEk4pxyXG2/ja
fkTFDdhEgNBO/iAjGCsXaUmaSa1OimpENKNZtosPL6dYbG/FFQ2UgKz+lUR7jsD8
5uH8H1gKH1565JmRfckcplX2hkwPteVDQ2HzSQAD3KyjIMmvDPLCAynTlvxxxn/V
wPeoXpeD1DDZA7RSiV+jaVtjK6rNcjbAUUOhlngigSiXCjBvfsA4lDhovQzivsOF
E1TRnWSmCrTlV21+rtSZjbEdg/WLiBIHVu0DLGjcSw/XeaVa9g8=
=3NM9
-----END PGP SIGNATURE-----
