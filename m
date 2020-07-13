Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF849C433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA20720674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vV+NVLZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgGMHrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgGMHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:47:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28803C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so12729800wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7D7AfDQQG73fSw4f21gOz4vhVntWScnapCoKvjgVSM=;
        b=vV+NVLZbcCzd4H3LMTl7g1rbRAL4pQW36HVzYwkRoNO7H8voiAmmb1Ft/Ig7C9LqAN
         5NElhgHT2E+DngzMp3xd9PzgBACBMSL8PKud4STlFQNDR488sZRESJlnOIhg6LCGA4IP
         rDwVwXp+sxZclZMMgDjZKriAl/1M+xdQKZqbKpi7WqPwgOpauWacugk41diIdooz92zq
         ZFF00fG+2EZXpSQFE6auRlu+aBEMoFFJLmUV2WwFzybWIeyjeiqTcanXL20tvjoiTyHN
         fsYhJ+CxX5aXYUhwoJeEzHlNhHW7gQeq7rpZl5sAHNPl8Z8VepXO+NMz/87JgOQTHgAn
         PSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7D7AfDQQG73fSw4f21gOz4vhVntWScnapCoKvjgVSM=;
        b=qhIcI+LfTgOTEm4oCuQEAMl4Gsser5LFA6iaisMN+USFkk/jYATCMwS7LzLkW24rjr
         pL4mdcCTO3+CV2mc20u3FrzcDlJlxxy6x5Ou8howPgEUdP6H2Zp2MLzFye/oaazj5T25
         I3eZMnsdtqRfHYrh2KlwMUUVJsj5XT//hAgqCgIHeM4hepZ+NyNmNEoQH/SHPaeTEImW
         Py4uhnokrMkNJdMzdZqBp5mXrNrJ5gh1Sk/7LzFH9FwxfobOCjkJgi4jgbg7ztmSGtfy
         wavdM4Siivu0nns5Vvrts8a6Y5LfUtmukn2wr/6t7tgslOmEv27swuGS6NN9foqS7xdK
         YwTw==
X-Gm-Message-State: AOAM531KCsEHUC8VSkSOdOsgvwmQjF4H68vd6He4O8B+6/hl1U3HsNeV
        OBsSgAD7lb/0Kcd5V+6HgfA3YGSt8UA=
X-Google-Smtp-Source: ABdhPJykgxeFl6MQNLKyLJskduUzPTsaisKDntI4PdPBhkHl/h6r0YVhcfokuRCVg5muKjhfySfqNA==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr18044156wmj.86.1594626437839;
        Mon, 13 Jul 2020 00:47:17 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:47:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH v2 28/29] scsi: aacraid: aachba: Fix a bunch of function doc formatting errors
Date:   Mon, 13 Jul 2020 08:46:44 +0100
Message-Id: <20200713074645.126138-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And a few missing/excessive parameter descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/aachba.c:358: warning: Function parameter or member 'dev' not described in 'aac_get_config_status'
 drivers/scsi/aacraid/aachba.c:358: warning: Function parameter or member 'commit_flag' not described in 'aac_get_config_status'
 drivers/scsi/aacraid/aachba.c:358: warning: Excess function parameter 'common' description in 'aac_get_config_status'
 drivers/scsi/aacraid/aachba.c:450: warning: Function parameter or member 'dev' not described in 'aac_get_containers'
 drivers/scsi/aacraid/aachba.c:450: warning: Excess function parameter 'common' description in 'aac_get_containers'
 drivers/scsi/aacraid/aachba.c:568: warning: Function parameter or member 'scsicmd' not described in 'aac_get_container_name'
 drivers/scsi/aacraid/aachba.c:796: warning: Function parameter or member 'scsicmd' not described in 'aac_probe_container_callback1'
 drivers/scsi/aacraid/aachba.c:796: warning: Excess function parameter 'dev' description in 'aac_probe_container_callback1'
 drivers/scsi/aacraid/aachba.c:796: warning: Excess function parameter 'cid' description in 'aac_probe_container_callback1'
 drivers/scsi/aacraid/aachba.c:1105: warning: Function parameter or member 'scsicmd' not described in 'aac_get_container_serial'
 drivers/scsi/aacraid/aachba.c:1961: warning: Excess function parameter 'phys_luns' description in 'aac_set_safw_attr_all_targets'
 drivers/scsi/aacraid/aachba.c:1961: warning: Excess function parameter 'rescan' description in 'aac_set_safw_attr_all_targets'
 drivers/scsi/aacraid/aachba.c:3394: warning: Cannot understand  *
 on line 3394 - I thought it was a doc line
 drivers/scsi/aacraid/aachba.c:3687: warning: Cannot understand  *
 on line 3687 - I thought it was a doc line
 drivers/scsi/aacraid/aachba.c:3752: warning: Cannot understand  *
 on line 3752 - I thought it was a doc line
 drivers/scsi/aacraid/aachba.c:3795: warning: Cannot understand  *
 on line 3795 - I thought it was a doc line

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/aachba.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 2b868f8db8ffe..7ae1e545a255c 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -561,7 +561,7 @@ static void get_container_name_callback(void *context, struct fib * fibptr)
 	scsicmd->scsi_done(scsicmd);
 }
 
