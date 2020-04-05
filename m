Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C59C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9048E20644
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCOf9EUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgDEQGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 12:06:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40091 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgDEQGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 12:06:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id c5so462369pgi.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SFjucbzNPzTJ25Tv8/pjykzoFBgwlF+DGdtgH9cJ+GQ=;
        b=KCOf9EUtnFOz+27goqRb0WuMUh997qLmiCQ7z609iFOB6qVLfTp081v8eadpHMfXr/
         MpJtADlGciRxo70TahBgYABeeoI5Z0oJIs5MNpgopbQe+COr1PuB+S2hqgjju0twBRr2
         zarTAK6vJegw1Vf97ZdU5LRreP5FJxMpT967KkaWzTTAICdzUsdwFGCoczzfW3Rj560b
         dggq0n/esaS5TE2sWBhPUVcH4eZPxhGvXvL16hP7EroDcpGodcLV7ukCwLSC7YkkJQxH
         voYjBSNx82GCC5xZ9vrpdTYOCIzDPDBAiBdPldcbLkT09rw0ACCvYIriy+fDLrQDK+8D
         l5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SFjucbzNPzTJ25Tv8/pjykzoFBgwlF+DGdtgH9cJ+GQ=;
        b=MsjLbCa+dnYSJwT1jrRAJOGkEjbUS7F6zD4+tll0wsmpj2EvzZ4q1Ap59jzCTk5oZb
         3HGYxcfd/NINe/nZT47YWVCnRjAXaN5PSGlROIA5cP1fDPLM5NYOpAuxCSZjTU6WfoBh
         QW/i8LI/q4QRlDOf9eaDBFC70s2ihW6n/DWKg91uFOrh3KWVbX9PsrzJgPs966AijvNy
         lV0D3Z2nGBysmILhls8D7iPrU0BytXIgX50l8uJxQ+COmZyfycklbu+oayj7rSOp4pCT
         gartvLGLRA8octmeTn5CgvR3cu88/Jdqt5P0TxzFjiu8x8K7uZCbMaVSl4VIcwjFxCt3
         WLZg==
X-Gm-Message-State: AGi0PuZl5nGYXrgJ9Z2iFX4As7r7Lqxegi01v1FOSD30DoUHGjsXSgua
        Roc3Upb0EgUrLFgtIMwCO7Y=
X-Google-Smtp-Source: APiQypLuixLhWvocBX9tvPIOvmbH9besJICjQtrDtJXukEIlKrwVR3BP/25Av1kBB5zQRPtlf8+0Kw==
X-Received: by 2002:aa7:8696:: with SMTP id d22mr17348838pfo.54.1586102790776;
        Sun, 05 Apr 2020 09:06:30 -0700 (PDT)
Received: from localhost.localdomain ([117.136.0.179])
        by smtp.gmail.com with ESMTPSA id h11sm9807258pfn.125.2020.04.05.09.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Apr 2020 09:06:30 -0700 (PDT)
From:   zhangfeionline@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, PengfeiZhang <zhangfeionline@gmail.com>
Subject: [PATCH] driver core: Fix possible use after free on name
Date:   Sun,  5 Apr 2020 09:05:49 -0700
Message-Id: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: PengfeiZhang <zhangfeionline@gmail.com>

__class_create() copies the pointer to the name passed as an
argument only to be used later. But there's a chance the caller
could immediately free the passed string(e.g., local variable).
This could trigger a use after free when we use class name(e.g.,
dev_uevent_name()called by device_destroy(),class_create_release()).

To be on the safe side: duplicate the string with kstrdup_const()
so that if an unaware user passes an address to a stack-allocated
buffer, we won't get the arbitrary name and crash.

Signed-off-by: PengfeiZhang <zhangfeionline@gmail.com>
---
 drivers/base/class.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index bcd410e..770b3b3 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -206,6 +206,7 @@ void class_unregister(struct class *cls)
 static void class_create_release(struct class *cls)
 {
 	pr_debug("%s called for %s\n", __func__, cls->name);
+	kfree_const(cls->name);
 	kfree(cls);
 }
 
@@ -227,7 +228,10 @@ struct class *__class_create(struct module *owner, const char *name,
 			     struct lock_class_key *key)
 {
 	struct class *cls;
-	int retval;
+	int retval = -EINVAL;
+
+	if (!name)
+		goto done;
 
 	cls = kzalloc(sizeof(*cls), GFP_KERNEL);
 	if (!cls) {
@@ -235,18 +239,27 @@ struct class *__class_create(struct module *owner, const char *name,
 		goto error;
 	}
 
+	name = kstrdup_const(name, GFP_KERNEL);
+	if (!name) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
 	cls->name = name;
 	cls->owner = owner;
 	cls->class_release = class_create_release;
 
 	retval = __class_register(cls, key);
 	if (retval)
-		goto error;
+		goto error_class_register;
 
 	return cls;
 
+error_class_register:
+	kfree(cls->name);
 error:
 	kfree(cls);
+done:
 	return ERR_PTR(retval);
 }
 EXPORT_SYMBOL_GPL(__class_create);
-- 
2.7.4

