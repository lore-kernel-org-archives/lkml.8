Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A87C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4C7206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="dHfNp/ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgGAOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgGAOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:35:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AA6C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 07:35:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m9so827657pfh.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BSf/vpHUifGkdyZX+Kgxt7sMwJIxVEANESZA5wY4Roc=;
        b=dHfNp/ZDKJqnnXwk2wz+HbWL+u7s3y8/MgUzn1RncvLd0wzgHMs6LILSC4x6IGDSJa
         Sakg/8yzQ2JjserYlOUjmKYJROY39L407Z0Db377ZnaqizFMNJRoazEitxExRXcrtMCl
         D+3KqybU3TRPVwz2S8xVl+zsQbK/f1O2I1s5fyRWGXJVYSR+Bjtd9XAvuPmRqB7cUfIo
         ZiiyvNdndbxWY7jJAwbBSNJgsOnc0OVUA9jxU8w90wGqUavhxfDIOETooWQr0Ifg7P3Q
         /NPB7jRQsv7SXyHNWpV7OkySavcVZe55RlEStX5iaOwAmplv2RFCnwp/K2ovfulRv/7a
         L1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BSf/vpHUifGkdyZX+Kgxt7sMwJIxVEANESZA5wY4Roc=;
        b=HKuzeLNvRqq9LsDGVt1C6GCTMBexlh/pOLWftyPQMOJV6wSdGqNMLCLro0Py/QksSC
         QyR5nI/VnuGsIkl4X/lyIoYK4gwoAH1Q2D82B0Y3SLsKbw4RCDanWeHM5y3ZO6JZFc/m
         yyRFEo57NeHBVBpHnTbnf9JmzZ0ct2rpvB2H/+U57zFC6YM+5RdZfTzarGqRauWop4fe
         c3QyL2Gnh4+7dTFicaf0ZwldFOywW8K4/Bku9X37KXktJP1xtRJ3A0MKLTYNDm8o2Eu7
         pHulxkVJNlz0Jm8DljXomP6v2gKaXzsbWDbGWLVWj/71uAlAF7L1zRHlFax3mtET3tLh
         PSTw==
X-Gm-Message-State: AOAM532O4XImJBlA4gMs7Q7LNoxvehAjqqTZQBY5XNcWGT9Ynz+y5kVc
        wzlnSOCRrxE+gB8ALH/MSvxxaQ==
X-Google-Smtp-Source: ABdhPJyJ2loHLGNrvZQDC+XojLat1lPdaszxAZlLnrV0qu79IoGVFF0hk598mQVzRnCr4o5B5fZcYQ==
X-Received: by 2002:a63:545e:: with SMTP id e30mr20530905pgm.62.1593614112802;
        Wed, 01 Jul 2020 07:35:12 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id 140sm6167882pfz.154.2020.07.01.07.35.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 07:35:10 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     adobriyan@gmail.com
Cc:     tglx@linutronix.de, kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] fs/proc: add short desc for /proc/softirqs
Date:   Wed,  1 Jul 2020 22:35:03 +0800
Message-Id: <1593614103-23574-1-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only softirq name is not friendly to end-users, typically 'HI' is
difficult to understand. During developing irqtop/lsirq utilities
for util-linux, Karel Zak considered that we should give more
information to end-users. Discuss about this:
    https://github.com/karelzak/util-linux/pull/1079

Add short desc for /proc/softirqs in this patch, then /proc/softirqs
gets more human-readable.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 fs/proc/softirqs.c        |  2 +-
 include/linux/interrupt.h |  5 +++--
 kernel/softirq.c          | 12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/proc/softirqs.c b/fs/proc/softirqs.c
index 12901dc..fcd21f3 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -20,7 +20,7 @@ static int show_softirqs(struct seq_file *p, void *v)
 		seq_printf(p, "%12s:", softirq_to_name[i]);
 		for_each_possible_cpu(j)
 			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
-		seq_putc(p, '\n');
+		seq_printf(p, "  %s\n", softirq_to_desc[i]);
 	}
 	return 0;
 }
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5db970b..1d51397 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -543,10 +543,11 @@ enum
 
 #define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
 
-/* map softirq index to softirq name. update 'softirq_to_name' in
- * kernel/softirq.c when adding a new softirq.
+/* map softirq index to softirq name. update 'softirq_to_name' &
+ * 'softirq_to_desc' in kernel/softirq.c when adding a new softirq.
  */
 extern const char * const softirq_to_name[NR_SOFTIRQS];
+extern const char * const softirq_to_desc[NR_SOFTIRQS];
 
 /* softirq mask and active fields moved to irq_cpustat_t in
  * asm/hardirq.h to get better cache usage.  KAO
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4201b7f..74eca3b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -61,6 +61,18 @@ const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
 };
 
+const char * const softirq_to_desc[NR_SOFTIRQS] = {
+	"high priority tasklet softirq",
+	"timer softirq",
+	"network transmit softirq",
+	"network receive softirq",
+	"block device softirq",
+	"IO poll softirq",
+	"normal priority tasklet softirq",
+	"schedule softirq",
+	"high resolution timer softirq",
+	"RCU softirq"
+};
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
  * but we also don't want to introduce a worst case 1/HZ latency
-- 
2.7.4

