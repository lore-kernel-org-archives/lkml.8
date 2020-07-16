Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C5EC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E6A206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apJ1u6/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgGPOAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgGPOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:00:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA5C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so7196598wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YB4uXEBe5ZV1fIYVAbMMfG0chbMfovgz8MVZY4BzIb4=;
        b=apJ1u6/fLV5zsisO/3CfZLtBf89rOnUM3/E1nIaW8guRoktsMjTZj5vgsV/m5hc+fX
         eVDFfiaMEFaykLhFeV+KU0ilAx4kSXh4w3UvFa4JWehEcZmdQvzX2Q1XuFrdJ5tZ5XLD
         Qv8FZxZyW9rGxd7735Hmwgw73TCZx3Jj5HZFcLuudFEIXPYVeIuaMDlnDdaqta0ph1QE
         KCsCVlSmxyyQvBiHGKMR097EuHHWvk1wZ2BhPZW9px2WhCdAg1alQvnKZ8207dxi8xb1
         roex8vcYWmf+2TcLGmWcP+e1bVB1X8AVlpWoO2JXKDgCTVR24iZ2k5OwIeM9pfeaR/C7
         Uswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YB4uXEBe5ZV1fIYVAbMMfG0chbMfovgz8MVZY4BzIb4=;
        b=JG4hSNt9+FF4B7nQ1CSNpkonBm1U5MRNYXSQAuDQLexl8/WKhgzXVDQitAodqF1bvo
         OcXfjsBGa95YnUzCTuHdt2pE8Kdeb/v+3mksTs2XQr4DI7n7EEIfu6egO1SGMp6wdTpR
         FmqIWaNFpRnK4ijEEWVF3027HN0Ghw+u0zrm8JSUqWic79liDWodKiiBbewbpZ12qGHY
         TyniteqTSIpJBRsTnuyC07hQHy8pfEZ3N8PFvRx09FX3+eDJnLKvoVSJWXOerHLKk3lE
         CH07xOIfM7nioi/XoVh+pXwxXReZGdUvIB0L8Sa2oeOh4wOBo6lpEhc/5LYThn2SyNRd
         0Cug==
X-Gm-Message-State: AOAM532OM2HUylOGtFaqk30PeAUZixnxN3D2SIMmXNSWrO723YPaSCND
        0NH3a75dhfJsZxGSiQjQ80tRgg==
X-Google-Smtp-Source: ABdhPJxHXGiSrMDXMcitHrAlUihoFBjlD5vbqRk01ClPtaIinGTqc8/QCQ1dXJOMmq0YVKMNsV9jsw==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr5021487wrs.320.1594908007721;
        Thu, 16 Jul 2020 07:00:07 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 29/30] iio: imu: kmx61: Fix formatting in kerneldoc function headers
Date:   Thu, 16 Jul 2020 14:59:27 +0100
Message-Id: <20200716135928.1456727-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'data' not described in 'kmx61_set_mode'
 drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'mode' not described in 'kmx61_set_mode'
 drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'device' not described in 'kmx61_set_mode'
 drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'update' not described in 'kmx61_set_mode'
 drivers/iio/imu/kmx61.c:731: warning: Function parameter or member 'data' not described in 'kmx61_set_power_state'
 drivers/iio/imu/kmx61.c:731: warning: Function parameter or member 'on' not described in 'kmx61_set_power_state'
 drivers/iio/imu/kmx61.c:731: warning: Function parameter or member 'device' not described in 'kmx61_set_power_state'

Cc: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/imu/kmx61.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index e67466100aff4..d0cee2e09884d 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -312,10 +312,10 @@ static int kmx61_convert_wake_up_odr_to_bit(int val, int val2)
 
 /**
  * kmx61_set_mode() - set KMX61 device operating mode
- * @data - kmx61 device private data pointer
- * @mode - bitmask, indicating operating mode for @device
- * @device - bitmask, indicating device for which @mode needs to be set
- * @update - update stby bits stored in device's private  @data
+ * @data: kmx61 device private data pointer
+ * @mode: bitmask, indicating operating mode for @device
+ * @device: bitmask, indicating device for which @mode needs to be set
+ * @update: update stby bits stored in device's private  @data
  *
  * For each sensor (accelerometer/magnetometer) there are two operating modes
  * STANDBY and OPERATION. Neither accel nor magn can be disabled independently
@@ -718,9 +718,9 @@ static int kmx61_setup_any_motion_interrupt(struct kmx61_data *data,
 
 /**
  * kmx61_set_power_state() - set power state for kmx61 @device
- * @data - kmx61 device private pointer
- * @on - power state to be set for @device
- * @device - bitmask indicating device for which @on state needs to be set
+ * @data: kmx61 device private pointer
+ * @on: power state to be set for @device
+ * @device: bitmask indicating device for which @on state needs to be set
  *
  * Notice that when ACC power state needs to be set to ON and MAG is in
  * OPERATION then we know that kmx61_runtime_resume was already called
-- 
2.25.1

