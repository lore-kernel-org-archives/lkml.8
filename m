Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B2DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FC42078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfyLfbWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgGJHmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGJHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:42:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675BEC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:42:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so4784769wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmGuoYcAtPZ/mwhFHqovUeVuw6/BJFRsIKd+l37OEGU=;
        b=VfyLfbWP1nT6ap53jH9hZ73gBJpfdAREdVk0UxjpRM7XM1HSVzVzMl0fSJIMDjiuwm
         p3Ywibmdl0v5HFxKnoa74FTxoD8IDl3S2RIoD95Oj0+oJxC86gAuQfCdVgbflFjepLr8
         eOxv42yK92L7KB38sSHljx7gIpyGD5/yY0ncgtJYZ7ynA/fYeiguTgE9g4rsI6gebkHh
         xqtKxp7AjDX/Nyh3AGZx3WpYlwziL5a7FIf0JEwrWyqwjjoMSB1bVnBgD4OayS0KZ0wQ
         JHtfpV0oide6/QfIkpDQyHVhG7C/nWzqKVBCdm2mG10xMbyWymTL6ZsQ4axOq0jaMzvY
         DkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmGuoYcAtPZ/mwhFHqovUeVuw6/BJFRsIKd+l37OEGU=;
        b=mGtUHT0V5IBZVxCT9BEs49uD/R7NfCpY4yrirUA6fNExl2kSGJEoKuuDuSlxHk17jH
         mJBDc3C5ETgfCEpK6yl9gnpUk3TYExodxq/4/MA9w8bfTQXG5FaWlNY5rLQ+pDWsV7Pc
         sd0s79eayOEBg8fY6brY9SC8cctMjDTkE2qQmJ5eSlNeiqRTm4l8P4YRDwMsA+XJcDtn
         U64f5HgXN+Ocj35lsAlmPyGqYxHDG3PcB/QsLCRJ8wDiXqisvBH1HfaNJ81EfvA5eExp
         wuicUh06Afjai/XWzYjQ0nSX86FpW5m8tAXD7r4Fxu3rp+uiSUtu+OxRSznmbbz9MHdc
         CNSQ==
X-Gm-Message-State: AOAM5319U/UFY1zc/pA30ZSKkYfRlWsAUH/BT35o1oH0xQjR+CQjwrsT
        5FfVLeirbPvPcf3Xjd29hfP0MnevdaY=
X-Google-Smtp-Source: ABdhPJz0aa7Gl6MEMJnk8e6Nu68bbbEgkcDVJGuvuCl9kvQNPXYdfoPMqa28QnqeviP+yiB1gIV76Q==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr3912062wmk.149.1594366937949;
        Fri, 10 Jul 2020 00:42:17 -0700 (PDT)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p17sm7951375wma.47.2020.07.10.00.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 00:42:17 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] drm/etnaviv: export loadavg via perfmon
Date:   Fri, 10 Jul 2020 09:41:27 +0200
Message-Id: <20200710074143.306787-5-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710074143.306787-1-christian.gmeiner@gmail.com>
References: <20200710074143.306787-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to access the sub-GPU component load value from
user space with the perfmon infrastructure.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 79 +++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index 75f9db8f7bec..614d86e2802d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -98,6 +98,19 @@ static u32 hi_total_idle_cycle_read(struct etnaviv_gpu *gpu,
 	return gpu_read(gpu, reg);
 }
 
+static u32 load_read(struct etnaviv_gpu *gpu,
+	const struct etnaviv_pm_domain *domain,
+	const struct etnaviv_pm_signal *signal)
+{
+	u32 load;
+
+	spin_lock_bh(&gpu->loadavg_spinlock);
+	load = gpu->loadavg_percentage[signal->data];
+	spin_unlock_bh(&gpu->loadavg_spinlock);
+
+	return load;
+}
+
 static const struct etnaviv_pm_domain doms_3d[] = {
 	{
 		.name = "HI",
@@ -387,6 +400,72 @@ static const struct etnaviv_pm_domain doms_3d[] = {
 				&perf_reg_read
 			}
 		}
+	},
+	{
+		.name = "LOAD",
+		.nr_signals = 12,
+		.signal = (const struct etnaviv_pm_signal[]) {
+			{
+				"FE",
+				0,
+				&load_read
+			},
+			{
+				"DE",
+				1,
+				&load_read
+			},
+			{
+				"PE",
+				2,
+				&load_read
+			},
+			{
+				"SH",
+				3,
+				&load_read
+			},
+			{
+				"PA",
+				4,
+				&load_read
+			},
+			{
+				"SE",
+				5,
+				&load_read
+			},
+			{
+				"RA",
+				6,
+				&load_read
+			},
+			{
+				"TX",
+				7,
+				&load_read
+			},
+			{
+				"VG",
+				8,
+				&load_read
+			},
+			{
+				"IM",
+				9,
+				&load_read
+			},
+			{
+				"FP",
+				10,
+				&load_read
+			},
+			{
+				"TS",
+				11,
+				&load_read
+			}
+		}
 	}
 };
 
-- 
2.26.2

