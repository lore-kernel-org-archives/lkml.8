Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E36C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A81624656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AITztlS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgAOSmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:42:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41921 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgAOSmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:42:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so19696829ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4f5SVpmjg4tV96vcY1wie1/tFbT5oyVSQBGC1Kpcs0=;
        b=AITztlS20IZgEJ8NQ5qreg8X15jfK/sjgiCboVCFiQDQZFRlubR3FYarEPw00acZpe
         o8V3XVR1YqCYdXcW8ZGUylPe84A4xWRJp2CjUQfJrfWjBTtkZ5fNrLCrHtYaC53IaJeW
         0fIYFSZq0E+BcwB0WZG5+bntxw7n1YgL3FAPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4f5SVpmjg4tV96vcY1wie1/tFbT5oyVSQBGC1Kpcs0=;
        b=A6ZNnClc36wpzNd4fAzeXvjIix1yX4cuoVfpIMu759CtAqykUFikd9H7U0pm6vQXkx
         t/Ynaew0Bl+Ml+tI1aTm7tMVk5EmoAAVmrzyNuZxmWQmgzazxyiOKjV4gG6PsXwZ3cNf
         tjQw/FtYXssaB5SHeWzBBz6V2x0C+oiW7TrUkVajCCbQVJ08aFtkZm0DSPEdQyJxWcko
         M5uhDydwNYszYZM8YR49+eZlsZ2ANCwZ0knnSPZIgr6mvZWYn9crDv9Cdr5M7VdcKrB5
         hQBNIzo8Njk8Ilu5knwG8fGj2HPLUZCrNkcQavwNSejb/VtgL+UR60hDnurjzmr/xPqY
         8S0w==
X-Gm-Message-State: APjAAAWCxOc/ZoNOt6Zpi/bD66MFPldd/K35xx6FjJspckQziDmS8FIc
        h4BzXJtKh6wVOkA3Uu9uMfZ7zw==
X-Google-Smtp-Source: APXvYqxIQhkp7WBrc6YcHJw1+6gr5i6zLN+diF+aXyVqupJwx5OlwL/m+RuJI6ZL5hCYUTxBhxd52Q==
X-Received: by 2002:a2e:818e:: with SMTP id e14mr2688900ljg.2.1579113723348;
        Wed, 15 Jan 2020 10:42:03 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 21sm9598631ljv.19.2020.01.15.10.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:42:02 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] devtmpfs: factor out common tail of devtmpfs_{create,delete}_node
Date:   Wed, 15 Jan 2020 19:41:53 +0100
Message-Id: <20200115184154.3492-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
References: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's some common boilerplate in devtmpfs_{create,delete}_node, put
that in a little helper.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/devtmpfs.c | 44 ++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 56632fb22fc0..5995c437cbdf 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -89,6 +89,23 @@ static inline int is_blockdev(struct device *dev)
 static inline int is_blockdev(struct device *dev) { return 0; }
 #endif
 
+static int devtmpfs_submit_req(struct req *req, const char *tmp)
+{
+	init_completion(&req->done);
+
+	spin_lock(&req_lock);
+	req->next = requests;
+	requests = req;
+	spin_unlock(&req_lock);
+
+	wake_up_process(thread);
+	wait_for_completion(&req->done);
+
+	kfree(tmp);
+
+	return req->err;
+}
+
 int devtmpfs_create_node(struct device *dev)
 {
 	const char *tmp = NULL;
@@ -113,19 +130,7 @@ int devtmpfs_create_node(struct device *dev)
 
 	req.dev = dev;
 
-	init_completion(&req.done);
-
-	spin_lock(&req_lock);
-	req.next = requests;
-	requests = &req;
-	spin_unlock(&req_lock);
-
-	wake_up_process(thread);
-	wait_for_completion(&req.done);
-
-	kfree(tmp);
-
-	return req.err;
+	return devtmpfs_submit_req(&req, tmp);
 }
 
 int devtmpfs_delete_node(struct device *dev)
@@ -143,18 +148,7 @@ int devtmpfs_delete_node(struct device *dev)
 	req.mode = 0;
 	req.dev = dev;
 
-	init_completion(&req.done);
-
-	spin_lock(&req_lock);
-	req.next = requests;
-	requests = &req;
-	spin_unlock(&req_lock);
-
-	wake_up_process(thread);
-	wait_for_completion(&req.done);
-
-	kfree(tmp);
-	return req.err;
+	return devtmpfs_submit_req(&req, tmp);
 }
 
 static int dev_mkdir(const char *name, umode_t mode)
-- 
2.23.0

