Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26F1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEF9206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Fr3Qm6GQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbgGaNFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:05:23 -0400
Received: from ozlabs.org ([203.11.71.1]:35957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbgGaNFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:05:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BJ6vj08n9z9sRK;
        Fri, 31 Jul 2020 23:05:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596200721;
        bh=cbtTbd1X6hBlPoUNAtbkqigXBbk7tL0v47li4l8IVdE=;
        h=From:To:Cc:Subject:Date:From;
        b=Fr3Qm6GQQJ1J3shWk88eS0fZB/kc9TrHoHWosbI75b1CN1r000P8/cUbaEzsA3BAU
         OVugrPXng0kMPpgJxb+XL9hbHrAZkbTk4GP81j2WoPkYg/y7A6kHRnUS2aU30SEAWd
         RkmZGOxlevkoizt9uFo4WwFNCg+EOIkfHy7ZRdgwwJX4KoPo9AzX6vNyWYKNJRVHe6
         0fZiFMyc4eM4smghkw15REEm8/tL0Fmos9bVqKGSLQyWL4W2oupKDd+CX8WxPaXXL/
         YPaNiu9DtdF4Cb2KQvdn39qm2HXyj9Y36+YZgEfZeLThR+phB9+gSJcbYiWgyBS3Co
         nRJOcIY0l2pJQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-8 tag
Date:   Fri, 31 Jul 2020 23:05:17 +1000
Message-ID: <87ime34yya.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull one more powerpc fix for 5.8:

The following changes since commit f0479c4bcbd92d1a457d4a43bcab79f29d11334a:

  selftests/powerpc: Use proper error code to check fault address (2020-07-15 23:10:17 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-8

for you to fetch changes up to 909adfc66b9a1db21b5e8733e9ebfa6cd5135d74:

  powerpc/64s/hash: Fix hash_preload running with interrupts enabled (2020-07-27 17:02:09 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.8 #8

Fix a bug introduced by the changes we made to lockless page table walking this
cycle. When using the hash MMU, and perf with callchain recording, we can
deadlock if the PMI interrupts a hash fault, and the callchain recording then
takes a hash fault on the same page.

Thanks to:
  Nicholas Piggin, Aneesh Kumar K.V, Anton Blanchard, Athira Rajeev.

- ------------------------------------------------------------------
Nicholas Piggin (1):
      powerpc/64s/hash: Fix hash_preload running with interrupts enabled


 arch/powerpc/kernel/exceptions-64s.S  | 14 ++++++++---
 arch/powerpc/mm/book3s64/hash_utils.c | 25 ++++++++++++++++++++
 arch/powerpc/perf/core-book3s.c       |  6 +++++
 3 files changed, 42 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl8kFsQACgkQUevqPMjh
pYAkbg/9HzJB8KbjAVJpoXHOf9+aHylhZKU2pcVtdoYE07VV6JabWnlI5flvTSEY
3Dvr3h/X0k2Z3n52+s1kYlW27ErU+o9Hbz1j4O41Ardiy14GmQ02FSi5iXjhKxuk
AjX2MN76n1Te+1ee2Ib/Ubu8KOrbxLIya223tJ0TNu7RWuYVaCO/lNXPPTwm2JWI
s9lryRAHNc4qkPMytsWi/gzNml3IP6cqnGVt1H5fmnOwQXUYbSjdmhBa7AwjCsA1
xJBMkxBxWOnUSknRCxaCCUTQ3sD+sJMzp6verlwEIb+HRh08iJyVzuWCpT9m0ZOG
5F3CvhIxwLatDsJ9N5EeGI2V4qBstBlHEUJJAjkwKgZxzmEm7j9H+ItAc421eo2A
t/SYJTK4JltllCDyB22jCxdEgJh+opv8rki7U+INI01I8gHzqsr/0CHleGtMN5Cq
fUBf25LOMUCpjeAO207j4DzeY6rTXz9H07XWrR4su//4S9bNkYUYpFfeE/3Kwwdq
vZCxjm+fxxLPyAW+E2D2EGsyzIJootrAzly5T7gun8qwgCSgoCxI+YV9/DLmYaGf
OjcG6+X58sfn1FTc8cD6udKCIMKh0JmSccZRqw1Ijp4EiGMnDZUbP9jg/aSciD8a
+oco9QGvvxYQTMut4XUkXtqqZqaTISgWFD/QB9f4KGJ1Rs8tW5Y=
=oaTB
-----END PGP SIGNATURE-----
