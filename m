Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0BEC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8AF24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAUIu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:50:28 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49091 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbgAUIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:50:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ToHW6n0_1579596625;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHW6n0_1579596625)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:50:25 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/fpu: remove unused macros
Date:   Tue, 21 Jan 2020 16:50:11 +0800
Message-Id: <1579596611-258536-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_VALID_PKRU_BITS/PKRU_VALID_MASK are never used after it was
introduced. So better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Borislav Petkov <bp@alien8.de> 
Cc: "H. Peter Anvin" <hpa@zytor.com> 
Cc: x86@kernel.org 
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de> 
Cc: Cyrill Gorcunov <gorcunov@gmail.com> 
Cc: Dave Hansen <dave.hansen@intel.com> 
Cc: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com> 
Cc: Aubrey Li <aubrey.li@linux.intel.com> 
Cc: linux-kernel@vger.kernel.org 
---
 arch/x86/kernel/fpu/xstate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index fa31470bbf24..73c3e2e72a88 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -899,8 +899,6 @@ const void *get_xsave_field_ptr(int xfeature_nr)
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
-#define NR_VALID_PKRU_BITS (CONFIG_NR_PROTECTION_KEYS * 2)
-#define PKRU_VALID_MASK (NR_VALID_PKRU_BITS - 1)
 /*
  * This will go out and modify PKRU register to set the access
  * rights for @pkey to @init_val.
-- 
1.8.3.1

