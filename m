Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E099C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFB1215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599646227;
	bh=DrZt4e9YLfPg0Lk/whdCAuWLqMlcxgTaAhqLzgLL9gA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2F6afIdhz71EqUnLq3Jz/O2/hQ0aVExfPgKDdpJ8N76PotVXdbyfcaqgdUKOEtiIC
	 ovfledjG5JieRg2PCm60lDaY9S1ifQcrqLM8Qkut5lv2Mz2bfgYb9EJU5GmthLUtyI
	 DsIz49YoceRZAuen7T1qi65OIHDJ8UE2+Gso4ICo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIIKKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIIKKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:10:14 -0400
Received: from localhost.localdomain (unknown [180.164.158.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9BD215A4;
        Wed,  9 Sep 2020 10:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599646213;
        bh=DrZt4e9YLfPg0Lk/whdCAuWLqMlcxgTaAhqLzgLL9gA=;
        h=From:To:Cc:Subject:Date:From;
        b=18xu8txyeTplyHzoA8E7bjCrL/XIFgcWM8/UfsFtcUzPh+20nSAgcnwO7fjm6DiaS
         dE59WYjwxMLpRN/KDhIkbU/t24z9rNzKumADv0fhM+nqQj688fulTT4In5mJ0iVC0r
         zWoybPRI4E4TUnb2iEV5Fv3qK/gWd2T0qj7kAvX4=
From:   Peter Chen <peter.chen@kernel.org>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-imx@nxp.com, jun.li@nxp.com, Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 1/1] extcon: release memory after both provider and user are unregistered
Date:   Wed,  9 Sep 2020 18:09:57 +0800
Message-Id: <20200909100957.6508-1-peter.chen@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

When the both extcon provider (eg, tcpci) and user (controller driver) are
built as module, if the extcon provider is removed first, the use-after-free
oops (see below) will be showed when removing extcon user module. The reason
is the edev (extcon device) and supported_cable are freed by provider, the
stale pointer will be get when calling unregister notifier.

Since the edev is used by both extcon provider and user, it needs to use
device core refcount to hold its memory until all users are unregistered.
The edev allocation and registration to device core are at two APIs, it
causes this memory management a little difficulties, this may could be
improveed in future after the edev .release is used for free memory.

oops log:
[  127.135373] Unable to handle kernel paging request at virtual address 0073656369766564
[  127.143400] Mem abort info:
[  127.146203]   ESR = 0x96000004
[  127.149378]   EC = 0x25: DABT (current EL), IL = 32 bits
[  127.155025]   SET = 0, FnV = 0
[  127.158097]   EA = 0, S1PTW = 0
[  127.161308] Data abort info:
[  127.164220]   ISV = 0, ISS = 0x00000004
[  127.168079]   CM = 0, WnR = 0
[  127.171072] [0073656369766564] address between user and kernel address ranges
[  127.178228] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  127.183803] Modules linked in: cdns3(-) phy_mxs_usb phy_generic crct10dif_ce mxc_jpeg_encdec imx8_media_dev(C) [last unloaded: usbmisc_imx]
[  127.196353] CPU: 1 PID: 1820 Comm: modprobe Tainted: G         C        5.4.47-00029-g054bf76ce616-dirty #4
[  127.206093] Hardware name: Freescale i.MX8QXP MEK (DT)

