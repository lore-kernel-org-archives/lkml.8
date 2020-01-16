Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379FFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115E924679
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199748;
	bh=QWtqO8cKmXuOe/GJohipsedM7ZuIUCFySx/QbStoT4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yYxE6lDMeROimwFk2i6PfESnoO2ZiurJvDmZYaX/HsVnko3V6jUFxLxDWt1vEJqZG
	 L8gQA7SpGt6egCBn+Tudl7FHi4REJHxWNOH94nWPuSb05hWLGKPkXfWDgFy2ckI94K
	 y7VR/O/e1lcmIrBC6eaP64/9Lu/n1s9mKkGFIBHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407156AbgAPSfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:35:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391752AbgAPRYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B6E2467E;
        Thu, 16 Jan 2020 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195464;
        bh=QWtqO8cKmXuOe/GJohipsedM7ZuIUCFySx/QbStoT4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyUlcp7Nne416IXNVikdneKWTNmEI59A03QD1+HEKx3Xv3/UYCfoqpNLVLKgB+eyV
         rUQhAoyzpKPStc3OV+/8Fp2CkRVaroy3HrP1SLT7TYOKiub60utlMvtTGovu6vF1BO
         bwcfP/6gmEPsiEDCno/9XHAG3qac7dtNWs42URsI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liu Jian <liujian56@huawei.com>,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 072/371] driver: uio: fix possible use-after-free in __uio_register_device
Date:   Thu, 16 Jan 2020 12:19:04 -0500
Message-Id: <20200116172403.18149-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit 221a1f4ac12d2ab46246c160b2e00d1b1160d5d9 ]

In uio_dev_add_attributes() error handing case, idev is used after
device_unregister(), in which 'idev' has been released, touch idev cause
use-after-free.

Fixes: a93e7b331568 ("uio: Prevent device destruction while fds are open")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Reviewed-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/uio/uio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 4e9b0ff79b13..7c18536a3742 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -944,6 +944,7 @@ int __uio_register_device(struct module *owner,
 		return ret;
 	}
 
+	device_initialize(&idev->dev);
 	idev->dev.devt = MKDEV(uio_major, idev->minor);
 	idev->dev.class = &uio_class;
 	idev->dev.parent = parent;
@@ -954,7 +955,7 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		goto err_device_create;
 
-	ret = device_register(&idev->dev);
+	ret = device_add(&idev->dev);
 	if (ret)
 		goto err_device_create;
 
@@ -986,9 +987,10 @@ int __uio_register_device(struct module *owner,
 err_request_irq:
 	uio_dev_del_attributes(idev);
 err_uio_dev_add_attributes:
-	device_unregister(&idev->dev);
+	device_del(&idev->dev);
 err_device_create:
 	uio_free_minor(idev);
+	put_device(&idev->dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__uio_register_device);
-- 
2.20.1

