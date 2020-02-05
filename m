Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643F6C3524D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1942085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="juVcxY+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgBEHGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 02:06:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:47401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgBEHGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580886368;
        bh=sFyepofbS14sAHZ6pDuWzLmkNs4XyhFZqJzFXP5JZxs=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=juVcxY+3qLTnTDKbEclnCk0Vj3TJA7fbLEMcwbXchMLYivIjekzGFWzrrRY8mrLmI
         dB4XANVZOdcfKSpfwmf3GqRcalmmf8gs0N16VBmgyH79cn50rebfOSdpCYIA4SGLmR
         on+ut8cqaxs2oxPw6cF306Eaqi1nIhJq432Wb6M4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.129.171]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1jRhxj17xz-00gtHl; Wed, 05
 Feb 2020 08:06:08 +0100
Date:   Wed, 5 Feb 2020 08:06:04 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.6
Message-ID: <20200205070604.GA11613@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:JvLviVfc4B9PfeafhwMkRK5L+rJd5hX8jPz1hZLdhc8VEooUv/Z
 +hjTND8xnqJyDVWg2eoS5iwgauUJLKjIhwoP9zbdkvzuFaTLxn4rB9OcrF8u23qYXnMr5sb
 d/qM2mAcn4TAjn/++SQ0gAXMoR7pF7JJy/qBL9uynVeL3xltPFOOVcLsLA2tfAuwTXIEFRj
 7P2LtAzl/xG8tg+hELWrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p5p43E+zilc=:BPhHaLHqhzweV6LwRmR9eY
 jg659WPr2nwORFobCelaY0KT3nM0TmTe5P4I8dl3uK5W+7rA0biWPVYYnReJY5mDXvzBHukWE
 Hyf77AnlLHggohCzqDKHOBGbCIIyDG8NFdRPRExPOE12hsASBMMhzLx/OfoF6tbEEE/fw0ykh
 VlOXBNXS3nJCbWcEZMZtHMZZuYkFE0bDBGiQLuT2GCGIDalKwtY+UodE7OJDOI8qevWFkFtCL
 dRJqrZZWVRPyGWbCmbz0FoSdoJuC4KQCjPJ3GJW4ADDVXf4hjtcceWH/ts9xfwE/9h/J2MGHW
 cbw+7qHy1cYk4VbUCSclKb9ST45ygQTTJL3mzrJoWiD8zLw1A8V8HTW3MYvaAEJIhtoVRFk7J
 EFFRJvKtsrxnjElKoNaIJ38vAN3Y9zi9WL5IKCyykGJvprVGT5AkClT449RI6+vFYa/rFoCE4
 Y2oowhAqC/1SR3zOyENDcW+uODLGNr+b+sNPKseuJ5G4v4EYjXBdPSNHIYTJ1RxoDPljzYU9H
 yhSYasdLc9RcRt6vuD8TlD/oDqqTJptt0Y/BtaKxUkWVI3k0n6QML6B/BzU4B3gsZ8RTNIpGT
 8zhyM01Vmqi2U133LKyMsjfLB4UjBWZtILq/6rOKf0ayU9roCFnLVDgqanYul1o8JkRR3h4Qh
 N05JXnJWhQdQwep+9EoyZB/dTvDOQUGd4razp04cL6aMzljU31rEOkmFSjKOMXZHmP5+KHyYn
 mW/q/Gcxvs56YiBaRi6yBTFKvhoJE4CG9VkuRit2wFmfkgDmsQ7zoMOKrz6TWF3nFQXK45s5x
 jx1Bf522qFpVH4n5ClF+CDkowccw6MuvBuhND7LYzo5CrWZGoKTPKHeruRf/JzQ/cJdOuqVck
 PFkmmxp3xYrUuxJd3SDrKQmY6mlnbzFU92hInRtg5XJUb6A1X4IEa6+ZUnlT7VysTIIWHXFfm
 G5a3MbUQqCbLU7n92FSydPFO3sdrsFVbsr8gx4IvLTvankiWkqyARmIXw6pmA7xBtYZJ97C95
 m76UFUeS/JqN49rMSQFIdoqY7KSmSHorCNbmZSGQXxC+7wUM7jWIiBmzITbrHgFbrAsRVIsST
 8CVOiFSPhPTskH0V8bdbtodnD+Ao8cYVVZ85eweBimT6CjxUi5oHH+i2sAAZlwFKo0w95JoOz
 cCghEQN5qZkkJXV/v2F2ZK5QOKjgck4/OMw7UVcG7DaMF6jc2TKLbjBxY6JYAB4B9BKmN5Nj1
 xu3VDg8bR0PZxvMIb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two patches for the parisc architecture for kernel 5.6 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.6-1

A page table initialization cleanup from Mike Rapoport and regenerated
defconfig files from Helge Deller.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Regenerate parisc defconfigs

Mike Rapoport (1):
      parisc: map_pages(): cleanup page table initialization

 arch/parisc/configs/712_defconfig           | 181 ---------------------
 arch/parisc/configs/a500_defconfig          | 177 ---------------------
 arch/parisc/configs/b180_defconfig          |  97 ------------
 arch/parisc/configs/c3000_defconfig         | 151 ------------------
 arch/parisc/configs/c8000_defconfig         | 234 ----------------------------
 arch/parisc/configs/defconfig               | 206 ------------------------
 arch/parisc/configs/generic-32bit_defconfig |  93 +++--------
 arch/parisc/configs/generic-64bit_defconfig |  72 +++------
 arch/parisc/mm/init.c                       |  50 ++----
 9 files changed, 55 insertions(+), 1206 deletions(-)
 delete mode 100644 arch/parisc/configs/712_defconfig
 delete mode 100644 arch/parisc/configs/a500_defconfig
 delete mode 100644 arch/parisc/configs/b180_defconfig
 delete mode 100644 arch/parisc/configs/c3000_defconfig
 delete mode 100644 arch/parisc/configs/c8000_defconfig
 delete mode 100644 arch/parisc/configs/defconfig
