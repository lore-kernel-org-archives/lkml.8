Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39B1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C182120757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy4Iv1dK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgEVVmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbgEVVmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:42:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17180C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:42:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a13so4939541pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fVUAtXSaWXKY2QT13OooGchGaVr8PVTqlkJIqIUCls=;
        b=cy4Iv1dKrgmFf8HFHiIihXeT9oWaLOFcX1u1xNS9Unjy3U9g7biDlL4hxe7LkC719J
         FkNVSCdFQwEML09RQPogyqLJF7hZonYdZrgu15BM52spOiyUe3YyKKRv5wh/hCiPVWMA
         sRITXFqyl4JxmJQPmbVQk9YiW2pb7BX1K5UxwM+BR9pfgXKlOlFglFW/7aGbqlI7ammv
         MZWvNtpLIVPyFv5psFYbpRL2iowWwVVe0UUhgs0I90tUqHZsEYFrIk3cosGX9kmhvWos
         USZpLWnCmaHoNlbyoMPtENvVpECQp7NrVPImq2t0nfV/BxjRrJ5ZKEsw4qOZ/jki0p8u
         QdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fVUAtXSaWXKY2QT13OooGchGaVr8PVTqlkJIqIUCls=;
        b=TYm4FXYy435zVHPVHoZSFqAeHjDutgyBovKb5DmJMFZU/P7aIpHky4Zc4E0/TcyjIF
         fnyaWjVcNWwxa2TC1zHUTnq0q7KCgT4/QkOWNGGuXOSLoi6nH7v/WRRGKZ9CMsD8GPNA
         FIVGHjxUfsId7O/QtECs+qW+LhMMa4nQznWO76Ay5lrn0qN5pdr+qKksJvh2m2RtXe8P
         ezqP2YFTKsW0a6R02lsvlAnQzg8MNodv3qHn2ciVxQHhOlByyFVuAPAt34lCSgJwu7xi
         f9O/7j/S7R6GQfMr4iSjmynKzee3MZw6ZBIvtzTdCPCsYCtG+BgZgEb4ASIiZHCceKvV
         0Ctg==
X-Gm-Message-State: AOAM531rlonb6AFBjvwazs5A5dXYmBjcf2g5S0OSY9nu5qqPUODxhMM3
        GJ3H73CETDSdRVXGAsTZwVc=
X-Google-Smtp-Source: ABdhPJyWoqBNAKwmwX2jgA3ybB8t3HseB65aDPJiYRmvuQhMYa7q3wo6oJvsLtPe9Q8F9aOSJpBfiw==
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr6547467pjb.78.1590183736327;
        Fri, 22 May 2020 14:42:16 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:d0d2:96ff:22ac:b8e6])
        by smtp.gmail.com with ESMTPSA id 4sm7625098pff.18.2020.05.22.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:42:15 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/3] xtensa: add missing __user annotations to asm/uaccess.h
Date:   Fri, 22 May 2020 14:41:53 -0700
Message-Id: <20200522214153.30163-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522214153.30163-1-jcmvbkbc@gmail.com>
References: <20200522214153.30163-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_user, strncpy_user, strnlen_user and their helpers operate on user
pointers, but don't have their arguments marked as __user.
Add __user annotation to userspace pointers of those functions.
Fix open-coded access check in the strnlen_user while at it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/uaccess.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 445bb4cf3c28..e933ded0d07b 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -270,15 +270,15 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
  */
 
 static inline unsigned long
-__xtensa_clear_user(void *addr, unsigned long size)
+__xtensa_clear_user(void __user *addr, unsigned long size)
 {
-	if (!__memset(addr, 0, size))
+	if (!__memset((void __force *)addr, 0, size))
 		return size;
 	return 0;
 }
 
 static inline unsigned long
-clear_user(void *addr, unsigned long size)
+clear_user(void __user *addr, unsigned long size)
 {
 	if (access_ok(addr, size))
 		return __xtensa_clear_user(addr, size);
@@ -290,10 +290,10 @@ clear_user(void *addr, unsigned long size)
 
 #ifndef CONFIG_GENERIC_STRNCPY_FROM_USER
 
-extern long __strncpy_user(char *, const char *, long);
+extern long __strncpy_user(char *dst, const char __user *src, long count);
 
 static inline long
-strncpy_from_user(char *dst, const char *src, long count)
+strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	if (access_ok(src, 1))
 		return __strncpy_user(dst, src, count);
@@ -306,13 +306,11 @@ long strncpy_from_user(char *dst, const char *src, long count);
 /*
  * Return the size of a string (including the ending 0!)
  */
-extern long __strnlen_user(const char *, long);
+extern long __strnlen_user(const char __user *str, long len);
 
-static inline long strnlen_user(const char *str, long len)
+static inline long strnlen_user(const char __user *str, long len)
 {
-	unsigned long top = __kernel_ok ? ~0UL : TASK_SIZE - 1;
-
-	if ((unsigned long)str > top)
+	if (!access_ok(str, 1))
 		return 0;
 	return __strnlen_user(str, len);
 }
-- 
2.20.1

