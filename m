Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFF5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54BA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cT2rGMII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgHDPUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:20:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:48113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbgHDPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596554429;
        bh=C+AAkHPNOBwAW4oAu9nf+erQ1139kdxLd0UjnY+ImzY=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=cT2rGMIIutPdEk7afzDRNe6BrPxXh86XFGlt/ub7auqT/gUgU023obL5CkkCDFlxo
         5u+IUmJ0xRovvSL6Vp432flcz3GZ9lSEDevtLXh1gseY4/mxPWiXCl2Tz1GfR04jJG
         UwUWiL5efrzm+GP4sIk6i2o1tbCteHk97zPHGupA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.148]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1kY8kR3uC3-00nPYf; Tue, 04
 Aug 2020 17:20:28 +0200
Date:   Tue, 4 Aug 2020 17:20:24 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.9
Message-ID: <20200804152024.GA2531@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:hh3AJlCROFU+UciaWhXNr9mJgxGWaCusdSwiixgsmFue9F/X1va
 aQqlOGhreVBIJMaRL/CkthfktyWkDAMsEo71ezUMjrQdwZOduy5olPp53kOVhjzzi9g8J/+
 uBaWEnOKwE1hIWRoi3yAMOR2U8YhRXFBxERr0YdvIDtYyKBEJEgEmsp/xD2pbEf2mZRRCmR
 iVg7nUHoFygTzhRYeisyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NxjoL9AcUSA=:zYU9g1wflJfMPR+RRXNyF2
 58HE+6u4SKqU9GmNiEVdsJsUO6/QZeps3wnqCTZGhntMBnll+8fb2MezKau6ZhVvIXdHOwy6u
 O1LkqxUDCkjlh2wWLI7GvtrAUSujOXSwDFF5cDGmEGYDCBUYciqqkybeuhrXTKWeUV/XcASoc
 1p3RI8kS8CDyO/TgaGAwdoBvDBzdTCAwlGdiEkaNxbzAKMxpatB8diLVFQYrOLHaFIyLjTGIv
 Rqv03gg7GR+I4atN24wwiQG9OBFit1GDgXDWd9XwGoQ3OnoUB5RB+Opk0JAGQrvH4HGvBFPxE
 CAWUSY2GoZb4Lxfl6XQI2BOMxwUcRL69jxooe/YcpfRQ+euEd9o43U1B6Z7JrCpOKh+Zl7RYL
 laTJ5E95mcRoe/eh5wGVWvEQsgFg+femx9C1v63YEs2Kw3J9lmzyyKeyNExoJMSYHV0EQ938G
 vr9tmkRH77JE9+RkP7vQPEJ8my+eoIhSX7n/zrjlSEk7Zw6oMeZ/5ys+rhHuIty1WwdgH0ZWw
 erV/dPZ/1KfZSzYxWE8Up/XfntVNWlItqf33w7DGohlv51Wvd7Xq9UFCmVQUNwS3GwnNfRvyk
 ntDCzTBo8GI2VaOZa4fCIN+8MeXkhmc945wl1HZMXRzjJ1FH/Q6hANAfUSBl7yGgSWEF0HSIq
 Ekg8EDfvXnWq72rSEuY6FoMiMfATSe4C2IuDhnjqvOoVdy/xN21gCqE2Zan4RDWtIDuh8bo1c
 fX7P9VeycuhSCWeN7/2dZMDza/feDcXUy8k2meYWKLUvKKRCIUvPFdeQ9M/+w9bpDE6eilI9p
 7/QGTzqon+ykyD5ZXkvg5HM1C3AtTOwlyBWyFjgjtlJ+LQoYsJKklu1YFxCrPJPtAJ76Kk6sX
 mAdaNz1m7GlvJs2JNiOrMCmA8aFRkIFzpFsLVhA1K4y1CpxE6IAd549/4lL3uoc4vSgvu3zd9
 V9wI1VZqjjn6Ne5eiRxjJYMFhmEpcH9XpeTTYW+4IAWZaNZDGFPREceKbzfCNM7CUyCxdN/CF
 M0iFQCz1uU0idy5WIA7494h0fNKzDycgtEcRi8FhcuIQ6FNIgNbM9VN1RBvWSy5ju2kJUbg9m
 eyJNPlLUiyHyD7fRbo863neFPfM0MCh4qdJCQCoKY3KEdLOAqS9hQ1mDZnTiZzotRRTZ8srS/
 yACD+VRX3ZpGD46eGvIIL7FEgt4EGgaWm2JGevz1rOMLwzIx33MPbLWCHr8QgXqH0haYmY28f
 S4tX9fOT6qMgaj7aU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates for kernel 5.9-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.9-1

The majority of the patches are reverts of previous commits regarding the
parisc-specific low level spinlocking code and barrier handling, with which we
tried to fix CPU stalls on our build servers.  In the end John David Anglin
found the culprit: We missed a define for atomic64_set_release(). This seems to
have fixed our issues, so now it's good to remove the unnecessary code again.

Other than that it's trivial stuff: Spelling fixes, constifications and such.

Thanks,
Helge

----------------------------------------------------------------
Alexander A. Klimov (1):
      parisc: Replace HTTP links with HTTPS ones

Helge Deller (6):
      parisc: Convert to BIT_MASK() and BIT_WORD()
      parisc: Report bad pages as HardwareCorrupted
      Revert "parisc: Improve interrupt handling in arch_spin_lock_flags()"
      Revert "parisc: Drop LDCW barrier in CAS code when running UP"
      Revert "parisc: Use ldcw instruction for SMP spinlock release barrier"
      Revert "parisc: Revert "Release spinlocks using ordered store""

John David Anglin (1):
      parisc: Do not use an ordered store in pa_tlb_lock()

Randy Dunlap (1):
      parisc: elf.h: delete a duplicated word

Rolf Eike Beer (1):
      parisc: make the log level string for register dumps const

 arch/parisc/Kconfig                |  2 +-
 arch/parisc/include/asm/bitops.h   | 41 +++++++++++---------------------
 arch/parisc/include/asm/elf.h      |  2 +-
 arch/parisc/include/asm/spinlock.h | 33 ++++++++------------------
 arch/parisc/kernel/entry.S         | 48 ++++++++++++++++++++------------------
 arch/parisc/kernel/pdt.c           |  3 +++
 arch/parisc/kernel/syscall.S       | 24 ++++---------------
 arch/parisc/kernel/traps.c         |  6 ++---
 arch/parisc/mm/init.c              | 12 +++++-----
 9 files changed, 66 insertions(+), 105 deletions(-)
