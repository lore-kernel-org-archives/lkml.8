Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F92C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28DD2078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snvn9xvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgGAIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgGAIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B3C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so622594wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ihwB2j52q4JKu9sE46KLVBy86wjLuHmVQi4idxjX6zQ=;
        b=snvn9xvIydiypiXr5MO0bygv1ZS/EM2GgCqevZyGvodvvnT7O7zCWyYmkQLhHVi+1/
         j/wzvGWRqMxAz2zp4oEaV8GFxHERQJmwaYsiCZo8RIGNoYmsctyShK0Vj1Ig2nCKFUtV
         rc7jGoLvofLd+9eZNOARjmUt95RTqSDk1lZ/6bfWVLwRQbqyMil6aGpamCtCmzgbzIqM
         WKb464Mf1lFjB+uXMjTIgTDrPkTkoRtTbt5w03/cWgXsJJnlNds/5sVxDBuBo834mCNN
         mzfR4bp+ym8sUppFmCBeUZDrxv9/LPJIbh/IIMlxUMxDuSHMEr3ESO+C5LgSNkKZNjxc
         8OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihwB2j52q4JKu9sE46KLVBy86wjLuHmVQi4idxjX6zQ=;
        b=dIrL/ESDLJj2ZWiP1rCX+1F6aw1gZ1qmheqo7feOTh9NoZn9HlL1076HQdDHlWv4dP
         UACCruWlsxp/agmCixjEcyb+pUn0zAbxXDhZkdvw6zliCP5mxVFKsolKkMF817uzYlWC
         SpOXpcjQw8Ux0L6W89faFF8nqobwO5Zzv/DA4iZ5h8mnsT0ZLKHs0B76QcuFu8ovLDHw
         m5vPZZfThGL90h36BdKbbgPZIfa29HyRi5R+320joKjoGy/k93OHTFwL3Jn9iyy07SxS
         pg97MPNLboDE1N41X5HWYLQaHqnRZsD5iP6yJEtCmjpygySX6y3m/OC15wuJcEzkLqZa
         e7Hg==
X-Gm-Message-State: AOAM531xKBLstZ7407KzHpqHdHKfcnteqQDyt9XcEGFFQtKPNKgfW4CP
        tHnkohiDJ6hJ3udmFYdQoD0w/CBcWPs=
X-Google-Smtp-Source: ABdhPJxrqfwsOrp9KISgBJFoUZ2zRhfjI8gFS2Sf7MKc2RHU0W4nuWlhNSlPDMKn8vHdJktFm7HiwQ==
X-Received: by 2002:adf:e98f:: with SMTP id h15mr27903913wrm.25.1593592308422;
        Wed, 01 Jul 2020 01:31:48 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 21/30] misc: mic: scif: scif_nodeqp: Fix a bunch of kerneldoc issues
Date:   Wed,  1 Jul 2020 09:31:09 +0100
Message-Id: <20200701083118.45744-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Includes; missing function argument documentation, misnamed argument
tags, the promotion of obvious kerneldoc header candidates and an
ordering issue (functions must follow the kerneldoc which describes
them).

Fixes the following W=1 kernel build issues:

 drivers/misc/mic/scif/scif_nodeqp.c:452: warning: Function parameter or member 'scifdev' not described in 'scif_node_connect'
 drivers/misc/mic/scif/scif_nodeqp.c:730: warning: Function parameter or member 'unused' not described in 'scif_exit'
 drivers/misc/mic/scif/scif_nodeqp.c:730: warning: Excess function parameter 'msg' description in 'scif_exit'
 drivers/misc/mic/scif/scif_nodeqp.c:748: warning: Function parameter or member 'unused' not described in 'scif_exit_ack'
 drivers/misc/mic/scif/scif_nodeqp.c:748: warning: Excess function parameter 'msg' description in 'scif_exit_ack'
 drivers/misc/mic/scif/scif_nodeqp.c:939: warning: Function parameter or member 'scifdev' not described in 'scif_node_add_nack'
 drivers/misc/mic/scif/scif_nodeqp.c:988: warning: Function parameter or member 'scifdev' not described in 'scif_get_node_info_resp'
 drivers/misc/mic/scif/scif_nodeqp.c:1070: warning: cannot understand function prototype: 'int scif_max_msg_id = SCIF_MAX_MSG; '
 drivers/misc/mic/scif/scif_nodeqp.c:1129: warning: Function parameter or member 'unused' not described in 'scif_loopb_wq_handler'
 drivers/misc/mic/scif/scif_nodeqp.c:1129: warning: Excess function parameter 'work' description in 'scif_loopb_wq_handler'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_nodeqp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_nodeqp.c b/drivers/misc/mic/scif/scif_nodeqp.c
