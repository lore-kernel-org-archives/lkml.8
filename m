Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C26C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D5420714
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 18:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCUS3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:29:49 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55247 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgCUS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 14:29:49 -0400
Received: from methusalix.internal.home.lespocky.de ([109.250.103.118]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3KgE-1jO4nw26K2-010MvO; Sat, 21 Mar 2020 19:29:14 +0100
Received: from lemmy.internal.home.lespocky.de ([192.168.243.175] helo=lemmy.home.lespocky.de)
        by methusalix.internal.home.lespocky.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <alex@home.lespocky.de>)
        id 1jFirv-0001nE-5w; Sat, 21 Mar 2020 19:29:12 +0100
Received: (nullmailer pid 2075 invoked by uid 2001);
        Sat, 21 Mar 2020 18:29:10 -0000
From:   Alexander Dahl <post@lespocky.de>
To:     x86@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Dahl <post@lespocky.de>
Subject: [PATCH v2] dma: Fix max PFN arithmetic overflow on 32 bit systems
Date:   Sat, 21 Mar 2020 19:28:23 +0100
Message-Id: <20200321182823.1912-1-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319153154.usbqsk6uspegw5pr@falbala.internal.home.lespocky.de>
References: <20200319153154.usbqsk6uspegw5pr@falbala.internal.home.lespocky.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scan-Signature: 2e89b8130284c79aa2484230574bb425
X-Provags-ID: V03:K1:BwocxLOhIIXx/bGnuVJFUi7zAE50Mb5DLFLlyuLG5Ay844jcgwI
 LQmCr8a3NyIY70JC5hnQ/5YRx7Zm3RKsrlAPyyXV2/6EUM31EZdZnbqYpbZZOFqiYV3fpzq
 PLEL8udppjzIByLsmu9NcHIS0o7vE9vl/d0mg0e8xLeky46vfdORyXdl3P5g6TIKHqv3SJT
 6yRaH1Iw2QZ/X/SnVBxhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dmeT3XHEs7M=:2/5OPJDlT0razmHb6Xylsw
 Qw5t6oz4xwqNi13QsjhqSLhuPw5FsDeogLiMe7+tXP82d80tn0gNX05wFxZksNoOzuGc3rPGo
 x4YOjGTuhtgXnoE8FmZhiOGUoFer4yfB9+U64sxyWmYK4nnhG5Dd+mhTqNqaCN291RwzrccMB
 /8HtB8G8qYIRg+9HRA8ovq4cqkKBPzKAB3sUWTBI3rEgcI2J/V/FUi/v/BylQygUFlSbY+p32
 iRUIFTopteboi3CO6ar4Lvkd8sMAAQZvLmJmwRHVU/YaKrNaW5vckRVZCsPB4MENpyquq+xV0
 aqo5WC4ETbg3UZYM9/rZU5of29NS4mLE9xl0HOb1HeTC7z+1OYhuHjpdP1WKlxP1ztm5icRPc
 mzS292sFD0ao5tUYHP75zARgE5FBf+LCBdFNCmUi6i6lOfmgwM9SJO9RZRG8z1Qf5CrUBokfc
 HnR1Cl8hJ03lPOiMRZhOQ3PHNzY85OTohzWLqt1wvwRmb/ey69a837x1rXsGOR0mhkKmdmEHK
 FbSPp0lSMumvLTqaaVlotW4iq1clfHjM6B+tSHfIHNSqqHitz8hb00sj6IfaVRcKHqgX871s+
 yLkiR/M+wNecaazkQrzHGJL64ki3K2gDf5dqgHcLgWnzpIIiORPE6zTvYY0neBYc4A4glkJLg
 Uqq0RJizwlaJBtGHswNEhqcUbXVBER4FFNRA/MaKoo36f/nyTpzBo/5FPmgGHFVQYSup+pmOK
 +rwOqP+QXnW5b00VKgiALPW4qv9Npsffv1DPmVjGSTR8VyL5FXtnQhzTiYVkXoGFGjrTbONDV
 DkXxOyAIicJikQg0Z0iJWuopKLO+CSMdecpKYgMbFMwFfyAz+4KaZWGfszalTxAZRUOS0yi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ARCH=x86 (32 bit) when you set CONFIG_IOMMU_INTEL since c5a5dc4cbbf4
("iommu/vt-d: Don't switch off swiotlb if bounce page is used") there's
a dependency on CONFIG_SWIOTLB, which was not necessarily active before.

The init code for swiotlb in 'pci_swiotlb_detect_4gb()' compares
something against MAX_DMA32_PFN to decide if it should be active.
However that define suffers from an arithmetic overflow since
1b7e03ef7570 ("x86, NUMA: Enable emulation on 32bit too") when it was
first made visible to x86_32.

The effect is at boot time 64 MiB (default size) were allocated for
bounce buffers now, which is a noticeable amount of memory on small
systems. We noticed this effect on the fli4l Linux distribution when
migrating from kernel v4.19 (LTS) to v5.4 (LTS) on boards like pcengines
ALIX 2D3 with 256 MiB memory for example:

  Linux version 5.4.22 (buildroot@buildroot) (gcc version 7.3.0 (Buildroot 2018.02.8)) #1 SMP Mon Nov 26 23:40:00 CET 2018
  …
  Memory: 183484K/261756K available (4594K kernel code, 393K rwdata, 1660K rodata, 536K init, 456K bss , 78272K reserved, 0K cma-reserved, 0K highmem)
  …
  PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
  software IO TLB: mapped [mem 0x0bb78000-0x0fb78000] (64MB)

The initial analysis and the suggested fix was done by user 'sourcejedi'
at stackoverflow and explicitly marked as GPLv2 for inclusion in the
Linux kernel:

  https://unix.stackexchange.com/a/520525/50007

The actual calculation however is the same as for arch/mips now as
suggested by Robin Murphy.

Fixes: https://web.nettworks.org/bugs/browse/FFL-2560
Fixes: https://unix.stackexchange.com/q/520065/50007
Reported-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Alexander Dahl <post@lespocky.de>
---

Notes:
    v1 -> v2:
      - use the same calculation as with arch/mips (Robin Murphy)

 arch/x86/include/asm/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
index 00f7cf45e699..8e95aa4b0d17 100644
--- a/arch/x86/include/asm/dma.h
+++ b/arch/x86/include/asm/dma.h
@@ -74,7 +74,7 @@
 #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
 
 /* 4GB broken PCI/AGP hardware bus master zone */
-#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
+#define MAX_DMA32_PFN (1UL << (32 - PAGE_SHIFT))
 
 #ifdef CONFIG_X86_32
 /* The maximum address that we can perform a DMA transfer to on this platform */
-- 
2.20.1

