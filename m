Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342CDC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105D0207CD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mIRfzIwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgGUQo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbgGUQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57D0C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so21824671wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ad78EnXv9h8fjtbbXBbN7LPQV5/Z4yR8tESs5C1s6bU=;
        b=mIRfzIwC5lXKHPYqj3Wv3vSmTGZB5Gk0wd0747TdqI/p0aDLP3Jr2F+G7YtZ3er/uS
         RwjBLxf3VuQllDK8t+RRVxtRTAhIhO7eTBWPUnpRwVZ1eBNGbMPtNYtNQdol1zc39joq
         GsrSQnvnhi5GskBBjvqrdShPYUInOsn8WvJnVySsNP/rV4gCbXWsvo3ppkxQrT2zVcE2
         iXt+ICEDJjuNjebMtRozAKXH+hw+gi/DQC16Fj7LJaCEhdnLf5hiwSqoAm6dNMvmpwBG
         /EkYC2rGLs4BTr7kzpNpCxh3REAZ0cExsf86UTxuXrIMpr0O29EIzExT0YoJ+6x3U2dL
         Vslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ad78EnXv9h8fjtbbXBbN7LPQV5/Z4yR8tESs5C1s6bU=;
        b=OXfpOHdXTT8sLwWsu1ONM/bkdE0+Uud0uxzBGHEm96CqVc/JvQSBd9JQFE4FffNMNa
         +te3PgOi37LGYHP2AuptSPkqq2vLZKHzc6KQDkAbDhCJ6zCemdmPLiClETWYZeglotvr
         LK7oEh8Yhgy3CPwW3bcFlegvPecXaBtxV7ms1h1GDGk3Z9RwMGqevUoPVSyXXxIZX9UF
         IpcMx7oPgleRl8azpmvrL/0NTQVBdX17fuG4sSYbCZuLlV0Nb9IEqM25E96QOSfjnQI5
         B2iuOAsnAIJfhI1D0OcATI43vI5aSFaQ8XI/1ajoeXZgviaiNuzOjSXiJ5GC6WAWgs+h
         34Fw==
X-Gm-Message-State: AOAM53355fl+BGuIHEVXYbY+ZHXkNuT6yKro0LupOUQuDrivtehJ+rzZ
        oWgOrrXtG25zyCz6PiYhUbPbQg==
X-Google-Smtp-Source: ABdhPJxl63xn+BN4Gni5a5wvPRlB6SXqtv1SiGIL99fykbtwiIA2JjlD1iU0HlbgK0SIABUh4sie3g==
X-Received: by 2002:adf:a299:: with SMTP id s25mr13274893wra.106.1595349739581;
        Tue, 21 Jul 2020 09:42:19 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:42:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 15/40] scsi: aic7xxx: aic79xx_core: Remove set but unused variables 'targ_info' and 'value'
Date:   Tue, 21 Jul 2020 17:41:23 +0100
Message-Id: <20200721164148.2617584-16-lee.jones@linaro.org>
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

Also remove 'tstate' which became unused after this patch.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic7xxx/aic79xx_core.c: In function ‘ahd_handle_seqint’:
 drivers/scsi/aic7xxx/aic79xx_core.c:1907:32: warning: variable ‘targ_info’ set but not used [-Wunused-but-set-variable]
 1907 | struct ahd_initiator_tinfo *targ_info;
 | ^~~~~~~~~
 drivers/scsi/pm8001/pm8001_hwi.c: In function ‘mpi_set_phys_g3_with_ssc’:
 drivers/scsi/pm8001/pm8001_hwi.c:413:6: warning: variable ‘value’ set but not used [-Wunused-but-set-variable]
 413 | u32 value, offset, i;
 | ^~~~~

Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 243e763085a61..c912d29b8bdf7 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -1904,8 +1904,6 @@ ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 		{
 			struct	ahd_devinfo devinfo;
 			struct	scb *scb;
-			struct	ahd_initiator_tinfo *targ_info;
-			struct	ahd_tmode_tstate *tstate;
 			u_int	scbid;
 
 			/*
@@ -1933,11 +1931,6 @@ ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 					    SCB_GET_LUN(scb),
 					    SCB_GET_CHANNEL(ahd, scb),
 					    ROLE_INITIATOR);
-			targ_info = ahd_fetch_transinfo(ahd,
-							devinfo.channel,
-							devinfo.our_scsiid,
-							devinfo.target,
-							&tstate);
 			ahd_set_width(ahd, &devinfo, MSG_EXT_WDTR_BUS_8_BIT,
 				      AHD_TRANS_ACTIVE, /*paused*/TRUE);
 			ahd_set_syncrate(ahd, &devinfo, /*period*/0,
-- 
2.25.1