index ea084626fe116..e0748be373f19 100644
--- a/drivers/misc/mic/scif/scif_nodeqp.c
+++ b/drivers/misc/mic/scif/scif_nodeqp.c
@@ -443,6 +443,7 @@ static void scif_deinit_p2p_info(struct scif_dev *scifdev,
 
 /**
  * scif_node_connect: Respond to SCIF_NODE_CONNECT interrupt message
+ * @scifdev: SCIF device
  * @dst: Destination node
  *
  * Connect the src and dst node by setting up the p2p connection
@@ -719,7 +720,7 @@ scif_init(struct scif_dev *scifdev, struct scifmsg *msg)
 /**
  * scif_exit() - Respond to SCIF_EXIT interrupt message
  * @scifdev:    Remote SCIF device node
- * @msg:        Interrupt message
+ * @unused:     Interrupt message (unused)
  *
  * This function stops the SCIF interface for the node which sent
  * the SCIF_EXIT message and starts waiting for that node to
@@ -740,7 +741,7 @@ scif_exit(struct scif_dev *scifdev, struct scifmsg *unused)
 /**
  * scif_exitack() - Respond to SCIF_EXIT_ACK interrupt message
  * @scifdev:    Remote SCIF device node
- * @msg:        Interrupt message
+ * @unused:     Interrupt message (unused)
  *
  */
 static __always_inline void
@@ -930,6 +931,7 @@ scif_node_add_ack(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_node_add_nack: Respond to SCIF_NODE_ADD_NACK interrupt message
+ * @scifdev:    Remote SCIF device node
  * @msg:        Interrupt message
  *
  * SCIF_NODE_ADD failed, so inform the waiting wq.
@@ -946,8 +948,9 @@ scif_node_add_nack(struct scif_dev *scifdev, struct scifmsg *msg)
 	}
 }
 
-/*
+/**
  * scif_node_remove: Handle SCIF_NODE_REMOVE message
+ * @scifdev:    Remote SCIF device node
  * @msg: Interrupt message
  *
  * Handle node removal.
@@ -962,8 +965,9 @@ scif_node_remove(struct scif_dev *scifdev, struct scifmsg *msg)
 	scif_handle_remove_node(node);
 }
 
-/*
+/**
  * scif_node_remove_ack: Handle SCIF_NODE_REMOVE_ACK message
+ * @scifdev:    Remote SCIF device node
  * @msg: Interrupt message
  *
  * The peer has acked a SCIF_NODE_REMOVE message.
@@ -979,6 +983,7 @@ scif_node_remove_ack(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_get_node_info: Respond to SCIF_GET_NODE_INFO interrupt message
+ * @scifdev:    Remote SCIF device node
  * @msg:        Interrupt message
  *
  * Retrieve node info i.e maxid and total from the mgmt node.
@@ -1058,6 +1063,7 @@ static void (*scif_intr_func[SCIF_MAX_MSG + 1])
 	scif_recv_sig_resp,	/* SCIF_SIG_NACK */
 };
 
+static int scif_max_msg_id = SCIF_MAX_MSG;
 /**
  * scif_nodeqp_msg_handler() - Common handler for node messages
  * @scifdev: Remote device to respond to
@@ -1067,8 +1073,6 @@ static void (*scif_intr_func[SCIF_MAX_MSG + 1])
  * This routine calls the appropriate routine to handle a Node Qp
  * message receipt
  */
-static int scif_max_msg_id = SCIF_MAX_MSG;
-
 static void
 scif_nodeqp_msg_handler(struct scif_dev *scifdev,
 			struct scif_qp *qp, struct scifmsg *msg)
@@ -1117,7 +1121,7 @@ void scif_nodeqp_intrhandler(struct scif_dev *scifdev, struct scif_qp *qp)
 
 /**
  * scif_loopb_wq_handler - Loopback Workqueue Handler.
- * @work: loop back work
+ * @unused: loop back work (unused)
  *
  * This work queue routine is invoked by the loopback work queue handler.
  * It grabs the recv lock, dequeues any available messages from the head
-- 
2.25.1

