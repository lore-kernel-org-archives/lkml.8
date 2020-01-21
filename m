Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968CDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BCD2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r55YOKxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgAUMte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:49:34 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:32839 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:49:34 -0500
Received: by mail-pj1-f67.google.com with SMTP id u63so981634pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSX3p7g/5+mGyY0QbppVn7Dy3rth1hiQMkYqW3UKtds=;
        b=r55YOKxKOjaGqMzpf9rvWrfHzXFrtKq54xZ8ZzKZz1tZHG4xSG/F51ZBV3dq9Wk69H
         RJSYJfopA9X1NU6lvr1ibkGo36C3YbtKms0oS3DWTE8eHI0tUVTDqOCrv0Ke3UypAmkm
         xbr/7cfk35tSzR7c+OhOixYeLDlg0Fu8WDZXrsUxY7P3AA2rjnQRWAckuhe46ST6nCVC
         pHDXke+7++2GLBxqFOf4Trj6FvBDJgZlxSNlbcJNpcrjALVR68JgIv/V1qTwezkRaK4s
         s4XryJ5AXaufZIdbF3dAlBPjZS1HzShnIFxwKBsGoMt28sPpRo3ime+JC9DkLEp6Mzta
         GGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSX3p7g/5+mGyY0QbppVn7Dy3rth1hiQMkYqW3UKtds=;
        b=dUt1Uzg5kblawXQVVfHmuCcS9eAhFfRR7CDl6wGvIXiju1oFsWqCPtsvqZcjqwiuLT
         aKxTlJEelh9z9zGuWf50nPZuxH6nOkZH+EJZTCgA2p+EZ/meUWhrQp8KBQF5hUVufWEb
         P5bsGRpk3bW/sGQl6QOJAm0lCFhNl/iWCSCAH4/wYbH55PEeWlBM/4Y5d4UJ4Wv9Pwsw
         pPU9bB/0xMGbKl9iUw9xANXlZhN/KjqIps8HyXqSM00uB3Ox1C4PYWGdBw46BTDtHq+2
         M6sdSZwvZc3KK2EEFtx3QhsThNhAjE2upiLbxE1tK/6CwfSCf85Z/DT6WN1prE0STYcv
         qphA==
X-Gm-Message-State: APjAAAXjCnm/P9mOWfVzCi9JPC9Mtr3upDThIJN7Flo0rAHsU2Ke3gsT
        sMYN0e0l3OoO2c3HZSAEZ0Q=
X-Google-Smtp-Source: APXvYqyIgR5gRAKdFCfwzwpL3gmf4F8fFRm0thwpdBo9umSnXXwdljZ2jUZHu2uDPrRHEhaIz1yO4Q==
X-Received: by 2002:a17:902:b08e:: with SMTP id p14mr5446473plr.323.1579610973429;
        Tue, 21 Jan 2020 04:49:33 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.201])
        by smtp.googlemail.com with ESMTPSA id g67sm44536999pfb.66.2020.01.21.04.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 04:49:32 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] kernel: module: Pass lockdep expression to RCU lists
Date:   Tue, 21 Jan 2020 18:17:46 +0530
Message-Id: <20200121124745.14864-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modules is traversed using list_for_each_entry_rcu outside an
RCU read-side critical section but under the protection
of module_mutex or with preemption disabled.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists.

list_for_each_entry_rcu when traversed inside a preempt disabled
section, doesn't need an explicit lockdep expression since it is
implicitly checked for.

Add macro for the corresponding lockdep expression.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/module.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index b56f3224b161..2425f58159dd 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -84,6 +84,8 @@
  * 3) module_addr_min/module_addr_max.
  * (delete and add uses RCU list operations). */
 DEFINE_MUTEX(module_mutex);
+#define module_mutex_held() \
+	lockdep_is_held(&module_mutex)
 EXPORT_SYMBOL_GPL(module_mutex);
 static LIST_HEAD(modules);
 
@@ -214,7 +216,7 @@ static struct module *mod_find(unsigned long addr)
 {
 	struct module *mod;
 
-	list_for_each_entry_rcu(mod, &modules, list) {
+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
 		if (within_module(addr, mod))
 			return mod;
 	}
@@ -448,7 +450,7 @@ bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
 	if (each_symbol_in_section(arr, ARRAY_SIZE(arr), NULL, fn, data))
 		return true;
 
-	list_for_each_entry_rcu(mod, &modules, list) {
+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
 		struct symsearch arr[] = {
 			{ mod->syms, mod->syms + mod->num_syms, mod->crcs,
 			  NOT_GPL_ONLY, false },
@@ -616,7 +618,7 @@ static struct module *find_module_all(const char *name, size_t len,
 
 	module_assert_mutex_or_preempt();
 
-	list_for_each_entry_rcu(mod, &modules, list) {
+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
 		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
 			continue;
 		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
@@ -2040,7 +2042,7 @@ void set_all_modules_text_rw(void)
 		return;
 
 	mutex_lock(&module_mutex);
-	list_for_each_entry_rcu(mod, &modules, list) {
+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 
@@ -2059,7 +2061,7 @@ void set_all_modules_text_ro(void)
 		return;
 
 	mutex_lock(&module_mutex);
-	list_for_each_entry_rcu(mod, &modules, list) {
+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
 		/*
 		 * Ignore going modules since it's possible that ro
 		 * protection has already been disabled, otherwise we'll
-- 
2.24.1

