Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA40C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2367C2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmuUR+42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbgF3NvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbgF3NvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA91C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so20279919wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tAsKayZdJ/bssiKZaLewML1qJ1Qy+lK1MBLKE8UREg=;
        b=HmuUR+42Bn4cTBDsI05lTD2ybzQaTZdf85wQG+9YuVjwQPKeeP1tNYCTEcHXqTrEEM
         T4z+jbv5tiNasZ6KmWnhlPG3QrEUrk/mMnYUOJsCJr6zrIDphWWO6uLDw76IRRzJVXc4
         TLUyYMKT9neCKXZ+YO+leUiN+5MszBevEmTVS2AyFbJmk7XkV+VbUU3NKN2vGSdQ+ROA
         4Lq+q5YSoYDj7Bda8DG5nn8T2TEXTgAqloWvajJ3guqnQBP5KTjMZi+BBUENM/oLgqox
         R9HTq7j3jdyvH478RgakzrBZVsYX3BX+2508Ti/I99uQAOYeoJdK4AM8Dlgn5m+Ws9vn
         omBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tAsKayZdJ/bssiKZaLewML1qJ1Qy+lK1MBLKE8UREg=;
        b=uPTPUzxDm0YImxqSBLFn6tiKSLGFZlMuoVw8HfzmVaRKgQ0iU0+a+mwEBkXZE9Mbo+
         du3zIeIpmywLxhIG+LeqO0AgCUKoCJyGU4weR4krtDLlPQN6pwDKndwd/5/JiyemNjeV
         BUzUUzV2TJMZ50Ip4KgkDMxRFtPSZijgajvXgZ01uGjpbBODWkrhFJqygIYhsMii5FsX
         73sonBCAzMb/Iwp5n/XInhaT6szF5MgH+iNH+1tDdyzZDKZ/MICJN5w/JoWAo/csafpO
         6YjuQBxpxvYr+RDqDrX97wD/uy+tTeDOGpRxhX4GItRxbIFZt4LEMbFQQSBiIzeq5TxN
         E00Q==
X-Gm-Message-State: AOAM531KXXdiLN8NFFkE2A5v38L8axOt9tOgWeZF/lfHhmkkpLOW8mBr
        fPlWV89D2WDggz9ZryB2Ps8P2A==
X-Google-Smtp-Source: ABdhPJxIo7/ko+Ybgyw1T84vSapma04jKlDgzkG2BjzAzen18pjnBD0YX9WF7hVrDcmqSZnly+BvqQ==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr21658826wrj.336.1593525073582;
        Tue, 30 Jun 2020 06:51:13 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH 01/30] misc: genwqe: card_ddcb: Fix a variety of kerneldoc issues
Date:   Tue, 30 Jun 2020 14:50:41 +0100
Message-Id: <20200630135110.2236389-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including; demoting file header from kerneldoc to standard comment/
header, adding a variety of missing function argument documentation,
re-ordering of #defines i.e. not placed between kerneldoc headers
and the functions they are documenting and re-documenting of changed/
renamed arguments.

Fixes the following W=1 kernel build warnings:

 drivers/misc/genwqe/card_ddcb.c:83: warning: Function parameter or member 'queue' not described in 'queue_empty'
 drivers/misc/genwqe/card_ddcb.c:262: warning: Excess function parameter 'cd' description in 'RET_DDCB_APPENDED'
 drivers/misc/genwqe/card_ddcb.c:262: warning: Excess function parameter 'queue' description in 'RET_DDCB_APPENDED'
 drivers/misc/genwqe/card_ddcb.c:262: warning: Excess function parameter 'ddcb_no' description in 'RET_DDCB_APPENDED'
 drivers/misc/genwqe/card_ddcb.c:329: warning: Function parameter or member 'req' not described in 'copy_ddcb_results'
 drivers/misc/genwqe/card_ddcb.c:329: warning: Function parameter or member 'ddcb_no' not described in 'copy_ddcb_results'
 drivers/misc/genwqe/card_ddcb.c:364: warning: Function parameter or member 'queue' not described in 'genwqe_check_ddcb_queue'
 drivers/misc/genwqe/card_ddcb.c:565: warning: Function parameter or member 'queue' not described in 'get_next_ddcb'
 drivers/misc/genwqe/card_ddcb.c:565: warning: Function parameter or member 'num' not described in 'get_next_ddcb'
 drivers/misc/genwqe/card_ddcb.c:909: warning: Function parameter or member 'cmd' not described in '__genwqe_execute_raw_ddcb'
 drivers/misc/genwqe/card_ddcb.c:909: warning: Excess function parameter 'req' description in '__genwqe_execute_raw_ddcb'
 drivers/misc/genwqe/card_ddcb.c:972: warning: Function parameter or member 'cd' not described in 'genwqe_next_ddcb_ready'
 drivers/misc/genwqe/card_ddcb.c:1002: warning: Function parameter or member 'cd' not described in 'genwqe_ddcbs_in_flight'
 drivers/misc/genwqe/card_ddcb.c:1181: warning: Function parameter or member 'data' not described in 'genwqe_card_thread'
 drivers/misc/genwqe/card_ddcb.c:1308: warning: Function parameter or member 'cd' not described in 'queue_wake_up_all'
 drivers/misc/genwqe/card_ddcb.c:1333: warning: Function parameter or member 'cd' not described in 'genwqe_finish_queue'

Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/genwqe/card_ddcb.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 905106579935a..0db4000dedf20 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * IBM Accelerator Family 'GenWQE'
  *
  * (C) Copyright IBM Corp. 2013
