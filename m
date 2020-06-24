Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A37C2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JohKMkVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbgFXVGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389393AbgFXVG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:06:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E5C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:06:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so1628577pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3HW0RJtzvOToZX2nxN+EFrEoQt3NsHrnZyl7VA0dYw=;
        b=JohKMkVoqHt/HTUforsqWQm58891DVmEUb+w04axP+7B45zw8idyTlriuzK218xzJO
         RA8I1DSviGuwqFKfdHk57bGxiy3ld4v64w+99TWuyatYhjkPEg++kzqVs8cNq7y/reD3
         6uDHTzZUkhATKDLEFKGH4bqPsVkzqT4P8P3pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3HW0RJtzvOToZX2nxN+EFrEoQt3NsHrnZyl7VA0dYw=;
        b=Hn1sTUMCX0cFZkpDir93P32i2rAXbnVk0fPop813QFXWkbsVRWKsBTYHrSJRwqWKV4
         qr4oB+MjTPultyhIjKEkNVeVbPsdNleB+CB5CfXdlOgtRUzPZfLY8DNtHU+8MKGsqmU9
         4xQ2P0YEcdHx98nIx8S4kk9lUtx3cei51tiZrle6nW/c3AtMMI3xHuQNRdqXfiiuVFwq
         fXKoIAHmKO3MA6qMa/Fk2JDu1aRy7kVOVFtBS667FUXBGTxu0io43/vEqFms10yKt8we
         w9cuNTP4o4a7fpB8dTPCyyCpp7zpEubF8QsTN/qvELB1HXLCICtyUe7BXJPl389CRNW/
         oM4Q==
X-Gm-Message-State: AOAM533nqKS2pWwOudNixcaGlDrXxUxSt8N9G3cfCinYqBtNODeqb05D
        sfA/7Ebl985EbUsQrSuyNKN1mg==
X-Google-Smtp-Source: ABdhPJwBB3oaMB/JFBK/9Rn3lpf31LljGpKoOc2GFLH+XsPu0YKNEaiJTcj2ido/xazt+cL0yPeyaQ==
X-Received: by 2002:a17:902:c408:: with SMTP id k8mr30750918plk.279.1593032784398;
        Wed, 24 Jun 2020 14:06:24 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id y9sm442927pfn.84.2020.06.24.14.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 14:06:23 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
Date:   Wed, 24 Jun 2020 14:06:16 -0700
Message-Id: <20200624140541.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200624210616.28477-1-abhishekpandit@chromium.org>
References: <20200624210616.28477-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Udev rules that depend on the power/wakeup attribute don't get triggered
correctly if device_set_wakeup_capable is called after the device is
created. This can happen for several reasons (driver sets wakeup after
device is created, wakeup is changed on parent device, etc) and it seems
reasonable to emit a changed event when adding or removing attributes on
the device.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/base/power/sysfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 24d25cf8ab1487..592a890bf137f0 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* sysfs entries for device PM */
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/export.h>
 #include <linux/pm_qos.h>
@@ -739,12 +740,29 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 
 int wakeup_sysfs_add(struct device *dev)
 {
-	return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
+	int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
+
+	if (!ret) {
+		int tmp = kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+
+		if (tmp)
+			dev_err(dev, "Error in uevent for wakeup_sysfs_add: %d",
+				tmp);
+	}
+
+	return ret;
 }
 
 void wakeup_sysfs_remove(struct device *dev)
 {
+	int tmp;
+
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
+
+	tmp = kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+	if (tmp)
+		dev_err(dev, "Error in uevent for wakeup_sysfs_remove: %d",
+			tmp);
 }
 
 int pm_qos_sysfs_add_resume_latency(struct device *dev)
-- 
2.27.0.111.gc72c7da667-goog

