Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC45C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61702065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b22FlzyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgGZTO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:14:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:59361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgGZTO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595790849;
        bh=60NzAn7wnfuCvZlkpoMbEGO/BzoL1A1qe443ZKZ302M=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=b22FlzyDbBjh9EaK/6kPyTIP8eVzpAKzVX7ZBtlzn3Cs/FxlRZ2+kNTFOHOnM8tq7
         NfEFU4f+lU0UC17pZIiNv82CY8yT8af1PnDRx6zSYirpJeGuwFKfyPQiyUd2ZkG34r
         h7C5m3YZ3TRRk0F2EcmFD/KdNMi9yYt8Myqnc6N4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.163.214]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hVB-1jv5Gq0psn-004kSP; Sun, 26
 Jul 2020 21:14:09 +0200
Date:   Sun, 26 Jul 2020 21:14:04 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.8
Message-ID: <20200726191404.GA10491@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:dMlUJld1YZPiDQoY661/BVRfo2xVuolqWCEM6a2y3HZUsTpcZiU
 TCBxNIfmdZi8TzCsWzuvyXCgpFxXBZs0h2uJWPXG8jjU0q1ctTIM93qM4mNxPb6ayAs5nE0
 Va9ZslTU8Az3RKLWN5gVeiRur6Dm1Bq7sSqCvd8xnicLZ17c/G+YGRcSG0eORS8cpQbnt3A
 Th2oUDSpidLmqObyxQGjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7YXXF+3avIw=:KSHfhqrlhYWA+Q1bMCm6Ar
 IsjTwSc3IP9uowYVafKO0ikLwEKZ3aSagTZG1gxVIrWFU+DtgKqEfny1spSB+1IQg9P95Iwhp
 c/UiwciLbZtEGXxPBsMs/9eK5vS61X05LA3Xf4eFpV5bdN65RedDHEV5eR6wNrrR0T7yRRTPH
 fp0hi0GBnefOQ/U4omcrmzTl6aaulSCcfYCAqlVP83/mRyhabhsrnqybKhCjf7pPtTH3RIVJi
 UaJzWO2GohlrcORD1tRznBtA6b+/ycOVW0pbqszSW8Snte+M2v8o6xF7MP14jYJkpbt4En4LM
 mHV/XLCMBCQsBxTEneUylPsnPExK6/ID4p2hFZun0twNmQUWLhCGdw4+cCcabXmaM2fAQlF35
 UFMKQGACojRkzS8GVCWBkSs0/MZZ61XO5006k81AothwA3wdlCB+9+oC71DJb+rHwoIZh5Hxe
 yTM9m5t5n3o/meTWywSxspZeC6Bj2/ZoLlD4TrU4nAgVOD5uzuKVS5lMb6soYM72ReDCmmXfr
 ZuwzQWPjXZHaJyaoy3NZJsxL0hctq+ZrV/GjfghC5Of0pR0ICuyJd7XbKGeh8Ey8hbsOaglOj
 bJ+ifl2CipcAJh95Q1MohMIFt2nKWYK7CDQ5WC46SGDfLMZ/uxQ/pHzd7eoIUo78RILcpN75x
 sTq7JDbcyjxVJh1jRlvSd28VRfgvNeSsivjQGmtTu60NZpcttUezK2FgjX6oHjAhFUjWzBLqb
 egYmTZQNCvpfvRciPJIFtCmYQFbUatHd5vp+/bFFvGwr3jEuEuOiZlEENxEChw6AQ51nyZ83Q
 8A2IiwuOUqzWPpfTJetYOKq7iunv0pUlNyis8JEn56DYDoMux7bcuV68mh5sGT595JF1LU3cm
 kYd66k0uPq43zXQtxVeuykkX8vWAg9qPHv1XQICYF3DElX2vEvurueG1fH2I3vRUQNiAL1cNR
 Uvn6ApTGJ4h3aXZK9Eebsj7tx8+8iN4nbs7QFEpShQ1zsMIHbzg3WVWqQDKDv94ql+aSRkxtb
 DcV9VvnIhyhW55FubCvML/DrZVbEdqUcQ/4aNtT3w1tG+nwFgLun70E3KUNvQVxTYNaNEAvah
 vK8v+RHNqz+P7hb1kS5sLp8iWi9XeiiKtBxgMJGS+NVp/1ofSiOUshTy8v86kbufGWAUuC71h
 WW1W6G+2GNL4X7z+NLZffhnyqPjwpW/MRHb5V7V87h92iT7LtMgBNbRecAhmm0wJIPpJO4sLX
 YgHA/gm1x2YdM46kr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two late parisc architecture fixes for kernel 5.8 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.8-2

Two fixes:
- Add the cmpxchg() function for pointers to u8 values. This fixes a kernel
  linking error when building the tusb1210 driver (from Liam Beguin).
- Add a define for atomic64_set_release() to fix CPU soft lockups which happen
  because of missing unlocks while processing bit operations (from John David
  Anglin).

Thanks,
Helge

----------------------------------------------------------------
John David Anglin (1):
      parisc: Add atomic64_set_release() define to avoid CPU soft lockups

Liam Beguin (1):
      parisc: add support for cmpxchg on u8 pointers

 arch/parisc/include/asm/atomic.h  |  2 ++
 arch/parisc/include/asm/cmpxchg.h |  2 ++
 arch/parisc/lib/bitops.c          | 12 ++++++++++++
 3 files changed, 16 insertions(+)
