Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B78AC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACB0206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnCu+Wb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgGWMZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgGWMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B9BC0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so4225554wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zeBAm1L7XVJ6IVI2TzsfeuXstruzEbtoUmoVsIn2ru8=;
        b=EnCu+Wb38b4dsqdsV/NDDN7jk4P11BTBfwFzIGhJwSa5HDLOreoGHFr+sZSji+0tgd
         +NcBdAvxWhDLzfVnrObozeGKSeU7mTKiRnnJx6DsiHNXmPxrR2yhvd86qUAPaio5LN+e
         R+Ug97vVFL4qvD8LKtWxN0JBVCS6yOl9exg04OsMljHZzlVq53mrlQRDuvffpYagfurV
         9a6Ydcr1LePnkVSPYyAmqWQ0sSzGXxKkhOfL4Smnlbeif+OrtsW64tk+1WO1YaB60ec9
         Vj7I/M0od+PGt3AUpVR+97u9fyO45j2/qXByvA0nfOepgtcgBBMM65/YXMh5iQ6VVpRU
         HLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zeBAm1L7XVJ6IVI2TzsfeuXstruzEbtoUmoVsIn2ru8=;
        b=lr65DXj1uC9Vwr+s3RCZ8t3Zm89TKMnF0nxVDfmUHqOei5vezGFwDShmqccBye3lrq
         s25a0HxeUiR+0WyxuI+44y8PgBgB0+wZvmqxrMCA4r5Sg9nj/qTUX28Fr/KYcgsrEj0K
         MofJxmf50S7aNsqDGTQmovfgxk/pyiKl/oXKVVOXb5altUALAlVximakTyT334yzNnxv
         aFaTcoxRNZrauFJA14SIwIA3pNB2pWVwpRW3i1I5qWoyo2pms2+2Q68FV2ydnIZxhZhF
         f8TgBJsP3F9+iYaYrJgAYI/kqnP96iq7qjN6TO5QAfvcbzYKPAxoLgFYUeZ+v6jWtsyU
         NbXQ==
X-Gm-Message-State: AOAM533YVpz19NVIkK5xPfQdxxb1WBpAS4fY7kavkWZCq1B8loKEruwW
        AVfa6G/gmBwLoWkcb0Ge8UjN4A==
X-Google-Smtp-Source: ABdhPJzLU3UY01dM0brcV0HKbf0KdBIOoTZNeWuxveErkT/5gB9xuWssPL6fEMHzlDUDTgRNjN48zA==
X-Received: by 2002:a1c:68c2:: with SMTP id d185mr3847154wmc.24.1595507131102;
        Thu, 23 Jul 2020 05:25:31 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Subject: [PATCH 34/40] scsi: bfa: bfa_core: Demote seemingly unintentional kerneldoc header
Date:   Thu, 23 Jul 2020 13:24:40 +0100
Message-Id: <20200723122446.1329773-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the source file and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bfa/bfa_core.c:1245: warning: Function parameter or member 'bfa' not described in 'bfa_iocfc_qreg'
 drivers/scsi/bfa/bfa_core.c:1245: warning: Function parameter or member 'qreg' not described in 'bfa_iocfc_qreg'

Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bfa/bfa_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfa_core.c b/drivers/scsi/bfa/bfa_core.c
index fb4c469bd89fc..6846ca8f7313c 100644
--- a/drivers/scsi/bfa/bfa_core.c
+++ b/drivers/scsi/bfa/bfa_core.c
@@ -1237,7 +1237,7 @@ bfa_iocfc_disable_cb(void *bfa_arg, bfa_boolean_t compl)
 		complete(&bfad->disable_comp);
 }
 
-/**
+/*
  * configure queue registers from firmware response
  */
 static void
-- 
2.25.1

