Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC55C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B87420772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n292cOlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgGHMDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgGHMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:03:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B811C08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:03:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so2732584wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQHRlmYiMy5z0WnxtNKRalmwQyJTVSmo3hN7/2Qvzas=;
        b=n292cOlkFOyUyQ8ZkW6XuDxtzEgcsyhqPXRt7/EPXsfkxxrObnUpsWEbLWdfZ8Eq6s
         P/lp8mGBvS46SbnST3odFaAF/4nxTUozIlvQvRrCISKPcSbf3EHcfXo3R0XZPFzKWE/M
         /RrB07MQODt05nVNPEhKIQRcU0rvw4VBjKaAiUpdwmUcpfHNL/LQP4J/VFqBS8UcbWoN
         g7QKzYhENoql15R1iKSDZIGmsP/8U05P5VOFN8YtkJTIByodKGe1GMjnqEfFCJb8khIC
         c2jBNUY588S31VNGlrlv95/LdNM8UZFuWKauPiMhIy84/UTVA0T055uCUGikYhYvvilL
         4cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQHRlmYiMy5z0WnxtNKRalmwQyJTVSmo3hN7/2Qvzas=;
        b=O2yMptS+z+Lagcd+RsQ54h6F6LYPv/NABbtKdS4pJSkZS/Y4+kc/fbxENY8nZPSuVj
         SQmdcNAdsXenzRjz8SkZ21q2/fZk3bJq2OFm6sjN/hf0asnd1MYB94oqLcAjaKmsu+Dx
         d/VLmXiihcGUidhRPae0t8RdOjGnBkFd7RwEZMaFPBKQrTwk5RW1q6pHuviqcDofBF32
         G/ZBp8QJd/wsSVzEarBPSInRjRUCOgiT1CGrRF3A9lVjYy83Pe3cbAHVWBuYiB6Rum98
         IPIPUMi2I4CUTU8io++xc3qqaKbEEaMgPHicwVVzgE/FY9TQ8zEsoqFs1RrN/E6mT6fc
         inyA==
X-Gm-Message-State: AOAM530UXlryrUgb+D9r77COPic4rmihPUD+CiEiuTD5iTW/Jyd69vZE
        IV/xyphOmDNY4DQo37PFOG53YYd5yhk=
X-Google-Smtp-Source: ABdhPJywj779mVY5kkp6U1/q3t+6iH+w1ef8s3SruZgBMfwL4j+sJHFUFND72bQd7nKC092vdnHnHA==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr8709643wmc.2.1594209789802;
        Wed, 08 Jul 2020 05:03:09 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:03:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@qlogic.com
Subject: [PATCH 30/30] scsi: qla4xxx: ql4_init: Provide a missing function param description and fix formatting
Date:   Wed,  8 Jul 2020 13:02:21 +0100
Message-Id: <20200708120221.3386672-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc function parameter references need to be in the format '@.*: ',
else the kerneldoc checker gets confused.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla4xxx/ql4_init.c: In function ‘ql4xxx_set_mac_number’:
 drivers/scsi/qla4xxx/ql4_init.c:17:10: warning: variable ‘func_number’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/qla4xxx/ql4_init.c: In function ‘qla4xxx_pci_config’:
 drivers/scsi/qla4xxx/ql4_init.c:664:6: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]
from  drivers/scsi/qla4xxx/ql4_init.c:9:
from  drivers/scsi/qla4xxx/ql4_init.c:9:
 drivers/scsi/qla4xxx/ql4_init.c:953: warning: Function parameter or member 'is_reset' not described in 'qla4xxx_initialize_adapter'
 drivers/scsi/qla4xxx/ql4_init.c:1168: warning: Function parameter or member 'ha' not described in 'qla4xxx_process_ddb_changed'
 drivers/scsi/qla4xxx/ql4_init.c:1168: warning: Function parameter or member 'fw_ddb_index' not described in 'qla4xxx_process_ddb_changed'
 drivers/scsi/qla4xxx/ql4_init.c:1168: warning: Function parameter or member 'state' not described in 'qla4xxx_process_ddb_changed'
 drivers/scsi/qla4xxx/ql4_init.c:1168: warning: Function parameter or member 'conn_err' not described in 'qla4xxx_process_ddb_changed'

Cc: QLogic-Storage-Upstream@qlogic.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla4xxx/ql4_init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_init.c b/drivers/scsi/qla4xxx/ql4_init.c
index 2bf5e3e639e1a..5963127f7d2ef 100644
--- a/drivers/scsi/qla4xxx/ql4_init.c
+++ b/drivers/scsi/qla4xxx/ql4_init.c
@@ -945,6 +945,7 @@ void qla4xxx_free_ddb_index(struct scsi_qla_host *ha)
 /**
  * qla4xxx_initialize_adapter - initiailizes hba
  * @ha: Pointer to host adapter structure.
+ * @is_reset: Is this init path or reset path
  *
  * This routine parforms all of the steps necessary to initialize the adapter.
  *
@@ -1156,9 +1157,9 @@ int qla4xxx_flash_ddb_change(struct scsi_qla_host *ha, uint32_t fw_ddb_index,
 
 /**
  * qla4xxx_process_ddb_changed - process ddb state change
- * @ha - Pointer to host adapter structure.
- * @fw_ddb_index - Firmware's device database index
- * @state - Device state
+ * @ha: Pointer to host adapter structure.
+ * @fw_ddb_index: Firmware's device database index
+ * @state: Device state
  *
  * This routine processes a Decive Database Changed AEN Event.
  **/
-- 
2.25.1

