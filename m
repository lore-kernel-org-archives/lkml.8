Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30648C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1146922CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzgdXiYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgGUQoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgGUQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55463C0619DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so3553778wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5IQF79/Wv1mUPoTk8SqKeP9+hRJHp1Ffrp6oNURN+/A=;
        b=LzgdXiYXm8zVDI4RC+BrUGSVWlFLyJqYdB1iaOCBPFp/Y/9S7UKPB5YByb1mUk54yh
         0KOQXEzz/+8J9730MRxUhJFe36/HsFurYjUOAYWttJGuiiVMafqABPsf64z8fmo//U/P
         9dMjF1s+AcOWvFQedS1/ZhkjpOVbWRZzMbUnL0leFqrwVFSZ/KHpI5fLVzAFr7mKkDZw
         ga2fdoa5ASdnDPb9vv4MftdM5whshVCZta0JKHTRqGBHoTWtpMKVRoMvMiosJJAtXRKH
         iCe/e7GZ0gNVTRpw3jQ3qbdMTQQRs+lsZeX1LTFiTreTV+/Htk6bQV2X4o+7x2ojW/DZ
         deuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5IQF79/Wv1mUPoTk8SqKeP9+hRJHp1Ffrp6oNURN+/A=;
        b=XZRTpFAm2ttj6cXqPxTlFzFWgIGjgA+2sUMRQZR0J4490pq5isHHhHTjhjulaAIREz
         4HH6JFgOUYbPmrZQQCf24xa/2DrUKRLBJv0B2+GyuigO8/GvXYJ2AbfLKUwEPsVP0G2M
         tALegImw2DlfUhzeHWZsHcgn1sMqwsS6QwNVfSPX2xKPGdm6lmXyNjnTwo/xDNNbhKBJ
         tXuegeb5uuTA7HF10HeZlSXMT1uwJSbXoPXskp4gmGKeu25mwK5MiAy+gX2gyIXyhJfe
         iQur5zpGrLlTAhOel6B6N31kGrkcjn2+xWuZaLzW7ZH57X4VNOxd5fI23tyyXVF8BmZS
         2eEA==
X-Gm-Message-State: AOAM5334A5GIRMGlyVQ7JMnAqwGTiBkFSz3fefO+8pMOU9TZZMHWABlk
        /AtaJ8c9x43HphR0ggStV3XVmw==
X-Google-Smtp-Source: ABdhPJw+qZ7BDG+pJAcG5mU2zCbypO4IB49a+l8+utkE5KdpCUEX6HeBmrTTOhYpokyvCCflsy0Bkw==
X-Received: by 2002:a1c:e209:: with SMTP id z9mr4858080wmg.153.1595349752090;
        Tue, 21 Jul 2020 09:42:32 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:42:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 24/40] scsi: pm8001: pm8001_hwi: Remove unused variable 'value'
Date:   Tue, 21 Jul 2020 17:41:32 +0100
Message-Id: <20200721164148.2617584-25-lee.jones@linaro.org>
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

Hasn't been used since 2009.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/pm8001/pm8001_hwi.c: In function ‘mpi_set_phys_g3_with_ssc’:
 drivers/scsi/pm8001/pm8001_hwi.c:415:6: warning: variable ‘value’ set but not used [-Wunused-but-set-variable]

Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index e9a939230b152..3368106320194 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -412,7 +412,7 @@ int pm8001_bar4_shift(struct pm8001_hba_info *pm8001_ha, u32 shiftValue)
 static void mpi_set_phys_g3_with_ssc(struct pm8001_hba_info *pm8001_ha,
 				     u32 SSCbit)
 {
-	u32 value, offset, i;
+	u32 offset, i;
 	unsigned long flags;
 
 #define SAS2_SETTINGS_LOCAL_PHY_0_3_SHIFT_ADDR 0x00030000
@@ -463,7 +463,6 @@ static void mpi_set_phys_g3_with_ssc(struct pm8001_hba_info *pm8001_ha,
 	so that the written value will be 0x8090c016.
 	This will ensure only down-spreading SSC is enabled on the SPC.
 	*************************************************************/
-	value = pm8001_cr32(pm8001_ha, 2, 0xd8);
 	pm8001_cw32(pm8001_ha, 2, 0xd8, 0x8000C016);
 
 	/*set the shifted destination address to 0x0 to avoid error operation */
-- 
2.25.1

