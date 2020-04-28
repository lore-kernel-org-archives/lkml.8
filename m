Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ADEC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B533206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD1FF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:05:27 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53195 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbgD1FF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:05:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TwvHWrt_1588050323;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TwvHWrt_1588050323)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Apr 2020 13:05:24 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     jeyu@kernel.org, corbet@lwn.net, rdunlap@infradead.org,
        mchehab+samsung@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        tianjia.zhang@linux.alibaba.com
Subject: [PATCH v2] module: Allow to disable modsign in kernel cmdline
Date:   Tue, 28 Apr 2020 13:05:23 +0800
Message-Id: <20200428050523.47253-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option allows to disable modsign completely at the beginning,
and turn off by set the kernel cmdline `no_modsig_enforce` when
`CONFIG_MODULE_SIG_FORCE` is enabled.

Yet another change allows to always show the current status of
modsign through `/sys/module/module/parameters/sig_enforce`.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 kernel/module.c                                 | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..00ed7566959f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3190,6 +3190,12 @@
 	noirqdebug	[X86-32] Disables the code which attempts to detect and
 			disable unhandled interrupt sources.
 
+	no_modsig_enforce
+			[KNL] When CONFIG_MODULE_SIG_FORCE is set, this option
+			allows to disable modsign completely at the beginning.
+			This means that modules without (valid) signatures will
+			success to load.
+
 	no_timer_check	[X86,APIC] Disables the code which tests for
 			broken timer IRQ sources.
 
diff --git a/kernel/module.c b/kernel/module.c
index 646f1e2330d2..0e68e1286377 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -269,6 +269,14 @@ static void module_assert_mutex_or_preempt(void)
 
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
 module_param(sig_enforce, bool_enable_only, 0644);
+#ifdef CONFIG_MODULE_SIG_FORCE
+static int __init set_no_modsig_enforce(char *str)
+{
+	sig_enforce = false;
+	return 1;
+}
+__setup("no_modsig_enforce", set_no_modsig_enforce);
+#endif /* !CONFIG_MODULE_SIG_FORCE */
 
 /*
  * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
-- 
2.17.1

