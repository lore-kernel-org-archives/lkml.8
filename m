Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26207C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0149A2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE5gU8Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgGAIdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgGAIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A4C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so21492526wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJCjtk9nocbEbC4CT5qyevqfhFFyrky+2iu8F1RJDRM=;
        b=hE5gU8Z2MoWdBUvNXDgpMd/Pzuy10wuMNp3S1726rdGfNdg2RzcAkde4aU4yTwvKHL
         1VkdxWo8Zl4po7+oGarpTxs4IEPCK3hj7pGJOwwf2ngia4OeKsQUykUxKriSKFHzboPL
         PYZRs0a96jiTOyrHkmF99tzXI6Jt8MBOjro7uU0FG2jOVUWm+8TY9rQEyDnwuMgRpjgI
         T0lEWgi+0oe3O5l5rrbpM/4uNVy1+nlPGzGLoHqYVyi5aDkYgWjobh2/63tnkhQRMUVI
         bEotVbBhPHlb/6Jw/ZszAQGOVgNc+uJw/8w2sSfyIZXaa1KZIgeqA3JUtC9JEl4MKQHe
         gV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJCjtk9nocbEbC4CT5qyevqfhFFyrky+2iu8F1RJDRM=;
        b=PvO2RhgnJvuQhzySWcGSpaFuzOO9mVqE94+lX9NO8bSTM1ScvDDVTKX/BPtYsLlGE8
         7mtmEWDml2OVtWw1YeniOAqsclMZZIzR0pNjwXkx1EHw92K0nzQrK+mayyxpvbITIPBw
         TF+yZcW159/+JLpNp2DAQRURItsKUhlo49DV4hEzvPCTHcuUuaRCA2iBFQJn2rjVH+37
         XDdUpyv8mpzE3NZ+XRtiYAhgpOlaO1oRgqjvHJoSR6HrOkcnCM/c+wH9vbhWj3sDw9kE
         zGX4/0w9iU1Kst0S1CGCjNqHp1l3VqltmJBp8isSEeADt7Om98vHwO5tombqqXiNg38T
         F6Fw==
X-Gm-Message-State: AOAM532XpHzsOgjKyC1HMApKAhqZZr8Z1zkwb8kkj33tfV+uR7ukytQH
        E2tL6kwZ8JAJV0rD3gzfP22VMw==
X-Google-Smtp-Source: ABdhPJzn5kMFtKnz5dhGBd9ToUsGVIUuJ2Lo5NQz39OSDXHv0Uo2SDvQTT2i++KogUBXps5KQblZjg==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr25322576wmf.103.1593592297239;
        Wed, 01 Jul 2020 01:31:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v2 11/30] misc: mic: host: mic_intr: Properly document function arguments
Date:   Wed,  1 Jul 2020 09:30:59 +0100
Message-Id: <20200701083118.45744-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mic_interrupt() and mic_setup_msix() have incomplete documentation.

Fixes the following W=1 kernel build warnings:

 drivers/misc/mic/host/mic_intr.c:42: warning: Function parameter or member 'irq' not described in 'mic_interrupt'
 drivers/misc/mic/host/mic_intr.c:42: warning: Function parameter or member 'dev' not described in 'mic_interrupt'
 drivers/misc/mic/host/mic_intr.c:188: warning: Function parameter or member 'pdev' not described in 'mic_setup_msix'

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/host/mic_intr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mic/host/mic_intr.c b/drivers/misc/mic/host/mic_intr.c
index 433d35dc17216..85b3221b5d407 100644
--- a/drivers/misc/mic/host/mic_intr.c
+++ b/drivers/misc/mic/host/mic_intr.c
@@ -37,6 +37,8 @@ static irqreturn_t mic_thread_fn(int irq, void *dev)
 /**
  * mic_interrupt - Generic interrupt handler for
  * MSI and INTx based interrupts.
+ * @irq:  interrupt to handle (unused)
+ * @dev: pointer to the mic_device instance
  */
 static irqreturn_t mic_interrupt(int irq, void *dev)
 {
@@ -180,7 +182,7 @@ static u8 mic_unregister_intr_callback(struct mic_device *mdev, u32 idx)
  * mic_setup_msix - Initializes MSIx interrupts.
  *
  * @mdev: pointer to mic_device instance
- *
+ * @pdev: PCI device structure
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-- 
2.25.1

