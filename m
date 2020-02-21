Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5978C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CAD24673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285462;
	bh=NQKrBHjBzSyeTsxpXWc3bXpl6Rq9kSaVFVHftSDfLtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zFBecDhB0HYJZ4dXzACSwP9nm9/kUNKQCN1fNkWSisOeQ81HedgTE5S0YhZA93cSI
	 zYk4uYRfTist4XGd9zE1+k/LDGESj3cavy5lj012DDbP7KS7Sn8p3KlLfRrIBXvzEU
	 vx/6hqFGvJJpZ9iHi9Kg/ZXSNY3YTE2GuPL5VhsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBULoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgBULoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:44:18 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BE9B24672;
        Fri, 21 Feb 2020 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285458;
        bh=NQKrBHjBzSyeTsxpXWc3bXpl6Rq9kSaVFVHftSDfLtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNqXEs/0SjsGghgbfxqJ2dVMYIl9gQdmJr8S3ZowZnLjp0bb7Rnb/itUfDkGkHLIq
         FHgq5QEzQfViXvxG1HLQFAd6mTiGWzBxNeLRW/DGf5IgeNp5da75KNO6yVV4a2QHUN
         iGeJ4CrPbaB5/KpT6zvjX4NOt1yaFgLZnI4txGHg=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, akpm@linux-foundation.org,
        Will Deacon <will@kernel.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/3] samples/hw_breakpoint: Drop use of kallsyms_lookup_name()
Date:   Fri, 21 Feb 2020 11:44:03 +0000
Message-Id: <20200221114404.14641-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221114404.14641-1-will@kernel.org>
References: <20200221114404.14641-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'data_breakpoint' test code is the only modular user of
kallsyms_lookup_name(), which was exported as part of fixing the test in
f60d24d2ad04 ("hw-breakpoints: Fix broken hw-breakpoint sample module").

In preparation for un-exporting this symbol, switch the test over to
using __symbol_get(), which can be used to place breakpoints on exported
symbols.

Cc: K.Prasad <prasad@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 samples/hw_breakpoint/data_breakpoint.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index 469b36f93696..418c46fe5ffc 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -23,7 +23,7 @@
 
 struct perf_event * __percpu *sample_hbp;
 
-static char ksym_name[KSYM_NAME_LEN] = "pid_max";
+static char ksym_name[KSYM_NAME_LEN] = "jiffies";
 module_param_string(ksym, ksym_name, KSYM_NAME_LEN, S_IRUGO);
 MODULE_PARM_DESC(ksym, "Kernel symbol to monitor; this module will report any"
 			" write operations on the kernel symbol");
@@ -41,9 +41,13 @@ static int __init hw_break_module_init(void)
 {
 	int ret;
 	struct perf_event_attr attr;
+	void *addr = __symbol_get(ksym_name);
+
+	if (!addr)
+		return -ENXIO;
 
 	hw_breakpoint_init(&attr);
-	attr.bp_addr = kallsyms_lookup_name(ksym_name);
+	attr.bp_addr = (unsigned long)addr;
 	attr.bp_len = HW_BREAKPOINT_LEN_4;
 	attr.bp_type = HW_BREAKPOINT_W;
 
@@ -66,6 +70,7 @@ static int __init hw_break_module_init(void)
 static void __exit hw_break_module_exit(void)
 {
 	unregister_wide_hw_breakpoint(sample_hbp);
+	symbol_put(ksym_name);
 	printk(KERN_INFO "HW Breakpoint for %s write uninstalled\n", ksym_name);
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

