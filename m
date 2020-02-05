Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A0CC3524D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B953F222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QpvwWoDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBEGJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:09:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40059 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgBEGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:09:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so626115pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 22:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mQKfMBsGIq7Hfer8YzXXFpOEX7eT6f9ZSgXgITsg2s=;
        b=QpvwWoDMxlep5jMdpHk2t9204huxy8F0ckz6nbF0g2vs+n9Y6CZvCuHBb3NOA65x6j
         slF0PIqixf3aAWfX2S1Qh8j43cgzlUyoeReEvly+gz/HSOOUr0x7fi8GlHQAeVodRD8T
         G6gbRbs81+Mmio/oAdKWEABHKcMDb47fBkDaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mQKfMBsGIq7Hfer8YzXXFpOEX7eT6f9ZSgXgITsg2s=;
        b=KqdLr2d20VmScfUhHulzFBxHpeFAJ+MKprnHV1tEv+pEgIxLv4LGVlV/jNnObC8BgE
         /xF0catdfFgyYCmdTHJqluXLBohg1ZHpPlnxYcFCDDgvh7c6hdKhTaPoFV5nSCsBa7xV
         x2wTGodV8ywaSKplHO07mThzccq59D/lNGdSgc9uRnHQJrvdHQVdCgBIAi0lmaw6pJrD
         xd3w3nz+iTCva7R+CMWlBCTZGx7Y8QFO+3JXuQYopSahWrK8QyQZo9fZAeOstgPgRYAk
         5ktdk5Js1Pa0R1rhMmRnKX1C+eOCvu0eUvK+e0WP05ds9819K9BAm10MQuVekF61ppd0
         AlSg==
X-Gm-Message-State: APjAAAWetcNUDKOcijX+ygxSW9qltI4rGt5P6evEat2oZMVTE5jsb7PC
        gd2aL5IcbFw5AgvbgBdj3sadjg==
X-Google-Smtp-Source: APXvYqxOoqdzPXFqh3VIm6fmR3wxTt7HovSZ/O22ZM9bUqJ7GHnPh/1EF0ADpOBTcMhz01PbBEh+Mw==
X-Received: by 2002:a63:e04a:: with SMTP id n10mr34505587pgj.341.1580882995522;
        Tue, 04 Feb 2020 22:09:55 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u26sm25680160pfn.46.2020.02.04.22.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 22:09:54 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH] genirq: Clarify that irq wake state is orthogonal to enable/disable
Date:   Tue,  4 Feb 2020 22:09:53 -0800
Message-Id: <20200205060953.49167-1-swboyd@chromium.org>
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
 kernel/irq/manage.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 818b2802d3e7..fa8db98c8699 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -731,6 +731,11 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
  *
  *	Wakeup mode lets this IRQ wake the system from sleep
  *	states like "suspend to RAM".
+ *
+ *	Note: irq enable/disable state is completely orthogonal
+ *	to the enable/disable state of irq wake. An irq can be
+ *	disabled with disable_irq() and still wake the system as
+ *	long as the irq has wake enabled.
  */
 int irq_set_irq_wake(unsigned int irq, unsigned int on)
 {
-- 
Sent by a computer, using git, on the internet

