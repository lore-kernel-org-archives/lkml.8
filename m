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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0894AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2632078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQHJq+34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGJHmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgGJHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:42:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83389C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:42:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so4898625wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESrGnYPx0hSksCrKaceiqnAKbnGzRGDWTCCV2K4s+Pg=;
        b=VQHJq+34R+TMtTGTYpPadh6I9+8mqXycEMpwSNSX0RqfbFcY5XwNqat/i0zTR1XEcT
         zLgyGAlMHvRBXOiQZjlmAon1yHt4p5kTImnhPTHZLyNNAnq6HK7/saTDQYqxNr57Xv8n
         geUVFM79g8XS5JYAKww+STAoGRqVk9SkpcdgHE4XITI9MeHyEu//HToKb0sTby8MCG/E
         1qfsMLKY1o3uRo+Nk5Un1Z9KxQgCwOZUnKJMWH4cw1nBJ0IDKITE7uKb5ZSyLMOde9gM
         On4Y3AG2wYy45+BYwaSUm/YEuF3IBrXy4B1TvFaEnlGpcrmtKOHBX6mT/TKiWUpHPO56
         XSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESrGnYPx0hSksCrKaceiqnAKbnGzRGDWTCCV2K4s+Pg=;
        b=N4OZvZ0IauhObsQdcgvAQecXPqaooRzWvZLEvPrmDxhmHAKKw3IjryOMec+SC8z2v6
         rd4IpyvL7UdWc1JJhYNZhqr5ixJVXmCD63f76JB8KDM6NppltCVfCSuAI1kQNyx/6JHl
         20qHtm+5Os/QO0o4FNZQ/i4Yfnnd1wVsxx9w2f2wlSSzC6lCFxU9ij9XZwQTmSOUvuzh
         45soJCRYtRGXWA6Nld1pib9VNR0PjZB/Eo/68EuUm8sgWz0Y/XA6riIR9U5PG6yOU83L
         QJ9tMs1cTR9lzJrtoqkbp1jA8yboJ8089tfc4uMFrifNabqKvWyLoX5m84FI/Rwver65
         t0WA==
X-Gm-Message-State: AOAM533MUDjxooF5ibltiGlSITi2tSQRWpEk9TCZgyXoHjNn+IpoDINy
        fEc7cchPe+axK2bHNhwcYkLU2OQgvGk=
X-Google-Smtp-Source: ABdhPJz/m7lvGEi/JaCh7Zc/xkKPZnrjRbmfEYFb02fxjeTKUgeShYF/9yDasVnsu01jy5FdbQ98GA==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr64152576wrs.306.1594366934055;
        Fri, 10 Jul 2020 00:42:14 -0700 (PDT)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p17sm7951375wma.47.2020.07.10.00.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 00:42:13 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/4] drm/etnaviv: show loadavg in debugfs
Date:   Fri, 10 Jul 2020 09:41:26 +0200
Message-Id: <20200710074143.306787-4-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710074143.306787-1-christian.gmeiner@gmail.com>
References: <20200710074143.306787-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Might be helpful to see the loadavg in debugfs.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 1f0eb7e00657..82fe4aafed57 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -884,7 +884,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 {
 	struct dma_debug debug;
 	u32 dma_lo, dma_hi, axi, idle;
-	int ret;
+	int ret, i;
 
 	seq_printf(m, "%s Status:\n", dev_name(gpu->dev));
 
@@ -1002,6 +1002,16 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 	if (idle & VIVS_HI_IDLE_STATE_AXI_LP)
 		seq_puts(m, "\t AXI low power mode\n");
 
+	seq_printf(m, "\tload:\n");
+	spin_lock_bh(&gpu->loadavg_spinlock);
+
+	for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
+		seq_printf(m, "\t %s: %u%%\n",
+				  etna_idle_module_names[i].name,
+				  gpu->loadavg_percentage[i]);
+
+	spin_unlock_bh(&gpu->loadavg_spinlock);
+
 	if (gpu->identity.features & chipFeatures_DEBUG_MODE) {
 		u32 read0 = gpu_read(gpu, VIVS_MC_DEBUG_READ0);
 		u32 read1 = gpu_read(gpu, VIVS_MC_DEBUG_READ1);
-- 
2.26.2

