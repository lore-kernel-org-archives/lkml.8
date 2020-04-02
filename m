Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333EFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC1520787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXRapGOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbgDBXWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:22:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42233 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDBXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:22:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id e1so1945085plt.9;
        Thu, 02 Apr 2020 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u8HvPpe3qGqlNdDY9g14WKC8TpBv8LKW4vXztMEUQuU=;
        b=BXRapGOpGVCp/gSWUISRPklkqWTrVMLlkReKe3UM16a5/8GQC8W9dnDkWy69uvKKFH
         QOBaW4lSsR7ql/CmDNA20yb04WtGe2mqf2nFyBzeLFAweKbuzQ1coOTt1yi/6Ij3CgRR
         hCzRyQv7o4JsclzfBfWAbjYwAjTl+Y2ITa2N9aC/UVJo/z4Wu4Peram4uEw0E5aOTzkn
         8QnI1qO/rbsYPIO//CELXM7kdSPZy9vrngkBKqZmrf5sAArm009WnmxJr9M2VjOIVQOa
         bHdabNf3PO3D6G+C+iHQ4/Z1y0ML3hZ/hEQOzOAw5Q5mg3TgTt8HFo78J2C4E+z5QUy7
         eTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u8HvPpe3qGqlNdDY9g14WKC8TpBv8LKW4vXztMEUQuU=;
        b=I1jM0ohF+xszm49CBlyWjfeoRNP5B98pNGsM4YpjD4v5UO2czF32wOoQJxqBXJVY0I
         KfMek7p66qfWgzPtO3SbqwNlLRjbsREIGztPe0RWUGlJfcMOgEPoADYU5+elO5j87IPB
         OpqdPp5GBdnDFsqaOotuYJdRYRXIh41piVUb81TnhZHKaPvzmEewp1ih04V4oInycjYP
         AUJHdd8R+WuYOFtiyepc5cfDKJKRH49c6HXvf2BS1qgeKvIAn3e15kFg0GwD3065BhNZ
         h9vGmqHBBRdJPTCRQMt0mHe4M2Idbl+1h6Vd1JZrLBaDmFbAVv+gr7wgME7UTnCtP9bK
         BLCA==
X-Gm-Message-State: AGi0PuaRbfGCR359KgzItLdMljjkG7xhtFqajsbnV9lqoRpxfSOwdi5D
        hSe+zCgtmFPZ89OUCjZGdvpAzp4=
X-Google-Smtp-Source: APiQypLezL7kO8y7vcqeff1s22qaWpImDhaVh2fQJ557YifCfpcJVqu3Fte88pNlWkSXH6yqZXJ8Yw==
X-Received: by 2002:a17:90a:8e84:: with SMTP id f4mr6542572pjo.72.1585869766247;
        Thu, 02 Apr 2020 16:22:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:13be:9909:917a:5556:7ebf:36b9])
        by smtp.gmail.com with ESMTPSA id 67sm4440445pfe.168.2020.04.02.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 16:22:45 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     gregkh@linuxfoundation.org, hariprasad.kelam@gmail.com,
        colin.king@canonical.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru,
        stern@rowland.harvard.edu,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] usb: host: u132-hcd: Remove u132_static_list
Date:   Fri,  3 Apr 2020 04:52:28 +0530
Message-Id: <20200402232228.22395-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

u132_static_list is a global list protected by u132_module_lock.
It is read in the u132_hcd_exit() function without holding the lock
thus may lead to data race.
However, it turns out that this list isn't used for anything useful
and thus it is okay to get rid of it.
Thus, remove the u132_static_list from u132-hcd module.

Found by Linux Driver Verification project (linuxtesting.org).

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/usb/host/u132-hcd.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index e9209e3e6248..52f70cf063ea 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -81,7 +81,6 @@ static DECLARE_WAIT_QUEUE_HEAD(u132_hcd_wait);
 static struct mutex u132_module_lock;
 static int u132_exiting;
 static int u132_instances;
-static struct list_head u132_static_list;
 /*
 * end of the global variables protected by u132_module_lock
 */
@@ -3089,7 +3088,6 @@ static int u132_probe(struct platform_device *pdev)
 		retval = 0;
 		hcd->rsrc_start = 0;
 		mutex_lock(&u132_module_lock);
-		list_add_tail(&u132->u132_list, &u132_static_list);
 		u132->sequence_num = ++u132_instances;
 		mutex_unlock(&u132_module_lock);
 		u132_u132_init_kref(u132);
@@ -3192,7 +3190,6 @@ static struct platform_driver u132_platform_driver = {
 static int __init u132_hcd_init(void)
 {
 	int retval;
-	INIT_LIST_HEAD(&u132_static_list);
 	u132_instances = 0;
 	u132_exiting = 0;
 	mutex_init(&u132_module_lock);
@@ -3213,14 +3210,9 @@ static int __init u132_hcd_init(void)
 module_init(u132_hcd_init);
 static void __exit u132_hcd_exit(void)
 {
-	struct u132 *u132;
-	struct u132 *temp;
 	mutex_lock(&u132_module_lock);
 	u132_exiting += 1;
 	mutex_unlock(&u132_module_lock);
-	list_for_each_entry_safe(u132, temp, &u132_static_list, u132_list) {
-		platform_device_unregister(u132->platform_dev);
-	}
 	platform_driver_unregister(&u132_platform_driver);
 	printk(KERN_INFO "u132-hcd driver deregistered\n");
 	wait_event(u132_hcd_wait, u132_instances == 0);
-- 
2.17.1

