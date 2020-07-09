Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E50C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8FD207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THHFlyDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgGIRqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgGIRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:46:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E7BC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 10:46:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so2746241wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZgkQ7bdc1wuAXRYHhS8n4ys9/FLwMulTL97bGrK6Pg=;
        b=THHFlyDNfbGhREe2Mth1t3vCdRUQD4ki7iIZalNoQuNJfu8+DSo3uQh/JnGFL1A7pB
         r6my4q+nRSD/YT8Kj7W7qiyUu4sCcRaeitRb9gqIgzTzXOrEgeNR5c2j7v0DiGPCTj/r
         GZ+R+hesfOrz8Xx88SDf0a9ZLtrXI9KyTVwM0Fc7itFpMLeGE/H4H7vnS5jdMQ1PSsm4
         XwPKiJQJdEbzq0enhc1XJN7KBC/Y8fJ6m1pTP34kg0vZIfkB5QtC1DGJoSUpWzHqjYHW
         KJevbzy75tsf6JdnjP+mG/Zt1RE5Ad862YUbB6B6NXn3g7lsp51hDsB9mOCnx+t38PoO
         1poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZgkQ7bdc1wuAXRYHhS8n4ys9/FLwMulTL97bGrK6Pg=;
        b=NQ4wkySdsQFdYsWFhJX5qcRXc7CQcKDwqdcTPwfptWpAWkh7rdRQgPwCEJMbnFQrSG
         689MFF3BCxt/H6FXhS74S6nAPbpqPYHmY8sR+eVLVoe6SGQFlGbQ6iR5o3PuCciia/Ur
         Y5BWxin+MEbeHxUxMPOlkgMV7S0f9c9zp7CN743y8B06IrIGuLSFRxnVoUSxEjsbq8Fy
         zE+tjR/6nqLzCYVrFUUP7kK2YtNRoT+LHoNqj3JdL4OehbP7Yv20/uJP5u2lXKqO52EN
         VNdeM4nrWcLdUphFdXXxUR1o7PPkyzCM5p1YNTLDtfqGLGkiSlcdstsBrU/1sMtQeh9D
         EdLQ==
X-Gm-Message-State: AOAM5324N2aDiorHdLZ8mY8WFJPZx8UdDe7tof9PaEJX94GWKRW7OIFa
        B6/K8g2lQ2Bj3+63r39E+OykWQ==
X-Google-Smtp-Source: ABdhPJxVsZiWV2GSjBwMelb7G5gDpGItFQpB6cjPyhX5+TFpX2QA4i7Wi5YMnZ42voh/y6eviZADJw==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr1191513wma.13.1594316779758;
        Thu, 09 Jul 2020 10:46:19 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id f15sm6063854wrx.91.2020.07.09.10.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:46:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        linux-drivers@broadcom.com
Subject: [PATCH 18/24] scsi: be2iscsi: be_main: Fix misdocumentation of 'pcontext'
Date:   Thu,  9 Jul 2020 18:45:50 +0100
Message-Id: <20200709174556.7651-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709174556.7651-1-lee.jones@linaro.org>
References: <20200709174556.7651-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also demote unintentional kerneldoc header.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/be2iscsi/be_main.c:986: warning: Function parameter or member 'pcontext' not described in 'alloc_wrb_handle'
 drivers/scsi/be2iscsi/be_main.c:986: warning: Excess function parameter 'pwrb_context' description in 'alloc_wrb_handle'
 drivers/scsi/be2iscsi/be_main.c:1409: warning: Function parameter or member 'beiscsi_conn' not described in 'beiscsi_complete_pdu'
 drivers/scsi/be2iscsi/be_main.c:1409: warning: Function parameter or member 'phdr' not described in 'beiscsi_complete_pdu'
 drivers/scsi/be2iscsi/be_main.c:1409: warning: Function parameter or member 'pdata' not described in 'beiscsi_complete_pdu'
 drivers/scsi/be2iscsi/be_main.c:1409: warning: Function parameter or member 'dlen' not described in 'beiscsi_complete_pdu'

Cc: Subbu Seetharaman <subbu.seetharaman@broadcom.com>
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: linux-drivers@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/be2iscsi/be_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 9b81cfbbc5c53..8dc2e0824ad78 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -977,7 +977,7 @@ beiscsi_get_wrb_handle(struct hwi_wrb_context *pwrb_context,
  * alloc_wrb_handle - To allocate a wrb handle
  * @phba: The hba pointer
  * @cid: The cid to use for allocation
- * @pwrb_context: ptr to ptr to wrb context
+ * @pcontext: ptr to ptr to wrb context
  *
  * This happens under session_lock until submission to chip
  */
@@ -1394,7 +1394,7 @@ static void hwi_complete_cmd(struct beiscsi_conn *beiscsi_conn,
 	spin_unlock_bh(&session->back_lock);
 }
 
-/**
+/*
  * ASYNC PDUs include
  * a. Unsolicited NOP-In (target initiated NOP-In)
  * b. ASYNC Messages
-- 
2.25.1

