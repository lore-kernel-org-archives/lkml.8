Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65E3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1EEA2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr269rF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHYReC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHYRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:33:48 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64145C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:33:48 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id n128so12352100oif.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=efvC3Unx7QAw8IwTDdEQR++n/Hl+Re4xPSL3PJY90Ss=;
        b=Wr269rF8WGTtRm+QzV4cuEZvANncTR1BnZWwJGEyF9ZKAbtZmO9Dfs1RFOSNu7e9A7
         9PY38bWfar4Lm9s8Cs+Co7t8uhxDshezSvCXPsf9c9iR2umb6vwLMCVneLp9YZ/VLiAX
         rPaYDVQ8UklTimXKIy+54rR5VAzpNNPTbaz6Dr2r1zN+NKWoE4imwlMr7rTJM4MMiST3
         xrFfgAfSJsBUogJ77ZusdQDxE5pX9KS/nAIfdfRdQvDX7eI0G/yxTc0FnGsocTqTAtpK
         0thxhfEiPtcY6N9FcOP7mdIBkyXgV6sQ7QQlxb4v2+kKi3B87rMMvOb6DuYHG9hKLHdj
         URCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=efvC3Unx7QAw8IwTDdEQR++n/Hl+Re4xPSL3PJY90Ss=;
        b=HGoTON2eezeQJM9BFBe3BxCePa8a+o6pHVvjDuKm4wj2l7XzQQfAwrXDrWdxlPsBT3
         iTCrmCYyr4NCLLcTtUwqOksjy7wWtLxAIWGL/Kp6nKUDKG2H0SWak0RYRawr8mVFFaCx
         2iDdLWwrrwNfMi21M+4PHQ8WEIXhF6dOZ+UHNctzRhysZkz09AjrNVdbfv/68uDpAwX2
         7ZiNFoU4+FfvT2KEHPhxMP6B5JeBNQA0jTe6dn4Ox6sbjTc//YuTUBShDukHw/vwyJAt
         /E4S9cObuIxejaNOG9a0DzoTZJrSC59ZuXEkgWfvMyNpwOBZWOK61lCTQIKx2CIR0AMT
         sH9w==
X-Gm-Message-State: AOAM532zO2nnrb8S2LdUM2FBfHUT+VF745N1cF6PRFhnNiqyzMFDJS2j
        xBmbeuRvF2oy4qT7FayPt/M=
X-Google-Smtp-Source: ABdhPJz8T6tgCLg3WOc7STArNN/tetas8uUnA5m8JvNRK/AXszwYEZzDKKTTZ3oBq1oUVTLHftXViQ==
X-Received: by 2002:aca:3ac2:: with SMTP id h185mr1708895oia.65.1598376827780;
        Tue, 25 Aug 2020 10:33:47 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::c4c])
        by smtp.googlemail.com with ESMTPSA id x11sm3214168oot.0.2020.08.25.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:33:47 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 2/3] dyndbg: refine export, rename to dynamic_debug_exec_queries()
Date:   Tue, 25 Aug 2020 11:33:38 -0600
Message-Id: <20200825173339.2082585-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825173339.2082585-1-jim.cromie@gmail.com>
References: <20200825173339.2082585-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 59cf47e7df31 dyndbg: export ddebug_exec_queries
left a few configs broken, fix them with ifdef stub-fns.

Rename the export to dynamic_debug_exec_queries().  This is a more
canonical function name, instead of exposing the 'ddebug' internal
name prefix.  Do this now, before export hits v5.9.0

Implement as new function wrapping ddebug_exec_queries(now static
again), which copies the query-string, preserving ddebug_exec_queries'
in-place parsing, while allowing users to pass const strings.

--
v2- fixes per Joe Perches

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 20 ++++++++++++++++----
 lib/dynamic_debug.c           | 26 ++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index aa9ff9e1c0b3..8aa0c7c2608c 100644
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
+	pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
+	return 0;
+}
+
+#endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 01b7d0210412..a23b5d153153 100644
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
@@ -557,7 +557,29 @@ int ddebug_exec_queries(char *query, const char *modname)
 		return exitcode;
 	return nfound;
 }
-EXPORT_SYMBOL_GPL(ddebug_exec_queries);
+
+/**
+ * dynamic_debug_exec_queries - select and change dynamic-debug prints
+ * @query: query-string described in admin-guide/dynamic-debug-howto
+ * @modname: string containing module name, usually &module.mod_name
+ *
+ * This uses the >/proc/dynamic_debug/control reader, allowing module
+ * authors to modify their dynamic-debug callsites. The modname is
+ * canonically struct module.mod_name, but can also be null or a
+ * module-wildcard, for example: "drm*".
+ */
+int dynamic_debug_exec_queries(const char *query, const char *modname)
+{
+	int rc;
+	char *qry = kstrndup(query, PAGE_SIZE, GFP_KERNEL);
+	if (!query)
+		return -ENOMEM;
+
+	rc = ddebug_exec_queries(qry, modname);
+	kfree(qry);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dynamic_debug_exec_queries);
 
 #define PREFIX_SIZE 64
 
-- 
2.26.2

