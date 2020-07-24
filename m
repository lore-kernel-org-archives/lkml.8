Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930FC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467EE2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595591103;
	bh=VZAsEXY42Tu/jpAO7QoFRIOrfaTdwHMInivtUyqGbwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6KhujCmsp+B33GLpz5PUFXtHGD6+sXacgNEXU1+CdFlPQl/yc7xzIEXRZGaSW1i/
	 sK3+OlMeDDNvgkr14cg92e4g60gW/u+yYg4U5kb+SIjMWQocgRQ8rt1WOZwc9gbWdF
	 qEcdoo826NDlgxwE5KVGZIIveXUSzeo3pZmSDW2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGXLpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGXLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:44:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC4FC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:44:54 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so6820004edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Bq++MinKG9gx6bqYmIyi/tTCmoBx0S5UtA4+Ambr1A=;
        b=e0InxT7RAvz4ENlPH8srV6RgsuNLgVqlsMI/7Kf/iQPAJliwuYpJ+Ll/EfaCMCsrVu
         Q22t2OmP8ms831/ZK6grzjC4BtfGOkQPJVwbrlKls5I26UKlQhLJeq7dL6TCFKQP9TwH
         xMTA35wt8fOVNOxV0lXW1RdxJZH3hlcyNSnZWzm2oprRPIY0Mkz2YwUFjwFWWHkW4aBo
         thjN24R9Ey/OTGMJrnNMqmioBSVOEBMO6NtxK4SlPX78Xu0tyrl3tmZxKJisjKU4/c9m
         6Xgn5/UdqSSUrdtiAOId3LELT8bJ4Ko3ff16fg7+ox/T9POciZg29qI9eL/LUYRr+vdn
         oNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7Bq++MinKG9gx6bqYmIyi/tTCmoBx0S5UtA4+Ambr1A=;
        b=raufiy0FAQ8U7keXXnFQahwVdNqtV3g2wakuNw2/hVPzN3E/6nGPdk9v/AZhRI8xZI
         ectw9GPDE5oAHj79jr70SNFR+NkbFZ9GlM6ZkFiPPqs15YxU0K1gxF0KZKjIpHk0uR86
         tA4MmdKQFmVBBidQ7cvAofs4CPWM6LOXO0Ms9U4rR6PHSDXJ9rtZVyb4rzC9UskBpkGQ
         sGkdC4/vTCibO7Wbq3fpTa+J5EknEvsMblzUVnIFFxJ5ZIzNrAzbRUMsg2YCFHbfRiYN
         457WoM/BLB4OhTQ/eQR64X+nTNWrTfCDe3swejUHtu6VPDf9CrOTJKBVNV50yJxWMmma
         c9AA==
X-Gm-Message-State: AOAM533LbzJIUYilhLwaFqFjKc62gry+Z+N0uRaoY/gCcwEWhPcTb38B
        LbE420yJ7qW3PejQBfH+UiVACKds
X-Google-Smtp-Source: ABdhPJzlxVCZvmufceEBW7uQx57AzjLqh0m/MPK4ziS/8dG3PxiDMo4Zi8M3dvqgx4u12G21c7geBQ==
X-Received: by 2002:aa7:d5cd:: with SMTP id d13mr8716985eds.370.1595591093137;
        Fri, 24 Jul 2020 04:44:53 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r5sm580152edx.32.2020.07.24.04.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:44:52 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 3/3] x86/mm: Remove the unused mk_kernel_pgd() #define
Date:   Fri, 24 Jul 2020 13:44:18 +0200
Message-Id: <20200724114418.629021-4-mingo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724114418.629021-1-mingo@kernel.org>
References: <20200724114418.629021-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICS the last uses of directly 'making' kernel PGDs was removed 7 years ago:

  8b78c21d72d9: ("x86, 64bit, mm: hibernate use generic mapping_init")

Where the explicit PGD walking loop was replaced with kernel_ident_mapping_init()
calls. This was then (unnecessarily) carried over through the 5-level paging conversion.

Also clean up the 'level' comments a bit, to convey the original, meanwhile somewhat
bit-rotten notion, that these are empty comment blocks with no methods to handle any
of the levels except the PTE level.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/pgtable_64.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 1b68d24dc6a0..d2af8c48ba50 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -175,16 +175,13 @@ extern void sync_global_pgds(unsigned long start, unsigned long end);
  * and a page entry and page directory to the page they refer to.
  */
 
-/*
- * Level 4 access.
- */
-#define mk_kernel_pgd(address) __pgd((address) | _KERNPG_TABLE)
+/* PGD - Level 4 access */
 
-/* PUD - Level3 access */
+/* PUD - Level 3 access */
 
-/* PMD  - Level 2 access */
+/* PMD - Level 2 access */
 
-/* PTE - Level 1 access. */
+/* PTE - Level 1 access */
 
 /*
  * Encode and de-code a swap entry
-- 
2.25.1

