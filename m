Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE39C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26F820897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1VuTplR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgE2IDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:03:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40300 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgE2IDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590739419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qAIlsWcWE5/JkQImrrDajyjydtkLArbDnm909F5raoM=;
        b=L1VuTplRlQoOPWWuuXG+OSUFhH59KKeIl3KCe27vjVsgfl45xDpMt8Wx8+gyl3YMppMvAp
        wCARXvRoBfSWJi90N9EGOEdKIR96psh4Zftb1ut/8OLu/CTseNnZKfMS/jzquaTFNsHpty
        jsYHO8/slRK0u5vKnWGyknT4okfz3gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-mJ9VqgnuPhSH-R82-jFFpA-1; Fri, 29 May 2020 04:03:36 -0400
X-MC-Unique: mJ9VqgnuPhSH-R82-jFFpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDDD081CBEF;
        Fri, 29 May 2020 08:03:33 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-231.pek2.redhat.com [10.72.13.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEA6999DE6;
        Fri, 29 May 2020 08:03:24 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH 2/6] vhost: use mmgrab() instead of mmget() for non worker device
Date:   Fri, 29 May 2020 16:02:59 +0800
Message-Id: <20200529080303.15449-3-jasowang@redhat.com>
In-Reply-To: <20200529080303.15449-1-jasowang@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the device that doesn't use vhost worker and use_mm(), mmget() is
too heavy weight and it may brings troubles for implementing mmap()
support for vDPA device.

This is because, an reference to the address space was held via
mm_get() in vhost_dev_set_owner() and an reference to the file was
held in mmap(). This means when process exits, the mm can not be
released thus we can not release the file.

This patch tries to use mmgrab() instead of mmget(), which allows the
address space to be destroy in process exit without releasing the mm
structure itself. This is sufficient for vDPA device which pin user
pages and does not depend on the address space to work.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 70105e045768..9642938a7e7c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -541,6 +541,36 @@ bool vhost_dev_has_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_has_owner);
 
+static void vhost_attach_mm(struct vhost_dev *dev)
+{
+	/* No owner, become one */
+	if (dev->use_worker) {
+		dev->mm = get_task_mm(current);
+	} else {
+		/* vDPA device does not use worker thead, so there's
+		 * no need to hold the address space for mm. This help
+		 * to avoid deadlock in the case of mmap() which may
+		 * held the refcnt of the file and depends on release
+		 * method to remove vma.
+		 */
+		dev->mm = current->mm;
+		mmgrab(dev->mm);
+	}
+}
+
+static void vhost_detach_mm(struct vhost_dev *dev)
+{
+	if (!dev->mm)
+		return;
+
+	if (dev->use_worker)
+		mmput(dev->mm);
+	else
+		mmdrop(dev->mm);
+
+	dev->mm = NULL;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -553,8 +583,8 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 		goto err_mm;
 	}
 
-	/* No owner, become one */
-	dev->mm = get_task_mm(current);
+	vhost_attach_mm(dev);
+
 	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
 		worker = kthread_create(vhost_worker, dev,
@@ -583,9 +613,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 		dev->worker = NULL;
 	}
 err_worker:
-	if (dev->mm)
-		mmput(dev->mm);
-	dev->mm = NULL;
+	vhost_detach_mm(dev);
 	dev->kcov_handle = 0;
 err_mm:
 	return err;
@@ -682,9 +710,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 		dev->worker = NULL;
 		dev->kcov_handle = 0;
 	}
-	if (dev->mm)
-		mmput(dev->mm);
-	dev->mm = NULL;
+	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
 
-- 
2.20.1

