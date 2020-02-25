Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F54AC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30232176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582652134;
	bh=gj1yIfg8bcja5Jkwg4ZUG4M7lskF6SDye1QbQQOdm+4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bFhThA6ynCUa6D8JdmhSAgqzkbXRC38vz0SMhzKFgQOGIXCjbwhKwTzPKmgrYaN3N
	 9KXJPIhYFpXHtD6RU5a1BC4V/ww5LUllbdNdXwSL7JSeTzpWjiP7h7+g0D051IJSOW
	 nG0gkgbr+Tv5FrIe6yr+FpYnDxvzqKb4KOSLd1oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgBYRfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:35:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgBYRfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:35:32 -0500
Received: from linux-8ccs.suse.de (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7CD02084E;
        Tue, 25 Feb 2020 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582652131;
        bh=gj1yIfg8bcja5Jkwg4ZUG4M7lskF6SDye1QbQQOdm+4=;
        h=From:To:Cc:Subject:Date:From;
        b=zrGFrm97ucudbeiQxg0re0H2jNOyDt1hmnAWDNn0eIXLYzKNac2SxervJj4G/lpR+
         5v70iKFlJOgXwUXDve/vqiiuJKf7VCgxhMX1p/8m5X6tIFSl8O+X/C4Xl/ntbe0Yv6
         mubokDoioExtElDIJyZ9nNXN7nESif44+8UvFJYc=
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 1/2] modpost: rework and consolidate logging interface
Date:   Tue, 25 Feb 2020 18:35:25 +0100
Message-Id: <20200225173526.9617-1-jeyu@kernel.org>
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
Hi,

This patch was added in response to the code duplication comments in the
first version of "modpost: return error if module is missing ns imports and
MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n" [1] 

[1] See 20200214143709.6490-1-jeyu@kernel.org

 scripts/mod/modpost.c | 69 ++++++++++++++++++++++++---------------------------
 scripts/mod/modpost.h | 22 +++++++++++++---
 2 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7edfdb2f4497..e2805fbeb99f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -51,41 +51,39 @@ enum export {
 
 #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
 
-#define PRINTF __attribute__ ((format (printf, 1, 2)))
+#define PRINTF __attribute__ ((format (printf, 2, 3)))
 
-PRINTF void fatal(const char *fmt, ...)
+PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
 {
+	char *level = NULL;
 	va_list arglist;
 
-	fprintf(stderr, "FATAL: ");
+	switch(loglevel) {
+	case(LOG_WARN):
+		level = "WARNING: ";
+		break;
+	case(LOG_ERROR):
+		level = "ERROR: ";
+		break;
+	case(LOG_FATAL):
+		level = "FATAL: ";
+		break;
+	default: /* invalid loglevel, ignore */
+		break;
+	}
 
-	va_start(arglist, fmt);
-	vfprintf(stderr, fmt, arglist);
-	va_end(arglist);
+	if (level)
+		fprintf(stderr, level);
 
-	exit(1);
-}
-
-PRINTF void warn(const char *fmt, ...)
-{
-	va_list arglist;
-
-	fprintf(stderr, "WARNING: ");
+	fprintf(stderr, "modpost: ");
 
 	va_start(arglist, fmt);
 	vfprintf(stderr, fmt, arglist);
 	va_end(arglist);
-}
-
-PRINTF void merror(const char *fmt, ...)
-{
-	va_list arglist;
 
-	fprintf(stderr, "ERROR: ");
+	if (loglevel == LOG_FATAL)
+		exit(1);
 
-	va_start(arglist, fmt);
-	vfprintf(stderr, fmt, arglist);
-	va_end(arglist);
 }
 
 static inline bool strends(const char *str, const char *postfix)
@@ -113,7 +111,7 @@ static int is_vmlinux(const char *modname)
 void *do_nofail(void *ptr, const char *expr)
 {
 	if (!ptr)
-		fatal("modpost: Memory allocation failure: %s.\n", expr);
+		fatal("Memory allocation failure: %s.\n", expr);
 
 	return ptr;
 }
@@ -2021,7 +2019,7 @@ static void read_symbols(const char *modname)
 
 	license = get_modinfo(&info, "license");
 	if (!license && !is_vmlinux(modname))
-		warn("modpost: missing MODULE_LICENSE() in %s\n"
+		warn("missing MODULE_LICENSE() in %s\n"
 		     "see include/linux/module.h for "
 		     "more information\n", modname);
 	while (license) {
@@ -2152,15 +2150,15 @@ static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
 
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
@@ -2178,7 +2176,7 @@ static void check_for_unused(enum export exp, const char *m, const char *s)
 	switch (exp) {
 	case export_unused:
 	case export_unused_gpl:
-		warn("modpost: module %s%s "
+		warn("module %s%s "
 		      "uses symbol '%s' marked UNUSED\n", m, e, s);
 		break;
 	default:
@@ -2197,14 +2195,11 @@ static int check_exports(struct module *mod)
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
@@ -2653,7 +2648,7 @@ int main(int argc, char **argv)
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

