Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD48C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D0120575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgEMWCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:02:44 -0400
Received: from v6.sk ([167.172.42.174]:54296 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbgEMWCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:02:43 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 66010610A5;
        Wed, 13 May 2020 22:02:10 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] drm/etnaviv: Fix the pm_domain lookup
Date:   Thu, 14 May 2020 00:02:04 +0200
Message-Id: <20200513220204.1366296-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a GC860 (both 3D and 2D capable) GPU, kmscube crashes:

  # strace -f ~lkundrak/src/kmscube/build/kmscube
  ...
  ioctl(6, DRM_IOCTL_ETNAVIV_PM_QUERY_DOM, 0xbe92b720) = 0
  ioctl(6, DRM_IOCTL_ETNAVIV_PM_QUERY_SIG <unfinished ...>) = ?
  +++ killed by SIGSEGV +++
  Segmentation fault (core dumped)

And triggers an oops:

  8<--- cut here ---
  Unable to handle kernel NULL pointer dereference at virtual address 00000000
  pgd = 40e2c0f7
  [00000000] *pgd=0df6d831, *pte=00000000, *ppte=00000000
  Internal error: Oops: 17 [#1] PREEMPT SMP ARM
  Modules linked in:
  CPU: 0 PID: 346 Comm: kmscube Not tainted 5.7.0-rc4+ #792
  Hardware name: Marvell MMP2 (Device Tree Support)
  PC is at strncpy+0x14/0x30
  LR is at etnaviv_pm_query_sig+0xd0/0x104
  pc : [<c04f35f4>]    lr : [<c05dd878>]    psr: 20010013
  sp : c85f5e00  ip : c85f5eb5  fp : beb58748
  r10: 0000004c  r9 : ca6f9100  r8 : c85f5e6c
  r7 : 00000050  r6 : c85f5e6c  r5 : 00000001  r4 : c0b69ae8
  r3 : c85f5e75  r2 : 0000003f  r1 : 00000000  r0 : c85f5e76
  Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
  Control: 10c5387d  Table: 0df70019  DAC: 00000051
  Process kmscube (pid: 346, stack limit = 0x816fba31)
  Stack: (0xc85f5e00 to 0xc85f6000)
  5e00: 00000000 d90e6000 00000020 c05d5b2c c85f5e6c c059ce90 00000000 c1003f88
  5e20: c04c644b 0000004c c0b69610 c04c644b c85f5e6c 0000004b ca6f9100 c059d0bc
  5e40: 00000001 c0d53ee8 c85f5f18 00000001 c85f5f50 c85f5e6c 0000004c c8454240
  5e60: c05d5b2c 00000051 00000000 00000000 00000001 00000000 00000000 00000000
  5e80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  5ea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000274 c011c3fc
  5ec0: 00000100 c0290434 5ebc5632 30e03501 5ebc5632 c8526600 00000274 00100cca
  5ee0: 00000831 b64c5000 cdf72d90 c1003f88 00000000 c04c644b c8454240 beb58748
  5f00: c8454240 00000006 c85f4000 d90ecad8 001c01a0 c02d49ac b64c52cc 80000007
  5f20: da9d6dc0 d9aa4000 d9aa4040 00000000 00000274 c011818c 00000005 0e200080
  5f40: 00000000 000003e5 00000000 00000100 00000000 00000000 00000000 cc78ac40
  5f60: 00000006 00000007 c1009a98 b64c52cc c85f5fb0 c0118080 00000080 c1003f88
  5f80: 00000000 00000001 beb58748 c04c644b 00000036 c0100288 c85f4000 00000036
  5fa0: 001c01a0 c0100060 00000001 beb58748 00000006 c04c644b beb58748 0000004c
  5fc0: 00000001 beb58748 c04c644b 00000036 beb58748 001bd688 beb58700 001c01a0
  5fe0: b6f41f08 beb586d4 b6f2784c b6e16cec 80010010 00000006 00000000 00000000
  [<c04f35f4>] (strncpy) from [<c05dd878>] (etnaviv_pm_query_sig+0xd0/0x104)
  [<c05dd878>] (etnaviv_pm_query_sig) from [<c059ce90>] (drm_ioctl_kernel+0xb4/0xf8)
  [<c059ce90>] (drm_ioctl_kernel) from [<c059d0bc>] (drm_ioctl+0x1e8/0x3b8)
  [<c059d0bc>] (drm_ioctl) from [<c02d49ac>] (ksys_ioctl+0xe0/0xaf0)
  [<c02d49ac>] (ksys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
  Exception stack(0xc85f5fa8 to 0xc85f5ff0)
  5fa0:                   00000001 beb58748 00000006 c04c644b beb58748 0000004c
  5fc0: 00000001 beb58748 c04c644b 00000036 beb58748 001bd688 beb58700 001c01a0
  5fe0: b6f41f08 beb586d4 b6f2784c b6e16cec
  Code: 012fff1e e2422001 e2403001 e080c002 (e5d12000)
  ---[ end trace 387aad33cd9c15ea ]---

Turns out that it's because pm_domain() returns a pointer outside any
any of the etnaviv_pm_domains. Unless I'm mistaken, the algorithm in
pm_domain() is entirely botched when GPU's features match more than one
domain. This tries to remedy it.

Tested with kmscube with mesa 20 on ome machine with GC860 and another
with GC2000 + GC300 pair.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index e6795bafcbb9..9dc1bb4d4582 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -444,7 +444,6 @@ static unsigned int num_pm_domains(const struct etnaviv_gpu *gpu)
 static const struct etnaviv_pm_domain *pm_domain(const struct etnaviv_gpu *gpu,
 	unsigned int index)
 {
-	const struct etnaviv_pm_domain *domain = NULL;
 	unsigned int offset = 0, i;
 
 	for (i = 0; i < ARRAY_SIZE(doms_meta); i++) {
@@ -453,15 +452,15 @@ static const struct etnaviv_pm_domain *pm_domain(const struct etnaviv_gpu *gpu,
 		if (!(gpu->identity.features & meta->feature))
 			continue;
 
-		if (meta->nr_domains < (index - offset)) {
+		if (meta->nr_domains <= (index - offset)) {
 			offset += meta->nr_domains;
 			continue;
 		}
 
-		domain = meta->domains + (index - offset);
+		return meta->domains + (index - offset);
 	}
 
-	return domain;
+	return NULL;
 }
 
 int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
-- 
2.26.2

