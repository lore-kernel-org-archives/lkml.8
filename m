Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C61C43445
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF9B20888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgTx2AQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgGWMZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgGWMZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9948C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so4977917wrl.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7HEL4xrEwuTkMeUXu16IXZ1qnXvn6HqyFPGQLsjThQ=;
        b=NgTx2AQ5OQPVWBHc7CmEJc5GGfGEO/5DyHik2uTF6EgETZV6AdtbtCDj0FSiyR51Cn
         tTyhu3J3XVFcqJss3c0b5hiXkqP5m1YVDeNPujGQynIqxmFBRhI6h8LdSboYukfZS/4O
         yO3mINgrz51r4097D6OtYhLHPuZgvb0LTUwVhV2LxObdnlvyW5aivwp3UwkGe2+ABYEF
         1mBn5mdSXsnfjbrrJwde9b2Kwxb2BhEtuXksHiDJEyJ1/xjjHtjuTOsKe4Q5EVcUqw7q
         Na8B/5PpPocWEXF2vzj/SYjLgRQaGXekwdU6mU2hYIRu1E4HPiOaVH/jyrKDjbjzTcZO
         m4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7HEL4xrEwuTkMeUXu16IXZ1qnXvn6HqyFPGQLsjThQ=;
        b=RZ6/zUjGwR8U1R+hQP9/Oz4/YPEPj0EPaKAy8hvdNk/Q09xgPLuxSIHinMhwiHV7c/
         DNUMwKsty8kxcSMMFSqRralRHQRP/DAyDdV32CjaISzjrEAH1yUqT27/eWy43GVJy1UW
         bdnjtjgVe+/NVCGK1FTGD1l8WfnMnzzXV/v31ekpUNFPUF+CpRsXIHK4W163SZlbr0nl
         g404XpPj9m7WJ5z5K4fHgFdDiFxUMYP5ZZ8NzesnsvCvNtI2QBwwaA6bnmIjaUfCa53l
         Zx0eslMGQG+r3PcyPCv+LL6X+yzGmq/xsbUgg8fuosNhPvgWmnB4/wPYwDGFul/YdHiG
         tZLg==
X-Gm-Message-State: AOAM531ZbhiqCm9ZzQLXTG5S34hHiAHwPbVLdT8KDdVUOjsZxfh1KnlH
        0KUIhRz1Njfif6HR7d/oaqh4ag==
X-Google-Smtp-Source: ABdhPJyh4nBcbknxwuqgi6BDewjRtpccybnkpPvqru8OaJoltE93qD4sMfXoKyIid7IznS1CwxsnqA==
X-Received: by 2002:adf:bc54:: with SMTP id a20mr3827338wrh.227.1595507117476;
        Thu, 23 Jul 2020 05:25:17 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Subject: [PATCH 23/40] scsi: bfa: bfa_ioc: Staticify non-external functions
Date:   Thu, 23 Jul 2020 13:24:29 +0100
Message-Id: <20200723122446.1329773-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bfa/bfa_ioc.c:5023:1: warning: no previous prototype for ‘bfa_diag_intr’ [-Wmissing-prototypes]
 5023 | bfa_diag_intr(void *diagarg, struct bfi_mbmsg_s *msg)
 | ^~~~~~~~~~~~~
 drivers/scsi/bfa/bfa_ioc.c:6966:1: warning: no previous prototype for ‘bfa_flash_sem_get’ [-Wmissing-prototypes]
 6966 | bfa_flash_sem_get(void __iomem *bar)
 | ^~~~~~~~~~~~~~~~~
 drivers/scsi/bfa/bfa_ioc.c:6979:1: warning: no previous prototype for ‘bfa_flash_sem_put’ [-Wmissing-prototypes]
 6979 | bfa_flash_sem_put(void __iomem *bar)
 | ^~~~~~~~~~~~~~~~~

Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bfa/bfa_ioc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index 3ce281a02d5bb..10c12b5a36b84 100644
--- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -5019,7 +5019,7 @@ diag_portbeacon_comp(struct bfa_diag_s *diag)
 /*
  *	Diag hmbox handler
  */
-void
+static void
 bfa_diag_intr(void *diagarg, struct bfi_mbmsg_s *msg)
 {
 	struct bfa_diag_s *diag = diagarg;
@@ -6962,7 +6962,7 @@ bfa_raw_sem_get(void __iomem *bar)
 
 }
 
-bfa_status_t
+static bfa_status_t
 bfa_flash_sem_get(void __iomem *bar)
 {
 	u32 n = FLASH_BLOCKING_OP_MAX;
@@ -6975,7 +6975,7 @@ bfa_flash_sem_get(void __iomem *bar)
 	return BFA_STATUS_OK;
 }
 
-void
+static void
 bfa_flash_sem_put(void __iomem *bar)
 {
 	writel(0, (bar + FLASH_SEM_LOCK_REG));
-- 
2.25.1

