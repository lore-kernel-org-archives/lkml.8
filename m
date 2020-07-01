Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C29C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8CA20853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgQBNHP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgGAWlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgGAWlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:41:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C415C08C5C1;
        Wed,  1 Jul 2020 15:41:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so29178061ljo.0;
        Wed, 01 Jul 2020 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh1Ddk7qeAP9r/b4akd97joGGTOfkA4hSpHtOpj8VWM=;
        b=NgQBNHP2cMgzhC4lpvFFiw+ODzA1BZ4LVJHCSIAmjkGo3nsvx5pXxhQloZlDaGY8AO
         UDMwX4asZcGsRrF3SAxvMfQgQVzNX0QC4tez95ZJoaYlXmoammVEQ39tDwObQxdA9Oa4
         18fyN4O/IL5tt9oZMz8oYV0xcrnsCRjQqnOFwg+KwSCwe/sEr5r5mpfci/veAvHqP2uX
         sqhqEVD/7f3c8k8Ic2ZEXXd18qArjdWKf75aMXRSjtp2R0K65GFOvEQPfAAyRazqbB9i
         UHa7J5AGZGsJSlC5wh9/gN97E5ZLVwbMqzYBVRqaqgSJ9HhjcCHn6NT7nIpmwo9EDHV2
         sluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh1Ddk7qeAP9r/b4akd97joGGTOfkA4hSpHtOpj8VWM=;
        b=oUCYNBjYnXJEeGzH8RL5fxlQ3dTvqkVzG5QiDuLSbkRcQcqmArZMJbpuPwHyAGecJ1
         mVpkABcaLMq0XufD76Oc5ovc0751NxB3chRzTpc5jmV7mB++++HUsdP3zl/VX5X4FzgO
         450L2c1seusZyG2ynhJ/1tfgCijqGsM32dG/ZE795tlG9JH8a4jOarSUcMNvttmO7EDj
         BDMdvpZA1xRTDE84xykrlGVnxeccFryNeDZ9OHvFN0mFhFA0rvVsTnzM+7yPNcYpoCqT
         STMmO0nUHUpjdfVQ5C42IodZSKr5GpIPvqBaLgeGlVs+LMZQzUou2myMA7X5orWkdamS
         HEjQ==
X-Gm-Message-State: AOAM53064CcGD2RpUPP7HwagV38+0fe7dK8MiS5Sx3R4BZAh4NKhzt+R
        8OFtVP9c3D5VUVNRno5XCkU=
X-Google-Smtp-Source: ABdhPJzVzNWS69AjRHu9Dc76JocLPh0hgx/4x0R35ePixRJQ7+dExk38h/B2aos6Wr3RPpgrCL3Y6Q==
X-Received: by 2002:a2e:9d10:: with SMTP id t16mr14628572lji.46.1593643261075;
        Wed, 01 Jul 2020 15:41:01 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-241.NA.cust.bahnhof.se. [98.128.181.241])
        by smtp.gmail.com with ESMTPSA id t15sm2271371lji.49.2020.07.01.15.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:41:00 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] video: fbdev: vt8623fb: Constify static vga_regsets
Date:   Wed,  1 Jul 2020 23:02:48 +0200
Message-Id: <20200701210248.64893-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are not modified so make them const to allow the compiler to put
them in read-only memory.

Before:
   text    data     bss     dec     hex filename
  25509    7928      64   33501    82dd drivers/video/fbdev/vt8623fb.o

