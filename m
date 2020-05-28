Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ED4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C4A206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCrHj4zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406154AbgE1TGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406029AbgE1TGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:06:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28224C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:06:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u6so1180160ybo.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A3s/v7w0uLuPK97vic+T6n73M3awD9PtOe90Ayg0n5s=;
        b=JCrHj4zv/MJWVT8lbg9tvILIkK/JOFTvXyBZvaxa6IvI2zKcBDT8fX9rCQ7ZNBBJ09
         OWE+X34O9pPczPky0URC65Ec7/ai69kav+mMf0m76alBbe7tPUJzLRTeh5iny0sOAMFN
         fVYOrSG9VI3Zc1ydo/3rME1iaroPfJ5N+NIt/tCjsBuGfHDYnjfNjnUK91Ky+PxE4pvH
         /+8dlZe1eYtwARju4JEKvUOGuNBGuqvahDk1cneWikx1+ev7cHZ24ScV0CsOYePwG1Gl
         zlsCimpLRay5Yro3VKyTUsH2kXB44FmgvTodi7KbI1Vs0v80LQYI0ITkIS9LMTXRIT6k
         cDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A3s/v7w0uLuPK97vic+T6n73M3awD9PtOe90Ayg0n5s=;
        b=T8K4DfshlBZvdvfduUsBj+jsb9U7nub5iIrlc5LulgOIcowIM8X08E+yxtPDi3iNfK
         RyF+jG05zBlawHOLJcXN7b2xeJoujyIZzMOWYmV2VQvBAy3eLvxrvVdhqNerNfZGPueU
         R11qRUdDhjfZItgimuBFBmV1fTqEbHmRnPCJrEovYm0vUVLwzBRTjCFt0bxDR0jb7mk7
         hgXJ98erbmSjvfzbVkL7m+aKi8h7IdVkKJA9+zHnJKvE8gn1L1nl8nh9uBijhCy0JKsZ
         f30R+azJF72tTLR6c+4SU0XPGHVTDFbvpNyasVbZg8eC/UwlX8cWBEHekh30vus0Rq1G
         39jw==
X-Gm-Message-State: AOAM531pcd/4zVrnwMfLPiy62UOZ4cG6+j4PWe3RzUiRrr1CGqe9u8L0
        wrFgKlgpHuFxEec/SBIUPGdLXnjAirsbCzA=
X-Google-Smtp-Source: ABdhPJwCZ6QM94nH29HLL/oVhOoNH1IZE9KaNFtqBSzkMPwEB8fkqCK36h437mzrlFO1aTroBpQr3arfb4QwSS0=
X-Received: by 2002:a25:51c1:: with SMTP id f184mr7084372ybb.448.1590692776323;
 Thu, 28 May 2020 12:06:16 -0700 (PDT)
Date:   Thu, 28 May 2020 12:06:09 -0700
In-Reply-To: <20200528190610.179984-1-saravanak@google.com>
Message-Id: <20200528190610.179984-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200528190610.179984-1-saravanak@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 1/2] driver core: Add dev_set_drv_sync_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
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

I'm hoping I can drop this patch based on discussions in patch 1/2.

 include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index ac8e37cd716a..aac548beb154 100644
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
2.27.0.rc0.183.gde8f92d652-goog

