Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC376C433F8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFCC206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/HEfOZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgGWM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgGWMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:24:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315C2C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:24:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so4964295wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ihdeGdGpgFkIzdF2x6is+yRXhsZbdmE+baPKtamOODg=;
        b=C/HEfOZW2bHfFxf2HJjaIioq8YJFxQfJM9vjgsFwFUdLzkpjL8rfbLAnxrBChpmPhI
         a0T+h39nKigPiDEkcIk7vlXAEYtuZNW5NHe6B5WJPVm95D9SOoezAGi9g2rMYu7DzLni
         vX4jEccc5FiYXFLwoDQmOCrrVyYb0n7g05Q1mJ8l8Y7u36bdMXBzTkYNheQJ/VjntmCC
         vVjkpHQlptkv0kJMiB8QUId2YOPfVUw91XTyYT0icpUhSoASPXCvwZcXaTJEPchLK0J3
         FeRZQxmPx+atTDIjngKPD4MnFLwNA/NX0Och4/1FwVrMwkdWvJ69mBp6y/PLXg3kS2yX
         NnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihdeGdGpgFkIzdF2x6is+yRXhsZbdmE+baPKtamOODg=;
        b=O1VIa/BSk3qPO4IwJjDvIB5CnxzynVw4VnVImCSolIfKfZwDyUOvdHKymBx5a/KowR
         dyzqGDyb2yB/W4JS6UZEjmnLeVJMqMsn7u12inbFQgAZ6nNh1268HS99iq3oEBI+vQ0h
         m4oNwLw/Yfs84AFon65/XkbRX9nT4RMk5hJc+19c/QP21wAOyeiMAa6yP7GGAoVJDMTC
         jMd1bgB1K0qrw7T/LjuRYpNNepC2PfrIWqHXMePknALMSBGuM6u9zq5VTMLo6LQUPSa1
         MOrC+L1uLbxRJrKYyQe+GlVLXZsgJXf8/KiG2O10ZoZXp17KqZDNo1aPoOgf1zFtJt9J
         Ewpg==
X-Gm-Message-State: AOAM530Ks3i+gUic8LCasDk3yELO43wyETco7/Vap3XOsUOEK86jCSJw
        8a5e3niwG5RNLM7xqtcXDL30Eg==
X-Google-Smtp-Source: ABdhPJx/bi8f9Iyz4dlcIsq3N8F+lCeAvevX1AjO5UazBsvSxdcZAB5/UjE/vWFIW63WtnKDl3oLoQ==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr3755171wrj.273.1595507091857;
        Thu, 23 Jul 2020 05:24:51 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:24:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 02/40] scsi: lpfc: lpfc_hbadisc: Fix kerneldoc parameter formatting/misnaming/missing issues
