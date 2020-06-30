Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D94C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D509420702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OihDsauu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbgF3Nwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbgF3Nvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FC7C03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so19684838wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9c9u4tDA/tuITz0x9b4sRgCY6xDvpdYsLA/gKX2PRak=;
        b=OihDsauuGos+atBkAQmQ98Sb91kjMWCgnGuEglF6lG3XVluS7gxfiGT0wk9w2Y8SfH
         D9GTgo0Ir3t2J6nII/WVYTtVb/HJR0tonCmcM9ADBX5FLB+DhZy2VNjFbD0kXBHESIrN
         RVfBZLfPS04fsIkGMFbQIBroUkgdpoPqfDUgc3IHQtAiPEF0pUTrBLJCCZBiwYIJreGZ
         vQon9WHCo66yzUZ995FfFpSeRjj7ievLDE4/ojI7H/AqcalrBC6Fa1cPozv+hq/aed96
         p/7y3KOknwmQ//WDGuRXWHvn4ONfhCXtjxIQlHAoEjnlQv1qgjyppYVqWapkXjru66dz
         WtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9c9u4tDA/tuITz0x9b4sRgCY6xDvpdYsLA/gKX2PRak=;
        b=JM+uFQ1Ghu1Rz7LyqQIj/ZWV22XYj7npqtKav275AqTZxR1z1KclVR1+MjXmutJeEO
         rVlBQUFyF+77BvruD60IFK8h7Ne7hVxm5t9f6NaRKBo75Zb+ywZOCqIOvTiyh9hEwQHe
         jkQq7nkTTX1DCj8ZjxuRhM71wfIqXf3md9nQiJuJ8vXaLFL5qmY4tw5P0M5YE1JL6iag
         lmfFv520g7kQo5vrvkFEm5++8abk9E8Inl4E96adP0O3Xkig9hjmdLSGD5TIxYJhqsre
         /RfG+604YYAlijWiCSJvBpcbXjN2nXKnVSOE4gW+9RGOrUpt2Tkr8Y6QC6puuf+bfa7z
         gZgw==
X-Gm-Message-State: AOAM53009JAiNSAJWcfGB3c8EZxl8hxokWzzbCytVXxK/xbKrk5BfeV+
        EdlVc516gMqz79e1qf61bkp2cmwiwZo=
X-Google-Smtp-Source: ABdhPJwRlejJQlEt5qpd9gycW4xMxVnkRlVdobgJjdYhmGmJu5MUUVgXNCMeq0EgZH3mSLHi19ymmg==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr21226455wmj.20.1593525097096;
        Tue, 30 Jun 2020 06:51:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 22/30] misc: mic: scif: scif_nm: Supply various kerneldoc fix-ups
Date:   Tue, 30 Jun 2020 14:51:02 +0100
Message-Id: <20200630135110.2236389-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Includes; missing descriptions for function args, the promotion
of obvious kerneldoc headers and the mis-formatting of existing
argument descriptions.

Fixes the following W=1 kernel build warnings:

 drivers/misc/mic/scif/scif_nm.c:19: warning: Function parameter or member 'node' not described in 'scif_invalidate_ep'
 drivers/misc/mic/scif/scif_nm.c:173: warning: Function parameter or member 'node_id' not described in 'scif_disconnect_node'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_nm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_nm.c b/drivers/misc/mic/scif/scif_nm.c
index c537df84539a9..c4d9422082b7d 100644
--- a/drivers/misc/mic/scif/scif_nm.c
+++ b/drivers/misc/mic/scif/scif_nm.c
@@ -14,6 +14,8 @@
 /**
  * scif_invalidate_ep() - Set state for all connected endpoints
  * to disconnected and wake up all send/recv waitqueues
+ *
+ * @node: Node to invalidate
  */
 static void scif_invalidate_ep(int node)
 {
@@ -99,11 +101,10 @@ void scif_send_acks(struct scif_dev *dev)
 	}
 }
 
-/*
- * scif_cleanup_scifdev
- *
+/**
+ * scif_cleanup_scifdev - Uninitialize SCIF data structures for remote
+ *                        SCIF device.
  * @dev: Remote SCIF device.
- * Uninitialize SCIF data structures for remote SCIF device.
  */
 void scif_cleanup_scifdev(struct scif_dev *dev)
 {
@@ -136,8 +137,8 @@ void scif_cleanup_scifdev(struct scif_dev *dev)
 	scif_cleanup_qp(dev);
 }
 
-/*
- * scif_remove_node:
+/**
+ * scif_remove_node
  *
  * @node: Node to remove
  */
@@ -162,9 +163,9 @@ static int scif_send_rmnode_msg(int node, int remove_node)
 }
 
 /**
- * scif_node_disconnect:
+ * scif_node_disconnect
  *
- * @node_id[in]: source node id.
+ * @node_id: source node id [in]
  * @mgmt_initiated: Disconnection initiated from the mgmt node
  *
  * Disconnect a node from the scif network.
-- 
2.25.1

