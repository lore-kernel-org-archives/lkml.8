Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3372AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01770206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlZk4sCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbgF3Nvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388396AbgF3NvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F589C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so18899677wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmSBURMhXlbXc5orPK26lnn3GrcbTsJzrTiKQM0CKuw=;
        b=wlZk4sCJ9LabE6MjBgDWfj+RAHJ7nlNR6gXF7qoifDB9OBorUV/WhRsFDUzsxdGC3k
         I+QATjMUHS6m99ukRPLizQEXD5V1Nd92XYCHMOAJ9mU+z6xf/ukS72a8n/il6//Ez6Ru
         DYrtSOwh4GkJBzr7ZcRIxMtyVSJqMuJ+wOZp6UVPd9rYzqnP3GOaSG829kAhJr3ZzxOX
         UvVnsVNZBiV6xsMa17D2OqtFmf/HMhxQVT/55iPrm7Ik4SZbMq5aTE6oyT8/gUW9F0av
         hnTOVhppnnQK7ZX27CXpmW5FWHS1RcJtiGxDSUZa64vF8C8mDDfFIcbmOMh7k955X53O
         hn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmSBURMhXlbXc5orPK26lnn3GrcbTsJzrTiKQM0CKuw=;
        b=TJnM9b1qzFCXGVzeixQUjHaqeNrBfjjwl1Y2/v9fcibBBAx36d52NrfngeBtREPcdo
         QW2WzlE2l+0gcdSd9fqZGIjvQzy6Qq9s827ARwNZFlemoHCFl9DsCh9TUli00sWNscXw
         rRS8AEtkJhHTSLr4ALHbssCXtEDJ/oaqc6mv/AKWyX/7XmcZscfI/uy2toZrnZCnXP24
         TULXH5PbaFihSuTBMc088AJCo9w/Cu9V3J3P/DcRaSfq5VuufP9ZyjMp+XgzU7Vzpzng
         aPjLgJhv2KJMT+r+rKJSY0XKiok3eemxCiAdMMn3U2oWFgrzN6j5lecxuMUH+aKkDPN0
         Dq+g==
X-Gm-Message-State: AOAM532XjVQzE5rINfE9TPYPkH8mf+idLbBWyUfZX65wDy3YySwpIbe0
        bl0iHt48cOQo/T0he0lsX+wnjg==
X-Google-Smtp-Source: ABdhPJw756eqLhggdvniBrPLPyxPwbKeDc28oktY7T6iJ36sLKgK7neqmV89L3KWmAqnXuhPUzSPOA==
X-Received: by 2002:a05:600c:21a:: with SMTP id 26mr17724220wmi.148.1593525083614;
        Tue, 30 Jun 2020 06:51:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 09/30] misc: mic: host: mic_x100: Move declaration of mic_x100_intr_init[] into c-file
Date:   Tue, 30 Jun 2020 14:50:49 +0100
Message-Id: <20200630135110.2236389-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
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

