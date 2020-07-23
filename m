Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC2C43446
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D75206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="firLoT+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgGWMZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgGWMZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D68C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so6396713wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1PYc82QmZnWYyBRN6HjG0q6jn6xq3+jiiSrC8xShRHw=;
        b=firLoT+nF6NP5uE7+rwzyF0eexaFUX6j4RXoRWCBz6fwm1F9siOipBBu+l6A/SZAqN
         RzQOsrxZlyVMpnEbBw5+3PfgrZCHddC6oDGHkcwuNgkOV332k9wn+tamNuINOLQtP15h
         apcNbIt/16saNXZZTIcDVmM4flz759qo+WrrYDNv56xmVHDnITyjZFE79Rj3o1ANkBQE
         nFwmTw85LwCzCAXbhD0Sjbuh9WUjU0UNQOBcEfWiTZrj4eTdDeg2a6uq80zOtVEk6yEh
         SY4hbFsGjBJ+q8EuwsfkEsvLXs11S4efCbIrAQzgUdean0xxF9c0iAtbpRZtY8lFtwqm
         CGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1PYc82QmZnWYyBRN6HjG0q6jn6xq3+jiiSrC8xShRHw=;
        b=HQrg7EFbCCoa+4W9X680lQQFxxR0zTgbpE8wC6wxrdZFzh7XkJYuvJXeB4+1jTId81
         M8JUpb+chmjhf/YZqmW1c6KMx+AAA/diOz1K16WmN0qY2uJ8BylubY89i7XMSnFvx0/d
         oIl2OOddqUSSoKidZMInGDNN0EFLDdUIqZOYnmgzwBci6GyMzC1oDGT1614r8exDEHds
         BhVEtDtg5tSi9mbflU4YBeRwPQ5hIGmOBP6RFnUvzs5mXiNQ0DKr5tSEGZJGXfBD+hLL
         6sKw5fBcTEbwC2kVmdhH6qB84VJVs9AkSPV3ALQQkK2jgnJLNp7Z4Gf4zXFqU+3Y0EIT
         9uwg==
X-Gm-Message-State: AOAM533jsXS9tvCNig8FswXsXjNH/lDoRNaAPevGVbd4FECPRng3NWMP
        nyZ29NdB955CECU4jZ8o4Ii53Q==
X-Google-Smtp-Source: ABdhPJwhScaiEIGilOpKYn2h+6SXYh8OlBq+1Bh9h3JTndjCEmfDrMIN2qZK+2SwNHeheXjeGFgsIw==
X-Received: by 2002:a1c:5418:: with SMTP id i24mr3820464wmb.47.1595507122467;
        Thu, 23 Jul 2020 05:25:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Subject: [PATCH 27/40] scsi: bfa: bfa_fcs_rport: Remove unused variable 'adisc'
Date:   Thu, 23 Jul 2020 13:24:33 +0100
Message-Id: <20200723122446.1329773-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bfa/bfa_fcs_rport.c: In function ‘bfa_fcs_rport_process_adisc’:
 drivers/scsi/bfa/bfa_fcs_rport.c:2243:21: warning: variable ‘adisc’ set but not used [-Wunused-but-set-variable]

Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bfa/bfa_fcs_rport.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcs_rport.c b/drivers/scsi/bfa/bfa_fcs_rport.c
index fc294e1950a62..143c35bd668c2 100644
--- a/drivers/scsi/bfa/bfa_fcs_rport.c
+++ b/drivers/scsi/bfa/bfa_fcs_rport.c
@@ -2240,15 +2240,12 @@ bfa_fcs_rport_process_adisc(struct bfa_fcs_rport_s *rport,
 	struct bfa_fcxp_s *fcxp;
 	struct fchs_s	fchs;
 	struct bfa_fcs_lport_s *port = rport->port;
-	struct fc_adisc_s	*adisc;
 
 	bfa_trc(port->fcs, rx_fchs->s_id);
 	bfa_trc(port->fcs, rx_fchs->d_id);
 
 	rport->stats.adisc_rcvd++;
 
-	adisc = (struct fc_adisc_s *) (rx_fchs + 1);
-
 	/*
 	 * Accept if the itnim for this rport is online.
 	 * Else reject the ADISC.
-- 
2.25.1