Message from syslogd@imx8qmmek at Fri Jul 10 07:34:08 2020 ...
imx8qmmek kernel: [  127.178228] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  127.224436] pstate: 20000005 (nzCv daif -PAN -UAO)
[  127.229240] pc : extcon_unregister_notifier+0x48/0xb8
[  127.234297] lr : devm_extcon_dev_notifier_unreg+0x1c/0x28
[  127.239696] sp : ffff80001257bc80
[  127.243004] x29: ffff80001257bc80 x28: ffff000837dc5400
[  127.248321] x27: 0000000000000000 x26: 0000000000000000
[  127.253638] x25: 0000000056000000 x24: ffff00083bcadc00
[  127.258956] x23: 0000000000000016 x22: ffff80001257bd08
[  127.264271] x21: ffff000836b95320 x20: ffff000836d20c00
[  127.269588] x19: 0000000000000000 x18: 0000000000000000
[  127.274905] x17: 0000000000000000 x16: 0000000000000000
[  127.280221] x15: 0000000000000004 x14: 4d554e5145530074
[  127.285538] x13: 0000000000000000 x12: 0000000000000001
[  127.290855] x11: 0000000000000000 x10: 0000000000000001
[  127.296172] x9 : ffff80001257ba50 x8 : ffff000837dc5e20
[  127.301488] x7 : 0000000040000000 x6 : 0000000000210d00
[  127.306805] x5 : 2f73656369766564 x4 : 0000000000000002
[  127.312122] x3 : ffff00083cbc6698 x2 : ffff000836b95320
[  127.317439] x1 : 0000000000000001 x0 : ffff000836d20c00
[  127.322757] Call trace:
[  127.325205]  extcon_unregister_notifier+0x48/0xb8
[  127.329908]  devm_extcon_dev_notifier_unreg+0x1c/0x28
[  127.334968]  release_nodes+0x1a8/0x220
[  127.338716]  devres_release_all+0x34/0x58
[  127.342723]  device_release_driver_internal+0x104/0x1c0
[  127.347952]  driver_detach+0x4c/0xd8
[  127.351533]  bus_remove_driver+0x54/0xa8
[  127.355460]  driver_unregister+0x2c/0x58
[  127.359388]  platform_driver_unregister+0x10/0x18

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/extcon/extcon.c | 60 ++++++++++++++++++++++++++++-------------
 drivers/extcon/extcon.h |  2 +-
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e055893fd5c3..306b80190246 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -909,6 +909,7 @@ int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
 	if (idx < 0)
 		return idx;
 
+	get_device(&edev->dev);
 	spin_lock_irqsave(&edev->lock, flags);
 	ret = raw_notifier_chain_register(&edev->nh[idx], nb);
 	spin_unlock_irqrestore(&edev->lock, flags);
@@ -941,6 +942,7 @@ int extcon_unregister_notifier(struct extcon_dev *edev, unsigned int id,
 	spin_lock_irqsave(&edev->lock, flags);
 	ret = raw_notifier_chain_unregister(&edev->nh[idx], nb);
 	spin_unlock_irqrestore(&edev->lock, flags);
+	put_device(&edev->dev);
 
 	return ret;
 }