After:
   text    data     bss     dec     hex filename
  26533    6904      64   33501    82dd drivers/video/fbdev/vt8623fb.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/video/fbdev/vt8623fb.c | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index 7b3eef1b893f..98ff8235c9e9 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -62,24 +62,24 @@ static const struct svga_pll vt8623_pll = {2, 127, 2, 7, 0, 3,
 
 /* CRT timing register sets */
 
-static struct vga_regset vt8623_h_total_regs[]       = {{0x00, 0, 7}, {0x36, 3, 3}, VGA_REGSET_END};
-static struct vga_regset vt8623_h_display_regs[]     = {{0x01, 0, 7}, VGA_REGSET_END};
-static struct vga_regset vt8623_h_blank_start_regs[] = {{0x02, 0, 7}, VGA_REGSET_END};
-static struct vga_regset vt8623_h_blank_end_regs[]   = {{0x03, 0, 4}, {0x05, 7, 7}, {0x33, 5, 5}, VGA_REGSET_END};
-static struct vga_regset vt8623_h_sync_start_regs[]  = {{0x04, 0, 7}, {0x33, 4, 4}, VGA_REGSET_END};
-static struct vga_regset vt8623_h_sync_end_regs[]    = {{0x05, 0, 4}, VGA_REGSET_END};
-
-static struct vga_regset vt8623_v_total_regs[]       = {{0x06, 0, 7}, {0x07, 0, 0}, {0x07, 5, 5}, {0x35, 0, 0}, VGA_REGSET_END};
-static struct vga_regset vt8623_v_display_regs[]     = {{0x12, 0, 7}, {0x07, 1, 1}, {0x07, 6, 6}, {0x35, 2, 2}, VGA_REGSET_END};
-static struct vga_regset vt8623_v_blank_start_regs[] = {{0x15, 0, 7}, {0x07, 3, 3}, {0x09, 5, 5}, {0x35, 3, 3}, VGA_REGSET_END};
-static struct vga_regset vt8623_v_blank_end_regs[]   = {{0x16, 0, 7}, VGA_REGSET_END};
-static struct vga_regset vt8623_v_sync_start_regs[]  = {{0x10, 0, 7}, {0x07, 2, 2}, {0x07, 7, 7}, {0x35, 1, 1}, VGA_REGSET_END};
-static struct vga_regset vt8623_v_sync_end_regs[]    = {{0x11, 0, 3}, VGA_REGSET_END};
-
-static struct vga_regset vt8623_offset_regs[]        = {{0x13, 0, 7}, {0x35, 5, 7}, VGA_REGSET_END};
-static struct vga_regset vt8623_line_compare_regs[]  = {{0x18, 0, 7}, {0x07, 4, 4}, {0x09, 6, 6}, {0x33, 0, 2}, {0x35, 4, 4}, VGA_REGSET_END};
-static struct vga_regset vt8623_fetch_count_regs[]   = {{0x1C, 0, 7}, {0x1D, 0, 1}, VGA_REGSET_END};
-static struct vga_regset vt8623_start_address_regs[] = {{0x0d, 0, 7}, {0x0c, 0, 7}, {0x34, 0, 7}, {0x48, 0, 1}, VGA_REGSET_END};
+static const struct vga_regset vt8623_h_total_regs[]       = {{0x00, 0, 7}, {0x36, 3, 3}, VGA_REGSET_END};
+static const struct vga_regset vt8623_h_display_regs[]     = {{0x01, 0, 7}, VGA_REGSET_END};
+static const struct vga_regset vt8623_h_blank_start_regs[] = {{0x02, 0, 7}, VGA_REGSET_END};
+static const struct vga_regset vt8623_h_blank_end_regs[]   = {{0x03, 0, 4}, {0x05, 7, 7}, {0x33, 5, 5}, VGA_REGSET_END};
+static const struct vga_regset vt8623_h_sync_start_regs[]  = {{0x04, 0, 7}, {0x33, 4, 4}, VGA_REGSET_END};
+static const struct vga_regset vt8623_h_sync_end_regs[]    = {{0x05, 0, 4}, VGA_REGSET_END};
+
+static const struct vga_regset vt8623_v_total_regs[]       = {{0x06, 0, 7}, {0x07, 0, 0}, {0x07, 5, 5}, {0x35, 0, 0}, VGA_REGSET_END};
+static const struct vga_regset vt8623_v_display_regs[]     = {{0x12, 0, 7}, {0x07, 1, 1}, {0x07, 6, 6}, {0x35, 2, 2}, VGA_REGSET_END};
+static const struct vga_regset vt8623_v_blank_start_regs[] = {{0x15, 0, 7}, {0x07, 3, 3}, {0x09, 5, 5}, {0x35, 3, 3}, VGA_REGSET_END};
+static const struct vga_regset vt8623_v_blank_end_regs[]   = {{0x16, 0, 7}, VGA_REGSET_END};
+static const struct vga_regset vt8623_v_sync_start_regs[]  = {{0x10, 0, 7}, {0x07, 2, 2}, {0x07, 7, 7}, {0x35, 1, 1}, VGA_REGSET_END};
+static const struct vga_regset vt8623_v_sync_end_regs[]    = {{0x11, 0, 3}, VGA_REGSET_END};
+
+static const struct vga_regset vt8623_offset_regs[]        = {{0x13, 0, 7}, {0x35, 5, 7}, VGA_REGSET_END};
+static const struct vga_regset vt8623_line_compare_regs[]  = {{0x18, 0, 7}, {0x07, 4, 4}, {0x09, 6, 6}, {0x33, 0, 2}, {0x35, 4, 4}, VGA_REGSET_END};
+static const struct vga_regset vt8623_fetch_count_regs[]   = {{0x1C, 0, 7}, {0x1D, 0, 1}, VGA_REGSET_END};
+static const struct vga_regset vt8623_start_address_regs[] = {{0x0d, 0, 7}, {0x0c, 0, 7}, {0x34, 0, 7}, {0x48, 0, 1}, VGA_REGSET_END};
 
 static const struct svga_timing_regs vt8623_timing_regs     = {
 	vt8623_h_total_regs, vt8623_h_display_regs, vt8623_h_blank_start_regs,
-- 
2.27.0

