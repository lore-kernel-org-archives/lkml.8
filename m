Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485D0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223022074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6emcavX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgGAIcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgGAIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE620C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so19876102wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9c9u4tDA/tuITz0x9b4sRgCY6xDvpdYsLA/gKX2PRak=;
        b=C6emcavXrS0sAJaB4EgwHG2NIfC2Z95Q9QyMrS8UgRqBviZqvwM4fTokhxLJkdolsU
         ayLDvmDKSKxZ4jconTmjB8Au7duak0T46ngmaX8SlHU0mWo81f+DapSXhIwJdhacCE90
         2eBi10ThTRMy7vtoK2iMSkiVSS0zbyQjQhJKKX61D8gyFDVBovOqDRTDnsY+u4D9svFg
         GjrpJenuLdbKnGvZ2QHjzvNkS9WDC+ubM1hUnDbP2ZHWXU5ifERbl+5Wy64rjMlfMIhZ
         EQ/NNAxhrnH7V54AsExg327jCMiL/AQ9mlD7y61YyvRRYZM5zvzKuR67yTreVCXMN/7E
         8cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9c9u4tDA/tuITz0x9b4sRgCY6xDvpdYsLA/gKX2PRak=;
        b=mwpgVJwgnBJ6n4jTInc/K4WRz8X4+HqtQ652dg7Ts2uwqQBVzrkrn3Riy4dDgplRbe
         ivcq9qsVCwMAILOSrW2GSJobPWyfzJeqoZPZgaMOYfmPx8rQTLpzxX1A9hsazlaDJROY
         6IzOji8euwTEhiVpn4Z9j57s2JgQPzEeJsPYBH2bjUPvSqxBi3e8iy6ZZPsk4FvjshcY
         ajZMD4LZ/JFw7kG1vIKSYzGSazS6jU2wM5oQ5cSbh9tjNFkb5SXT9gzTonTogQVXELtH
         ofCiL2wNhW6jdP3PHb9u1Cav46j9upqVnbmtDWBw2/CWc+ZjYp3mLtRGNhmCK64k7x1V
         cZPQ==
X-Gm-Message-State: AOAM530qrni0lC1geJ4bwgXxRj3uO12Z2A/i60I4Ki2JF99d+Som94tm
        KJABll566kuOTin/rOFCALhMBSnD0ZU=
X-Google-Smtp-Source: ABdhPJw/xbj3QdGCPwDaRKsmvYF3w1E8/+ksO90aiaHfPoWccdmsiuuaGqHGu/YIHpNih12W8WjpRA==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr26041731wrj.264.1593592309531;
        Wed, 01 Jul 2020 01:31:49 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 22/30] misc: mic: scif: scif_nm: Supply various kerneldoc fix-ups
Date:   Wed,  1 Jul 2020 09:31:10 +0100
Message-Id: <20200701083118.45744-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
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

