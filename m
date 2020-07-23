Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DACC433FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A28E20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASk1pLpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgGWMZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgGWMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D3DC0619E8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so6396367wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvVihUnRFqMdxGLBXS9BPHUYjIV5Tt/WnThdFe3tGqE=;
        b=ASk1pLpmZPrxFOz/aAoD/Ta392mN6iPzej/2OLBJcHirDz4m4DiqrW5Rz8pnvQCg3b
         4v1g2OLLCe8FpjQJnZbAmPuD2pF1PSDJsZK514iZvhY8Z6kiTMAG/BH9ixrHk6waYQzx
         ggrEIo1zyDBRcLeIGpoY2MvSAUuRDyZmxGPDMWr3jLGah+qTy04BkMCb6LVokUZaZ56L
         My+BJAHs3hylLRjrKDjgrECQ9WsWKYatXeURswCgJiF/6C4uEhK1mX6ODqqF4pv6hNWE
         DrdDaaHD92YqGw+fv5ny+LnMAm5fSxmOYdbY5EDb73V86wYzvhFb6GT8ElCfzuLgCQsW
         /nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvVihUnRFqMdxGLBXS9BPHUYjIV5Tt/WnThdFe3tGqE=;
        b=hsCLe6leSHW2dYUlDRngGOfb+qkVSGyktj7oeRwPaCcVIU+XuhHKIjRhsZbAty6Jaa
         cDExhLTtSndGTfz2nXczx3x3wj0MnGk94XFOOf9lRsWHNB6DJ9njDlgMmCHDuxXNeBlb
         zDzOiPJsy0FDIeIQKWBeu87w4s8eOFuDdAjc7KiW+DmqOoO1B4tnA5FsjxYlhhp4My+o
         rGjfQvqNIxIezl/osPaZdRAajJkA2jRC/Brhm2l4tiZqLlCznK6ULs6n8j3NfDvleeJi
         r1gldt2NqwOnWfDDoqLKUlz2tQHJ+J29ecPnDXxG4H+YSKucpD3+3drUfZJUi44gjGqD
         dLUA==
X-Gm-Message-State: AOAM5300TneNAD4OOwG79ky45FOuFQ2S1nsqTnKgF8uMhZkSFCJeGRxY
        rBpbrP/Az9tXNdJqxrI3miQpuQ==
X-Google-Smtp-Source: ABdhPJyKG4U0JmHyOzcwDHBhbjxqAF1cbPfZqUXMamtCsYAkdrJV/XwgD9FSh+MCWccrwNnLa0xp2A==
X-Received: by 2002:a1c:a757:: with SMTP id q84mr1700943wme.1.1595507109953;
        Thu, 23 Jul 2020 05:25:09 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@qlogic.com
Subject: [PATCH 17/40] scsi: qla4xxx: ql4_bsg: Rename function parameter descriptions
Date:   Thu, 23 Jul 2020 13:24:23 +0100
Message-Id: <20200723122446.1329773-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla4xxx/ql4_bsg.c:811: warning: Function parameter or member 'bsg_job' not described in 'qla4xxx_process_vendor_specific'
 drivers/scsi/qla4xxx/ql4_bsg.c:811: warning: Excess function parameter 'job' description in 'qla4xxx_process_vendor_specific'
 drivers/scsi/qla4xxx/ql4_bsg.c:858: warning: Function parameter or member 'bsg_job' not described in 'qla4xxx_bsg_request'
 drivers/scsi/qla4xxx/ql4_bsg.c:858: warning: Excess function parameter 'job' description in 'qla4xxx_bsg_request'

Cc: QLogic-Storage-Upstream@qlogic.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla4xxx/ql4_bsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_bsg.c b/drivers/scsi/qla4xxx/ql4_bsg.c
index 415ee5eb3fc7e..9231917066d3e 100644
--- a/drivers/scsi/qla4xxx/ql4_bsg.c
+++ b/drivers/scsi/qla4xxx/ql4_bsg.c
@@ -805,7 +805,7 @@ static int qla4xxx_execute_diag_test(struct bsg_job *bsg_job)
 
 /**
  * qla4xxx_process_vendor_specific - handle vendor specific bsg request
- * @job: iscsi_bsg_job to handle
+ * @bsg_job: iscsi_bsg_job to handle
  **/
 int qla4xxx_process_vendor_specific(struct bsg_job *bsg_job)
 {
@@ -852,7 +852,7 @@ int qla4xxx_process_vendor_specific(struct bsg_job *bsg_job)
 
 /**
  * qla4xxx_bsg_request - handle bsg request from ISCSI transport
- * @job: iscsi_bsg_job to handle
+ * @bsg_job: iscsi_bsg_job to handle
  */
 int qla4xxx_bsg_request(struct bsg_job *bsg_job)
 {
-- 
2.25.1

