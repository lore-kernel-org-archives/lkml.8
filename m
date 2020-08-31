Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847BEC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6434D208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck/m3fO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgHaSXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbgHaSXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:23:04 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:23:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j2so7040530ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YEL2sT07e48hoT0+vsetk/IvirpQ7LEfHojHk2BQCs=;
        b=ck/m3fO1xWI/k1U6ETZWVA2a0KrXgETKMqcl2K0S1DHKhyCHJGiV74e9C3fs+XMY3R
         2GKQEcBeq9Izm6EHz3ELyej4jqSZ9QMhO6gaAQTlZuGjcddzjD0c+9qOIJ5rhAludUdT
         Z/vdzqy4MxRdcey/xsapf14Iqc11rYN/d3+NVJl88UGD3IIOyudChKVQyACdmHkPaCYC
         Ur6OHZktnK02NAIXcoVSldYHPsK6RFVPQPI1RS9mSB99SVUKYbqMGN0rC6mO30JMwnOW
         izGat9ltRwo7BKRDhIISCxyC6hElN8WXnjGyE6vdGwxntMrIvWtL5uHLD1b+cudX22cM
         SKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YEL2sT07e48hoT0+vsetk/IvirpQ7LEfHojHk2BQCs=;
        b=iYOI8Xh5KjxMID12uHzBX1smX114eKTH44VNDpJEvLVjMUyYOjkM+DGjC6JspziVef
         MazakQEoLYhMT8BeU4Shwc9Hni2doGz0FL6Nd6aj/Oqnvg5/UrBhtkMan1w7fW/hb/4G
         pFb3t70E7JUMbsDLhFjKiY1Ls+CWk88UTpGW90hJMt0+OpniffWLgBtIWc55K7KUTbSG
         YpDZfTCZhxE2JcU4oCh3tKBvVsvfkA871jFYgjQxxItDGFMrPMJnloQyp86M9yrabrV5
         veQy+xGUA+Hwzd3aDVFjP3Hg70e/uRTWLz0KG1zA+jiwDBCec1kBCXBGRFd9lo0n7UYq
         Famw==
X-Gm-Message-State: AOAM531NAApthepas2p/VLqXW7miNKRXpmamJX4GhcyKGii9ZgkE9d/Z
        +I0pAy+IUtX76r9u4amMwp0=
X-Google-Smtp-Source: ABdhPJzohRMx3RZk5tsn04pfTQBRYbOXkR521Hw26xy41w3CZlFY1uJ7WkN42e9rnSpNnU1Q7uDqPA==
X-Received: by 2002:a02:1004:: with SMTP id 4mr2430142jay.127.1598898183259;
        Mon, 31 Aug 2020 11:23:03 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::dc2e])
        by smtp.googlemail.com with ESMTPSA id p18sm4129017iog.1.2020.08.31.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:23:02 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 2/3] dyndbg: refine export, rename to dynamic_debug_exec_queries()
Date:   Mon, 31 Aug 2020 12:22:09 -0600
Message-Id: <20200831182210.850852-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831182210.850852-1-jim.cromie@gmail.com>
References: <20200831182210.850852-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4c0d77828d4f ("dyndbg: export ddebug_exec_queries")

had a few problems:
 - broken non DYNAMIC_DEBUG_CORE configs, sparse warning
 - the exported function modifies query string, breaks on RO strings.
 - func name follows internal convention, shouldn't be exposed as is.

1st is fixed in header with ifdefd function prototype or stub defn.
Also remove an obsolete HAVE-symbol ifdef-comment, and add others.

Fix others by wrapping existing internal function with a new one,
named in accordance with module-prefix naming convention, before
export hits v5.9.0.  In new function, copy query string to a local
buffer, so users can pass hard-coded/RO queries, and internal function
can be used unchanged.

Fixes: 4c0d77828d4f ("dyndbg: export ddebug_exec_queries")
---
v2- code improvements, per Joe Perches
v3- commit message fixups

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 20 ++++++++++++++++----
 lib/dynamic_debug.c           | 27 +++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 6 deletions(-)

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
index 01b7d0210412..08e4b057514c 100644
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
@@ -557,7 +557,30 @@ int ddebug_exec_queries(char *query, const char *modname)
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
+
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

