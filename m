Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A169C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326072084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgIDX0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 19:26:33 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34844 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgIDX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:26:28 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 8929E2ACC0; Fri,  4 Sep 2020 19:26:27 -0400 (EDT)
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <896f542e5f0f1d6cf8218524c2b67d79f3d69b3c.1599260540.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1599260540.git.fthain@telegraphics.com.au>
References: <cover.1599260540.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 1/5] powerpc/tau: Use appropriate temperature sample interval
Date:   Sat, 05 Sep 2020 09:02:20 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the MPC750 Users Manual, the SITV value in Thermal
Management Register 3 is 13 bits long. The present code calculates the
SITV value as 60 * 500 cycles. This would overflow to give 10 us on
a 500 MHz CPU rather than the intended 60 us. (But according to the
Microprocessor Datasheet, there is also a factor of 266 that has to be
applied to this value on certain parts i.e. speed sort above 266 MHz.)
Always use the maximum cycle count, as recommended by the Datasheet.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/powerpc/include/asm/reg.h |  2 +-
 arch/powerpc/kernel/tau_6xx.c  | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 88e6c78100d9b..c750afc62887c 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -815,7 +815,7 @@
 #define THRM1_TIN	(1 << 31)
 #define THRM1_TIV	(1 << 30)
 #define THRM1_THRES(x)	((x&0x7f)<<23)
-#define THRM3_SITV(x)	((x&0x3fff)<<1)
+#define THRM3_SITV(x)	((x & 0x1fff) << 1)
 #define THRM1_TID	(1<<2)
 #define THRM1_TIE	(1<<1)
 #define THRM1_V		(1<<0)
diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index e2ab8a111b693..976d5bc1b5176 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -178,15 +178,11 @@ static void tau_timeout(void * info)
 	 * complex sleep code needs to be added. One mtspr every time
 	 * tau_timeout is called is probably not a big deal.
 	 *
-	 * Enable thermal sensor and set up sample interval timer
-	 * need 20 us to do the compare.. until a nice 'cpu_speed' function
-	 * call is implemented, just assume a 500 mhz clock. It doesn't really
-	 * matter if we take too long for a compare since it's all interrupt
-	 * driven anyway.
-	 *
-	 * use a extra long time.. (60 us @ 500 mhz)
+	 * The "PowerPC 740 and PowerPC 750 Microprocessor Datasheet"
+	 * recommends that "the maximum value be set in THRM3 under all
+	 * conditions."
 	 */
-	mtspr(SPRN_THRM3, THRM3_SITV(500*60) | THRM3_E);
+	mtspr(SPRN_THRM3, THRM3_SITV(0x1fff) | THRM3_E);
 
 	local_irq_restore(flags);
 }
-- 
2.26.2

