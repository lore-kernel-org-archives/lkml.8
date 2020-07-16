Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046FC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34879206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dW8P0Vke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgGPEVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgGPEU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:20:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68973C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:20:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 8so5608910ybc.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t5BsHfPfwFVdHmiG0W5J1oIj8NgJvst3ZhdQc1gbEek=;
        b=dW8P0Vke6ERAMi0eBPrG+t/SoxjO80foc+7Mx40qQ8SuP2cyTBv4uJqs7QXnYia6yH
         Lwp0cCj5vlEYdEZtfIW9lgmfgJNSgiaPeSJA0QnWY6sjx54y2AcdLLLgayFcslxHp3Dh
         109wayv//wcAAf4AGEmNO7icGq5PObOWMxbf1IcuZlkuc13yYBddq0FV8aBhLeUdrEI8
         eiq0vY8wm731Pfe66uJxfw9Hh5mak2/Otl1Loxo1giQZSDzFtWnmOZbfDCHeUNMvq46I
         8oknyD+JH3ZgkeJEvtZlCGcitcFevptg6Kl8BRHPgmTvttNHHBBMgsZWFAuLiozmAIQm
         OZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t5BsHfPfwFVdHmiG0W5J1oIj8NgJvst3ZhdQc1gbEek=;
        b=GIyysXaTUG4BuOMhXrbIqzddX4mTV5UGD/ksE+xXH25f73Nc6tmvJWKLsx7a+xfDBk
         TJbG89PcWiwOmKxjxxAvhKZ3N/rNDWOds33NgxFOIYzPMt5UW3aHj0tsmMSy9lgnNqAg
         4j/UqAs4s/onIiWgZ2MlU4Rc2PZOjFh+k8vN27DFPZvrOIuF3a4xu0PJyUdfuLJ3fTLE
         OU9h0pNdoXLTTBADFD0hWqZTyGwHaiU1ApK6MYhFQUPg9nAd5Ss9DqcfdejCbKO7pLYm
         Gz/hWDVb+Z5i9CMvfh8lZ2nDput8LGIWqf9BgH67RPbpHUKs2/3f1aMVHHAsjYKRBYPR
         6gbA==
X-Gm-Message-State: AOAM532xri+U7sntFXjdz+b0jJGBPT8F2TBliAT0WfduxgxgTjrJ/L6D
        NavmWV9kWYCA+MG40p0efYRBiyeKKgCj92w=
X-Google-Smtp-Source: ABdhPJxAohZPC7dEvTt/1RmjvaDTRQUlcxLRKuc5obRasiVtvJdZoLvTMIYhPBylJdUu+IDrzMC4x+MDzZlLG+o=
X-Received: by 2002:a25:2d4d:: with SMTP id s13mr3733112ybe.349.1594873258589;
 Wed, 15 Jul 2020 21:20:58 -0700 (PDT)
Date:   Wed, 15 Jul 2020 21:20:50 -0700
In-Reply-To: <20200716042053.1927676-1-saravanak@google.com>
Message-Id: <20200716042053.1927676-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200716042053.1927676-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 1/4] driver core: Add dev_set_drv_sync_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used by frameworks to set the sync_state() helper functions
for drivers that don't already have them set.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 15460a5ac024..2f56afdd9107 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -806,6 +806,18 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline int dev_set_drv_sync_state(struct device *dev,
+					 void (*fn)(struct device *dev))
+{
+	if (!dev || !dev->driver)
+		return 0;
+	if (dev->driver->sync_state && dev->driver->sync_state != fn)
+		return -EBUSY;
+	if (!dev->driver->sync_state)
+		dev->driver->sync_state = fn;
+	return 0;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
-- 
2.28.0.rc0.105.gf9edc3c819-goog

