Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF24C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69792074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTQYuBgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFMP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgFMP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:36 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3502AC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:36 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k15so9764672otp.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXTO5MprXvHIQWTapodiaHnYkq6yaPhQ4S0ZTvUxcYg=;
        b=RTQYuBgJjnTJsylTr86adqp2KQWbaWgzpPLhYu6LDditSmUkYoFdaWIm9af2p31hCp
         xJ0z5PH+YtsdqZYAiOFEzLem7TIDkhvB1bbO5N1ICU/72wDmfO7SOX+WPr/aRZKsaUrs
         OhCii1LYazVcwWjIYKa2pC5DpAZkhpjnkFu/pXfDCVqhuwuU5Kdq5/4G1CYiJraVsjuM
         i4HlPmC4IN+LtPrMiMDwvzRgHxPJmOmn3bIEja9f8DoWheMa0wR4eFs7PRMMYXOKaWcT
         85vi6R+FqqveBJ5aVJPIDICucQBD6uoQNStv7JucAcoNbieLB7WYoL/Pa3F6infMWGZ8
         Yvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXTO5MprXvHIQWTapodiaHnYkq6yaPhQ4S0ZTvUxcYg=;
        b=SwqP4yoaQswE47FTmeI/8A9jIRivTdrIwZGVYOQZeoUmQIss5oU7N/FOUiD/GcUbpv
         UxMyLZ4ljIUgaWr546R9hv/zU08nmrprNjWmnMxr5QXImmFo36u7VvpSTiJhuVsv0otX
         0be/TyX2pOKGn7XnMPb2Hh4uar6c9wZBANoYYXr//zXDcuqi1bibSldf2g4tvM8O8WtW
         ZbqJrBKu6YKfCZIRbZoL0ORXeCWN33q7EQDJTZJYVrDebm7yC6fziCUoxB9sxwg5E+cE
         hvfsajeZVsXh1aX+HbOep/kXebGUnvFbffo7eOPK8kYCm/ahGrnNhQb/iwYi2wC2GBI9
         2TyA==
X-Gm-Message-State: AOAM533+8lCvig2JqMDsmxjorKxgDJak3nlnyqtwzRv+tSHX+VpG0ety
        T7ayfnA0qpj4T4jLyUPBuaw=
X-Google-Smtp-Source: ABdhPJyHuG2sduei/L1gKZmiMIlw7Ek2kUbXCwNsmsYFZkISi8jVUtdRqBx+j/94uGEOjY+YazoGuw==
X-Received: by 2002:a9d:6e84:: with SMTP id a4mr14707807otr.112.1592063915569;
        Sat, 13 Jun 2020 08:58:35 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:34 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 21/24] dyndbg: adapt header macros to pass print-class
Date:   Sat, 13 Jun 2020 09:57:35 -0600
Message-Id: <20200613155738.2249399-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

derive DEFINE_DYNAMIC_DEBUG_METADATA_CL
from DEFINE_DYNAMIC_DEBUG_METADATA
then redefine latter as former(0, ...)

Also rework /(_?_?dynamic_.+)/ macros, adding _cl suffix & cl arg1
and redefine them in terms of _cl version.

in printk.h: add pr_debug_n, fix pr_debug use it with pr_cls=0
---
 include/linux/dynamic_debug.h | 69 +++++++++++++++++++++++------------
 include/linux/printk.h        |  5 ++-
 2 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 7ac822d6be87..d7f3dd6fc78a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -80,7 +80,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const struct ib_device *ibdev,
 			 const char *fmt, ...);
 
-#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
+#define DEFINE_DYNAMIC_DEBUG_METADATA_CL(cl, name, fmt)		\
 	static struct _ddebug  __aligned(8)			\
 	__section(__dyndbg) name = {				\
 		.modname = KBUILD_MODNAME,			\
@@ -89,8 +89,11 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
+		.pr_class = cl,					\
 		_DPRINTK_KEY_INIT				\
 	}
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt) \
+	DEFINE_DYNAMIC_DEBUG_METADATA_CL(0, name, fmt)
 
 #ifdef CONFIG_JUMP_LABEL
 
@@ -121,17 +124,21 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #endif
 
-#define __dynamic_func_call(id, fmt, func, ...) do {	\
-	DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);		\
-	if (DYNAMIC_DEBUG_BRANCH(id))			\
-		func(&id, ##__VA_ARGS__);		\
+#define __dynamic_func_call_cl(cl, id, fmt, func, ...) do {	\
+	DEFINE_DYNAMIC_DEBUG_METADATA_CL(cl, id, fmt);		\
+	if (DYNAMIC_DEBUG_BRANCH(id))				\
+		func(&id, ##__VA_ARGS__);			\
 } while (0)
+#define __dynamic_func_call(id, fmt, func, ...)			\
+	__dynamic_func_call_cl(0, id, fmt, func, ...)
 
-#define __dynamic_func_call_no_desc(id, fmt, func, ...) do {	\
-	DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);			\
-	if (DYNAMIC_DEBUG_BRANCH(id))				\
-		func(__VA_ARGS__);				\
+#define __dynamic_func_call_no_desc_cl(cl, id, fmt, func, ...) do {	\
+	DEFINE_DYNAMIC_DEBUG_METADATA_CL(cl, id, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(id))					\
+		func(__VA_ARGS__);					\
 } while (0)
