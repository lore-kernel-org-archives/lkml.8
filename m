Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C5FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA18E206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="LEGLnPFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHTDUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHTDUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:20:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC25C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:20:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so354335pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vHdrsdj7gDMqy4NNagh59xCi/uOR6KtwQRJPQeC1kI=;
        b=LEGLnPFwabL4I09BLHdpUnbz0CLjPeNfX8cVNM4NEK/bZjnBLNfNUXYRp5n7abzhcS
         SHN/b7Ru3/wVsLZAbIQbsTDD27kbbk6TruGkytRHix3UN/KWcCJ+09EPrBDHmiY/RjAA
         sBtNsjoNjIhPPWlDkxV5ll01Z0gFMIZ3Muvs51tgmU2AjT4T+joOTixTgv+83k+eIB2v
         e7FKUcvMmHCaJggsTGwivLpwo39qq6TQXdkKD3J2bL10unWqvalC92Uv88nJ3MrCOo6+
         ZLf08aPpMWFIZnDYCNUBq4nQERJSjL2cIYrr2pM/LVEXslsdPVoi9ber+OqgY+cP7rmL
         oHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vHdrsdj7gDMqy4NNagh59xCi/uOR6KtwQRJPQeC1kI=;
        b=X5YDqO0qpZlBruYpYnOI5tqCUiSjO7a8nCR3hEMqm7570TZa3a1h9wHbX4KA4Jgx4v
         sOrbPvQPGszCylLh2Mte23yW7EMV5A2iyKhIzP2uGbtZgYW93wLGj8qdhJpc+AfLzWnm
         6nAfUljLPlzU4MCPVEfzy0pnW/bC2Hispe8KXOdcDekS8noVoeAEI305xaDZYsiZJc+j
         L/d+FlLBRxumi+AlLhh9pVPd+UIMJo+ZQXmclmpaAF3WF8Z9GizkyzMrLj25jpewrzsC
         bvj/bBbWDpdvIIk2aEvdVcDf2GdGHKu81vC3W/WhS+yA9sydkCyChpUUH/muUczuHKnb
         kXpA==
X-Gm-Message-State: AOAM531/t2Uyc0ZemlJdmbztFKHBwDJ+5LXM9xrKG0GrUMRBVcxtD94W
        JLlRJUU7Tn3L26LmM6mZUYR4MQ==
X-Google-Smtp-Source: ABdhPJwOE+UlDgl7Rls0FbuxVICl17fIZckvJfd+ErwHQHv0Y5mJDQGFM2BumF/dD+MR0pD0N2kbBg==
X-Received: by 2002:a17:902:ee4b:: with SMTP id 11mr1044526plo.294.1597893618423;
        Wed, 19 Aug 2020 20:20:18 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.221.67])
        by smtp.gmail.com with ESMTPSA id g5sm701511pfh.168.2020.08.19.20.20.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 20:20:17 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, songliubraving@fb.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] kprobes: Fix kill kprobe which has been marked as gone
Date:   Thu, 20 Aug 2020 11:19:33 +0800
Message-Id: <20200820031933.46025-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a kprobe is marked as gone, we should not kill it again. Otherwise,
we can disarm the kprobe more than once. In that case, the statistics
of kprobe_ftrace_enabled can unbalance which can lead to that kprobe
do not work.

Fixes: 0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/kprobes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d36e2b017588..7bac3ea44ff4 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2422,7 +2422,10 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry(p, head, hlist)
+		hlist_for_each_entry(p, head, hlist) {
+			if (kprobe_gone(p))
+				continue;
+
 			if (within_module_init((unsigned long)p->addr, mod) ||
 			    (checkcore &&
 			     within_module_core((unsigned long)p->addr, mod))) {
@@ -2439,6 +2442,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 				 */
 				kill_kprobe(p);
 			}
+		}
 	}
 	if (val == MODULE_STATE_GOING)
 		remove_module_kprobe_blacklist(mod);
-- 
2.11.0

