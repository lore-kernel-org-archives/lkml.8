Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51274C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147E52054F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfSswwue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbgDATRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:17:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36228 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732303AbgDATRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:17:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so349781plo.3;
        Wed, 01 Apr 2020 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=viGWFCrIxPqDJuQStiywsFxnJG3SDHsHQV6GDzJrJRw=;
        b=SfSswwueB9nuSrY0D07ks4ZOi7dFotaZMRUFmemgH0arYcUIyQg8gU71qkctQDUM2I
         Fbp4C3/dabKOGWtTzfzBVsZ0GKomc7QRazdcoQrk6bArtah/KYyA6/UxWp5wYDeyhRIP
         4D/H1ARsUhnfnj4HI3ivQms5J43peUSbvrTC1YEdEEQG1dzY6RbaLAt62lZ9UmtzFioD
         fnqi96QuC/qo6QJuR28GJC4D4SO359ZVwkwkPY6qNVfatAJZR7vYTVVqnA58HH3o8Dpt
         Jf0pUyCDlt+2J6Jv6AozTmTy5PGBEqWiNlK+//3XvO6mafRm6JAXEiF1e08/5NKmc24x
         gJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=viGWFCrIxPqDJuQStiywsFxnJG3SDHsHQV6GDzJrJRw=;
        b=TGqmi6wKbnuYl4yE7exuHBkKk6FwPEKNsG5o+o6LpKGJbfQ8VBUBMaydpcR2ceT1QV
         kcNPiHmfCimGLOl0hbM5PPgqtNFYOaHUtUcHWXzinieY7tlJdefgEFN+he1mvTlgvAua
         pgFB//BBa0Kzawj9YhTvqYjLOsimIrFxncLWEKdw7w5MvklltW67T6nVWRZ9jUTlfTs/
         Ox/pBAvgWN69juAB+rFHTJRtr9/bK12fvNt+REvNgaeDNSSkM3Mu5TQWqVPYYoEqIAo+
         1b0sU7RdeP1n9neYNAfjXKj0FoZexiMVBZtbXcMXi+Dq+Fn73t0tkF+zrjWPEG2pUcTv
         GBcw==
X-Gm-Message-State: ANhLgQ1oe+tX7m7BvZkgmlbSzLfi/wHUyr1IqEmEVk7SgOPTsO2YKP9D
        tfhnXcstAKviwr4v8olGJg==
X-Google-Smtp-Source: ADFU+vt6j6vjN1F+h9jb2txE96Yfm/p5BVJmqPBUL7aMDC0TO+cKWVRJF8d7JBu9t2Dt4avZV0RMew==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10mr24025837plp.218.1585768671958;
        Wed, 01 Apr 2020 12:17:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:d0a:ee38:44da:9bb6:388c:6150])
        by smtp.gmail.com with ESMTPSA id q43sm2257428pjc.40.2020.04.01.12.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 12:17:50 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     gregkh@linuxfoundation.org, hariprasad.kelam@gmail.com,
        colin.king@canonical.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] usb: host: u132-hcd: Traverse u132_static_list under mutex lock in u132_hcd_exit
Date:   Thu,  2 Apr 2020 00:47:35 +0530
Message-Id: <20200401191735.10809-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

The global list u132_static_list is protected by u132_module_lock.
Elements are added to this list in the probe function and this list is
traversed in u132_hcd_exit() to unregister devices.

If probe and exit execute simultaneously there can be a race condition
between writing to this list in probe and reading the list in exit as
u132_module_lock is not held in exit function.

Even though u132_exiting variable is used in probe to detect if the module is
exiting, it is ineffective as the probe function may read the value
before it is updated in exit and thus leading to a race condition.

Therefore, hold u132_module_lock while traversing u132_static_list in
exit function.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/usb/host/u132-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index e9209e3e6248..1cadc4e0c9b2 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3217,10 +3217,10 @@ static void __exit u132_hcd_exit(void)
 	struct u132 *temp;
 	mutex_lock(&u132_module_lock);
 	u132_exiting += 1;
-	mutex_unlock(&u132_module_lock);
 	list_for_each_entry_safe(u132, temp, &u132_static_list, u132_list) {
 		platform_device_unregister(u132->platform_dev);
 	}
+	mutex_unlock(&u132_module_lock);
 	platform_driver_unregister(&u132_platform_driver);
 	printk(KERN_INFO "u132-hcd driver deregistered\n");
 	wait_event(u132_hcd_wait, u132_instances == 0);
-- 
2.17.1

