Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3B1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32293206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILFYgyub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391028AbgDCSSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:18:38 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38563 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgDCSSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:18:37 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so3298385pje.3;
        Fri, 03 Apr 2020 11:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XyOcRqHLrPMKWL0+JCToAyCGJJg9Vdkcz8glcxLfQsY=;
        b=ILFYgyubl8EZk3gAnCfiFTzzgD6EDawXKLLuYpR4xGfNSvpQRhdd2gt6aT1KSee0fi
         gCeeigsN7dAe4UWcrr4JBXqCqOVm6q5KX2ASNntgXyFgwVBqUYf+NnHBGG8Dob9ZPGOA
         buqRasH4wFH8/JUfGTVhzq2/RVPmK/YWT2FJEj3Vgxl9B5CorEAWmASlAd6PxeWAGvMS
         iUtOOJydqkpgYxC3/M2Dld4oqYMMcfkn/yAxSZRnbGaLaWsFe2e10tL2EdrQWVuRwNAo
         QMxjkkUfgTyBZUlXVYAIbThKxEtPNChSuuWUg06MuxJYxpK1pLIGCgOAieb596eMeca/
         RKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XyOcRqHLrPMKWL0+JCToAyCGJJg9Vdkcz8glcxLfQsY=;
        b=D4wrF9zPLggbsQI+dzW+kE0MGaXotOzmKt1l7VqGFHAdeCWv1InAhJ9HemaBLYETaw
         8QXFVYvrM30ona1YWdMxmLud50VDPEUeFjMV41RIhRogVLmmUjwH0E4HvT41yxgq0pLn
         Tqohr4GtUpNADGlbTui8ei8s6sQlksjMeECpx5orB6Wg1eyqi8BGxCy8VGu9OQ+cDagh
         dekuSW/eJbM0G8/adWDKSW1sCfhGfvqhoYZk2RApI3qWGZy9zxyZE6mdG8DoSafAA/l2
         qYQ5dX/WWNdLi3keTJCNto2cm8Um3ixm2eGCMP0LNVp8u6g23+c8IQMqKDtzArSk1a9B
         s0Cw==
X-Gm-Message-State: AGi0PuYeNE8zYL7TU2lHqttdqiHKN2/ZVRdCr1YiMWbblyGNzsAqH52K
        +kPmDvi3hE6LeIFMF7p/08vlPUk=
X-Google-Smtp-Source: APiQypJNWzRaLCfW1ZN5MjEnanFUEM0GaLuid95rtKhYEECecqDPgywodDlnjVvpHUmPkE0hN7jdrQ==
X-Received: by 2002:a17:902:ac8d:: with SMTP id h13mr9142477plr.267.1585937916376;
        Fri, 03 Apr 2020 11:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:d32:bec6:f832:439c:9244:ba33])
        by smtp.gmail.com with ESMTPSA id f200sm6322893pfa.177.2020.04.03.11.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:18:35 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     gregkh@linuxfoundation.org, hariprasad.kelam@gmail.com,
        colin.king@canonical.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru,
        stern@rowland.harvard.edu,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] usb: host: u132-hcd: Remove u132_static_list and list head u132_list
Date:   Fri,  3 Apr 2020 23:48:16 +0530
Message-Id: <20200403181816.8115-1-madhuparnabhowmik10@gmail.com>
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
Also remove struct list_head u132_list from struct u132.

Found by Linux Driver Verification project (linuxtesting.org).

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/usb/host/u132-hcd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index e9209e3e6248..995bc52d2d22 100644
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
@@ -177,7 +176,6 @@ struct u132_ring {
 };
 struct u132 {
 	struct kref kref;
-	struct list_head u132_list;
 	struct mutex sw_lock;
 	struct mutex scheduler_lock;
 	struct u132_platform_data *board;
@@ -254,7 +252,6 @@ static void u132_hcd_delete(struct kref *kref)
 	struct usb_hcd *hcd = u132_to_hcd(u132);
 	u132->going += 1;
 	mutex_lock(&u132_module_lock);
-	list_del_init(&u132->u132_list);
 	u132_instances -= 1;
 	mutex_unlock(&u132_module_lock);
 	dev_warn(&u132->platform_dev->dev, "FREEING the hcd=%p and thus the u13"
@@ -3089,7 +3086,6 @@ static int u132_probe(struct platform_device *pdev)
 		retval = 0;
 		hcd->rsrc_start = 0;
 		mutex_lock(&u132_module_lock);
-		list_add_tail(&u132->u132_list, &u132_static_list);
 		u132->sequence_num = ++u132_instances;
 		mutex_unlock(&u132_module_lock);
 		u132_u132_init_kref(u132);
@@ -3192,7 +3188,6 @@ static struct platform_driver u132_platform_driver = {
 static int __init u132_hcd_init(void)
 {
 	int retval;
-	INIT_LIST_HEAD(&u132_static_list);
 	u132_instances = 0;
 	u132_exiting = 0;
 	mutex_init(&u132_module_lock);
@@ -3213,14 +3208,9 @@ static int __init u132_hcd_init(void)
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