+#define __dynamic_func_call_no_desc(cl, id, fmt, func, ...)		\
+	__dynamic_func_call_no_desc_cl(0, cl, id, fmt, func, ##__VA_ARGS__)
 
 /*
  * "Factory macro" for generating a call to func, guarded by a
@@ -141,31 +148,44 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * the varargs. Note that fmt is repeated in invocations of this
  * macro.
  */
-#define _dynamic_func_call(fmt, func, ...)				\
-	__dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
+#define _dynamic_func_call_cl(cl, fmt, func, ...)		\
+	__dynamic_func_call_cl(cl, __UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
+#define _dynamic_func_call(fmt, func, ...)			\
+	_dynamic_func_call_cl(0, fmt, func, ##__VA_ARGS__)
 /*
  * A variant that does the same, except that the descriptor is not
  * passed as the first argument to the function; it is only called
  * with precisely the macro's varargs.
  */
-#define _dynamic_func_call_no_desc(fmt, func, ...)	\
-	__dynamic_func_call_no_desc(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
+#define _dynamic_func_call_no_desc_cl(cl, fmt, func, ...)	\
+	__dynamic_func_call_no_desc_cl(cl, __UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
+#define _dynamic_func_call_no_desc(fmt, func, ...)		\
+	_dynamic_func_call_no_desc_cl(0, fmt, func, ##__VA_ARGS__)
 
-#define dynamic_pr_debug(fmt, ...)				\
-	_dynamic_func_call(fmt,	__dynamic_pr_debug,		\
-			   pr_fmt(fmt), ##__VA_ARGS__)
+#define dynamic_pr_debug_cl(cl, fmt, ...)			\
+	_dynamic_func_call_cl(cl, fmt, __dynamic_pr_debug,	\
+			      pr_fmt(fmt), ##__VA_ARGS__)
 
-#define dynamic_dev_dbg(dev, fmt, ...)				\
-	_dynamic_func_call(fmt,__dynamic_dev_dbg, 		\
+#define dynamic_dev_dbg_cl(cl, dev, fmt, ...)			\
+	_dynamic_func_call_cl(cl, fmt, __dynamic_dev_dbg,	\
 			   dev, fmt, ##__VA_ARGS__)
 
-#define dynamic_netdev_dbg(dev, fmt, ...)			\
-	_dynamic_func_call(fmt, __dynamic_netdev_dbg,		\
+#define dynamic_netdev_dbg_cl(cl, dev, fmt, ...)		\
+	_dynamic_func_call_cl(cl, fmt, __dynamic_netdev_dbg,	\
 			   dev, fmt, ##__VA_ARGS__)
 
-#define dynamic_ibdev_dbg(dev, fmt, ...)			\
-	_dynamic_func_call(fmt, __dynamic_ibdev_dbg,		\
-			   dev, fmt, ##__VA_ARGS__)
+#define dynamic_ibdev_dbg_cl(cl, dev, fmt, ...)			\
+	_dynamic_func_call_cl(cl, fmt, __dynamic_ibdev_dbg,	\
+			      dev, fmt, ##__VA_ARGS__)
+
+#define dynamic_pr_debug(...)					\
+	dynamic_pr_debug_cl(0, ##__VA_ARGS__)
+#define dynamic_dev_dbg(...)					\
+	dynamic_dev_dbg_cl(0, ##__VA_ARGS__)
+#define dynamic_netdev_dbg(...)					\
+	dynamic_netdev_dbg_cl(0, ##__VA_ARGS__)
+#define dynamic_ibdev_dbg(...)					\
+	dynamic_ibdev_dbg_cl(0, ##__VA_ARGS__)
 
 #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
 			 groupsize, buf, len, ascii)			\
@@ -202,6 +222,9 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 	return -EINVAL;
 }
 
+#define dynamic_pr_debug_cl(cl, ...) dynamic_pr_debug(__VA_ARGS__)
+#define dynamic_dev_dbg_cl(cl, ...)  dynamic_dev_dbg(__VA_ARGS__)
+
 #define dynamic_pr_debug(fmt, ...)					\
 	do { if (0) printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); } while (0)
 #define dynamic_dev_dbg(dev, fmt, ...)					\
diff --git a/include/linux/printk.h b/include/linux/printk.h
index fc8f03c54543..693d7c9235b7 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -416,7 +416,10 @@ extern int kptr_restrict;
  * pr_fmt() internally).
  */
 #define pr_debug(fmt, ...)			\
-	dynamic_pr_debug(fmt, ##__VA_ARGS__)
+	dynamic_pr_debug_cl(0, fmt, ##__VA_ARGS__)
+#define pr_debug_n(num, fmt, ...)				\
+	dynamic_pr_debug_cl(num, fmt, ##__VA_ARGS__)
+
 #elif defined(DEBUG)
 #define pr_debug(fmt, ...) \
 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-- 
2.26.2

