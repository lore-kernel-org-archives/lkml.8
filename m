Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E2EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB2C2065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRrcLJ4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgGHMDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgGHMCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99907C08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so40611899wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsv1890EAaVy29cSOpHY+htSuPNyhdWUNl+08rJAqiI=;
        b=vRrcLJ4vDQL45XkegDFjkvZZg7i76UXflllyN2qZnOq226OkdOjiHe3dbctK+ciSBn
         gWt/7Pwpd0ep+S4IlbWVMRNd/jxynHNsYOvFF4YJzUTxJ4WRNxA+9Xx+Hga8fCD8h3Kq
         NjUMJjub0ouBPz11A0fIgcXp8KkYeU0hakOhnTw2D9YgxvZx9AjdDri3FolrNPkWD89E
         WQUqQpZ1EfyUTEBnP5Xc43TgLsqRxFxs6LmMtoHTj4gDY7oCFlPP7UeQ1vB/MgbnZwnA
         62ZNMumMK3DF40ZarEwdRS0gFNj3ETrfBbl55wKEp2PSrEmF76zgNslRZPhokRoIaQps
         hGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsv1890EAaVy29cSOpHY+htSuPNyhdWUNl+08rJAqiI=;
        b=R4/Mc7MCPWewIP0FzZQ4XrQUfOT+uRAodZfIO+oVvN8FYkNPykXXb5HhG/iILRnsAp
         bfXUYtRl9rU9YdmpDVpDE2uOnh2SBoT4N4tRolgb8vAjb44AK+T+aPAtU3rU2NILZyyT
         E0TYNtsgvoOJ621C6oqSmwyXv+pn1Rs4+LoTApEm/QCe1kOYj3C6drmKNHD+gpXaBhHb
         i70IdUIpzPM7+u3fIFdj7AKYAmIuXQxp22QQl+6/ddQ5HzqFYp8V27meptTzMgkC74ua
         ktsL6Vvl+lmvWFFyXzMvvMDxK0P/FRzEFb9Sd7bsK84Kqm8cLzEU3QIWNUs0tMe3htQ+
         mKlw==
X-Gm-Message-State: AOAM530QZFnE9MJ5j4sMxqZPEcvuqpNyM8eB7v3VNhMf5NbObEc+V4F6
        iRE2z4Ent7WkXVYgxYemvcfW3g==
X-Google-Smtp-Source: ABdhPJz3PHEM50t/r5XjgX+XVA3j0TbMoFQW182h5eqiEs0GZFDqnC7RQSOEvrxuPzYypjDcuJLp6Q==
X-Received: by 2002:adf:e948:: with SMTP id m8mr59728702wrn.398.1594209771378;
        Wed, 08 Jul 2020 05:02:51 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@qlogic.com,
        Prakash Gollapudi <bprakash@broadcom.com>
Subject: [PATCH 18/30] scsi: bnx2fc: bnx2fc_tgt: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Wed,  8 Jul 2020 13:02:09 +0100
Message-Id: <20200708120221.3386672-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document either of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bnx2fc/bnx2fc_tgt.c:442: warning: Function parameter or member 'lport' not described in 'bnx2fc_rport_event_handler'
 drivers/scsi/bnx2fc/bnx2fc_tgt.c:442: warning: Function parameter or member 'rdata' not described in 'bnx2fc_rport_event_handler'
 drivers/scsi/bnx2fc/bnx2fc_tgt.c:442: warning: Function parameter or member 'event' not described in 'bnx2fc_rport_event_handler'
 drivers/scsi/bnx2fc/bnx2fc_tgt.c:665: warning: Function parameter or member 'hba' not described in 'bnx2fc_alloc_session_resc'
 drivers/scsi/bnx2fc/bnx2fc_tgt.c:665: warning: Function parameter or member 'tgt' not described in 'bnx2fc_alloc_session_resc'

Cc: QLogic-Storage-Upstream@qlogic.com
Cc: Prakash Gollapudi <bprakash@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bnx2fc/bnx2fc_tgt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index 50384b4a817c8..a3e2a38aabf2f 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -431,7 +431,7 @@ static int bnx2fc_init_tgt(struct bnx2fc_rport *tgt,
 	return 0;
 }
 
-/**
+/*
  * This event_callback is called after successful completion of libfc
  * initiated target login. bnx2fc can proceed with initiating the session
  * establishment.
@@ -656,9 +656,8 @@ static void bnx2fc_free_conn_id(struct bnx2fc_hba *hba, u32 conn_id)
 	spin_unlock_bh(&hba->hba_lock);
 }
 
-/**
- *bnx2fc_alloc_session_resc - Allocate qp resources for the session
- *
+/*
+ * bnx2fc_alloc_session_resc - Allocate qp resources for the session
  */
 static int bnx2fc_alloc_session_resc(struct bnx2fc_hba *hba,
 					struct bnx2fc_rport *tgt)
-- 
2.25.1

