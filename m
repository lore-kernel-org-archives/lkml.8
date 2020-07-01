Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A6AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42732074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUgIF8hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgGAIbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgGAIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DD7C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so22292072wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmSBURMhXlbXc5orPK26lnn3GrcbTsJzrTiKQM0CKuw=;
        b=vUgIF8hwOgcwmDoUiPlF27BmC4izYUFFVsAn0GiT+e09TKGwFCpy0Vbj2LlnPWzwR7
         VE6hQV2F70/LO9AlmcVydtYKKi9I4aPOIOWNYB3JZ5FoFnHYC2HjYgVV8rrBZMO9KgxB
         Iu5EzH1En+dGNljbnnBy1DShMHsBfQTi3R8j6mjpZY9/7MFVPXWpCYU8vn3BtGknt8Jz
         odMlQDuh+2I+XRH2OokpNjJhwpAM6paRM2JqsZqOHM2Y6K+FF8G9biKaT4X2XLG1fPzI
         1f9wQtSZYDR+jHMyloha67LGdkR51TxF/kA8HIo6Th6ufZX4LxrKzza6PoQgH/ValJ7T
         2P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmSBURMhXlbXc5orPK26lnn3GrcbTsJzrTiKQM0CKuw=;
        b=YEN6+ieB/VDfcx+WEtQBYLVpIIX89DTxQvj0Dlrz0VLt1ORu0YCtHG/0+qiGRXstuL
         xNXvw5FhukFixMHapkm3SKNleUAG4VARPA/LSvvKoqwastthYHv3TdK/ArnMexj3Xt7A
         2HqrDnWLJLs9ZXkPN7Wg8bV8Ox8rcSAsjBdZm7rzp7AXDWby8jnI7ve9xCqc0XywP5k+
         /6UQzomz1KPjwso30t+EUFRaKeEe8mQxKQ/V9ehYF50kr0kKub0ZBicWfZDj2Rt4nZF7
         rZxNh3U9X5L3OVQOoB7kyLolWa1aZfvGeUxnz1wmSr2tmJc1Go3IUkoy4gb2FBZloUzE
         o2zA==
X-Gm-Message-State: AOAM532FBpu1pmEG0HdtMB96LpRA09XCaxjotYHZTvQFzbuky1ubjhE5
        98mHeUq+FPF6GiBfL1yUAAX8ww==
X-Google-Smtp-Source: ABdhPJwoGqmeBkKFR6E9KWNDDD5aFH788XLW+bYm17wM2BpDJriZaknI4m5Joa2HKSJiNFR7wpyT9g==
X-Received: by 2002:a05:600c:414f:: with SMTP id h15mr15106099wmm.82.1593592294885;
        Wed, 01 Jul 2020 01:31:34 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v2 09/30] misc: mic: host: mic_x100: Move declaration of mic_x100_intr_init[] into c-file
Date:   Wed,  1 Jul 2020 09:30:57 +0100
Message-Id: <20200701083118.45744-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mic_x100_intr_init[] is only ever used in mic_x100.c, so instead
of listing to the compiler complain about unused static arrays
simply move it into the c-file for direct consumption.  This way
it can stay 'static'.

Fixes the following W=1 kernel build warning:

 In file included from drivers/misc/mic/host/mic_main.c:17:
 drivers/misc/mic/host/mic_x100.h:70:18: warning: ‘mic_x100_intr_init’ defined but not used [-Wunused-const-variable=]
 70 | static const u16 mic_x100_intr_init[] = {
 | ^~~~~~~~~~~~~~~~~~

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/host/mic_x100.c | 9 +++++++++
 drivers/misc/mic/host/mic_x100.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/mic/host/mic_x100.c b/drivers/misc/mic/host/mic_x100.c
index d18cda9669121..843ce13750158 100644
--- a/drivers/misc/mic/host/mic_x100.c
+++ b/drivers/misc/mic/host/mic_x100.c
@@ -17,6 +17,15 @@
 #include "mic_x100.h"
 #include "mic_smpt.h"
 
+static const u16 mic_x100_intr_init[] = {
+		MIC_X100_DOORBELL_IDX_START,
+		MIC_X100_DMA_IDX_START,
+		MIC_X100_ERR_IDX_START,
+		MIC_X100_NUM_DOORBELL,
+		MIC_X100_NUM_DMA,
+		MIC_X100_NUM_ERR,
+};
+
 /**
  * mic_x100_write_spad - write to the scratchpad register
  * @mdev: pointer to mic_device instance
diff --git a/drivers/misc/mic/host/mic_x100.h b/drivers/misc/mic/host/mic_x100.h
index 1f727a6f609c7..aebcaed6fa728 100644
--- a/drivers/misc/mic/host/mic_x100.h
+++ b/drivers/misc/mic/host/mic_x100.h
@@ -67,15 +67,6 @@
 #define MIC_X100_FW_SIZE 5
 #define MIC_X100_POSTCODE 0x242c
 
-static const u16 mic_x100_intr_init[] = {
-		MIC_X100_DOORBELL_IDX_START,
-		MIC_X100_DMA_IDX_START,
-		MIC_X100_ERR_IDX_START,
-		MIC_X100_NUM_DOORBELL,
-		MIC_X100_NUM_DMA,
-		MIC_X100_NUM_ERR,
-};
-
 /* Host->Card(bootstrap) Interrupt Vector */
 #define MIC_X100_BSP_INTERRUPT_VECTOR 229
 
-- 
2.25.1

