Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B55C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EBA2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGQDEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:64377 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgGQDEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:36 -0400
IronPort-SDR: lgIBqWgI8828t/dvo+l+giqKDcHjwtWVQh5b//pjZFxkTotF0UgABoXPLvUdQItm6GfW7WHXW/
 7/pVBGRMdSSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="150911880"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="150911880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:34 -0700
IronPort-SDR: MVIEKgMVVFLb0tEnRCpp1hJSuDHZ5wku/OVBAfa6T4aB0KP6SVsOOeC5iqf+FrP0NT/HTR88lU
 6Me0OiSfKEMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="286686856"
Received: from pgerasim-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.34.31])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2020 20:04:32 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v4 1/7] module: Add lock_modules() and unlock_modules()
Date:   Fri, 17 Jul 2020 06:04:15 +0300
Message-Id: <20200717030422.679972-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wrapper functions for acquiring module_mutex so that the locking can
be implicitly compiled out when CONFIG_MODULES is not enabled.

Cc: Andi Kleen <ak@linux.intel.com>
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/linux/module.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 2e6670860d27..8850b9692b8f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -705,6 +705,16 @@ static inline bool is_livepatch_module(struct module *mod)
 bool is_module_sig_enforced(void);
 void set_module_sig_enforced(void);
 
+static inline void lock_modules(void)
+{
+	mutex_lock(&module_mutex);
+}
+
+static inline void unlock_modules(void)
+{
+	mutex_unlock(&module_mutex);
+}
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -852,6 +862,14 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 	return ptr;
 }
 
+static inline void lock_modules(void)
+{
+}
+
+static inline void unlock_modules(void)
+{
+}
+
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
-- 
2.25.1

