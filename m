Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0857CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD6B206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Im8mUJ2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgENIWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:22:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45449C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:22:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so2671582wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k8mN2LzDGdESlrPmoeh28g5LnWiU2ms8gKIo8DdwscE=;
        b=Im8mUJ2eggAAkZI/v80HzLPX9qqa36sDqko1J2LXPgGJ01bIFxWXlgiIUUXNItclyq
         YJlRxzQgOkAf/kpLwuBYUf5dtc+m0h2EEcAuX1bb4AUAkdTlnA29b+TMMrpi1fdeq+ma
         TxjSHAWmQy1WhQjz7iwmbrnUQL6tqPSO239Q9Abu4vr88QoBJRj1WB0mRCOoy2qFREeh
         xr2nuf1+hw65YDQL5CYVPpz6MXv+QWERLPpjdItghoMqKAp3d426gVFkWMtd315hgG1R
         4W5ayj35Q36DvrMwuQvCWWtefd4e28AsudKQBxPJ/kSU4emTzmR3iLPDU0tJJeuYDjH9
         +M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k8mN2LzDGdESlrPmoeh28g5LnWiU2ms8gKIo8DdwscE=;
        b=jliJL1wiZzl/Uo8eXbBzKbH2RY9A8PkHOs4g1p5tFisdrwGS1QOtSCDU3q68y/BqIQ
         l/Mzs4ocmn19wSt3I0GIJ8F8aOPEeovRTmLzlw88zGbYqsLw7VhOwksPsMyTN7Q+2XY/
         OjzqH4I4tpjCWUECKg752yjkdCHX21nl/bgY8tbYid/H84mUICA+buw6WRN9U8W9q3ff
         7FG+mNM6azZVsj3sCsGc1l+73heFzCa72mVOlzPKyWznylH0NlAE7eGsZJg1cmGmPwr3
         mrRMQSWs6K0v4EKUWRC0MGyU+No/pnwebG3bJY3reIiJ9DDFy+lVkuaRBpZ+HTIIlu4K
         /S8g==
X-Gm-Message-State: AOAM533jKdZcEhsiJ3jMTedJEIfNb7DTpxkJhNRua2La0Fv4RLV6tR5b
        CHk1YHG9CGOeKrNFlgdtPvrbRG7iKaAVTQ==
X-Google-Smtp-Source: ABdhPJxIKdKece7W45CJ1lsjnCRxxcI5n5xTf/PCcBjsJUpQs1DS6rnRmslbg7l2wJ6hCwF2p0o++w==
X-Received: by 2002:a05:6000:85:: with SMTP id m5mr3753246wrx.281.1589444532801;
        Thu, 14 May 2020 01:22:12 -0700 (PDT)
Received: from lmecxl0524.lme.st.com (2a01cb058702ff00bc4b798f4f30d41e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:bc4b:798f:4f30:d41e])
        by smtp.gmail.com with ESMTPSA id l18sm9170002wmj.22.2020.05.14.01.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:22:12 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, tglx@linutronix.de, alexios.zavras@intel.com,
        will@kernel.org, maz@kernel.org, steven.price@arm.com,
        etienne.carriere@linaro.org
Subject: [PATCH 2/2] firmware: psci: support SMCCC v1.2 for SMCCC conduit
Date:   Thu, 14 May 2020 10:21:09 +0200
Message-Id: <20200514082109.27573-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514082109.27573-1-etienne.carriere@linaro.org>
References: <20200514082109.27573-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update PSCI driver to support SMCCC v1.2 reported by secure firmware
and indirectly make SMCCC conduit properly set when so. TF-A release
v2.3 implements and reports SMCCC v1.2 since commit [1].

Link: [1] https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=e34cc0cedca6e229847c232fe58d37fad2610ce9
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/psci/psci.c | 14 ++++++++++----
 include/linux/psci.h         |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2937d44b5df4..80cf73bea4b0 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -409,11 +409,17 @@ static void __init psci_init_smccc(void)
 	feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
 
 	if (feature != PSCI_RET_NOT_SUPPORTED) {
-		u32 ret;
-		ret = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
-		if (ret == ARM_SMCCC_VERSION_1_1) {
+		ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
+
+		switch (ver) {
+		case ARM_SMCCC_VERSION_1_1:
 			psci_ops.smccc_version = SMCCC_VERSION_1_1;
-			ver = ret;
+			break;
+		case ARM_SMCCC_VERSION_1_2:
+			psci_ops.smccc_version = SMCCC_VERSION_1_2;
+			break;
+		default:
+			break;
 		}
 	}
 
diff --git a/include/linux/psci.h b/include/linux/psci.h
index a67712b73b6c..c7d99b7f34ed 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -24,6 +24,7 @@ bool psci_has_osi_support(void);
 enum smccc_version {
 	SMCCC_VERSION_1_0,
 	SMCCC_VERSION_1_1,
+	SMCCC_VERSION_1_2,
 };
 
 struct psci_operations {
-- 
2.17.1

