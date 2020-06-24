Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C11EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739282070A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsBw1uV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404386AbgFXPFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404361AbgFXPEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:04:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99C6C061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so2619586wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVepsW5AvbKSelkDGpeRLJ59PttgtzeSmv2QlhFjJvQ=;
        b=LsBw1uV8LrG03R4u2wAAHV9lr+txMyw7+BdND15xIDswqXzGkXd922uezxszzxlKxa
         y6z1rBpFXRbiDLX/DYinCMp07ITmQAaZc4ADuyeddcvqYS9TdDbGAYOWzoL2rDSQWcw9
         85nofVUxEK24RYZvCHdW4bsSTMWEs4SAqGBcHF+XCYhgfe54ZZFoXKhSjLS2/c9PD9N3
         MjSyj4nMjZzhJNj1+kmNeddik1BNOt9Qx4pJUmMe8atuBq0wU6WIA3OgGX8lEd5hIh7w
         uQSnwO83jCtGstF7Qtm4upnJkXj8EyJ26Ib+qAdCMXuKvWx55yEiYohCoEgTdLNct4K9
         AsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVepsW5AvbKSelkDGpeRLJ59PttgtzeSmv2QlhFjJvQ=;
        b=so3ImDiu4cTPpBlvEQqGLXCXGsr8G/t/d5fCSSF3bZZKk3oCkO0N8XLIf1BoeQaEs4
         8xhO1sVQHu4yPUxIYPmXNtrKGlBG6+Q2iuYp1gu2Hk31uKT2BfwZSDPJLLXTUJKmYAeJ
         4Kd9KQBuMhp5VQ8Lo72QwGDyYm/kqEr+iaOzYEqYVFS9F8qfzTK8+Oae5Mq/ulJ1R25z
         oFm3/tjI3fxscdaBwVkH3dOSso+APamhvhBfLb5apUk5aZwsLB2CDnbbefdIIxyOPODc
         L8Mep4ls2yD3b3laexLbqp6mNKReUB3m0KKOqOt7rCzUy4bg8aLzDBDDSjOpKVuUltZ2
         9Drw==
X-Gm-Message-State: AOAM530H8MsB18PeAjwwUId+FoA7gpHdTDz9TzdAIjs02/7E8J4G5OPW
        vETMJL6uHkC1slV3hQcWh6Za2w==
X-Google-Smtp-Source: ABdhPJy5hjoveRZ0F4NTZinjK6e2tP12GsQQtzyhrotgfkM8UdmF7amCXrR0qX7WGB+tS0ZfQBcPvA==
X-Received: by 2002:adf:e782:: with SMTP id n2mr31179657wrm.417.1593011088504;
        Wed, 24 Jun 2020 08:04:48 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f186sm8200319wmf.29.2020.06.24.08.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:04:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jamey Hicks <jamey.hicks@hp.com>,
        Andrew Zabolotny <zap@homelink.ru>
Subject: [PATCH 6/8] backlight: backlight: Supply description for function args in existing Kerneldocs
Date:   Wed, 24 Jun 2020 15:57:19 +0100
Message-Id: <20200624145721.2590327-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.  Descriptions required.

Prevents warnings like:

 drivers/video/backlight/backlight.c:329: warning: Function parameter or member 'reason' not described in 'backlight_force_update'
 drivers/video/backlight/backlight.c:354: warning: Function parameter or member 'props' not described in 'backlight_device_register'

Cc: <stable@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jamey Hicks <jamey.hicks@hp.com>
Cc: Andrew Zabolotny <zap@homelink.ru>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 92d80aa0c0ef1..744ba58488e01 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -320,6 +320,7 @@ ATTRIBUTE_GROUPS(bl_device);
  * backlight_force_update - tell the backlight subsystem that hardware state
  *   has changed
  * @bd: the backlight device to update
+ * @reason: reason for update
  *
  * Updates the internal state of the backlight in response to a hardware event,
  * and generate a uevent to notify userspace
@@ -344,6 +345,7 @@ EXPORT_SYMBOL(backlight_force_update);
  * @devdata: an optional pointer to be stored for private driver use. The
  *   methods may retrieve it by using bl_get_data(bd).
  * @ops: the backlight operations structure.
+ * @props: pointer to backlight's properties structure.
  *
  * Creates and registers new backlight device. Returns either an
  * ERR_PTR() or a pointer to the newly allocated device.
-- 
2.25.1

