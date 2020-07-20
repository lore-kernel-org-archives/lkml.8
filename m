Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B75C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E983322D02
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261354;
	bh=IQtVVwASIV9iN5LpAQ0FqLnEWWJ0Umn2MdHysulL3lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zGqc3Pm9TQcJhirYpVd1pImFZYBoA7Il5N6JrvMxAv9Wqn4ed7U2vZJUTuX8szONI
	 E0gMMyXsvgk7BJtP3ZfB+g054WcPcK7rK04hiMXOoF0u4spk/HxsZm/OOXI7PP3gL8
	 e29ldtk/xwhkqt8BhsiS/CvON1wWolUX438+/RDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgGTQJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387461AbgGTQJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:09:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF662065E;
        Mon, 20 Jul 2020 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261342;
        bh=IQtVVwASIV9iN5LpAQ0FqLnEWWJ0Umn2MdHysulL3lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHD3ayACkiLDf7WleGsT0v+SYipGmn3ekMY91anz0UErKePkE5Yina2YMRVx03p8q
         7ED9aGZp8BNqlmUXslqKCGfA1n30fjf0ki/BEL5p93fEYy4mS9ytEigIzoIgZTn7AZ
         rZIwri1aW4v4mmIOlgZZdtmSnAIbGZdRoYgLltqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikhil Rao <nikhil.rao@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 082/244] dmaengine: idxd: fix cdev locking for open and release
Date:   Mon, 20 Jul 2020 17:35:53 +0200
Message-Id: <20200720152829.742328308@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Rao <nikhil.rao@intel.com>

[ Upstream commit 66983bc18fad17d10766650b3685045f6f092d73 ]

add the wq lock in cdev open and release call. This fixes
race conditions observed in the open and close routines.

Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
Signed-off-by: Nikhil Rao <nikhil.rao@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/159285824892.64944.2905413694915141834.stgit@djiang5-desk3.ch.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/cdev.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff49847e37a86..cb376cf6a2d2c 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -74,6 +74,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_device *idxd;
 	struct idxd_wq *wq;
 	struct device *dev;
+	int rc = 0;
 
 	wq = inode_wq(inode);
 	idxd = wq->idxd;
@@ -81,17 +82,27 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 	dev_dbg(dev, "%s called: %d\n", __func__, idxd_wq_refcount(wq));
 
-	if (idxd_wq_refcount(wq) > 0 && wq_dedicated(wq))
-		return -EBUSY;
-
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
+	mutex_lock(&wq->wq_lock);
+
+	if (idxd_wq_refcount(wq) > 0 && wq_dedicated(wq)) {
+		rc = -EBUSY;
+		goto failed;
+	}
+
 	ctx->wq = wq;
 	filp->private_data = ctx;
 	idxd_wq_get(wq);
+	mutex_unlock(&wq->wq_lock);
 	return 0;
+
+ failed:
+	mutex_unlock(&wq->wq_lock);
+	kfree(ctx);
+	return rc;
 }
 
 static int idxd_cdev_release(struct inode *node, struct file *filep)
@@ -105,7 +116,9 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	filep->private_data = NULL;
 
 	kfree(ctx);
+	mutex_lock(&wq->wq_lock);
 	idxd_wq_put(wq);
+	mutex_unlock(&wq->wq_lock);
 	return 0;
 }
 
-- 
2.25.1