@@ -244,10 +244,13 @@ static int ddcb_requ_finished(struct genwqe_dev *cd, struct ddcb_requ *req)
 		(cd->card_state != GENWQE_CARD_USED);
 }
 
+#define RET_DDCB_APPENDED 1
+#define RET_DDCB_TAPPED   2
 /**
  * enqueue_ddcb() - Enqueue a DDCB
  * @cd:         pointer to genwqe device descriptor
  * @queue:	queue this operation should be done on
+ * @pddcb:      pointer to ddcb structure
  * @ddcb_no:    pointer to ddcb number being tapped
  *
  * Start execution of DDCB by tapping or append to queue via NEXT
@@ -259,9 +262,6 @@ static int ddcb_requ_finished(struct genwqe_dev *cd, struct ddcb_requ *req)
  * Return: 1 if new DDCB is appended to previous
  *         2 if DDCB queue is tapped via register/simulation
  */
-#define RET_DDCB_APPENDED 1
-#define RET_DDCB_TAPPED   2
-
 static int enqueue_ddcb(struct genwqe_dev *cd, struct ddcb_queue *queue,
 			struct ddcb *pddcb, int ddcb_no)
 {
@@ -316,6 +316,8 @@ static int enqueue_ddcb(struct genwqe_dev *cd, struct ddcb_queue *queue,
 
 /**
  * copy_ddcb_results() - Copy output state from real DDCB to request
+ * @req:        pointer to requsted DDCB parameters
+ * @ddcb_no:    pointer to ddcb number being tapped
  *
  * Copy DDCB ASV to request struct. There is no endian
  * conversion made, since data structure in ASV is still
@@ -356,6 +358,7 @@ static void copy_ddcb_results(struct ddcb_requ *req, int ddcb_no)
 /**
  * genwqe_check_ddcb_queue() - Checks DDCB queue for completed work equests.
  * @cd:         pointer to genwqe device descriptor
+ * @queue:	queue to be checked
  *
  * Return: Number of DDCBs which were finished
  */
@@ -553,6 +556,8 @@ int __genwqe_wait_ddcb(struct genwqe_dev *cd, struct ddcb_requ *req)
 /**
  * get_next_ddcb() - Get next available DDCB
  * @cd:         pointer to genwqe device descriptor
+ * @queue:      DDCB queue
+ * @num:        internal DDCB number
  *
  * DDCB's content is completely cleared but presets for PRE and
  * SEQNUM. This function must only be called when ddcb_lock is held.
@@ -900,7 +905,7 @@ int __genwqe_enqueue_ddcb(struct genwqe_dev *cd, struct ddcb_requ *req,
 /**
  * __genwqe_execute_raw_ddcb() - Setup and execute DDCB
  * @cd:         pointer to genwqe device descriptor
- * @req:        user provided DDCB request
+ * @cmd:        user provided DDCB command
  * @f_flags:    file mode: blocking, non-blocking
  */
 int __genwqe_execute_raw_ddcb(struct genwqe_dev *cd,
@@ -965,6 +970,7 @@ int __genwqe_execute_raw_ddcb(struct genwqe_dev *cd,
 
 /**
  * genwqe_next_ddcb_ready() - Figure out if the next DDCB is already finished
+ * @cd:         pointer to genwqe device descriptor
  *
  * We use this as condition for our wait-queue code.
  */
@@ -993,6 +999,7 @@ static int genwqe_next_ddcb_ready(struct genwqe_dev *cd)
 
 /**
  * genwqe_ddcbs_in_flight() - Check how many DDCBs are in flight
+ * @cd:         pointer to genwqe device descriptor
  *
  * Keep track on the number of DDCBs which ware currently in the
  * queue. This is needed for statistics as well as conditon if we want
@@ -1171,6 +1178,7 @@ static irqreturn_t genwqe_vf_isr(int irq, void *dev_id)
 
 /**
  * genwqe_card_thread() - Work thread for the DDCB queue
+ * @data:         pointer to genwqe device descriptor
  *
  * The idea is to check if there are DDCBs in processing. If there are
  * some finished DDCBs, we process them and wakeup the
@@ -1299,6 +1307,7 @@ int genwqe_setup_service_layer(struct genwqe_dev *cd)
 
 /**
  * queue_wake_up_all() - Handles fatal error case
+ * @cd:         pointer to genwqe device descriptor
  *
  * The PCI device got unusable and we have to stop all pending
  * requests as fast as we can. The code after this must purge the
@@ -1323,6 +1332,7 @@ static int queue_wake_up_all(struct genwqe_dev *cd)
 
 /**
  * genwqe_finish_queue() - Remove any genwqe devices and user-interfaces
+ * @cd:         pointer to genwqe device descriptor
  *
  * Relies on the pre-condition that there are no users of the card
  * device anymore e.g. with open file-descriptors.
-- 
2.25.1

