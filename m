Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C76C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FC2208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHJgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:36:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgEHJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:36:15 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M593i-1jVsxU00vs-00197T; Fri, 08 May 2020 11:35:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: use -fno-strict-aliasing for decompressor
Date:   Fri,  8 May 2020 11:35:43 +0200
Message-Id: <20200508093553.2742898-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7tDpWFlk5uE8Zir9SrJMuuF0lDc+G5XvFh0IJYTt1zb9FMbuj2J
 SvQ76u9u7CLw2g6LsA3FdoiteKYk1/NG8ht+HeRL0I+6XdM4Y0YfI5by5GXmxtrkPVxZMWw
 6rAG3VCOAftkDcWL+Sst/+2eBsjF13GnUUmOuNMCp7DDqrOSjf/OGdh1QK3B4n2GQAsS2e2
 rODk1B46J0aXokZsatwQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zkseO91Qx9s=:f6TijkTq/87j1JoL9LHGz7
 zStj/Xd3A5Fb6dbgE34zkJy1caUuRhZ7uo0wXEOWwMeJNLUdZ9GS9Hxayn6+iA67fUX1l8hcu
 QEoAI3rcm1UeVJE0uLf9pn0qVz2aLq+zD2kujtAzBL5K89zbTDjILvDOLma81gSj/ViV/VpGO
 pDei9qYhnyN6tA10wq12E5aKv8+w+ql55LqXuPO84Bn/PwPPJZb90LXM1CL7eIXWq1HQyjTSk
 3zAM66bbLutfb5dC8a8lgubmFl2bIrhm61F0XsNb09RxvoKBjXX8H6Uao2cgf8jTi5I4kRBlR
 RYrsf9db0Pi0J7OusVYl3velY8lBg4jJyQIFN7huEyIhg+hAnHWMFJhy3rksa5TOecGUDjPiq
 6KtRIlRndZdAPRlCJZAX9JyCe0jDtuMxAaw4Ue6oz3c1g3J5h7N2NOlj7vPZJYFbqwMaSjDPo
 lk6vCMYG61CJv+uJHFT/23jhE9MjN6gWQrCwhaaHk0Q/8U7kTgx7zvpAyPjQOv7Kc+e4YwtsB
 q+Gjs6xmQeFAc5Kyx7Sip/+2uNjtdopCDe/f6P0e0tx0FRPPLmuGo293eyaMkrizH7d3Vl+Lj
 ISIM+Dgymyk7FsbOtDv3WR+njdTpM/cgAaEzgbICyfeAQNLiNuiOcvIb2VC7UuSD/pXaIr350
 QgOaZSRZtrUjyQFO2AkRHUN4gF62L6k+z0Xr08BYTMXpZzfPxGx8bbPOiLR9me3zRqz1eAoPp
 6qqp3N3UuxDbdaSeZ/x35dMYkM/IEXfB8Js9FFTfAGLNdlt/GTxzbEdTRKqIOWsQ+Q2iz/vAC
 Dj7nFtDJtkwR/h8OSCvZ3+9flJH2h3cKzWV4zSp/CIsbiwNCEs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An experimental patch series of mine reworks how warnings are processed
in Kbuild. A side effect is a new warning about a harmless aliasing
rule violation in an inline function:

In file included from
include/linux/rhashtable-types.h:15:0,
                 from include/linux/ipc.h:7,
                 from include/uapi/linux/sem.h:5,
                 from include/linux/sem.h:5,
                 from include/linux/sched.h:15,
                 from include/linux/uaccess.h:6,
                 from arch/parisc/boot/compressed/misc.c:7:
include/linux/workqueue.h: In function 'work_static':
include/linux/workqueue.h:212:2: warning: dereferencing
type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
  return *work_data_bits(work) & WORK_STRUCT_STATIC;

Make the decompressor use -fno-strict-aliasing like the rest of
the kernel for consistency, and to ensure this warning never makes
it into a release.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 1e5879c6a752..dff453687530 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -16,6 +16,7 @@ targets += real2.S firmware.c
 
 KBUILD_CFLAGS := -D__KERNEL__ -O2 -DBOOTLOADER
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS += -fno-strict-aliasing
 KBUILD_CFLAGS += $(cflags-y) -fno-delete-null-pointer-checks -fno-builtin-printf
 KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
 ifndef CONFIG_64BIT
-- 
2.26.0

