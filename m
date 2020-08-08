Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537AFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225F020825
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930060;
	bh=HOXa4eD0bvE5fye5g9+SaQbqIgVHHLMvawfQXnpAunQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gHIDlHHh4MGEAuGOUQ3LnTHieQPDuPj2NB99FvW8VNUrTi0vqIaA3iSTLNJn008cn
	 M8lsI0ScG6VlHT1ZYy+4rCWlOPOKakqK/IeQDZlJlmyNRC1nHcUJXJ2+rVi8EEp/lC
	 zLVvyZ+zOofDjHl0VtLvnKYSOw/QyprIG6HFGM1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgHHXk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgHHXk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:40:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C77C221E2;
        Sat,  8 Aug 2020 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596930055;
        bh=HOXa4eD0bvE5fye5g9+SaQbqIgVHHLMvawfQXnpAunQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JZE+oyexIC/7i0mM3Y+SGKJH/oBTQgT4UXeGXajYrm1HK7Dc8V1VinS2cMzEgVBzl
         XT9mrd3CScOgAeiA7tVOBenhRwVNV7ypOT13+YFIDnUD+K2+D1UwMWymtd6KdoVaJ4
         JdIg9b1fkBJG4ZtwnHIg/dBMZL1Cd8oKfjaG8ujs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Borislav Petkov <bp@suse.de>,
        Sasha Levin <sashal@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 1/5] EDAC: Fix reference count leaks
Date:   Sat,  8 Aug 2020 19:40:49 -0400
Message-Id: <20200808234054.3619873-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 17ed808ad243192fb923e4e653c1338d3ba06207 ]

When kobject_init_and_add() returns an error, it should be handled
because kobject_init_and_add() takes a reference even when it fails. If
this function returns an error, kobject_put() must be called to properly
clean up the memory associated with the object.

Therefore, replace calling kfree() and call kobject_put() and add a
missing kobject_put() in the edac_device_register_sysfs_main_kobj()
error path.

 [ bp: Massage and merge into a single patch. ]

Fixes: b2ed215a3338 ("Kobject: change drivers/edac to use kobject_init_and_add")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200528202238.18078-1-wu000273@umn.edu
Link: https://lkml.kernel.org/r/20200528203526.20908-1-wu000273@umn.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/edac_device_sysfs.c | 1 +
 drivers/edac/edac_pci_sysfs.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index fb68a06ad6837..18991cfec2af4 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -280,6 +280,7 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 
 	/* Error exit stack */
 err_kobj_reg:
+	kobject_put(&edac_dev->kobj);
 	module_put(edac_dev->owner);
 
 err_mod_get:
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 24d877f6e5775..c56128402bc67 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -394,7 +394,7 @@ static int edac_pci_main_kobj_setup(void)
 
 	/* Error unwind statck */
 kobject_init_and_add_fail:
-	kfree(edac_pci_top_main_kobj);
+	kobject_put(edac_pci_top_main_kobj);
 
 kzalloc_fail:
 	module_put(THIS_MODULE);
-- 
2.25.1

