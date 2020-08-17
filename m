Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01658C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04D6206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597683416;
	bh=1L2XI9E70UHebhqqpeBnk0xohvD+JQFCR3QdL8E6IDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ocFbrdkDtuKXmg3+cxlH1tHqTJDmQrCvANRPt+qB0orsBlRkgyW6NhhlbPSrKKSSW
	 PWgAVvhp9CjCmxEnwp0WiWHfF/Txz5vHW6rpP8G7AurGHTiahzR5KWOUvPNUwF//JG
	 EAZmrXDx4xV5p90bm8q0Gzb7mtWpDzNZengIctNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbgHQQ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgHQQEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:04:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09372053B;
        Mon, 17 Aug 2020 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680272;
        bh=1L2XI9E70UHebhqqpeBnk0xohvD+JQFCR3QdL8E6IDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WghZoqR2HtKDT2EiftgMahP04nDEUKmHTat/HxZda+wiwu6xBD5NPIJvPRjy3SZ7d
         8poGXb0nOnBKSWIe/5yde/9hxq0DcIGtBSMW3mn6vzkzs2Zec3wBXGxJOOW9ZHVIgx
         9z7/n0Ib/Qq8aRcx3WRqOLslUssPfAHnTzohG3jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 120/270] RDMA/core: Fix bogus WARN_ON during ib_unregister_device_queued()
Date:   Mon, 17 Aug 2020 17:15:21 +0200
Message-Id: <20200817143801.738575632@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 0cb42c0265837fafa2b4f302c8a7fed2631d7869 ]

ib_unregister_device_queued() can only be used by drivers using the new
dealloc_device callback flow, and it has a safety WARN_ON to ensure
drivers are using it properly.

However, if unregister and register are raced there is a special
destruction path that maintains the uniform error handling semantic of
'caller does ib_dealloc_device() on failure'. This requires disabling the
dealloc_device callback which triggers the WARN_ON.

Instead of using NULL to disable the callback use a special function
pointer so the WARN_ON does not trigger.

Fixes: d0899892edd0 ("RDMA/device: Provide APIs from the core code to help unregistration")
Link: https://lore.kernel.org/r/0-v1-a36d512e0a99+762-syz_dealloc_driver_jgg@nvidia.com
Reported-by: syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com
Suggested-by: Hillf Danton <hdanton@sina.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 10ae6c6eab0ad..59dc9f3cfb376 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1330,6 +1330,10 @@ static int enable_device_and_get(struct ib_device *device)
 	return ret;
 }
 
+static void prevent_dealloc_device(struct ib_device *ib_dev)
+{
+}
+
 /**
  * ib_register_device - Register an IB device with IB core
  * @device:Device to register
@@ -1397,11 +1401,11 @@ int ib_register_device(struct ib_device *device, const char *name)
 		 * possibility for a parallel unregistration along with this
 		 * error flow. Since we have a refcount here we know any
 		 * parallel flow is stopped in disable_device and will see the
-		 * NULL pointers, causing the responsibility to
+		 * special dealloc_driver pointer, causing the responsibility to
 		 * ib_dealloc_device() to revert back to this thread.
 		 */
 		dealloc_fn = device->ops.dealloc_driver;
-		device->ops.dealloc_driver = NULL;
+		device->ops.dealloc_driver = prevent_dealloc_device;
 		ib_device_put(device);
 		__ib_unregister_device(device);
 		device->ops.dealloc_driver = dealloc_fn;
@@ -1449,7 +1453,8 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
 	 * Drivers using the new flow may not call ib_dealloc_device except
 	 * in error unwind prior to registration success.
 	 */
-	if (ib_dev->ops.dealloc_driver) {
+	if (ib_dev->ops.dealloc_driver &&
+	    ib_dev->ops.dealloc_driver != prevent_dealloc_device) {
 		WARN_ON(kref_read(&ib_dev->dev.kobj.kref) <= 1);
 		ib_dealloc_device(ib_dev);
 	}
-- 
2.25.1



