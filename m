Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C79FC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA4921741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iK0F5TKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBFTPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:15:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38602 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFTPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:15:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so3602694pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kttq95JJMgSrLLGiYe2dDFloBfbkzPtd5qLVcbb/oxM=;
        b=iK0F5TKRcEFCg/q6knGyypxXgg/T5g020rre7/PPnqK99UpUSw3AOb8htr8ceJNCSy
         Q+Xxby3XbbPIbDtWsK2bvZrmm8Hj3xU3xQR3umcHPQRWg6+wrQQfdKONFJmnHwn/nHOs
         5PLXDCARUEdp9HUiBAZ9wTfpeso6EzrJG6RRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kttq95JJMgSrLLGiYe2dDFloBfbkzPtd5qLVcbb/oxM=;
        b=rKJdkILRw2vkvNBNv/AVH0yWQn9X8td9FhrfFdsh3homu6amPC4Lwlzk7fdGexvECu
         MseLNV6Xuef7H6gpgEwcyOagYrfVOBa1dqov2rqglIdDrVhMqDu1zYWn3/CR5aKEaQpV
         uQo3BBTn5pHEaVTzoIFp8qhH18nT5PosT05m6PXlHinzRecdEdFX4UCNJr30POFa5/SD
         QmRx91TgsF2E5okSCaX1NK9w6EFPsFJ370Ty6B+8qz5fnY8BLtr1wEUFKmKRL94mq4DL
         pzkDuOzkgJycpsSb8oTj+Xhw0hL0Z6p0hT11jqqyFJq35vERTThtPeYFmVO5Bwc0jePF
         J5dg==
X-Gm-Message-State: APjAAAUwyXObzO0wAFVFC8Yb/0lOGLdnEDxUvBuAGXzjPPejRGJicBBl
        eqmbyAJPyL1XanE/8a8XVC2UpA==
X-Google-Smtp-Source: APXvYqzMIMztX/eSaIFKYBzf5jMxem4ngtPYJfpstOGEW3fwchMPDC0lt1UaVtT7e/geJODEC5Fnew==
X-Received: by 2002:a63:64c5:: with SMTP id y188mr5248612pgb.10.1581016523239;
        Thu, 06 Feb 2020 11:15:23 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r9sm157331pfl.136.2020.02.06.11.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:15:22 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v2] genirq: Clarify that irq wake state is orthogonal to enable/disable
Date:   Thu,  6 Feb 2020 11:15:21 -0800
Message-Id: <20200206191521.94559-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's some confusion around if an irq that's disabled with
disable_irq() can still wake the system from sleep states such as
"suspend to RAM". Let's clarify this in the kernel documentation for
irq_set_irq_wake() so that it's clear that an irq can be disabled and
still wake the system if it has been marked for wakeup.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Added the last sentence from tglx

 kernel/irq/manage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 818b2802d3e7..e1e217d7778c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -731,6 +731,13 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
  *
  *	Wakeup mode lets this IRQ wake the system from sleep
  *	states like "suspend to RAM".
+ *
+ *	Note: irq enable/disable state is completely orthogonal
+ *	to the enable/disable state of irq wake. An irq can be
+ *	disabled with disable_irq() and still wake the system as
+ *	long as the irq has wake enabled. If this does not hold,
+ *	then either the underlying irq chip and the related driver
+ *	need to be investigated.
  */
 int irq_set_irq_wake(unsigned int irq, unsigned int on)
 {
-- 
Sent by a computer, using git, on the internet

