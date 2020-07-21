Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB460C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8607C207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwF/uDv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgGUQmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbgGUQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26369C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so21824263wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mle0K9iX1gOzfM2GRPPq3JQOM3T1CbFjbMy5ihSTAjg=;
        b=LwF/uDv9JjgJ6tOJDx9S19wxQq0K6WzNDZpCbUVAZqOOS4y3+/5IW8fzBsD9ffptOr
         araaDs712E4vRx4iVqouJIqbT0hz8TmRmJFwDH6WUhlb2lhB+qBVJrpFGTxYqoriFtY7
         sdTVukS7onnFT5Dutv6rIEaRH96jGqfuZtG8d4MaMQGdDiTEjckB+NEZGn2rVqBjLwK9
         IO7zAAtGbAhX6FSwfcC43CZxI1pKxJsEuxAn/U67EpRRrAw4JaioxOqiv1YkXSt395xz
         AtSn3vm150mDHFLZUFql5vPIx787guBzfBPvxl9e6b75Av29txcSzx9LQLc8zADJSRZ5
         uTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mle0K9iX1gOzfM2GRPPq3JQOM3T1CbFjbMy5ihSTAjg=;
        b=WKk1EGIWVU9z805spCtGVIxX7ZtSO11LTs2tn2uvsy3UvVZr35f3G7uxClcErJrORT
         ZuoM4uXLMWXTikRhPiTM7KjbcxbgfV4QlQFkriHlcuQWDkcuhKFrF0jijL9BYBp5rb/i
         1f626HNHfJxwzfe0b5N9Rli01OyuZPraXHhqQLee6/vO2OqKETZBYpYxyG6pc1STDhUO
         WGkKk4mnPYWRfmssQs9AKUexBQZMLPqCkXj7XsJA2Mnyh0QMmXgziQPCKjPXWorLqbQO
         /aX6xX9yS8VltDZVOx7WtKsa3x1YhLFXliJ0yrAkDUuMvxfjj3+f5u6V8y8MTKDbs66E
         ln6w==
X-Gm-Message-State: AOAM533f2JO04ufU5SgPIJWn0XaMzWGlzDbuMtvDWpvaQOdz7JUGRFYJ
        z5D9uGpvq71hyjoEuKL0bInL8g==
X-Google-Smtp-Source: ABdhPJzSwRhnH3gmodgCQ9XqPBRP74SZfFE69iCmRfmpUeEdOUcZLk5iKSqwTxLYt3eTZxT+rj5U5Q==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr29595659wrw.29.1595349728890;
        Tue, 21 Jul 2020 09:42:08 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:42:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 10/40] scsi: pm8001: pm8001_sas: Mover function header and supply some missing parameter descriptions
Date:   Tue, 21 Jul 2020 17:41:18 +0100
Message-Id: <20200721164148.2617584-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions must follow directly after the header that documents them.

Fixes the following W=1 kernel build warning(s):

from  drivers/scsi/pm8001/pm8001_sas.c:41:
inlined from ‘pm8001_issue_ssp_tmf’ at  drivers/scsi/pm8001/pm8001_sas.c:919:2:
 drivers/scsi/pm8001/pm8001_sas.c:379: warning: Function parameter or member 'pm8001_dev' not described in 'DEV_IS_GONE'
 drivers/scsi/pm8001/pm8001_sas.c:379: warning: Excess function parameter 'task' description in 'DEV_IS_GONE'
 drivers/scsi/pm8001/pm8001_sas.c:379: warning: Excess function parameter 'num' description in 'DEV_IS_GONE'
 drivers/scsi/pm8001/pm8001_sas.c:379: warning: Excess function parameter 'gfp_flags' description in 'DEV_IS_GONE'
 drivers/scsi/pm8001/pm8001_sas.c:379: warning: Excess function parameter 'is_tmf' description in 'DEV_IS_GONE'
 drivers/scsi/pm8001/pm8001_sas.c:379: warning: Excess function parameter 'tmf' description in 'DEV_IS_GONE'
 drivers/scsi/pm8001/pm8001_sas.c:583: warning: Function parameter or member 'device_id' not described in 'pm8001_find_dev'
 drivers/scsi/pm8001/pm8001_sas.c:1000: warning: Function parameter or member 'dev' not described in 'pm8001_I_T_nexus_reset'

Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/pm8001/pm8001_sas.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 941f783897d8e..bcf169b26e31a 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -129,6 +129,7 @@ int pm8001_mem_alloc(struct pci_dev *pdev, void **virt_addr,
 	*pphys_addr_lo = lower_32_bits(phys_align);
 	return 0;
 }
+
 /**
   * pm8001_find_ha_by_dev - from domain device which come from sas layer to
   * find out our hba struct.
@@ -366,17 +367,15 @@ static int sas_find_local_port_id(struct domain_device *dev)
 	return 0;
 }
 
+#define DEV_IS_GONE(pm8001_dev)	\
+	((!pm8001_dev || (pm8001_dev->dev_type == SAS_PHY_UNUSED)))
 /**
   * pm8001_task_exec - queue the task(ssp, smp && ata) to the hardware.
   * @task: the task to be execute.
-  * @num: if can_queue great than 1, the task can be queued up. for SMP task,
-  * we always execute one one time.
   * @gfp_flags: gfp_flags.
   * @is_tmf: if it is task management task.
   * @tmf: the task management IU
   */
-#define DEV_IS_GONE(pm8001_dev)	\
-	((!pm8001_dev || (pm8001_dev->dev_type == SAS_PHY_UNUSED)))
 static int pm8001_task_exec(struct sas_task *task,
 	gfp_t gfp_flags, int is_tmf, struct pm8001_tmf_task *tmf)
 {
@@ -577,6 +576,7 @@ static struct pm8001_device *pm8001_alloc_dev(struct pm8001_hba_info *pm8001_ha)
 /**
   * pm8001_find_dev - find a matching pm8001_device
   * @pm8001_ha: our hba card information
+  * @device_id: device ID to match against
   */
 struct pm8001_device *pm8001_find_dev(struct pm8001_hba_info *pm8001_ha,
 					u32 device_id)
@@ -995,6 +995,7 @@ void pm8001_open_reject_retry(
 /**
   * Standard mandates link reset for ATA  (type 0) and hard reset for
   * SSP (type 1) , only for RECOVERY
+  * @dev: the device structure for the device to reset.
   */
 int pm8001_I_T_nexus_reset(struct domain_device *dev)
 {
-- 
2.25.1

