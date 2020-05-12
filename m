Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE7CC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF52C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgELPTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgELPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:19:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B15C061A0E;
        Tue, 12 May 2020 08:19:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYWgN-0007Da-11; Tue, 12 May 2020 17:18:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8CA8D1C0475;
        Tue, 12 May 2020 17:18:58 +0200 (CEST)
Date:   Tue, 12 May 2020 15:18:58 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] kprobes: Support NOKPROBE_SYMBOL() in modules
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134059.771170126@linutronix.de>
References: <20200505134059.771170126@linutronix.de>
MIME-Version: 1.0
Message-ID: <158929673850.390.3433747204484607858.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     16db6264c93d2d7df9eb8be5d9eb717ab30105fe
Gitweb:        https://git.kernel.org/tip/16db6264c93d2d7df9eb8be5d9eb717ab30105fe
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Thu, 26 Mar 2020 23:50:00 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 17:15:32 +02:00

kprobes: Support NOKPROBE_SYMBOL() in modules

Support NOKPROBE_SYMBOL() in modules. NOKPROBE_SYMBOL() records only symbol
address in "_kprobe_blacklist" section in the module.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134059.771170126@linutronix.de

---
 include/linux/module.h |  2 ++
 kernel/kprobes.c       | 17 +++++++++++++++++
 kernel/module.c        |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 369c354..1192097 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -492,6 +492,8 @@ struct module {
 #ifdef CONFIG_KPROBES
 	void *kprobes_text_start;
 	unsigned int kprobes_text_size;
+	unsigned long *kprobe_blacklist;
+	unsigned int num_kprobe_blacklist;
 #endif
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b754999..9eb5acf 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2192,6 +2192,11 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 	}
 }
 
+static void kprobe_remove_ksym_blacklist(unsigned long entry)
+{
+	kprobe_remove_area_blacklist(entry, entry + 1);
+}
+
 int __init __weak arch_populate_kprobe_blacklist(void)
 {
 	return 0;
@@ -2231,6 +2236,12 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
+	int i;
+
+	if (mod->kprobe_blacklist) {
+		for (i = 0; i < mod->num_kprobe_blacklist; i++)
+			kprobe_add_ksym_blacklist(mod->kprobe_blacklist[i]);
+	}
 
 	start = (unsigned long)mod->kprobes_text_start;
 	if (start) {
@@ -2242,6 +2253,12 @@ static void add_module_kprobe_blacklist(struct module *mod)
 static void remove_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
+	int i;
+
+	if (mod->kprobe_blacklist) {
+		for (i = 0; i < mod->num_kprobe_blacklist; i++)
+			kprobe_remove_ksym_blacklist(mod->kprobe_blacklist[i]);
+	}
 
 	start = (unsigned long)mod->kprobes_text_start;
 	if (start) {
diff --git a/kernel/module.c b/kernel/module.c
index 978f3fa..faf7337 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3197,6 +3197,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 #ifdef CONFIG_KPROBES
 	mod->kprobes_text_start = section_objs(info, ".kprobes.text", 1,
 						&mod->kprobes_text_size);
+	mod->kprobe_blacklist = section_objs(info, "_kprobe_blacklist",
+						sizeof(unsigned long),
+						&mod->num_kprobe_blacklist);
 #endif
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
