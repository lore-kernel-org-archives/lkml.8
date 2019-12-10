Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED0C2D0EE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C425206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgC1Qnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:55 -0400
Received: from mx.sdf.org ([205.166.94.20]:49939 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgC1Qno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:44 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhMAI029531
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:22 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhMtr029198;
        Sat, 28 Mar 2020 16:43:22 GMT
Message-Id: <202003281643.02SGhMtr029198@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Tue, 10 Dec 2019 10:45:27 -0500
Subject: [RFC PATCH v1 39/50] arm: kexec_file: Avoid temp buffer for RNG seed
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After using get_random_bytes(), you want to wipe the buffer
afterward so the seed remains secret.

In this case, we can eliminate the temporary buffer entirely.
fdt_setprop_placeholder returns a pointer to the property value
buffer, allowing us to put the random data directy in there without
using a temporary buffer at all.  Faster and less stack all in one.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/machine_kexec_file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 7b08bf9499b6b..69e25bb96e3fb 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -106,12 +106,12 @@ static int setup_dtb(struct kimage *image,
 
 	/* add rng-seed */
 	if (rng_is_initialized()) {
-		u8 rng_seed[RNG_SEED_SIZE];
-		get_random_bytes(rng_seed, RNG_SEED_SIZE);
-		ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED, rng_seed,
-				RNG_SEED_SIZE);
+		void *rng_seed;
+		ret = fdt_setprop_placeholder(dtb, off, FDT_PROP_RNG_SEED,
+				RNG_SEED_SIZE, &rng_seed);
 		if (ret)
 			goto out;
+		get_random_bytes(rng_seed, RNG_SEED_SIZE);
 	} else {
 		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
 				FDT_PROP_RNG_SEED);
-- 
2.26.0

