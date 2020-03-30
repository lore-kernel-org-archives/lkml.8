Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEF0C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23702073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgC3RiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:38:22 -0400
Received: from mx.sdf.org ([205.166.94.20]:52290 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgC3RiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:38:22 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02UHc2SK002031
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 30 Mar 2020 17:38:02 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02UHc1dq024983;
        Mon, 30 Mar 2020 17:38:01 GMT
Date:   Mon, 30 Mar 2020 17:38:01 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, lkml@sdf.org
Subject: [PATCH v2] arm64: kexec_file: Avoid temp buffer for RNG seed
Message-ID: <20200330173801.GA9199@SDF.ORG>
References: <202003281643.02SGhMtr029198@sdf.org>
 <20200330133701.GA10633@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330133701.GA10633@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After using get_random_bytes(), you want to wipe the buffer
afterward so the seed remains secret.

In this case, we can eliminate the temporary buffer entirely.
fdt_setprop_placeholder() returns a pointer to the property value
buffer, allowing us to put the random data directly in there without
using a temporary buffer at all.  Faster and less stack all in one.

Signed-off-by: George Spelvin <lkml@sdf.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
v2: Typos in commit message fixed.

Thank you, I'd be delighted if you'd apply it to the arm64 tree directly!  
I can take it out of my patch series and off my plate.

Now that I'm looking at it some more, I want to change
fdt_setprop_placeholder to return an ERR_PTR.
Must. Stop. Scope. Creep.

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
