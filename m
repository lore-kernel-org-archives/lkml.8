Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD84C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5E0206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OSWjkt3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHLN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:58:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:49623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgHLN6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597240675;
        bh=9VcFNbLqkkrfNbCLxuWEXQ2U74fNHzcMjg2FPaMwkKs=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=OSWjkt3mfoOzAdjZDs2unwg+edBufwHL4umdD2e/1qEiR3KCBsmTBvdIiS4tgF7Uk
         NTnOzi/O73e7E6xu/vtsRHZ8gceQ/yi8ThsiyKXPMC3hK3CIVLy1mSrvgWig42alcg
         znSbdPVdHGjpBPGU+DJQfvOoqM5VHknpl9iUqXLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.153.63]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6UZl-1k3NEI2cZN-006xEf; Wed, 12
 Aug 2020 15:57:55 +0200
Date:   Wed, 12 Aug 2020 15:57:50 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.9
Message-ID: <20200812135750.GA17014@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:/y1QGhODqNeXS1fXn+2WMCfX7ZEgRCD54/dnx4wD74wKJOBqkf0
 qKiP2IM2YyEAjVAvIRFufQhxaxXLmUKGphrkLMqA7isW4PIe8ZVXunVDS/nWakpJswg5gpw
 CiA9O8obbqIUL01nfWqxlba6B56yjJsHeUbZuuXYiE1c/4R+LLmF4Q1plezV/4kqDU/EDDW
 UCZcudgVTAS7lAIFeb48A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qzVejtT3Pw4=:7o1UnmIZxuvgnkb9+dAaV7
 61Yyy0WzTyM4Y3RcaPxkckLk5eAWKC0fmKD3R+KMMnKQOumCJswM50xa7E/aZbfwuDJa3IT5D
 aPDjX23Ey375OziJ+oJbEbjgMoHeBLJFLc/8aGD5DgSKMHePVFzU7UPxhhXd99F7CAehBo8By
 aRKzxKqrrr/vAOCoMzAQjni9IUQR5zClS//1Oz0Yxs7LyJswBEHJq9M64sKeZjKK3DejFqi+J
 46/OWtE9rbbFtyUpROPVP1TXO/nofr1p+BALZ1ewHs9S0P8updImcnmqziYSiWg86HyHRsby1
 q/vKVW1J/IILQ8XMJeWWwMIK+GPRNgK8ji8tL1csJvIFufGrmECqm4GiTDxe+2BTtxuoHJ+A0
 7QnfKfMcep8Lq3IEFv9ZXe8qBarhhZwOmSoO1+FQJbncqWQ2aiEiIDv3PaqPR3NpYKPfKe+uI
 h6+rWnt2meDvojcfOX/memSCZUJfzWQUAoJZTJcQTpMnCWRWQOtiygtwbfZDd4/xrgB6UVJly
 Nlg5kGJtrr8rx1WE+/LPGiTdrPqABL1Z6ANLKhNW7zBaIAc+SIBCWVVAvROEAfpy4m8s0ycjz
 MkETTIrUUJC8ZDWDR0HDGfFl7+FycCd/6gUabKD77BaTphb3D6mnBcdj0HpuhKyeJXJCOSokm
 7TNqAIO7eoSskH0hSKjMH1+sCjWaTZJQVxaMQRKOn5hB9Qnwd5+p14vhLxWxxzjY8Ya5yORHo
 PF6ZsSz01IPpNeCTOyBvO8VAs6mDU1XmoeB69JZ2d936ooCy+nEyKVUbZOG3jpxFsSFzQEBbL
 0Lt/QUMqN5TrFTzUztBg5c5EJC/9NfKIz2bJyxUBnKBGtXmYADxLhnKAFiRJOZ8QyNf727u5q
 ejzXhW80nGl3gWipYZXBRCfL3qlrbMkOecnClXoeJo7WYfPtdErTaF15BB15F0bXcjj1uG6PU
 dJpEG2vofSuXmtY5ORC7NPDJ8sU8Ke2dRvc1A/x/s1fMuqCs7U//1Kp4t3PqEW/57biBv3+1U
 PcjlbmMgH3LbLE5DEDbN1gPbz96xx3rmT1tf5hq+Z6iGownblKhEvsPJOH+t0HAdURCP95+pU
 IxTOrOn9xopY4KgAbAJaMPwGVcWW+6haHt1krxw+kVvJP+nmadKtXKgMWFie4YgwzEkDzKi5U
 YchjMVtNVAF53vOpqWw3RFmhADt7jYl3W0VNWP+yo5R0wm80f2F0oZsyBuz5+6jNHC460YP66
 Pw85O/K+mTZTnM1nO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull another set of patches for the parisc architecture for kernel 5.9-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.9-2

This patchset includes:
- Oscar Carter contributed a patch which fixes parisc's usage of
  dereference_function_descriptor() and thus will allow using the
  -Wcast-function-type compiler option in the top-level Makefile
- Sven Schnelle fixed a bug in the SBA code to prevent crashes during kexec
- John David Anglin provided implementations for __smp_store_release() and
  __smp_load_acquire barriers() which avoids using the sync assembler
  instruction and thus speeds up barrier paths
- Some whitespace cleanups in parisc's atomic.h header file

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (2):
      sections.h: dereference_function_descriptor() returns void pointer
      parisc: Whitespace cleanups in atomic.h

John David Anglin (1):
      parisc: Implement __smp_store_release and __smp_load_acquire barriers

Oscar Carter (1):
      parisc/kernel/ftrace: Remove function callback casts

Sven Schnelle (1):
      parisc: mask out enable and reserved bits from sba imask

 arch/parisc/include/asm/atomic.h  |  8 ++---
 arch/parisc/include/asm/barrier.h | 61 +++++++++++++++++++++++++++++++++++++++
 arch/parisc/kernel/ftrace.c       |  3 +-
 drivers/parisc/sba_iommu.c        |  2 +-
 include/asm-generic/sections.h    |  4 +--
 5 files changed, 70 insertions(+), 8 deletions(-)