-/**
+/*
  *	aac_get_container_name	-	get container name, none blocking.
  */
 static int aac_get_container_name(struct scsi_cmnd * scsicmd)
@@ -786,8 +786,7 @@ static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(stru
 
 /**
  *	aac_probe_container		-	query a logical volume
- *	@dev: device to query
- *	@cid: container identifier
+ * @scsicmd: the scsi command block
  *
  *	Queries the controller about the given volume. The volume information
  *	is updated in the struct fsa_dev_info structure rather than returned.
@@ -1098,7 +1097,7 @@ static void get_container_serial_callback(void *context, struct fib * fibptr)
 	scsicmd->scsi_done(scsicmd);
 }
 
-/**
+/*
  *	aac_get_container_serial - get container serial, none blocking.
  */
 static int aac_get_container_serial(struct scsi_cmnd * scsicmd)
@@ -1952,8 +1951,6 @@ static int aac_get_safw_attr_all_targets(struct aac_dev *dev)
 /**
  *	aac_set_safw_attr_all_targets-	update current hba map with data from FW
  *	@dev:	aac_dev structure
- *	@phys_luns: FW information from report phys luns
- *	@rescan: Indicates scan type
  *
  *	Update our hba map with the information gathered from the FW
  */
@@ -3391,15 +3388,12 @@ int aac_dev_ioctl(struct aac_dev *dev, unsigned int cmd, void __user *arg)
 }
 
 /**
- *
  * aac_srb_callback
  * @context: the context set in the fib - here it is scsi cmd
  * @fibptr: pointer to the fib
  *
  * Handles the completion of a scsi command to a non dasd device
- *
  */
-
 static void aac_srb_callback(void *context, struct fib * fibptr)
 {
 	struct aac_srb_reply *srbreply;
@@ -3684,13 +3678,11 @@ static void hba_resp_task_failure(struct aac_dev *dev,
 }
 
 /**
- *
  * aac_hba_callback
  * @context: the context set in the fib - here it is scsi cmd
  * @fibptr: pointer to the fib
  *
  * Handles the completion of a native HBA scsi command
- *
  */
 void aac_hba_callback(void *context, struct fib *fibptr)
 {
@@ -3749,14 +3741,12 @@ void aac_hba_callback(void *context, struct fib *fibptr)
 }
 
 /**
- *
  * aac_send_srb_fib
  * @scsicmd: the scsi command block
  *
  * This routine will form a FIB and fill in the aac_srb from the
  * scsicmd passed in.
  */
-
 static int aac_send_srb_fib(struct scsi_cmnd* scsicmd)
 {
 	struct fib* cmd_fibcontext;
@@ -3792,7 +3782,6 @@ static int aac_send_srb_fib(struct scsi_cmnd* scsicmd)
 }
 
 /**
- *
  * aac_send_hba_fib
  * @scsicmd: the scsi command block
  *
-- 
2.25.1

