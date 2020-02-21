Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3B6C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ACD20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272696;
	bh=Bl+eetMqLKM0BBK6wxdFNvrTkYLTGTwoLhuG4siGpk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vSvdMrAS0Cd7/oBoQ24ZL5Z9C9iK+oaf+8RypLrzsXloGjuXqL2h+AxeHY9Tua+E+
	 q1icO3E4oSk20yaVIef4gvD9DTBR8qXj1Bpu1s6wgjrchskLzq9FlHDWO4uGgdJDjQ
	 C9yb665vneMeyTcUB+eK8gOb0k0/zrrRDKN2I6Eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbgBUILe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731756AbgBUILb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:11:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1649C20722;
        Fri, 21 Feb 2020 08:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272690;
        bh=Bl+eetMqLKM0BBK6wxdFNvrTkYLTGTwoLhuG4siGpk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7cUHZy8gX1gl5tD57HUpedmCvEQDW2xOUCy7wNGyEtH4AWiT4RnRQj40+Nbh8Ifn
         9NHbpDYJAKaYoCf2tYVKHxPFgCnQkHKna13I2mJQf28/PIjCzCoqvI+7CpVO9gCPrx
         sVzckUfFCCsLksCm1uRs9gUddX5mxta0ZDN47iOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 238/344] scsi: ufs: pass device information to apply_dev_quirks
Date:   Fri, 21 Feb 2020 08:40:37 +0100
Message-Id: <20200221072410.935492657@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

[ Upstream commit c40ad6b7fcd35bc4d36db820c7737e1aa18d5d41 ]

Pass UFS device information to vendor-specific variant callback
"apply_dev_quirks" because some platform vendors need to know such
information to apply special handling or quirks in specific devices.

At the same time, modify existing vendor implementations according to the
new interface for those vendor drivers which will be built-in or built as a
module alone with UFS core driver.

[mkp: clarified commit desc]

Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Asutosh Das <asutoshd@codeaurora.org>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Bean Huo <beanhuo@micron.com>
Cc: Can Guo <cang@codeaurora.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Link: https://lore.kernel.org/r/1578726707-6596-2-git-send-email-stanley.chu@mediatek.com
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 3 ++-
 drivers/scsi/ufs/ufshcd.c   | 8 ++++----
 drivers/scsi/ufs/ufshcd.h   | 7 ++++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index a5b71487a2065..411ef60b2c145 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -905,7 +905,8 @@ out:
 	return err;
 }
 
-static int ufs_qcom_apply_dev_quirks(struct ufs_hba *hba)
+static int ufs_qcom_apply_dev_quirks(struct ufs_hba *hba,
+				     struct ufs_dev_desc *card)
 {
 	int err = 0;
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 6b5ec4bbcdb02..d9ea0ae4f374f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6721,7 +6721,8 @@ out:
 	return ret;
 }
 
-static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
+static void ufshcd_tune_unipro_params(struct ufs_hba *hba,
+				      struct ufs_dev_desc *card)
 {
 	if (ufshcd_is_unipro_pa_params_tuning_req(hba)) {
 		ufshcd_tune_pa_tactivate(hba);
@@ -6735,7 +6736,7 @@ static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
 	if (hba->dev_quirks & UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE)
 		ufshcd_quirk_tune_host_pa_tactivate(hba);
 
-	ufshcd_vops_apply_dev_quirks(hba);
+	ufshcd_vops_apply_dev_quirks(hba, card);
 }
 
 static void ufshcd_clear_dbg_ufs_stats(struct ufs_hba *hba)
@@ -6898,10 +6899,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	}
 
 	ufs_fixup_device_setup(hba, &card);
+	ufshcd_tune_unipro_params(hba, &card);
 	ufs_put_device_desc(&card);
 
-	ufshcd_tune_unipro_params(hba);
-
 	/* UFS device is also active now */
 	ufshcd_set_ufs_dev_active(hba);
 	ufshcd_force_reset_auto_bkops(hba);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 089013b758a19..5260e594e0b95 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -322,7 +322,7 @@ struct ufs_hba_variant_ops {
 	void	(*setup_task_mgmt)(struct ufs_hba *, int, u8);
 	void    (*hibern8_notify)(struct ufs_hba *, enum uic_cmd_dme,
 					enum ufs_notify_change_status);
-	int	(*apply_dev_quirks)(struct ufs_hba *);
+	int	(*apply_dev_quirks)(struct ufs_hba *, struct ufs_dev_desc *);
 	int     (*suspend)(struct ufs_hba *, enum ufs_pm_op);
 	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
 	void	(*dbg_register_dump)(struct ufs_hba *hba);
@@ -1047,10 +1047,11 @@ static inline void ufshcd_vops_hibern8_notify(struct ufs_hba *hba,
 		return hba->vops->hibern8_notify(hba, cmd, status);
 }
 
-static inline int ufshcd_vops_apply_dev_quirks(struct ufs_hba *hba)
+static inline int ufshcd_vops_apply_dev_quirks(struct ufs_hba *hba,
+					       struct ufs_dev_desc *card)
 {
 	if (hba->vops && hba->vops->apply_dev_quirks)
-		return hba->vops->apply_dev_quirks(hba);
+		return hba->vops->apply_dev_quirks(hba, card);
 	return 0;
 }
 
-- 
2.20.1



