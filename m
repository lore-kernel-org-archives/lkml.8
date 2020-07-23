Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FF4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F09520792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6ge4Ti8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgGWMY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgGWMYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:24:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E23EC0619E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:24:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so4976790wrl.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5l35wuUCv0+znhq/VnSUhgz/EG/YdhUiwAApvAIamk=;
        b=r6ge4Ti8+kXThHu3tpFrY2Ryo0k3bAW1ptY+IUg7BKnhP9feLqbB4Ki0VPkdi4Rfvh
         qiERb1MCbRVWRbqpr7Li7FdfNx7sNXcrZZKQ+ZYrZN9Q/wXNqcAOCgwy/xPcjVmHEwHS
         SjZDEHqnvq2ZirIeFiV8qz605QE95ZmTRcZHXYEmR8UknIZC1GxppBcSd1EAo+bXchNf
         p5TCHVosIiUnxOj1mPS2h0O9qK7hcFZu1MdueLtyLnnPUdd0Ld1xbJoIGkcmxW8osJbq
         OsFQnujym60qi7zEglAXs6H9nCYvCE7quvmqEBO9TWEnoz0xOy8mjr/cKra0Rcz4LUXV
         Mb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5l35wuUCv0+znhq/VnSUhgz/EG/YdhUiwAApvAIamk=;
        b=jChzt4I/VLMOn2gotJb+PivBoU/VXKRbguuB7noqhkmJ6scalhc6XAwfAcpy2ZoYs5
         Y6TOLBZpGJSshan6029cyO9J79DYt88ymC97yLKoae/mX3mv0ocDHCuoZb66QbKdEyst
         3CrfMkB6N5Z4rwX3kc8P19TyMc61ksUzzwW+33XieqAu+W7A18VR19q52z21oqxH/BTk
         ServZQZi18Hjg3l7k7QCD3V+RI7A42Cwftb+D7d+8161vAtnRWQGa+ETzUtkPmrQM5sB
         2mj/eF1HsG0lTxqUh0R799OblEGadjNQF2NOJpbaVB1I6FU9bcfyQRGgvvPovFZF0ua6
         ehmA==
X-Gm-Message-State: AOAM5335FoeA5bEviiUrgApqrUW92+MTeJ43SH67V/Ua0Jv9q7EbdH9o
        y8ED2dZx0uDaBGz1h4+Cvquv0w==
X-Google-Smtp-Source: ABdhPJw7cFW8uyR4m7st3tXI308gCTAkeFzpp+TnCDHQ3/qHkQMnoiCpCil6wZfPRUOhm/y+04iOjQ==
X-Received: by 2002:a5d:6248:: with SMTP id m8mr181272wrv.317.1595507093339;
        Thu, 23 Jul 2020 05:24:53 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:24:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 03/40] scsi: ufs: ufs-qcom: Demote nonconformant kerneldoc headers
Date:   Thu, 23 Jul 2020 13:24:09 +0100
Message-Id: <20200723122446.1329773-4-lee.jones@linaro.org>
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

 drivers/scsi/ufs/ufs-qcom.c:253: warning: Function parameter or member 'hba' not described in 'ufs_qcom_host_reset'
 drivers/scsi/ufs/ufs-qcom.c:383: warning: Function parameter or member 'hba' not described in 'ufs_qcom_cfg_timers'
 drivers/scsi/ufs/ufs-qcom.c:383: warning: Function parameter or member 'gear' not described in 'ufs_qcom_cfg_timers'
 drivers/scsi/ufs/ufs-qcom.c:383: warning: Function parameter or member 'hs' not described in 'ufs_qcom_cfg_timers'
 drivers/scsi/ufs/ufs-qcom.c:383: warning: Function parameter or member 'rate' not described in 'ufs_qcom_cfg_timers'
 drivers/scsi/ufs/ufs-qcom.c:383: warning: Function parameter or member 'update_link_startup_timer' not described in 'ufs_qcom_cfg_timers'
 drivers/scsi/ufs/ufs-qcom.c:1738: error: Cannot parse struct or union!

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 139c3ae05e956..d0d75527830e9 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -246,7 +246,7 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 	mb();
 }
 
-/**
+/*
  * ufs_qcom_host_reset - reset host controller and PHY
  */
 static int ufs_qcom_host_reset(struct ufs_hba *hba)
@@ -375,7 +375,7 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 	return err;
 }
 
-/**
+/*
  * Returns zero for success and non-zero in case of a failure
  */
 static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
@@ -1723,7 +1723,7 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 }
 #endif
 
-/**
+/*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
  * The variant operations configure the necessary controller and PHY
-- 
2.25.1

