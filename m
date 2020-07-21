Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AAEC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E7520720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSBNkzIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgGUQmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbgGUQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so3531720wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K90vcy/o25tlbqMsi3dOYtFzefeQDnF1S4V8+JehAOE=;
        b=kSBNkzIgN4rXdVJ2lPl48mG5ud+1RxKIJoRnCAzUm7zOtw6he03uDCVu6aUHAz0P/2
         xypcS8bzJNMrOGZs+yaPvHsv+iAMDRxK3bVXzJ79M9PVq2X9cHJbGnDSDLK2LqY0zQhm
         rl6VKnqZRkifrpQRV9ZBRunLKpGE9o4tmm6GylhKpMCS9jwWbUrBa88Fju4SK796150V
         PQtmbVpoBCPHuYUnXK2HPsWhcoXY9BKuqxs/pAa2OWnbtfp9qI+UQyyH7Kyb2ZS3gJUg
         zMpDIdHwy0qGqJRjXV/lbCmfFOkuC6nCRdx9EkVyIisfhJMVZqDpzzPv+4g+p8EMghGk
         gDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K90vcy/o25tlbqMsi3dOYtFzefeQDnF1S4V8+JehAOE=;
        b=pwK2eGxBkKx5snBxheADyAkMny23TTCf83DVu14EQLCPw8fO1HGM8Y7Otlo1ChKK6K
         bx1WQPJ+ev9bvbc6on6xaWrNhf741uKULZvRWui8ijX20oGU9i+YiIHtohvvaR2xZ9hl
         WEukPuc0ecDzvCWyALCPdemMhh6pTN2D3wAecfq14ZbLxdzndvU/2S5WBM00Z6NGYceh
         Seg5e8cDGN6Q80LtSkmLwH3TFjdJvhsNF50yaqtdiU4vpkxehhiUdzvI2IbkmroJjZP3
         oHMbCxuRT7zALK2Cu7JcUenndodbA8m/M5/aJ5p9tjyAbWkGLnwcxbXg+CYT/Jp2BInT
         RPoQ==
X-Gm-Message-State: AOAM533NQw+7luiNTydsMWUjHOWj7G4LV3g+SwVBE9HwXrIgi5e4BhI6
        07SwFR9VI2s76PFtLa2eViNIPO4qujo=
X-Google-Smtp-Source: ABdhPJzJeQquSCZ32VcLdoqaRDKTdnfQqG9/uBWmvXER/GCrpEN/vLpo9JDj7ONFNsTzu6wJGulixQ==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr4974710wmh.77.1595349748188;
        Tue, 21 Jul 2020 09:42:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:42:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@qlogic.com
Subject: [PATCH 22/40] scsi: qla4xxx: ql4_iocb: Fix incorrectly named function parameter
Date:   Tue, 21 Jul 2020 17:41:30 +0100
Message-Id: <20200721164148.2617584-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

from  drivers/scsi/qla4xxx/ql4_iocb.c:8:
 drivers/scsi/qla4xxx/ql4_iocb.c:87: warning: Function parameter or member 'mrkr_mod' not described in 'qla4xxx_send_marker_iocb'
 drivers/scsi/qla4xxx/ql4_iocb.c:87: warning: Excess function parameter 'marker_type' description in 'qla4xxx_send_marker_iocb'

Cc: QLogic-Storage-Upstream@qlogic.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla4xxx/ql4_iocb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_iocb.c b/drivers/scsi/qla4xxx/ql4_iocb.c
index 17222eb497622..a8df2d7eb0699 100644
--- a/drivers/scsi/qla4xxx/ql4_iocb.c
+++ b/drivers/scsi/qla4xxx/ql4_iocb.c
@@ -78,7 +78,7 @@ static int qla4xxx_get_req_pkt(struct scsi_qla_host *ha,
  * @ha: Pointer to host adapter structure.
  * @ddb_entry: Pointer to device database entry
  * @lun: SCSI LUN
- * @marker_type: marker identifier
+ * @mrkr_mod: marker identifier
  *
  * This routine issues a marker IOCB.
  **/
-- 
2.25.1

