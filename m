Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CC7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C3F20EDD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943579;
	bh=MTuXDHylMOw0H85+MoZYgJaDuRO39F3XVO5XcphaXws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qEvW1T9+/2PciEFV5ykPExZASgbEqMcQX9rnbJXJFMJZBTupyIRDq1GdU08fKCLFR
	 DhJicOJE67zPaANM/Wf1uzItvYn2KTDuANjosqhUaFla6P9Yukje/2UXqSqxOYcBjJ
	 cL3ebZpF5F5lF6bqLIr9730TRfAZZAhSJ/2o3yDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389824AbgFWUTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389812AbgFWUTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:19:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD8D20EDD;
        Tue, 23 Jun 2020 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943575;
        bh=MTuXDHylMOw0H85+MoZYgJaDuRO39F3XVO5XcphaXws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOMeYrbmdXeU7e6NrT+aMkdbKR2uqXw/nvhDMlDwEom3huABXzF0F820kb/o1gtV8
         ddOlBTdG7JWnRjQrudXXcYjEsgJmbk6FceJi4V94KAPTNdgrP1ucGLNHJEMoG/HFDn
         PAr/Xag8AcXSO6naOm6Vw98Q+FGXKCg6jfRM5Wsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeykumar Sankaran <jsanka@codeaurora.org>,
        Steve Cohen <cohens@codeaurora.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 5.7 446/477] drm/connector: notify userspace on hotplug after register complete
Date:   Tue, 23 Jun 2020 21:57:23 +0200
Message-Id: <20200623195428.618442659@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
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
 
@@ -523,6 +524,10 @@ int drm_connector_register(struct drm_co
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
@@ -291,9 +291,6 @@ int drm_sysfs_connector_add(struct drm_c
 		return PTR_ERR(connector->kdev);
 	}
 
-	/* Let userspace know we have a new connector */
-	drm_sysfs_hotplug_event(dev);
-
 	if (connector->ddc)
 		return sysfs_create_link(&connector->kdev->kobj,
 				 &connector->ddc->dev.kobj, "ddc");


