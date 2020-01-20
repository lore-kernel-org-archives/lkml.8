Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A4AC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82CF2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="oHxM02Cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgATEyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 23:54:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37214 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgATEyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:54:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so14898162pga.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 20:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pOmFCBblhkqj3gkmP+37nPe0hJ5NkRyIggkMoZ1sHnY=;
        b=oHxM02Cr48GBC2n2ErbUXAGiQbp9a9tIcZ01GW7OKYJz7SZdJx/qhAqSqjyNPLtZHc
         iXgHOE9I9QQlka8lEeceHuV/2cuIprxB8oep2Vgu9GlkUbjY9SELUov3xaKqMu7+FpNS
         NJ3D9mZpMq9jHjQyR1ePY6oL3wPxcf7nalshU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pOmFCBblhkqj3gkmP+37nPe0hJ5NkRyIggkMoZ1sHnY=;
        b=SYETf0m6I4Yoi69r/CJjwxlfOyeqmwHxyXTewe0V1YLQV23hkG8yISRQXBEvwE1e4R
         sGyHu5YsDkFwxD+MyHJSTWMTJu6HCrQN5SPt14zO7MT3MadqEQLU9I8pzxINVLTtnz/n
         PZ6Kn+GODrOfnlSEH89M5wANxc+sUnK+k5ttvIEz4sIZH2g4jCFkyxAKwB1g7nXBcOmZ
         nfyMEyUkLDNdYNBazi5l/dTNnCsxvig12C4pdbPwryqiVdMvtYjzDBI51JgLeh3H/Lpv
         gXAMjlDkohWIPSqJ0qu9BgPlkvO/QEn2S3NMY6sL4sOuGPDYoACduzCz35J6NnflC+iz
         XM+Q==
X-Gm-Message-State: APjAAAUjdb+gTA4GSqYMJWh3KEFRx6m4ITAFHRI67KVVYWgBZAy5B7Ie
        tzqOwKp3hMQUXUWKKUuTCEgpUg==
X-Google-Smtp-Source: APXvYqx7MFbc9YXjaXN7u01v6rADAHDuX6xKBxQb86CEcWZHxmIXyxvsRMsN6v83PEIaZCaoJ+1MrA==
X-Received: by 2002:a63:a4b:: with SMTP id z11mr56030367pgk.97.1579496078651;
        Sun, 19 Jan 2020 20:54:38 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-4064-d910-a710-f29a.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4064:d910:a710:f29a])
        by smtp.gmail.com with ESMTPSA id d4sm1663895pjg.19.2020.01.19.20.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 20:54:38 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kernel-hardening@lists.openwall.com, akpm@linux-foundation.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 2/2] lkdtm: tests for FORTIFY_SOURCE
Date:   Mon, 20 Jan 2020 15:54:24 +1100
Message-Id: <20200120045424.16147-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120045424.16147-1-dja@axtens.net>
References: <20200120045424.16147-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to test both:

 - runtime detection of the overrun of a structure. This covers the
   __builtin_object_size(x, 0) case. This test is called FORTIFY_OBJECT.

 - runtime detection of the overrun of a char array within a structure.
   This covers the __builtin_object_size(x, 1) case which can be used
   for some string functions. This test is called FORTIFY_SUBOBJECT.

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/lkdtm/bugs.c  | 51 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c  |  2 ++
 drivers/misc/lkdtm/lkdtm.h |  2 ++
 3 files changed, 55 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index a4fdad04809a..77bf01ce7e0c 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -11,6 +11,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
 #include <linux/uaccess.h>
+#include <linux/slab.h>
 
 #ifdef CONFIG_X86_32
 #include <asm/desc.h>
@@ -376,3 +377,53 @@ void lkdtm_DOUBLE_FAULT(void)
 	panic("tried to double fault but didn't die\n");
 }
 #endif
+
+void lkdtm_FORTIFY_OBJECT(void)
+{
+	struct target {
+		char a[10];
+	} target[2] = {};
+	int result;
+
+	/*
+	 * Using volatile prevents the compiler from determining the value of
+	 * 'size' at compile time. Without that, we would get a compile error
+	 * rather than a runtime error.
+	 */
+	volatile int size = 11;
+
+	pr_info("trying to read past the end of a struct\n");
+
+	result = memcmp(&target[0], &target[1], size);
+
+	/* Print result to prevent the code from being eliminated */
+	pr_err("FAIL: fortify did not catch an object overread!\n"
+	       "\"%d\" was the memcmp result.\n", result);
+}
+
+void lkdtm_FORTIFY_SUBOBJECT(void)
+{
+	struct target {
+		char a[10];
+		char b[10];
+	} target;
+	char *src;
+
+	src = kmalloc(20, GFP_KERNEL);
+	strscpy(src, "over ten bytes", 20);
+
+	pr_info("trying to strcpy past the end of a member of a struct\n");
+
+	/*
+	 * strncpy(target.a, src, 20); will hit a compile error because the
+	 * compiler knows at build time that target.a < 20 bytes. Use strcpy()
+	 * to force a runtime error.
+	 */
+	strcpy(target.a, src);
+
+	/* Use target.a to prevent the code from being eliminated */
+	pr_err("FAIL: fortify did not catch an sub-object overrun!\n"
+	       "\"%s\" was copied.\n", target.a);
+
+	kfree(src);
+}
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index ee0d6e721441..78d22a23b4f9 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -117,6 +117,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(STACK_GUARD_PAGE_TRAILING),
 	CRASHTYPE(UNSET_SMEP),
 	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
+	CRASHTYPE(FORTIFY_OBJECT),
+	CRASHTYPE(FORTIFY_SUBOBJECT),
 	CRASHTYPE(OVERWRITE_ALLOCATION),
 	CRASHTYPE(WRITE_AFTER_FREE),
 	CRASHTYPE(READ_AFTER_FREE),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index c56d23e37643..13f13421dc19 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -31,6 +31,8 @@ void lkdtm_UNSET_SMEP(void);
 #ifdef CONFIG_X86_32
 void lkdtm_DOUBLE_FAULT(void);
 #endif
+void lkdtm_FORTIFY_OBJECT(void);
+void lkdtm_FORTIFY_SUBOBJECT(void);
 
 /* lkdtm_heap.c */
 void __init lkdtm_heap_init(void);
-- 
2.20.1