Date:   Thu, 23 Jul 2020 13:24:08 +0100
Message-Id: <20200723122446.1329773-3-lee.jones@linaro.org>
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

 drivers/scsi/lpfc/lpfc_hbadisc.c:1209: warning: Function parameter or member 'phba' not described in 'lpfc_sli4_clear_fcf_rr_bmask'
 drivers/scsi/lpfc/lpfc_hbadisc.c:1309: warning: Function parameter or member 'sw_name' not described in 'lpfc_sw_name_match'
 drivers/scsi/lpfc/lpfc_hbadisc.c:1309: warning: Excess function parameter 'fab_name' description in 'lpfc_sw_name_match'
 drivers/scsi/lpfc/lpfc_hbadisc.c:1397: warning: Function parameter or member 'fcf_rec' not described in 'lpfc_copy_fcf_record'
 drivers/scsi/lpfc/lpfc_hbadisc.c:1397: warning: Excess function parameter 'fcf' description in 'lpfc_copy_fcf_record'
 drivers/scsi/lpfc/lpfc_hbadisc.c:1956: warning: Cannot understand  lpfc_sli4_fcf_record_match - testing new FCF record for matching existing FCF
 on line 1956 - I thought it was a doc line
 drivers/scsi/lpfc/lpfc_hbadisc.c:2078: warning: Function parameter or member 'fcf_index' not described in 'lpfc_sli4_fcf_pri_list_del'
 drivers/scsi/lpfc/lpfc_hbadisc.c:2109: warning: Function parameter or member 'fcf_index' not described in 'lpfc_sli4_set_fcf_flogi_fail'
 drivers/scsi/lpfc/lpfc_hbadisc.c:2135: warning: Function parameter or member 'fcf_index' not described in 'lpfc_sli4_fcf_pri_list_add'
 drivers/scsi/lpfc/lpfc_hbadisc.c:2135: warning: Function parameter or member 'new_fcf_record' not described in 'lpfc_sli4_fcf_pri_list_add'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 1713349cec4f5..142a021144793 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -1198,7 +1198,7 @@ lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 /**
  * lpfc_sli4_clear_fcf_rr_bmask
- * @phba pointer to the struct lpfc_hba for this port.
+ * @phba: pointer to the struct lpfc_hba for this port.
  * This fucnction resets the round robin bit mask and clears the
  * fcf priority list. The list deletions are done while holding the
  * hbalock. The ON_LIST flag and the FLOGI_FAILED flags are cleared
@@ -1297,7 +1297,7 @@ lpfc_fab_name_match(uint8_t *fab_name, struct fcf_record *new_fcf_record)
 
 /**
  * lpfc_sw_name_match - Check if the fcf switch name match.
- * @fab_name: pointer to fabric name.
+ * @sw_name: pointer to switch name.
  * @new_fcf_record: pointer to fcf record.
  *
  * This routine compare the fcf record's switch name with provided
@@ -1385,7 +1385,7 @@ __lpfc_update_fcf_record_pri(struct lpfc_hba *phba, uint16_t fcf_index,
 
 /**
  * lpfc_copy_fcf_record - Copy fcf information to lpfc_hba.
- * @fcf: pointer to driver fcf record.
+ * @fcf_rec: pointer to driver fcf record.
  * @new_fcf_record: pointer to fcf record.
  *
  * This routine copies the FCF information from the FCF
@@ -1953,7 +1953,7 @@ lpfc_sli4_log_fcf_record_info(struct lpfc_hba *phba,
 }
 
 /**
- lpfc_sli4_fcf_record_match - testing new FCF record for matching existing FCF
+ * lpfc_sli4_fcf_record_match - testing new FCF record for matching existing FCF
  * @phba: pointer to lpfc hba data structure.
  * @fcf_rec: pointer to an existing FCF record.
  * @new_fcf_record: pointer to a new FCF record.
@@ -2067,7 +2067,7 @@ int lpfc_sli4_fcf_rr_next_proc(struct lpfc_vport *vport, uint16_t fcf_index)
 /**
  * lpfc_sli4_fcf_pri_list_del
  * @phba: pointer to lpfc hba data structure.
- * @fcf_index the index of the fcf record to delete
+ * @fcf_index: the index of the fcf record to delete
  * This routine checks the on list flag of the fcf_index to be deleted.
  * If it is one the list then it is removed from the list, and the flag
  * is cleared. This routine grab the hbalock before removing the fcf
@@ -2097,7 +2097,7 @@ static void lpfc_sli4_fcf_pri_list_del(struct lpfc_hba *phba,
 /**
  * lpfc_sli4_set_fcf_flogi_fail
  * @phba: pointer to lpfc hba data structure.
- * @fcf_index the index of the fcf record to update
+ * @fcf_index: the index of the fcf record to update
  * This routine acquires the hbalock and then set the LPFC_FCF_FLOGI_FAILED
  * flag so the the round robin slection for the particular priority level
  * will try a different fcf record that does not have this bit set.
@@ -2117,7 +2117,8 @@ lpfc_sli4_set_fcf_flogi_fail(struct lpfc_hba *phba, uint16_t fcf_index)
 /**
  * lpfc_sli4_fcf_pri_list_add
  * @phba: pointer to lpfc hba data structure.
- * @fcf_index the index of the fcf record to add
+ * @fcf_index: the index of the fcf record to add
+ * @new_fcf_record: pointer to a new FCF record.
  * This routine checks the priority of the fcf_index to be added.
  * If it is a lower priority than the current head of the fcf_pri list
  * then it is added to the list in the right order.
-- 
2.25.1

