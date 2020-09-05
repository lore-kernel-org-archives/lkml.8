Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC33C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B452072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL62SZE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgIENU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgIENUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:20:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E77C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:20:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so6116018pfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3M12r6RBsgDh9Kn7e4dzNB2fHG/fqe+ly7p4h+ugstE=;
        b=dL62SZE+PPlLRxt+Ptikpj96vd99o31DUJX7SKAqCdm5ULXLVFP40N4tHovLGVMN4T
         QLb2gpOqckjeMjbpyq1LcyjW/Z+zquvGapHE3dy5BqGLR3/D0nlqW2gRagGhXBMz497C
         /n4/Aclo4uUuAQDXn4I9PwbAKfKRhOqXDYYXeyqb2HGez5LHAHMHVPURC8PovEBCV2KA
         xd2hPsm9KSlkNddthIlp2mAKVVULCOsM45jnMrNuHQl/MZxBlk5yaF0vmE2kRwwdTRok
         zyXHsA7A0Qh6rFxF10/vvp882dhW8C/0Ilh6mgsB6GTQAygkTv7y1+aD/F8YVy/eMF6f
         sKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3M12r6RBsgDh9Kn7e4dzNB2fHG/fqe+ly7p4h+ugstE=;
        b=MDpvoWGCvyaloEUp5oFH89QI2oBo0lHE7spHJlxlx51YTFWbSrA3I1oGCT5Jdq6Ggz
         dJBLGdtO1YAA3LipjyDzVK8fhrK/IteKkCyihL0BQYZZVA/zdYZUaCN9XkjUBNK7kMQx
         SdNpxjPNNHeaxyJdxRfDNv611iZduINbY3uhBWMTJJC7sj1JIKqblTVKLqSnBbgGUMyz
         yLGEEwkI8v+jt9JvwVYub+KClkrvFOnimydtlBFBwXrtiL2/y+WkujNhXnmfde0uEz8h
         ql2Sz2ZNmaq77yhu8SvP/Fehe7K0Vg8w7aBfoFahT8HxigpEOKgVcnlEIV/pvKxpfgPn
         38cg==
X-Gm-Message-State: AOAM530XVuuvhmXFNpZFLoDPYppAy8g/7wpaDHbXYoDagtcK7MgWQjZK
        y5bYB4bjf2TXzkVMipnl/qYZw0W4Hm0=
X-Google-Smtp-Source: ABdhPJxWO+qkptDPOMTPwZRyc53hCMYBkR2mBSoOwsoH3PZwxA8AzWoAuXHU0Dko62LsE0nD812dqA==
X-Received: by 2002:a63:f752:: with SMTP id f18mr10350651pgk.94.1599312013624;
        Sat, 05 Sep 2020 06:20:13 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id j18sm8478509pgm.30.2020.09.05.06.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:20:12 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 2/3] openrisc: Fix cache API compile issue when not inlining
Date:   Sat,  5 Sep 2020 22:19:34 +0900
Message-Id: <20200905131935.972386-3-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905131935.972386-1-shorne@gmail.com>
References: <20200905131935.972386-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found this when compiling a kbuild random config with GCC 11.  The
config enables CONFIG_DEBUG_SECTION_MISMATCH, which sets CFLAGS
-fno-inline-functions-called-once. This causes the call to cache_loop in
cache.c to not be inlined causing the below compile error.

    In file included from arch/openrisc/mm/cache.c:13:
    arch/openrisc/mm/cache.c: In function 'cache_loop':
    ./arch/openrisc/include/asm/spr.h:16:27: warning: 'asm' operand 0 probably does not match constraints
       16 | #define mtspr(_spr, _val) __asm__ __volatile__ (  \
	  |                           ^~~~~~~
    arch/openrisc/mm/cache.c:25:3: note: in expansion of macro 'mtspr'
       25 |   mtspr(reg, line);
	  |   ^~~~~
    ./arch/openrisc/include/asm/spr.h:16:27: error: impossible constraint in 'asm'
       16 | #define mtspr(_spr, _val) __asm__ __volatile__ (  \
	  |                           ^~~~~~~
    arch/openrisc/mm/cache.c:25:3: note: in expansion of macro 'mtspr'
       25 |   mtspr(reg, line);
	  |   ^~~~~
    make[1]: *** [scripts/Makefile.build:283: arch/openrisc/mm/cache.o] Error 1

The asm constraint "K" requires a immediate constant argument to mtspr,
however because of no inlining a register argument is passed causing a
failure.  Fix this by using __always_inline.

Link: https://lore.kernel.org/lkml/202008200453.ohnhqkjQ%25lkp@intel.com/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index 08f56af387ac..534a52ec5e66 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -16,7 +16,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static void cache_loop(struct page *page, const unsigned int reg)
+static __always_inline void cache_loop(struct page *page, const unsigned int reg)
 {
 	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
 	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
-- 
2.26.2

