Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C9C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8372467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582727185;
	bh=ytxePLeD/G96wACd0ePqTIXUsy4t44NP+Ducb61scBw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qCSXPwb6ngEPTFplz0NAEO+XeEdlNOOLCSTTSUH8sXSenO7BpUvOTCXC7Kqt8u5Cs
	 5wYUdwm2BOKnmyVqstEsxmRSqn4fMwYkH64qpTTfZddmXJm3Dpk+CKQKvqlyI613MX
	 TFY32x/lWgQs8oKW79BW72ZbiZStW53nacumVkNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBZO0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:26:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbgBZO0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:26:24 -0500
Received: from linux-8ccs.suse.de (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9872467B;
        Wed, 26 Feb 2020 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582727182;
        bh=ytxePLeD/G96wACd0ePqTIXUsy4t44NP+Ducb61scBw=;
        h=From:To:Cc:Subject:Date:From;
        b=fJMMYe1qLwKI93WYdUmmFjlo1xgvL1rfmeukwTO99xkOnReuh/b9kRbMinyEkPB/x
         uFr6KS4S3xzHVBcqu+/CvbzVm4FihrnpDtL9D8wqWhW0373kFDcXKKiUU6R9wst/MV
         YpTlW5tA26wLFlGkMoFvfeTdXRGs2Xs28QMJkBeQ=
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matthias Maennich <maennich@google.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2 1/2] modpost: rework and consolidate logging interface
Date:   Wed, 26 Feb 2020 15:26:07 +0100
Message-Id: <20200226142608.19499-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework modpost's logging interface by consolidating merror(), warn(),
and fatal() to use a single function, modpost_log(). Introduce different
logging levels (WARN, ERROR, FATAL) as well as a conditional warn
(warn_unless()). The conditional warn is useful in determining whether
to use merror() or warn() based on a condition. This reduces code
duplication overall.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
v2:
  - modpost_log: initialize level to ""
  - remove parens () from case labels

 scripts/mod/modpost.c | 69 +++++++++++++++++++++++----------------------------
 scripts/mod/modpost.h | 22 +++++++++++++---
 2 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7edfdb2f4497..3201a2ac5cc4 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -51,41 +51,37 @@ enum export {
 
 #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
 
-#define PRINTF __attribute__ ((format (printf, 1, 2)))
+#define PRINTF __attribute__ ((format (printf, 2, 3)))
 
-PRINTF void fatal(const char *fmt, ...)
+PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
 {
+	char *level = "";
 	va_list arglist;
 
-	fprintf(stderr, "FATAL: ");
-
-	va_start(arglist, fmt);
-	vfprintf(stderr, fmt, arglist);
-	va_end(arglist);
-
-	exit(1);
-}
-
-PRINTF void warn(const char *fmt, ...)
-{
-	va_list arglist;
+	switch(loglevel) {
+	case LOG_WARN:
+		level = "WARNING: ";
+		break;
+	case LOG_ERROR:
+		level = "ERROR: ";
+		break;
+	case LOG_FATAL:
+		level = "FATAL: ";
+		break;
+	default: /* invalid loglevel, ignore */
+		break;
+	}
 
-	fprintf(stderr, "WARNING: ");
+	fprintf(stderr, level);
+	fprintf(stderr, "modpost: ");
 
 	va_start(arglist, fmt);
 	vfprintf(stderr, fmt, arglist);
 	va_end(arglist);
-}
 
-PRINTF void merror(const char *fmt, ...)
-{
-	va_list arglist;
-
-	fprintf(stderr, "ERROR: ");
+	if (loglevel == LOG_FATAL)
+		exit(1);
 
-	va_start(arglist, fmt);
-	vfprintf(stderr, fmt, arglist);
-	va_end(arglist);
 }
 
 static inline bool strends(const char *str, const char *postfix)
@@ -113,7 +109,7 @@ static int is_vmlinux(const char *modname)
 void *do_nofail(void *ptr, const char *expr)
 {
 	if (!ptr)
-		fatal("modpost: Memory allocation failure: %s.\n", expr);
+		fatal("Memory allocation failure: %s.\n", expr);
 
 	return ptr;
 }
@@ -2021,7 +2017,7 @@ static void read_symbols(const char *modname)
 
 	license = get_modinfo(&info, "license");
 	if (!license && !is_vmlinux(modname))
-		warn("modpost: missing MODULE_LICENSE() in %s\n"
+		warn("missing MODULE_LICENSE() in %s\n"
 		     "see include/linux/module.h for "
 		     "more information\n", modname);
 	while (license) {
@@ -2152,15 +2148,15 @@ static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
 
 	switch (exp) {
 	case export_gpl:
-		fatal("modpost: GPL-incompatible module %s%s "
+		fatal("GPL-incompatible module %s%s "
 		      "uses GPL-only symbol '%s'\n", m, e, s);
 		break;
 	case export_unused_gpl:
-		fatal("modpost: GPL-incompatible module %s%s "
+		fatal("GPL-incompatible module %s%s "
 		      "uses GPL-only symbol marked UNUSED '%s'\n", m, e, s);
 		break;
 	case export_gpl_future:
-		warn("modpost: GPL-incompatible module %s%s "
+		warn("GPL-incompatible module %s%s "
 		      "uses future GPL-only symbol '%s'\n", m, e, s);
 		break;
 	case export_plain:
@@ -2178,7 +2174,7 @@ static void check_for_unused(enum export exp, const char *m, const char *s)
 	switch (exp) {
 	case export_unused:
 	case export_unused_gpl:
-		warn("modpost: module %s%s "
+		warn("module %s%s "
 		      "uses symbol '%s' marked UNUSED\n", m, e, s);
 		break;
 	default:
@@ -2197,14 +2193,11 @@ static int check_exports(struct module *mod)
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod) {
 			if (have_vmlinux && !s->weak) {
-				if (warn_unresolved) {
-					warn("\"%s\" [%s.ko] undefined!\n",
-					     s->name, mod->name);
-				} else {
-					merror("\"%s\" [%s.ko] undefined!\n",
-					       s->name, mod->name);
+				warn_unless(!warn_unresolved,
+					    "\"%s\" [%s.ko] undefined!\n",
+					    s->name, mod->name);
+				if (!warn_unresolved)
 					err = 1;
-				}
 			}
 			continue;
 		}
@@ -2653,7 +2646,7 @@ int main(int argc, char **argv)
 	if (dump_write)
 		write_dump(dump_write);
 	if (sec_mismatch_count && sec_mismatch_fatal)
-		fatal("modpost: Section mismatches detected.\n"
+		fatal("Section mismatches detected.\n"
 		      "Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.\n");
 	for (n = 0; n < SYMBOL_HASH_SIZE; n++) {
 		struct symbol *s;
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 64a82d2d85f6..631d07714f7a 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -198,6 +198,22 @@ void *grab_file(const char *filename, unsigned long *size);
 char* get_next_line(unsigned long *pos, void *file, unsigned long size);
 void release_file(void *file, unsigned long size);
 
-void fatal(const char *fmt, ...);
-void warn(const char *fmt, ...);
-void merror(const char *fmt, ...);
+enum loglevel {
+	LOG_WARN,
+	LOG_ERROR,
+	LOG_FATAL
+};
+
+void modpost_log(enum loglevel loglevel, const char *fmt, ...);
+
+#define warn(fmt, args...)	modpost_log(LOG_WARN, fmt, ##args)
+#define merror(fmt, args...)	modpost_log(LOG_ERROR, fmt, ##args)
+#define fatal(fmt, args...)	modpost_log(LOG_FATAL, fmt, ##args)
+/* Warn unless condition is true, then use merror() */
+#define warn_unless(condition, fmt, args...)	\
+do {						\
+	if (condition)				\
+		merror(fmt, ##args);		\
+	else					\
+		warn(fmt, ##args);		\
+} while (0)
-- 
2.16.4

