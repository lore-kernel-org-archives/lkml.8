Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6E7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F95120739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFMIG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 04:06:56 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:9910 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMIGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 04:06:54 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 37CC4261122;
        Sat, 13 Jun 2020 16:06:50 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drivers/hwmon/nct6683: Use kobj_to_dev() instead
Date:   Sat, 13 Jun 2020 16:06:44 +0800
Message-Id: <1592035604-22336-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSk5LGEkeSU5KT05IVkpOQklLSE5NSktPT0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46PQw4Tjg8FQoyTiMvKiMy
        DxEKFD9VSlVKTkJJS0hOTUpLQ01LVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTFlXWQgBWUFJQ0JMNwY+
X-HM-Tid: 0a72acb78f159375kuws37cc4261122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/hwmon/nct6683.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 drivers/hwmon/nct6683.c

diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index c022915..2d29914
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -674,7 +674,7 @@ show_in_reg(struct device *dev, struct device_attribute *attr, char *buf)
 static umode_t nct6683_in_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct6683_data *data = dev_get_drvdata(dev);
 	int nr = index % 4;	/* attribute */
 
@@ -739,7 +739,7 @@ show_fan_pulses(struct device *dev, struct device_attribute *attr, char *buf)
 static umode_t nct6683_fan_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct6683_data *data = dev_get_drvdata(dev);
 	int fan = index / 3;	/* fan index */
 	int nr = index % 3;	/* attribute index */
@@ -857,7 +857,7 @@ show_temp_type(struct device *dev, struct device_attribute *attr, char *buf)
 static umode_t nct6683_temp_is_visible(struct kobject *kobj,
 				       struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct6683_data *data = dev_get_drvdata(dev);
 	int temp = index / 7;	/* temp index */
 	int nr = index % 7;	/* attribute index */
@@ -944,7 +944,7 @@ SENSOR_TEMPLATE(pwm, "pwm%d", S_IRUGO, show_pwm, store_pwm, 0);
 static umode_t nct6683_pwm_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct6683_data *data = dev_get_drvdata(dev);
 	int pwm = index;	/* pwm index */
 
-- 
2.7.4

