Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C795C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01052065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A9q2xqO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgGPNF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgGPNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:05:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF412C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:05:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z3so3649965pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGzmIzqJnm7CKiLoQ8H6AcVjxIg7aO11yFeUG1Srnrs=;
        b=A9q2xqO9qU7vO2PYAJ7sDGqDrFpOQhpO18YI1qzAdojQMgDPA9vvbwy6Dr+qGyMlCt
         0hu0x4+MjSDu59Y1L4wyeRpS1SBGMk/weFFlmPqqkWNwkD+jMvYZP1yfV7b/5+7XWHaV
         cXMf2/u/3oSKMUlCX4vV2knvHwlk/NIvsKJonyc9mbygZbI1RX6+2ut3TJxs8vm1MT7O
         6OqsthAU2ZM5XML9B4JgoAmxMBS8EqYWHIAtatLVxwCfrq752o0gpHG/Xv2wptWcFf4F
         0nTOxf1XAJQALDR0EOPkwADZwKZA9JIxftA8904XOF/qPSngheKnxRmZL8dZmy/1v0HU
         jV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGzmIzqJnm7CKiLoQ8H6AcVjxIg7aO11yFeUG1Srnrs=;
        b=SoaOS5Kkqjur0OfH3YNAecpBG4PYEzJyEWc4oyGsJSY2og6ZCKvnCl9y1rRLdEHrbc
         NZ9cM+Z0KthWnYFgfThCTmEe9VGmUCq4pk0i4yBV0/muugBjonQue+U2D81qSaox4X3C
         7/jvJLPOd3EUZMaaYfjxV2ChIqaDenuDIqV1YusKxT7cSr3pUyfbVsiXFf7lbQuTLDPz
         vnFCosxQPvf11GK2wb6MMZdis/Bx8K36/cZLTVGsdGbFv53DWVBmcO85bgTIHIS8URrd
         8HgvDjLEwzbrEC20aI/Uyt2mrUsgwRxapJbhFoI4JuoZy9HQXJrkszHiHLVN/papjStd
         ApqQ==
X-Gm-Message-State: AOAM530WWvFlX98XiOVh7X0gQqGY8aE+xRYi9uhaplL+muO4J8ABDeF4
        7K1MW32LmLH/EZcRX05ntV/nwQ==
X-Google-Smtp-Source: ABdhPJwGEOBlmUcQ6k6tnLCKBcSWT/f0cdQf1kOitNTShXHuFHrwdKJCFKyv96KFR+kV2UBc8bbkWA==
X-Received: by 2002:a63:4a4c:: with SMTP id j12mr4317304pgl.115.1594904754427;
        Thu, 16 Jul 2020 06:05:54 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id c134sm4770203pfc.115.2020.07.16.06.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:05:53 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>, Pekka Enberg <penberg@kernel.org>
Subject: [PATCH v2 2/2] riscv: Fix build warning for mm/pageattr
Date:   Thu, 16 Jul 2020 21:05:46 +0800
Message-Id: <8691a6a78271c748a2f75f1430b36f304551838d.1594886530.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594886530.git.zong.li@sifive.com>
References: <cover.1594886530.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header for missing prototype. Also, static keyword should be at
beginning of declaration.

The warning messages as follows (with W=1 build):

arch/riscv/mm/pageattr.c:130:5:
warning: no previous prototype for 'set_memory_ro' [-Wmissing-prototypes]

arch/riscv/mm/pageattr.c:136:5:
warning: no previous prototype for 'set_memory_rw' [-Wmissing-prototypes]

arch/riscv/mm/pageattr.c:142:5:
warning: no previous prototype for 'set_memory_x' [-Wmissing-prototypes]

arch/riscv/mm/pageattr.c:147:5:
warning: no previous prototype for 'set_memory_nx' [-Wmissing-prototypes]

arch/riscv/mm/pageattr.c:152:5:
warning: no previous prototype for 'set_direct_map_invalid_noflush' [-Wmissing-prototypes]

arch/riscv/mm/pageattr.c:169:5:
warning: no previous prototype for 'set_direct_map_default_noflush' [-Wmissing-prototypes]

arch/riscv/mm/pageattr.c:97:1:
warning: 'static' is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Pekka Enberg <penberg@kernel.org>
---
 arch/riscv/mm/pageattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 289a9a5ea5b5..19fecb362d81 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -7,6 +7,7 @@
 #include <linux/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/bitops.h>
+#include <asm/set_memory.h>
 
 struct pageattr_masks {
 	pgprot_t set_mask;
@@ -94,7 +95,7 @@ static int pageattr_pte_hole(unsigned long addr, unsigned long next,
 	return 0;
 }
 
-const static struct mm_walk_ops pageattr_ops = {
+static const struct mm_walk_ops pageattr_ops = {
 	.pgd_entry = pageattr_pgd_entry,
 	.p4d_entry = pageattr_p4d_entry,
 	.pud_entry = pageattr_pud_entry,
-- 
2.27.0

