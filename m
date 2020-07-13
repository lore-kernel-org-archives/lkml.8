Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F392C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC4220674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awfg1w8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgGMHrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgGMHrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:47:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ED6C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so14695723wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+pt3rF/aF9MXBxaxOWkhoV3OTeQnwTFN7tbYNZX5zs=;
        b=awfg1w8hLZaUeONe8FwFH8j88+Ggd4dTWQYwOx4LJBDj/hooZxwrwNsyZPuFQpyKqD
         01XRGH++ZXUAUk6tFVGrk2nqMdjfW1wcQldXKsZIj7u2DzDUZu2y5LkDTEKCfCnYixgU
         UFFIxMW/qOECoEjRPY0Cfn8mdpxL4gRQpEtc7owyS+zGUQ4fx9Qy7n94Yh2+u7qR2fh4
         47Di5k6+PNiKW7wgNJsxV+JBGngbT0y/zMH3RWnt64Fj5HDXXKM6se95Sn7/z0K9ciMm
         h02W4SFvKbl07l4Gh/BGJySnn89OkKt+I9xBlMJjt7THbizS2equRg/VUbMWtnIaZmvI
         8oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+pt3rF/aF9MXBxaxOWkhoV3OTeQnwTFN7tbYNZX5zs=;
        b=k7JPvaYzi/5nPLrPF/egtLkgL0/b1adMis9+RCK5s0ptcLzqY2cpUzguGrezQ8VN1d
         SY2I96MxoG2jTF2XYdyB9fOYITR4mvINgg63TU0QjB5bVdN1cGyDt1QonslZMSNnMrUK
         Um72U/bF0FgLD7S0zBnfps/IgbTgqyWR1bLqSgIgo+cyKfY/CyaavKdyGustBkbm7heD
         QV62ct3h3qBUm4zOCpVFta2QTVcETxjJUmqmOhnMMolk+f5Oy5srrzFOtJeQu7keK6WD
         o51EbOjJ9wOaVVLMcE63L+wMVPmiB6TQAlNzvixy5lohnK5Z/Pw48CtMnCr6W84D4K7S
         Ns+A==
X-Gm-Message-State: AOAM533ibuHBz5ZoRGhFx5JakxvVWlg4NkdqUdRAz4SDy6XTlvIEhS8n
        LtWLsSaGcZpOvjREJs+bPkayFw==
X-Google-Smtp-Source: ABdhPJxZbAHPn5pqfgwXCi4N+vnMcu57B+yNhS6xaLCLcT9XR5lJhp1zez0iYsnzWTLEzSFEurFjgQ==
X-Received: by 2002:adf:f209:: with SMTP id p9mr74769708wro.86.1594626421826;
        Mon, 13 Jul 2020 00:47:01 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:47:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@qlogic.com,
        Prakash Gollapudi <bprakash@broadcom.com>
Subject: [PATCH v2 13/29] scsi: bnx2fc: bnx2fc_hwi: Fix a couple  of bitrotted function documentation headers
Date:   Mon, 13 Jul 2020 08:46:29 +0100
Message-Id: <20200713074645.126138-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Likely a result of documentation not keeping up with API updates (a.k.a. bitrot).

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bnx2fc/bnx2fc_hwi.c:493: warning: Function parameter or member 'hba' not described in 'bnx2fc_send_session_destroy_req'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:493: warning: Excess function parameter 'port' description in 'bnx2fc_send_session_destroy_req'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:1345: warning: Function parameter or member 'context' not described in 'bnx2fc_indicate_kcqe'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:1345: warning: Function parameter or member 'kcq' not described in 'bnx2fc_indicate_kcqe'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:1345: warning: Excess function parameter 'hba' description in 'bnx2fc_indicate_kcqe'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:1345: warning: Excess function parameter 'kcqe' description in 'bnx2fc_indicate_kcqe'

Cc: QLogic-Storage-Upstream@qlogic.com
Cc: Prakash Gollapudi <bprakash@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bnx2fc/bnx2fc_hwi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 8c0d6866cf3b8..e72d7bb7f4f42 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -485,7 +485,7 @@ int bnx2fc_send_session_disable_req(struct fcoe_port *port,
 /**
  * bnx2fc_send_session_destroy_req - initiates FCoE Session destroy
  *
- * @port:		port structure pointer
+ * @hba:		adapter structure pointer
  * @tgt:		bnx2fc_rport structure pointer
  */
 int bnx2fc_send_session_destroy_req(struct bnx2fc_hba *hba,
@@ -1334,8 +1334,8 @@ static void bnx2fc_init_failure(struct bnx2fc_hba *hba, u32 err_code)
 /**
  * bnx2fc_indicae_kcqe - process KCQE
  *
- * @hba:	adapter structure pointer
- * @kcqe:	kcqe pointer
+ * @context:	adapter structure pointer
+ * @kcq:	kcqe pointer
  * @num_cqe:	Number of completion queue elements
  *
  * Generic KCQ event handler
-- 
2.25.1

