Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4F4C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E42520768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GG9m4KU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgIHUEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgIHPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A6C0A3BF1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:19:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so17563577wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IoBahBXL8EV0Zm9JurRP5zVn3O/ezWTWYb2ZZwdoss=;
        b=GG9m4KU79FRy3Qgbny/8OL+0RnULk7UHa8hwD7IGdlg/qZhDxf7vKcI4P3TtCRnWdZ
         t6SU2EesiN0Cw098TrXyhVUAbYiefAj+KMX4mOg1eFswalgfcdxfwWFd/2OhgVTFVRXf
         g0dRQ0aec6jsWRZ846qt63PSfKpe9CRYDVyuynbySXEdwR52T3mzEDOmJpGxQlgwxhsR
         IpjPOse9s6p0IfHP9+eYD58xNRKvXxt51uPieX/UxsPiOthcKowdpEe+ob6Bpatn2wNW
         rrfbpmyD9lJLn0HetNn/Bm5glZadk3/taeSTRnHJRgtnOOemPdW3Cmkd8Y5jL0zjvFCG
         uWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IoBahBXL8EV0Zm9JurRP5zVn3O/ezWTWYb2ZZwdoss=;
        b=I75npmQXrC2yJzzre28BW2H+ZNYJzpMsddAIfO3wr3avYXco8dAd1K0dZp+MD0Hq3t
         iv19NDw87N8owkdigzlVoMO5mJukK6/A6iggF448xHbdEkpzGWQ8oKmJ7YRwoO951rbO
         y0/4yrLVeQ0/cDvuNBBMciL53JGNXfJzOm4mhPgA+tGuNJ6I7iSgkrVEoFgpY+ki4S92
         mpTgDBfDN2DBhbyHK8+FfI52n29NNxnb51JZSygpyBeXVyfLZ0KxuA48gIhVjxCPjz3s
         l92DIO+/z3YrY6ZoHje7nmY8J5PNdLhgMNsEiXdPtWSFVEKD3Hg17MzR+cd3NXSoms3Y
         6pbA==
X-Gm-Message-State: AOAM5313oKidzk+v1rCoz/ASApeiXHn3BBecvmtG5rqwbYv6R/wuTi0I
        Gtz1UwpDkUal48uWWny6EHOMFA==
X-Google-Smtp-Source: ABdhPJw6zcnIiatO6SQE5a+MzW0yXoBmBj7sAP9Cf3yM7GxqrkpZS5u2132oDAMPyj0810YP9kSkWQ==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr73546wmg.58.1599578343681;
        Tue, 08 Sep 2020 08:19:03 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d25sm10004886wra.25.2020.09.08.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:19:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/5] drm/panfrost: add amlogic reset quirk callback
Date:   Tue,  8 Sep 2020 17:18:52 +0200
Message-Id: <20200908151853.4837-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200908151853.4837-1-narmstrong@baylibre.com>
References: <20200908151853.4837-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T820, G31 & G52 GPUs integratewd by Amlogic in the respective GXM, G12A/SM1 & G12B
SoCs needs a quirk in the PWR registers at the GPU reset time.

Since the documentation of the GPU cores are not public, we do not know what does these
values, but they permit having a fully functional GPU running with Panfrost.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c  | 13 +++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h  |  2 ++
 drivers/gpu/drm/panfrost/panfrost_regs.h |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index c129aaf77790..018737bd4ac6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -80,6 +80,19 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
 	return 0;
 }
 
+void panfrost_gpu_amlogic_quirks(struct panfrost_device *pfdev)
+{
+	/*
+	 * The Amlogic integrated Mali-T820, Mali-G31 & Mali-G52 needs
+	 * these undocumented bits to be set in order to operate
+	 * correctly.
+	 * These GPU_PWR registers contains:
+	 * "device-specific power control value"
+	 */
+	gpu_write(pfdev, GPU_PWR_KEY, 0x2968A819);
+	gpu_write(pfdev, GPU_PWR_OVERRIDE1, 0xfff | (0x20 << 16));
+}
+
 static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
 {
 	u32 quirks = 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
index 4112412087b2..a881d7dc812f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
@@ -16,4 +16,6 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev);
 void panfrost_gpu_power_on(struct panfrost_device *pfdev);
 void panfrost_gpu_power_off(struct panfrost_device *pfdev);
 
+void panfrost_gpu_amlogic_reset_quirk(struct panfrost_device *pfdev);
+
 #endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
index ea38ac60581c..fa0d02f3c830 100644
--- a/drivers/gpu/drm/panfrost/panfrost_regs.h
+++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
@@ -51,6 +51,9 @@
 #define GPU_STATUS			0x34
 #define   GPU_STATUS_PRFCNT_ACTIVE	BIT(2)
 #define GPU_LATEST_FLUSH_ID		0x38
+#define GPU_PWR_KEY			0x050	/* (WO) Power manager key register */
+#define GPU_PWR_OVERRIDE0		0x054	/* (RW) Power manager override settings */
+#define GPU_PWR_OVERRIDE1		0x058	/* (RW) Power manager override settings */
 #define GPU_FAULT_STATUS		0x3C
 #define GPU_FAULT_ADDRESS_LO		0x40
 #define GPU_FAULT_ADDRESS_HI		0x44
-- 
2.22.0

