Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A5DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8203D204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597681159;
	bh=wUztgG6LY77gW6VJsHXbDj0WwifbH3QV90eFQrjGYwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KBkswi1iuZyObCsN0V6m9JfgNsYwJy+vACrKky/lNkvTMGl4kGPvd+1Ui6iU8rMge
	 BtKhGPr3uv8/Stn2cl4RIHqytQ4YKcYJrDARC0L9UKdat2PF6qgHx33BRKFmy2tDWK
	 7hgUGpgVQr4x8+5t862Fyr3U956N5jjxMiKO8VJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgHQQTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:32926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387657AbgHQPsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18A120855;
        Mon, 17 Aug 2020 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679334;
        bh=wUztgG6LY77gW6VJsHXbDj0WwifbH3QV90eFQrjGYwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9ZjugNBY0Lxm1utPw2DymBG1A7L7sQ6x5h40X/CglnQC14cgc2mg+k0xdHvng1Dy
         eI7+TGm2NU2Cb6cyADmTQj6184leJjGouV+n3vAjuLIxT9XDPWL9j02m7E2fTfAHEt
         Ts0eENxYw+TvH5XEH+zO09wKi2UoTzm3VjQVuk5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 175/393] RDMA/core: Fix bogus WARN_ON during ib_unregister_device_queued()
Date:   Mon, 17 Aug 2020 17:13:45 +0200
Message-Id: <20200817143828.104447923@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
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
index d0b3d35ad3e43..0fe3c3eb3dfd1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1327,6 +1327,10 @@ static int enable_device_and_get(struct ib_device *device)
 	return ret;
 }
 
+static void prevent_dealloc_device(struct ib_device *ib_dev)
+{
+}
+
 /**
  * ib_register_device - Register an IB device with IB core
  * @device: Device to register
@@ -1396,11 +1400,11 @@ int ib_register_device(struct ib_device *device, const char *name)
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
@@ -1448,7 +1452,8 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
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



