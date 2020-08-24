Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC5D206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlrq0lBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHXSyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgHXSyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:54:31 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2608C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:54:30 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id o21so9213198oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2WkY0b3YqGMCogRM2MrrKDo52ckvFAY39zpSCTS3eP0=;
        b=nlrq0lBkUkKm5+f93Ckl4mDD6XWpHRNaqwzT3w5kP/wpeO8/JBWRzYDBH7MCiCdv5G
         uK/0sfcfy/fcAwv0o9w70vCUjD3v5rlXmP5zQ7/1Md/LUv7P+6plKLw4Sm04eyp4r8tK
         8AWQOpfbDxuc8MT9Qgz458+KZmqt/+ZkitZsP0rBhWDGWaSOYmsfDyP7TfOkJiKsB5dk
         GFIhlZB7KgjTmo1RWfROUFdcyJcm0eGY2TLqA32bDiDJlvjTluaiytUUCM9AyrfY0g4I
         38dwc7GFqARTxoZRIwtU3xhBvXCgplkBp9+DkR7xSgYYmMImChEOCRhq1sNPtRFQBvZw
         ePLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WkY0b3YqGMCogRM2MrrKDo52ckvFAY39zpSCTS3eP0=;
        b=Z5iJnmSrJ/IcDVkV+5v2YbWTZBaQzGS1rcN7zJY7xvR3YrWGb6GEqg6i3jfySzln0X
         3q3ARRLYIui2O5/SNgGk53Jis1mBq+qSNtJetdmJRCOdf9jw/FsKJkdzdm9PydH9jAvq
         qP0ch4DeZKo9ZbP2vm/KFHxqq32uVAbxELlRaY0YurPMP1a0tYMTUp6nN8pAGyekh2OJ
         QeAkj9iZt7k7VwRu0ucW9MK4r2Xh6OtCE3fLBcghDoHaWpygmyOKcrpL8jYFa63StMqK
         Qdx1V/my1x/QSiyCXwwykN5Ev1iGoFzb7yji7Fag5CgBJ/wPQA735YIgMX26c0RjPNvc
         SR9Q==
X-Gm-Message-State: AOAM532469yR8eAqVPE+Y4zkJDbzwG99BSW37irR1T6vzIfUkQ4IxBay
        75ptK9Giy0vpmiOzaawB1fk=
X-Google-Smtp-Source: ABdhPJx/NwQ8MGHgMpgZRv7Ahk25Ha4rlVTVa1JMN8/fhQ1YWEfNetR/D/bLSqgPSyoM8UdVBgjEJA==
X-Received: by 2002:aca:488f:: with SMTP id v137mr473913oia.90.1598295270288;
        Mon, 24 Aug 2020 11:54:30 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::b30e])
        by smtp.googlemail.com with ESMTPSA id b188sm2112414oif.19.2020.08.24.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:54:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/3] dyndbg: refine export, rename to dynamic_debug_exec_queries()
Date:   Mon, 24 Aug 2020 12:54:11 -0600
Message-Id: <20200824185412.1617174-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824185412.1617174-1-jim.cromie@gmail.com>
References: <20200824185412.1617174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 59cf47e7df31 dyndbg: export ddebug_exec_queries
left a few configs broken, fix them with ifdef-stubs.

Rename the export to dynamic_debug_exec_queries().  This is a more
canonical function name, instead of exposing the 'ddebug' internal
name prefix.  Do this now, before export hits v5.9.0

Implement as new function wrapping ddebug_exec_queries(now static
again), which copies the query-string, preserving ddebug_exec_queries'
in-place parsing, while allowing users to pass "const strings".

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 20 ++++++++++++++++----
 lib/dynamic_debug.c           | 24 ++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index aa9ff9e1c0b3..b0191d3aff26 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -49,6 +49,10 @@ struct _ddebug {
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
+
+/* exported for module authors to exercise >control */
+int dynamic_debug_exec_queries(const char *query, const char *modname);
+
 int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 				const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
@@ -105,7 +109,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	static_branch_unlikely(&descriptor.key.dd_key_false)
 #endif
 
-#else /* !HAVE_JUMP_LABEL */
+#else /* !CONFIG_JUMP_LABEL */
 
 #define _DPRINTK_KEY_INIT
 
@@ -117,7 +121,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
 #endif
 
-#endif
+#endif /* CONFIG_JUMP_LABEL */
 
 #define __dynamic_func_call(id, fmt, func, ...) do {	\
 	DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);		\
@@ -172,10 +176,11 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 				   KERN_DEBUG, prefix_str, prefix_type,	\
 				   rowsize, groupsize, buf, len, ascii)
 
-#else
+#else /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/printk.h>
 
 static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 				    const char *modname)
@@ -210,6 +215,13 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 		print_hex_dump(KERN_DEBUG, prefix_str, prefix_type,	\
 				rowsize, groupsize, buf, len, ascii);	\
 	} while (0)
-#endif
+
+static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
+{
+	printk(KERN_WARNING "kernel not built w CONFIG_DYNAMIC_DEBUG_CORE\n");
+	return 0;
+}
+
+#endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 01b7d0210412..b6ab2c643116 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -525,7 +525,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
    last error or number of matching callsites.  Module name is either
    in param (for boot arg) or perhaps in query string.
 */
-int ddebug_exec_queries(char *query, const char *modname)
+static int ddebug_exec_queries(char *query, const char *modname)
 {
 	char *split;
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
@@ -557,7 +557,27 @@ int ddebug_exec_queries(char *query, const char *modname)
 		return exitcode;
 	return nfound;
 }
-EXPORT_SYMBOL_GPL(ddebug_exec_queries);
+
+/**
+ * dynamic_debug_exec_queries - apply changes to selected dynamic-debug prints
+ * @query: string with callsite-selectors +enablement+decorations
+ * @modname: string containing module name
+ *
+ * This implements the >/proc/dynamic_debug/control reader, allowing
+ * module authors to modify their dynamic-debug callsites. The modname
+ * is canonically struct module.mod_name, but can also be null or a
+ * module-wildcard, for example: "drm*".
+ */
+int dynamic_debug_exec_queries(const char *query, const char *modname)
+{
+	char *qry = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	int rc;
+	strncpy(qry, query, PAGE_SIZE);
+	rc = ddebug_exec_queries(qry, modname);
+	kfree(qry);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dynamic_debug_exec_queries);
 
 #define PREFIX_SIZE 64
 
-- 
2.26.2

