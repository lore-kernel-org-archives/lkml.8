Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EBDC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC1E2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivoW9Lui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgGMIAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbgGMIA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:00:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E3FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so14777258wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOkk/AOE4a1rIKIblem9cC9W1YA+YYErwB4kADkbA6U=;
        b=ivoW9LuiqFryL5aujmOFCwfClhS0ODYgoFhI6l1yi1CHg//IVHm2ugcAs+/VhXZeAV
         dxPbFvu0tGc8lIoZxq1kmj45ehBJpZYF1C3M/CjwYxWkygqc40oilXBB/gAmTY95yyNd
         skd1c+bXcGfOSeZVqJVM1DRzzqP3/teEpAjWRWIiFMv0mEF3sLpat+UOWUJTsR481VxT
         4148aRlBKjJwdM7NzB7IxpS8nwRq5zkpcvoiIb+BO5vRmzz6H5kb1+yY8kVtB1rQE4K+
         kFSESLOpv6cuYA0qFQWJVkVSFvOt7TwbF0u4zCB4hfQGqVq3UxWPge/o/aCT9BRyUOZd
         7k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOkk/AOE4a1rIKIblem9cC9W1YA+YYErwB4kADkbA6U=;
        b=bEmv4XCHCzHNTilP43vVccFaoeOZEHYehb2XLT0T4gOvJYKzhJRdVviFzurd3z5pvx
         WyHCjVTn0UxXV9TI2qheTjAxoUkhViqsCWc4NbnAyOA6H02oMhlM9107zdePs+M9nKIF
         AYhJrtU5QDxJ5K41Vm8RFtWZ0Cq+iWrRvtP3XuwZ+wKFvuLfWFeGGbc6Lyp68aOM+RbT
         FSO4dBaa3M1ZJDJT7flXGxxlptJRwxsNCGGUxssLh5nL2lk4HdiUi47NkllSPvFKwDB5
         GncqcUE9cgnNC/LFiLXqkmUN3p5s4llBGdmzSE+SqGPoSog58PuE3qo2NlofyV+MUTyn
         WSpg==
X-Gm-Message-State: AOAM5304Vh3YV66lCP4+z/ZtXRRd7yodalZ4CgUZUoItuukIxbcFhOQB
        21hfwsI+SuN5o/+OXYlQGgRgAw==
X-Google-Smtp-Source: ABdhPJzHD/4IVzBNdJENKx1a6mXcOPjXpA6cothz9YdYC7Zo+cS9T082RvQ7n9AJqR6XQqvEe1YA2A==
X-Received: by 2002:adf:8024:: with SMTP id 33mr84296402wrk.117.1594627226531;
        Mon, 13 Jul 2020 01:00:26 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id 33sm24383549wri.16.2020.07.13.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:00:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        linux-drivers@broadcom.com
Subject: [PATCH v2 17/24] scsi: be2iscsi: be_iscsi: Fix API/documentation slip
Date:   Mon, 13 Jul 2020 08:59:54 +0100
Message-Id: <20200713080001.128044-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713080001.128044-1-lee.jones@linaro.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And add descriptions for a couple of missing function parameters.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/be2iscsi/be_iscsi.c:38: warning: Function parameter or member 'ep' not described in 'beiscsi_session_create'
 drivers/scsi/be2iscsi/be_iscsi.c:173: warning: Function parameter or member 'is_leading' not described in 'beiscsi_conn_bind'
 drivers/scsi/be2iscsi/be_iscsi.c:998: warning: Function parameter or member 'beiscsi_ep' not described in 'beiscsi_free_ep'
 drivers/scsi/be2iscsi/be_iscsi.c:998: warning: Excess function parameter 'ep' description in 'beiscsi_free_ep'
 drivers/scsi/be2iscsi/be_iscsi.c:1039: warning: Function parameter or member 'non_blocking' not described in 'beiscsi_open_conn'
 drivers/scsi/be2iscsi/be_iscsi.c:1135: warning: Function parameter or member 'shost' not described in 'beiscsi_ep_connect'
 drivers/scsi/be2iscsi/be_iscsi.c:1135: warning: Excess function parameter 'scsi_host' description in 'beiscsi_ep_connect'
 drivers/scsi/be2iscsi/be_iscsi.c:1236: warning: Function parameter or member 'beiscsi_ep' not described in 'beiscsi_conn_close'
 drivers/scsi/be2iscsi/be_iscsi.c:1236: warning: Excess function parameter 'ep' description in 'beiscsi_conn_close'

Cc: Subbu Seetharaman <subbu.seetharaman@broadcom.com>
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: linux-drivers@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/be2iscsi/be_iscsi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index 2058d50d62e12..fe10575bce7f0 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -27,6 +27,7 @@ extern struct iscsi_transport beiscsi_iscsi_transport;
 
 /**
  * beiscsi_session_create - creates a new iscsi session
+ * @ep: pointer to iscsi ep
  * @cmds_max: max commands supported
  * @qdepth: max queue depth supported
  * @initial_cmdsn: initial iscsi CMDSN
@@ -164,6 +165,7 @@ beiscsi_conn_create(struct iscsi_cls_session *cls_session, u32 cid)
  * @cls_session: pointer to iscsi cls session
  * @cls_conn: pointer to iscsi cls conn
  * @transport_fd: EP handle(64 bit)
+ * @is_leading: indicate if this is the session leading connection (MCS)
  *
  * This function binds the TCP Conn with iSCSI Connection and Session.
  */
@@ -992,7 +994,7 @@ static void beiscsi_put_cid(struct beiscsi_hba *phba, unsigned short cid)
 
 /**
  * beiscsi_free_ep - free endpoint
- * @ep:	pointer to iscsi endpoint structure
+ * @beiscsi_ep: pointer to device endpoint struct
  */
 static void beiscsi_free_ep(struct beiscsi_endpoint *beiscsi_ep)
 {
@@ -1027,9 +1029,10 @@ static void beiscsi_free_ep(struct beiscsi_endpoint *beiscsi_ep)
 
 /**
  * beiscsi_open_conn - Ask FW to open a TCP connection
- * @ep:	endpoint to be used
+ * @beiscsi_ep: pointer to device endpoint struct
  * @src_addr: The source IP address
  * @dst_addr: The Destination  IP address
+ * @non_blocking: blocking or non-blocking call
  *
  * Asks the FW to open a TCP connection
  */
@@ -1123,7 +1126,7 @@ static int beiscsi_open_conn(struct iscsi_endpoint *ep,
 
 /**
  * beiscsi_ep_connect - Ask chip to create TCP Conn
- * @scsi_host: Pointer to scsi_host structure
+ * @shost: Pointer to scsi_host structure
  * @dst_addr: The IP address of Target
  * @non_blocking: blocking or non-blocking call
  *
@@ -1228,7 +1231,7 @@ static void beiscsi_flush_cq(struct beiscsi_hba *phba)
 
 /**
  * beiscsi_conn_close - Invalidate and upload connection
- * @ep: The iscsi endpoint
+ * @beiscsi_ep: pointer to device endpoint struct
  *
  * Returns 0 on success,  -1 on failure.
  */
-- 
2.25.1

