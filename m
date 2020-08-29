Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A641EC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D5820776
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm54eYmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgH2Xig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 19:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgH2Xif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 19:38:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BE3C061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 16:38:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so2516297wrl.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvvEFJC3r2OPjSyh/BhUW93zegDka1Z53malHiCOnk8=;
        b=hm54eYmJkDSU+QWtvWQJeloX9fUQ+Oc1WZHl7RpQFt0U9yIZxEj5os4fPJn8HRYjTL
         S+uG0UWxqjY1u1Fw+nTHgz5PJcUxWhSepdeBxAaN3Z/BU9owHZqpVUz8dmdHQtH/jrzl
         p9UQ1lbWbnHx3Ve3YrspC+jNUUXrp013DDZbuRUo0KOeHwHa0FEFa+L6tSZLOAJ0yITk
         C4kB0dr37ySuR7em7Gwxa7BhFYefRnMh1E/Jocg0iySrHwhlvi7zQedEDOsxgbjnTFjN
         flLOzAs4ajIj3IeurvVUOnPfWB7Mmciji9Q735Ayi1zG/j5Z8ujzzyDveMCBJS3j80Nt
         hZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvvEFJC3r2OPjSyh/BhUW93zegDka1Z53malHiCOnk8=;
        b=Jr6GA02LJ+C8sR1jKJ29BNN0iJ17Y0dauvFu2HR00urJg0QxbvaZ0kssTJWI8Ob4Ba
         Y6TJvKsLrBCdbYn3olFe7SzPCVwhDCbDcMqQ4ZkWIhydhdN+GTT+tU4PejZWp9pxX8Dm
         g/MTMhPaO7QcpOC/p/ZIc8HL4sUGttgz4UVwndCgD25J4Qkwc1Zpd62e+AEzTN+RnUUD
         tY1NKdnc/vSkPmQNyxDUqks8msjhdKSuj3xpPQO3iT9t31BoQdOfCcifCkKBazFwgGbB
         asxZeymLG+3oH9shlz0E/zdFpDoT7uvgwPbVLKxXFZMVNd9W5N5q4Y7BB7pBtwlv5pLm
         3lSQ==
X-Gm-Message-State: AOAM533lDsmmxA4w8zuEMQBn+fD5JTPyO9HMHZNH8gQyn4E9wscWNEjj
        7O5uaF6vlBpg6rz/7CDn0IU=
X-Google-Smtp-Source: ABdhPJwOQ4DKvVV549h6bmWs5l7UA6+RRcDIJEyLAbonxDuMgULQpsaiyUb67c3zbRwow2PuVrhHXA==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr5100689wrh.167.1598744312916;
        Sat, 29 Aug 2020 16:38:32 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id t13sm5253878wru.65.2020.08.29.16.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 16:38:32 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/2] sysfs: add helpers for safely showing simple strings
Date:   Sun, 30 Aug 2020 00:37:16 +0100
Message-Id: <20200829233720.42640-2-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829233720.42640-1-alex.dewar90@gmail.com>
References: <20200829233720.42640-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper, sysfs_strscpy(), which simply copies a string and
appends a newline and NUL char to the end, making sure not to overflow
the destination buffer, which MUST be PAGE_SIZE bytes (which is true for
buffers in this context). It includes a compile time check for the
specified destination buffer size.

Also add a helper macro, sysfs_strcpy(), which calls sysfs_strscpy() with
count == PAGE_SIZE, for use with regular NUL-terminated strings. If the
src buffer is a fixed-size array, guarantee that we don't copy beyond its
end by only copying a maximum of sizeof(src) bytes.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 fs/sysfs/file.c       | 14 ++++++++++++++
 include/linux/sysfs.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index eb6897ab78e7..2a60e5c6392d 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -707,3 +707,17 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sysfs_change_owner);
+
+ssize_t __sysfs_strscpy(char *dest, const char *src, size_t count)
+{
+	ssize_t written;
+
+	if (count > PAGE_SIZE)
+		return -EINVAL;
+
+	written = strscpy(dest, src, count - 1);
+	dest[written++] = '\n';
+	dest[written] = '\0';
+	return written;
+}
+EXPORT_SYMBOL_GPL(__sysfs_strscpy);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 34e84122f635..26e7d9f69dfd 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -162,6 +162,41 @@ static const struct attribute_group _name##_group = {		\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 
+/**
+ *	sysfs_strscpy - return a string from a show method with terminating
+ *	newline to a maximum of count bytes
+ *	@dest: destination buffer
+ *	@src: string to be emitted
+ *	@count: maximum number of bytes to be written to dest
+ */
+#define sysfs_strscpy(dest, src, count)                                       \
+({                                                                            \
+	BUILD_BUG_ON(__builtin_constant_p(count) && (count) > PAGE_SIZE);      \
+	__sysfs_strscpy((dest), (src), (count));                               \
+})
+
+ssize_t __sysfs_strscpy(char *dest, const char *src, size_t count);
+
+/**
+ *	sysfs_strcpy - return a string from a show method with terminating
+ *	newline
+ *	@dest: destination buffer
+ *	@src: string to be emitted
+ *
+ *	This method will only write a maximum of PAGE_SIZE bytes to dest,
+ *	ensuring that the output buffer is not overflown. If src is a
+ *	fixed-size array, a maximum of sizeof(src) bytes will be copied,
+ *	ensuring that memory is not read beyond the end of the array.
+ */
+#define sysfs_strcpy(dest, src)                                      \
+sysfs_strscpy((dest), (src),                                         \
+		__builtin_choose_expr(                                \
+			__same_type((src), &(src)[0]),                \
+			PAGE_SIZE,                                    \
+			min(sizeof(src) + 2, PAGE_SIZE)               \
+		)                                                     \
+)
+
 struct file;
 struct vm_area_struct;
 
-- 
2.28.0

