Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86D7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAEB42075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgESTww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgESTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547E0C08C5C0;
        Tue, 19 May 2020 12:52:45 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8I3-0007uH-HA; Tue, 19 May 2020 21:52:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0ED4B1C047E;
        Tue, 19 May 2020 21:52:39 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:38 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] kprobes: Prevent probes in .noinstr.text section
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134100.179862032@linutronix.de>
References: <20200505134100.179862032@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795892.17951.11098194135392988351.tip-bot2@tip-bot2>
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

Commit-ID:     66e9b0717102507e64f638790eaece88765cc9e5
Gitweb:        https://git.kernel.org/tip/66e9b0717102507e64f638790eaece88765cc9e5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Mar 2020 14:04:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:56:20 +02:00

kprobes: Prevent probes in .noinstr.text section

Instrumentation is forbidden in the .noinstr.text section. Make kprobes
respect this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20200505134100.179862032@linutronix.de

---
 include/linux/module.h |  2 ++
 kernel/kprobes.c       | 18 ++++++++++++++++++
 kernel/module.c        |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 1192097..d849d06 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -458,6 +458,8 @@ struct module {
 	void __percpu *percpu;
 	unsigned int percpu_size;
 #endif
+	void *noinstr_text_start;
+	unsigned int noinstr_text_size;
 
 #ifdef CONFIG_TRACEPOINTS
 	unsigned int num_tracepoints;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9eb5acf..3f310df 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2229,6 +2229,12 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	/* Symbols in __kprobes_text are blacklisted */
 	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
 					(unsigned long)__kprobes_text_end);
+	if (ret)
+		return ret;
+
+	/* Symbols in noinstr section are blacklisted */
+	ret = kprobe_add_area_blacklist((unsigned long)__noinstr_text_start,
+					(unsigned long)__noinstr_text_end);
 
 	return ret ? : arch_populate_kprobe_blacklist();
 }
@@ -2248,6 +2254,12 @@ static void add_module_kprobe_blacklist(struct module *mod)
 		end = start + mod->kprobes_text_size;
 		kprobe_add_area_blacklist(start, end);
 	}
+
+	start = (unsigned long)mod->noinstr_text_start;
+	if (start) {
+		end = start + mod->noinstr_text_size;
+		kprobe_add_area_blacklist(start, end);
+	}
 }
 
 static void remove_module_kprobe_blacklist(struct module *mod)
@@ -2265,6 +2277,12 @@ static void remove_module_kprobe_blacklist(struct module *mod)
 		end = start + mod->kprobes_text_size;
 		kprobe_remove_area_blacklist(start, end);
 	}
+
+	start = (unsigned long)mod->noinstr_text_start;
+	if (start) {
+		end = start + mod->noinstr_text_size;
+		kprobe_remove_area_blacklist(start, end);
+	}
 }
 
 /* Module notifier call back, checking kprobes on the module */
diff --git a/kernel/module.c b/kernel/module.c
index faf7337..72ed2b3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3150,6 +3150,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	}
 #endif
 
+	mod->noinstr_text_start = section_objs(info, ".noinstr.text", 1,
+						&mod->noinstr_text_size);
+
 #ifdef CONFIG_TRACEPOINTS
 	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
 					     sizeof(*mod->tracepoints_ptrs),
