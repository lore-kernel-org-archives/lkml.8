Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD73C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031972187F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583510543;
	bh=QW90AK9Vh4BPfKjMMRIcaMOj1yE9pR5xIteocBuulQA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VoC8cMNRUDz4S/9alSfhQo+EhC0iPFRYOdQe+EOo0qgbZyGedDR4wW3rQTLfF28NT
	 hURFxO62xWbNhS+CeyYktaP4Xh6OV0sSYFl80oY4FlYrRpG7AfTlj36UejsKY96nrR
	 7IfufViWyeEZeG8xvjxAEcoy8i5997QFdqrgGKPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCFQCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:02:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFQCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:02:21 -0500
Received: from linux-8ccs.suse.de (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836C2208CD;
        Fri,  6 Mar 2020 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583510540;
        bh=QW90AK9Vh4BPfKjMMRIcaMOj1yE9pR5xIteocBuulQA=;
        h=From:To:Cc:Subject:Date:From;
        b=uIO0FzGILaLYbi3lvVfxgx824SEgVNDVxjtffAGYhHkKuuvdrG6TndsotlLwpJTCE
         oEhbARAnpXDTaea+vCiAKD+4/KZZtEl46Ry0x9SS+2oVmiJHvmnb8VJnDp+s98V1mE
         1XwF9uECfoN15rFtiQzxdEUHl6rlxU8sjs8Az9/E=
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v3 1/2] modpost: rework and consolidate logging interface
Date:   Fri,  6 Mar 2020 17:02:05 +0100
Message-Id: <20200306160206.5609-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework modpost's logging interface by consolidating merror(), warn(), and
fatal() to use a single function, modpost_log(). Introduce different
logging levels (WARN, ERROR, FATAL) as well. The purpose of this cleanup is
to reduce code duplication when deciding whether or not to warn or error
out based on a condition.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
v3:
	- remove level variable from modpost_log and just call fprintf in each
	  case 
	- remove warn_unless and just call modpost_log() directly
	- fix checkpatch error:
		ERROR: space required before the open parenthesis '('
        #102: FILE: scripts/mod/modpost.c:61:
        + switch(loglevel) {

 scripts/mod/modpost.c | 68 ++++++++++++++++++++++-----------------------------
 scripts/mod/modpost.h | 14 ++++++++---
 2 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7edfdb2f4497..a2329235a6db 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -51,41 +51,34 @@ enum export {
 
 #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
 
-#define PRINTF __attribute__ ((format (printf, 1, 2)))
+#define PRINTF __attribute__ ((format (printf, 2, 3)))
 
-PRINTF void fatal(const char *fmt, ...)
+PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
 {
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
+	switch (loglevel) {
+	case LOG_WARN:
+		fprintf(stderr, "WARNING: ");
+		break;
+	case LOG_ERROR:
+		fprintf(stderr, "ERROR: ");
+		break;
+	case LOG_FATAL:
+		fprintf(stderr, "FATAL: ");
+		break;
+	default: /* invalid loglevel, ignore */
+		break;
+	}
 
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
-
-	va_start(arglist, fmt);
-	vfprintf(stderr, fmt, arglist);
-	va_end(arglist);
+	if (loglevel == LOG_FATAL)
+		exit(1);
 }
 
 static inline bool strends(const char *str, const char *postfix)
@@ -113,7 +106,7 @@ static int is_vmlinux(const char *modname)
 void *do_nofail(void *ptr, const char *expr)
 {
 	if (!ptr)
-		fatal("modpost: Memory allocation failure: %s.\n", expr);
+		fatal("Memory allocation failure: %s.\n", expr);
 
 	return ptr;
 }
@@ -2021,7 +2014,7 @@ static void read_symbols(const char *modname)
 
 	license = get_modinfo(&info, "license");
 	if (!license && !is_vmlinux(modname))
-		warn("modpost: missing MODULE_LICENSE() in %s\n"
+		warn("missing MODULE_LICENSE() in %s\n"
 		     "see include/linux/module.h for "
 		     "more information\n", modname);
 	while (license) {
@@ -2152,15 +2145,15 @@ static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
 
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
@@ -2178,7 +2171,7 @@ static void check_for_unused(enum export exp, const char *m, const char *s)
 	switch (exp) {
 	case export_unused:
 	case export_unused_gpl:
-		warn("modpost: module %s%s "
+		warn("module %s%s "
 		      "uses symbol '%s' marked UNUSED\n", m, e, s);
 		break;
 	default:
@@ -2197,14 +2190,11 @@ static int check_exports(struct module *mod)
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod) {
 			if (have_vmlinux && !s->weak) {
-				if (warn_unresolved) {
-					warn("\"%s\" [%s.ko] undefined!\n",
-					     s->name, mod->name);
-				} else {
-					merror("\"%s\" [%s.ko] undefined!\n",
-					       s->name, mod->name);
+				modpost_log(warn_unresolved ? LOG_WARN : LOG_ERROR,
+					    "\"%s\" [%s.ko] undefined!\n",
+					    s->name, mod->name);
+				if (!warn_unresolved)
 					err = 1;
-				}
 			}
 			continue;
 		}
@@ -2653,7 +2643,7 @@ int main(int argc, char **argv)
 	if (dump_write)
 		write_dump(dump_write);
 	if (sec_mismatch_count && sec_mismatch_fatal)
-		fatal("modpost: Section mismatches detected.\n"
+		fatal("Section mismatches detected.\n"
 		      "Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.\n");
 	for (n = 0; n < SYMBOL_HASH_SIZE; n++) {
 		struct symbol *s;
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 64a82d2d85f6..60dca9b7106b 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -198,6 +198,14 @@ void *grab_file(const char *filename, unsigned long *size);
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
-- 
2.16.4

