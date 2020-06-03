Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0441C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B4E2074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IyWXJLRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgFCDht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:37:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44374 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgFCDhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:37:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591155467; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/bVnFV5V+H9IHRWbu8rDBXg4KkhS3ShA7XcdSKExHnk=; b=IyWXJLRLrdiL6qbBJ70wLug+z7I6aQIgLMsMwej+JLttTpbfVnvZFV+mlYWQOogipNLfdR0a
 y4nh1/sMtZqFw49/ZUGurLE1df2r1mKs5O9ZHcP4kgvcBAVcCUX/W9qFwD1S39WQmZZJqKu5
 1BCFtb7x0HfjXGT1+Boo4VGdgOI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ed71b034c2ebead13d52b48 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Jun 2020 03:37:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11248C43395; Wed,  3 Jun 2020 03:37:39 +0000 (UTC)
Received: from jeykumar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jsanka)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17862C433C6;
        Wed,  3 Jun 2020 03:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17862C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jsanka@codeaurora.org
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Jeykumar Sankaran <jsanka@codeaurora.org>, seanpaul@chromium.org,
        robdclark@gmail.com, Steve Cohen <cohens@codeaurora.org>
Subject: [PATCH] drm/connector: notify userspace on hotplug after register complete
Date:   Tue,  2 Jun 2020 20:37:31 -0700
Message-Id: <1591155451-10393-1-git-send-email-jsanka@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm connector notifies userspace on hotplug event prematurely before
late_register and mode_object register completes. This leads to a race
between userspace and kernel on updating the IDR list. So, move the
notification to end of connector register.

Signed-off-by: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Steve Cohen <cohens@codeaurora.org>
---
 drivers/gpu/drm/drm_connector.c | 5 +++++
 drivers/gpu/drm/drm_sysfs.c     | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b1099e1..d877ddc 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -27,6 +27,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
+#include <drm/drm_sysfs.h>
 
 #include <linux/uaccess.h>
 
@@ -523,6 +524,10 @@ int drm_connector_register(struct drm_connector *connector)
 	drm_mode_object_register(connector->dev, &connector->base);
 
 	connector->registration_state = DRM_CONNECTOR_REGISTERED;
+
+	/* Let userspace know we have a new connector */
+	drm_sysfs_hotplug_event(connector->dev);
+
 	goto unlock;
 
 err_debugfs:
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 939f003..f0336c8 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -291,9 +291,6 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 		return PTR_ERR(connector->kdev);
 	}
 
-	/* Let userspace know we have a new connector */
-	drm_sysfs_hotplug_event(dev);
-
 	if (connector->ddc)
 		return sysfs_create_link(&connector->kdev->kobj,
 				 &connector->ddc->dev.kobj, "ddc");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

