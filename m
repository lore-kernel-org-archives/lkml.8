Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EFAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EA620702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946517;
	bh=9Y+QW6C7mi8kmyJpRYZ+G1/TJtJ8eMv5VTZ+0KcRnyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=brK5bUp8RwFQtHpojiN8nVv6tVQcS3s+3d1jUQQUBS9FqJpB1UYPYasLD0LUvFzS7
	 iOgKT0JeCm+sXKoNLnBLqWmR89+siAf/dkBxTK+osneJ11LGiG90Idoxg/EBzeEvtG
	 CBCLuIeGAs7T7R8ZyQc3wdqz7ZEsX5lIEr3We9A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391985AbgFWVIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391558AbgFWUeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:34:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95ADA2072E;
        Tue, 23 Jun 2020 20:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944476;
        bh=9Y+QW6C7mi8kmyJpRYZ+G1/TJtJ8eMv5VTZ+0KcRnyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJVFXIuYlGrIa4ewB8ZSY8AsDH2fsxs0T2tJU+yUmG2hnNoqED26a+f1m7v0sXgq4
         d+p2akv/pBQmgv35h7Sqjb79KvtIDVKy7N9/1MHj+25RQnQcm6HuXDlB2h/VHGGbB0
         AEDi+rsKCCmSPI3CK2wA6mQCdO/rQr5rz/Z4+dJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeykumar Sankaran <jsanka@codeaurora.org>,
        Steve Cohen <cohens@codeaurora.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 5.4 301/314] drm/connector: notify userspace on hotplug after register complete
Date:   Tue, 23 Jun 2020 21:58:16 +0200
Message-Id: <20200623195353.353722626@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeykumar Sankaran <jsanka@codeaurora.org>

commit 968d81a64a883af2d16dd3f8a6ad6b67db2fde58 upstream.

drm connector notifies userspace on hotplug event prematurely before
late_register and mode_object register completes. This leads to a race
between userspace and kernel on updating the IDR list. So, move the
notification to end of connector register.

Signed-off-by: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Steve Cohen <cohens@codeaurora.org>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1591155451-10393-1-git-send-email-jsanka@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_connector.c |    5 +++++
 drivers/gpu/drm/drm_sysfs.c     |    3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -27,6 +27,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
+#include <drm/drm_sysfs.h>
 
 #include <linux/uaccess.h>
 
@@ -511,6 +512,10 @@ int drm_connector_register(struct drm_co
 	drm_mode_object_register(connector->dev, &connector->base);
 
 	connector->registration_state = DRM_CONNECTOR_REGISTERED;
+
+	/* Let userspace know we have a new connector */
+	drm_sysfs_hotplug_event(connector->dev);
+
 	goto unlock;
 
 err_debugfs:
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -293,9 +293,6 @@ int drm_sysfs_connector_add(struct drm_c
 		return PTR_ERR(connector->kdev);
 	}
 
-	/* Let userspace know we have a new connector */
-	drm_sysfs_hotplug_event(dev);
-
 	if (connector->ddc)
 		return sysfs_create_link(&connector->kdev->kobj,
 				 &connector->ddc->dev.kobj, "ddc");


