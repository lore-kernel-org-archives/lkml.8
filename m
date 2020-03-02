Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D0C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6298D217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsMLy1Lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCBNEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:04:38 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:41013 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgCBNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:04:37 -0500
Received: by mail-wm1-f74.google.com with SMTP id f207so2871528wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Wr2Qj05MN+2+uObWO7o5CaCL9JBE9M/aEcqw3hihs/Y=;
        b=JsMLy1LwqBPNhCZ8C0SkN0ibFV2jvFW7MLh2FiV+2/se6TT5NzZZoAm/skX7PxHnTP
         QDLYP+vYyGE+Z79s0Eycc7aeC7/ucskvy5rO4qJFgiHSEBeClC68CULVEOj/7z90Ugxi
         1CMfCA6Dk+tP+GESoBVRt/nEtS/b2zkiUWErzLsqm3cO18Jq7wjCxWmkXivrEWcv5BkT
         RBqWZOvPZIgt/B3+mTn1xdgIMAS9q+Ke5m3Lp4iLhMhTtHf/Gt91xDyQf0u6Iyy0gMrq
         9vcuL5GXPGvsuNHVWmrSGcFOhUkouHWb/CFhz/WwWJrhIap3S/1lDf9bsY+I2sfB1/7T
         96EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Wr2Qj05MN+2+uObWO7o5CaCL9JBE9M/aEcqw3hihs/Y=;
        b=SnGjbXSr9fWaNxFoysHfskNFwfFm7ZEAvVg8Eq0dS+6BxKjxRzzj9mFFopcCyMunKt
         0pTVbLLiLmV5VnzSTAUHglbaVy4RUhZDlK+vrwoSo85PDg+nc9Wc7kYYSGRUCne1jxa+
         2zx9zIe3p8imuPbO3vPVqL/weHgaG7REhz8w0Nrs0Ij9DptyELInDietIsHGzrWynaEA
         Av1vNCbRSCR7f5z4E8n7RtrLjsd8rYZo+YVbtpz45FdUi8uDVyms98tYppSaW4nGZpOp
         EgosIwnu4eJUqU65M2k37E4SU/T4PeUfHtlOyPcKgIvPl3gKHeQiLGLPoxTkRUzPG8bR
         xUxg==
X-Gm-Message-State: APjAAAXUWPMotZGx9fj/o+P0dRMZPJibrx15ii+jzn1OwYWBaaIriHlf
        2PS/AVQtoLaJDHH4G3KGu0kItUipU9E=
X-Google-Smtp-Source: APXvYqyg/8mpbpxuymg0ej9yeLWFMIm+QfXj5o/7rTcNntG02buymV/bnHtZ2K4XoI3xMButacyfTjszFa0=
X-Received: by 2002:a5d:4807:: with SMTP id l7mr22350075wrq.250.1583154275704;
 Mon, 02 Mar 2020 05:04:35 -0800 (PST)
Date:   Mon,  2 Mar 2020 14:04:28 +0100
Message-Id: <20200302130430.201037-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 1/3] compiler.h: define __no_initialize
From:   glider@google.com
To:     tkjos@google.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, arve@android.com, mingo@redhat.com
Cc:     dvyukov@google.com, jannh@google.com, devel@driverdev.osuosl.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CONFIG_INIT_STACK_ALL it's sometimes handy to disable
force-initialization for a local variable, if it is known to be initialized
later on before the first use. This can be done by using the
__no_initialize macro.

__no_initialize should be applied carefully, as future changes to
the code around the local variable may introduce paths on which the
variable remains uninitialized before the use.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

v2:
 - changed __do_not_initialize to __no_initialize as requested by Kees
   Cook
---
 include/linux/compiler-clang.h | 10 ++++++++++
 include/linux/compiler_types.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 333a6695a918c..27f774b27b061 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -24,6 +24,16 @@
 #define __no_sanitize_address
 #endif
 
+/*
+ * Disable initialization of a local variable when building with
+ * CONFIG_INIT_STACK_ALL.
+ */
+#ifdef CONFIG_INIT_STACK_ALL
+#define __no_initialize __attribute__((uninitialized))
+#else
+#define __no_initialize
+#endif
+
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a8c1a6c5..0208699c855af 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -216,6 +216,10 @@ struct ftrace_likely_data {
 # define __no_fgcse
 #endif
 
+#ifndef __no_initialize
+#define __no_initialize
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
-- 
2.25.0.265.gbab2e86ba0-goog

