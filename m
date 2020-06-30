Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA0AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3F0206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmUE4xRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgF3Nvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388412AbgF3Nv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B84AC03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so9004980wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJCjtk9nocbEbC4CT5qyevqfhFFyrky+2iu8F1RJDRM=;
        b=RmUE4xRRiwVsmYoHLqv4r8cSKHDYrBB658nvefHkaSclGp0eS91gB+SAjnzDGVUbpE
         kdr/4pBlbcXLjisWngtOtitsAZFIpCmfZaYhQEdP1rkjRpxU1wj1JnQcqawvmOp08ZIe
         JHNA4T0IV8DLKk3SXIU+0TtuyX/ExSs0VvHDP3FNG/f1VfGCOBoHEpDTTbZesPaUe08R
         I6jtzOgeQr+LSTwrI4W7JVNOsHCBXa/498wBwMdpZvkemTceOt7S8bL9ELpmUO1oE3Wu
         0sm6241qSpfPTCe+1wBtH8+48VHMraGuS2IYB7cLSaF/SXRnX51aU0xsaTZBcfgRIRxI
         VeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJCjtk9nocbEbC4CT5qyevqfhFFyrky+2iu8F1RJDRM=;
        b=qkZ9mmp0lWqQ8C0ss+BwVDeZlHiKP6cfNmgkTut2U7D7NZ74qjCbi4OuoF4+rA1Z/7
         /4NLP4lDZ7Z6I5wjx+INWyI5CdVfzG6xDiNtcrYT8xPykTgHMtx65pGi7Qd2j+l9eiso
         NyIQ52I6lLbx4a41n+FJnewttIzRJFsxuih/CBgS7Ogi7/Kywcm3uFztX2+gIL0IGdLH
         iblv7X5Xres+MpG/VpChc56VfvwJtWqjc88FsVW6QO6V8XyyW7hKt23uD506TKUZvW6n
         u8fG3ML2d4Q1XeUIHAOCG0PmSBU7lASh2qHBvD+KcnLd28QiA/KUWhPhbpqOzuBDcEmZ
         hOqw==
X-Gm-Message-State: AOAM531zFIR1CwB4JHUKUznzJBdnICB7ERUwGB0buUvmfmwBOD+aHmqW
        7T5Cy+AvwEC0nanpmh9UISWFmA==
X-Google-Smtp-Source: ABdhPJx2kkPJCP6s7Z7K+iQmwN4Qs9Wxn6yYUEBx+rYFR+LhJUUCrVnVwUsObMJQldJQDD2uO1u9wg==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr22596798wrt.5.1593525085786;
        Tue, 30 Jun 2020 06:51:25 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 11/30] misc: mic: host: mic_intr: Properly document function arguments
Date:   Tue, 30 Jun 2020 14:50:51 +0100
Message-Id: <20200630135110.2236389-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
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

