Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28454C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 12:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F5320726
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 12:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gDIL/+Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBHMwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 07:52:47 -0500
Received: from ozlabs.org ([203.11.71.1]:55851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgBHMwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 07:52:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48FBsT0tPVz9sPK;
        Sat,  8 Feb 2020 23:52:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581166365;
        bh=oTzymqr6KbFrZJ28LMXr7fJJ6tIdsEGkIDpbea8meWg=;
        h=From:To:Cc:Subject:Date:From;
        b=gDIL/+Bo1XcQZelvIo+Gb4cvZDMV469kEwWu8rt6igb4CeM4RK0MvV4OHAu2BtX7I
         0LKrHte9KWOMPvt505IPcAez8Op1KUyCvn7eKFxptyvMKsA9RDT8EoIDKRx6azf84R
         7M0WSq04Csl9xw3SI8UNmqs00DTUmkofwMi+nGHcBZiVT56bign25Fv1qVjEUCuPYS
         xUNsvOI3QGex8Pmc4RoHJWhGaL623Lu2gPC2HeMx7egKEa1TDNd9JwONXDPENcrVt6
         OmmFxQH088wSbE64DC2+JNUYYrwrXw+RUOMUVQMDOEc06szg1vVKQA9y/wCosPITsh
         mQR1uLk8AI6jA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-2 tag
Date:   Sat, 08 Feb 2020 23:52:43 +1100
Message-ID: <87ftfl1bs4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull two powerpc fixes for 5.6:

The following changes since commit 71c3a888cbcaf453aecf8d2f8fb003271d28073f:

  Merge tag 'powerpc-5.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2020-02-04 13:06:46 +0000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-2

for you to fetch changes up to d4bf905307a1c90a27714ff7a9fd29b0a2ceed98:

  powerpc: Fix CONFIG_TRACE_IRQFLAGS with CONFIG_VMAP_STACK (2020-02-08 21:49:06 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.6 #2

Fix an existing bug in our user access handling, exposed by one of the bug fixes
we merged this cycle.

A fix for a boot hang on 32-bit with CONFIG_TRACE_IRQFLAGS and the recently
added CONFIG_VMAP_STACK.

Thanks to:
  Christophe Leroy, Guenter Roeck.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc: Fix CONFIG_TRACE_IRQFLAGS with CONFIG_VMAP_STACK

Michael Ellerman (1):
      powerpc/futex: Fix incorrect user access blocking


 arch/powerpc/include/asm/futex.h | 10 ++++++----
 arch/powerpc/kernel/entry_32.S   |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl4+rucACgkQUevqPMjh
pYBy4Q/+OHH+G3jPH2sCPycqXNh3e0XbAymtAH7v01Lj6c1BSiWhvq1vP58mEeUM
TwssxNgQC7ZeltOHwZc/0GA7WPp4cYuHIU0XVuxKmj8LvWM3gqC0WUbaMkbz1uvz
mM5IN+WA9ENvzEX4A4y5vKzM/pEMVkyyXOluaUmFWCT+94bapYqlKUjeQqYySxwu
js4qBAuMULl4qr3zgMAa4WS3v3XgJ+Zj5v3Rh0O/ITpV/qv+/lQrBYlI6Q48/L5x
hYmQa+3ahCaVtxLnsDpZHrvfiv8UKpgZMjNYPgDfv0nPjTsngTXGB2RtLlD63a4t
Ve2uHLxoSvHGn2TTgUJ7N+VDuqGEYzHv0Ulg72SQBGz5kUKGeS8h0EdDI2naUNTS
OTicNI/DaGv9zCTChSXHEgrLc6mR+qLaamgqwjljF9iIxlKhr2cyD9/02d3XtrHH
2EKm8LCy+5pCtFjReUk+fENU9MZQ5+bYHtk/svcHCC63XXquHzwE+NdB6Whz/QPz
iV5NQW8EtU74u+wkPjdsmqta1IMmYzoisc4IULGEXgFJSjgYdYchkpKd0mf49QMG
Wmd4HQR5iMi2w2YiE25hyqa3nxWjHY2y3TV+b1JZZ4sAKOKCNLLZ6ey989SZKraw
xP9G/r7H7/TtMVA0aC1fcjVnxPzU4d+ygpVBtqL8u7T3/pul9dg=
=mWQt
-----END PGP SIGNATURE-----
