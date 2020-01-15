Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44211C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181542075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="gQA0Eavk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgAOKVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:21:55 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:35368 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgAOKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:21:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DFA6327E0BA4;
        Wed, 15 Jan 2020 11:21:52 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U1wdrKSlpnGz; Wed, 15 Jan 2020 11:21:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 64E4B27E0A5D;
        Wed, 15 Jan 2020 11:21:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 64E4B27E0A5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1579083712;
        bh=coWsTXp4V4TYH5Han63gSZrWtYPuRAU9HFOVMXalNEk=;
        h=From:To:Date:Message-Id;
        b=gQA0Eavk9MSsZhpSd/SQUtzWw8fM4amN5WILS2w8EaTNEWpZCWdTy7PaH0XKkIbv4
         SVeRllH9f89usb2KGupoyLnV9i9GFwb4U69cDu9yOeUKNoHBBdc76lylnZpsW3a7hd
         42uz7ytW12dqySjQLrBgJfbTNuQ//V7MSCSLYRrY=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lMKAkCjT1Yu6; Wed, 15 Jan 2020 11:21:52 +0100 (CET)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 522C027E031E;
        Wed, 15 Jan 2020 11:21:52 +0100 (CET)
From:   Clement Leger <cleger@kalray.eu>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH] remoteproc: Add support for predefined notifyids
Date:   Wed, 15 Jan 2020 11:21:42 +0100
Message-Id: <20200115102142.11229-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.15.0.276.g89ea799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support preallocated notify ids, if their value is
equal to FW_RSC_NOTIFY_ID_ANY, then do no allocate a notify id
dynamically but try to allocate the requested one. This is useful when
using custom ids to bind them to custom vendor resources. For instance,
it allow to assign a group of queues to a specific interrupti in order
to dispatch notifications.

Signed-off-by: Clement Leger <cleger@kalray.eu>
---
 drivers/remoteproc/remoteproc_core.c | 27 +++++++++++++++++++--------
 include/linux/remoteproc.h           |  1 +
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 307df98347ba..b1485fcd0f11 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -351,14 +351,27 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	/*
 	 * Assign an rproc-wide unique index for this vring
 	 * TODO: assign a notifyid for rvdev updates as well
-	 * TODO: support predefined notifyids (via resource table)
 	 */
-	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		dev_err(dev, "idr_alloc failed: %d\n", ret);
-		return ret;
+	if (rsc->vring[i].notifyid == FW_RSC_NOTIFY_ID_ANY) {
+		ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
+		if (ret < 0) {
+			dev_err(dev, "idr_alloc failed: %d\n", ret);
+			return ret;
+		}
+		notifyid = ret;
+
+		/* Let the rproc know the notifyid of this vring.*/
+		rsc->vring[i].notifyid = notifyid;
+	} else {
+		/* Reserve requested notify_id */
+		notifyid = rsc->vring[i].notifyid;
+		ret = idr_alloc(&rproc->notifyids, rvring, notifyid,
+				notifyid + 1, GFP_KERNEL);
+		if (ret < 0) {
+			dev_err(dev, "idr_alloc failed: %d\n", ret);
+			return ret;
+		}
 	}
-	notifyid = ret;
 
 	/* Potentially bump max_notifyid */
 	if (notifyid > rproc->max_notifyid)
@@ -366,8 +379,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 
 	rvring->notifyid = notifyid;
 
-	/* Let the rproc know the notifyid of this vring.*/
-	rsc->vring[i].notifyid = notifyid;
 	return 0;
 }
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad66683ad0..dcae3394243e 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -123,6 +123,7 @@ enum fw_resource_type {
 };
 
 #define FW_RSC_ADDR_ANY (-1)
+#define FW_RSC_NOTIFY_ID_ANY (-1)
 
 /**
  * struct fw_rsc_carveout - physically contiguous memory request
-- 
2.15.0.276.g89ea799

