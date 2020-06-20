Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9CDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C625D207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgFTPFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 11:05:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39429 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgFTPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 11:05:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id a9so14689834ljn.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 08:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbdOzdHlWKQ2A53AC9U9xzo8udqOk2K2fGGjIVcMgws=;
        b=SQok47lO51Rup7rtvWC9Q5fMLrzwQhmkTqWWQKP6sGxa6tLpvxKf9nQLExR7Yegy6L
         j+W0BlAatQ0NkSq8KE0NNDy4h1i1HcOLOjVXpi+04VdUZmV7DFoMqhLUccIXmodVeWWR
         cZpfu/NJoQ3XW1nNez+nUVOLuyVbFEIh23uPddLI5+6g9G0UquA/VlmMXO7bncsyC7kP
         aK4JGzAJDrhuIsKvaesrWV05tEbkfg+Q3BCKjVFS0jLjvXWsWpMp3BXzQQEiWv3N5GIy
         SwOs1wpINKEBZ46ZDk6baxlApzA6DO1z5RzoLNEEoGLrPTxwJwBLkNUZTVmRsbtcYp1T
         /Bng==
X-Gm-Message-State: AOAM530pEXjggeOwTFkXiRRwyHn2w2v9/v4Y7FZKMgugV/QXZtZx0K7n
        W2F2zccZkIbhmqDnPJW8EnMzLx+RLjjRKw==
X-Google-Smtp-Source: ABdhPJyMxDjxla5jDylaP2ys+kG8FYZz/1U4aHCzjUkq6lGx47llrQKTrzsRB76ovI9U9LZsbwFNAQ==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr4075012ljh.318.1592665537268;
        Sat, 20 Jun 2020 08:05:37 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.195])
        by smtp.googlemail.com with ESMTPSA id u8sm2127832lff.38.2020.06.20.08.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 08:05:36 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Use scnprintf() instead of snprintf() in device show functions
Date:   Sat, 20 Jun 2020 18:05:29 +0300
Message-Id: <20200620150529.18678-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Documentation/filesystems/sysfs.txt:
- show() must not use snprintf() when formatting the value to be
  returned to user space. If you can guarantee that an overflow
  will never happen you can use sprintf() otherwise you must use
  scnprintf().

The reason is that snprintf() returns the length the resulting string
would be, assuming the data will fit into the destination array.
scnprintf() returns the length of the string actually created in buf.

device_show_{ulong,int,bool}() functions are reference implementation
and should respect the kernel documentation.

Signed-off-by: Denis Efremov <efremov@linux.com>
---

Actually, I don't know why snprintf() is used here initially. It looks
safe to use sprintf().

 drivers/base/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67d39a90b45c..2815deb511fc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1472,7 +1472,7 @@ ssize_t device_show_ulong(struct device *dev,
 			  char *buf)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	return snprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_ulong);
 
@@ -1502,7 +1502,7 @@ ssize_t device_show_int(struct device *dev,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
+	return scnprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_int);
 
@@ -1523,7 +1523,7 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
+	return scnprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
-- 
2.26.2