@@ -967,6 +969,7 @@ int extcon_register_notifier_all(struct extcon_dev *edev,
 	if (!edev || !nb)
 		return -EINVAL;
 
+	get_device(&edev->dev);
 	spin_lock_irqsave(&edev->lock, flags);
 	ret = raw_notifier_chain_register(&edev->nh_all, nb);
 	spin_unlock_irqrestore(&edev->lock, flags);
@@ -994,6 +997,7 @@ int extcon_unregister_notifier_all(struct extcon_dev *edev,
 	spin_lock_irqsave(&edev->lock, flags);
 	ret = raw_notifier_chain_unregister(&edev->nh_all, nb);
 	spin_unlock_irqrestore(&edev->lock, flags);
+	put_device(&edev->dev);
 
 	return ret;
 }
@@ -1020,6 +1024,13 @@ static int create_extcon_class(void)
 
 static void extcon_dev_release(struct device *dev)
 {
+	struct extcon_dev *edev = container_of(dev, struct extcon_dev, dev);
+
+	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
+
+	kfree(edev->nh);
+	kfree(edev->supported_cable);
+	kfree(edev);
 }
 
 static const char *muex_name = "mutually_exclusive";
@@ -1041,6 +1052,7 @@ static void dummy_sysfs_dev_release(struct device *dev)
 struct extcon_dev *extcon_dev_allocate(const unsigned int *supported_cable)
 {
 	struct extcon_dev *edev;
+	int index = 0;
 
 	if (!supported_cable)
 		return ERR_PTR(-EINVAL);
@@ -1049,8 +1061,18 @@ struct extcon_dev *extcon_dev_allocate(const unsigned int *supported_cable)
 	if (!edev)
 		return ERR_PTR(-ENOMEM);
 
-	edev->max_supported = 0;
-	edev->supported_cable = supported_cable;
+	for (; supported_cable[index] != EXTCON_NONE; index++)
+		;
+
+	edev->max_supported = index;
+	edev->supported_cable = kmemdup(supported_cable,
+				(index + 1) * sizeof(*supported_cable),
+				GFP_KERNEL);
+
+	if (!edev->supported_cable) {
+		kfree(edev);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	return edev;
 }
@@ -1058,10 +1080,11 @@ struct extcon_dev *extcon_dev_allocate(const unsigned int *supported_cable)
 /*
  * extcon_dev_free() - Free the memory of extcon device.
  * @edev:	the extcon device
+ *
+ * TODO: useless now, may delete later
  */
 void extcon_dev_free(struct extcon_dev *edev)
 {
-	kfree(edev);
 }
 EXPORT_SYMBOL_GPL(extcon_dev_free);
 
@@ -1081,25 +1104,25 @@ EXPORT_SYMBOL_GPL(extcon_dev_free);
  */
 int extcon_dev_register(struct extcon_dev *edev)
 {
-	int ret, index = 0;
+	int ret, index;
 	static atomic_t edev_no = ATOMIC_INIT(-1);
 
 	if (!extcon_class) {
 		ret = create_extcon_class();
 		if (ret < 0)
-			return ret;
+			goto free_edev;
 	}
 
-	if (!edev || !edev->supported_cable)
-		return -EINVAL;
-
-	for (; edev->supported_cable[index] != EXTCON_NONE; index++);
+	if (!edev || !edev->supported_cable) {
+		ret = -EINVAL;
+		goto free_edev;
+	}
 
-	edev->max_supported = index;
-	if (index > SUPPORTED_CABLE_MAX) {
+	if (edev->max_supported > SUPPORTED_CABLE_MAX) {
 		dev_err(&edev->dev,
 			"exceed the maximum number of supported cables\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free_edev;
 	}
 
 	edev->dev.class = extcon_class;
@@ -1109,7 +1132,8 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (IS_ERR_OR_NULL(edev->name)) {
 		dev_err(&edev->dev,
 			"extcon device name is null\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free_edev;
 	}
 	dev_set_name(&edev->dev, "extcon%lu",
 			(unsigned long)atomic_inc_return(&edev_no));
@@ -1123,7 +1147,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 				       GFP_KERNEL);
 		if (!edev->cables) {
 			ret = -ENOMEM;
-			goto err_sysfs_alloc;
+			goto free_edev;
 		}
 		for (index = 0; index < edev->max_supported; index++) {
 			cable = &edev->cables[index];
@@ -1237,8 +1261,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 	}
 
 	spin_lock_init(&edev->lock);
-	edev->nh = devm_kcalloc(&edev->dev, edev->max_supported,
-				sizeof(*edev->nh), GFP_KERNEL);
+	edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh), GFP_KERNEL);
 	if (!edev->nh) {
 		ret = -ENOMEM;
 		goto err_dev;
@@ -1274,7 +1297,8 @@ int extcon_dev_register(struct extcon_dev *edev)
 err_alloc_cables:
 	if (edev->max_supported)
 		kfree(edev->cables);
-err_sysfs_alloc:
+free_edev:
+	kfree(edev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(extcon_dev_register);
@@ -1283,8 +1307,6 @@ EXPORT_SYMBOL_GPL(extcon_dev_register);
  * extcon_dev_unregister() - Unregister the extcon device.
  * @edev:	the extcon device to be unregistered.
  *
- * Note that this does not call kfree(edev) because edev was not allocated
- * by this class.
  */
 void extcon_dev_unregister(struct extcon_dev *edev)
 {
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 93b5e0306966..02b5da7f880c 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -41,7 +41,7 @@
 struct extcon_dev {
 	/* Optional user initializing data */
 	const char *name;
-	const unsigned int *supported_cable;
+	unsigned int *supported_cable;
 	const u32 *mutually_exclusive;
 
 	/* Internal data. Please do not set. */
-- 
2.17.1

