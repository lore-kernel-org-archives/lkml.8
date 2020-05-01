Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C0EC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E042166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq+6SN7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEAVuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAVuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:50:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4FC061A0C;
        Fri,  1 May 2020 14:50:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so4080417plo.7;
        Fri, 01 May 2020 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sCwnL9j5tuq9C/zCfZk+GBElwtsC97H/4kGQxJh9yoE=;
        b=kq+6SN7e26oYWrvqvD/PA/9Es8QwBjsr2gG4NxFyAibz89l3IQti445oA24zTob1RZ
         YJ/2OTzeKhsphayq+l15QLDGwz4yZc5aCC8b6e8weZjIhZPPuA5aecfJB25MypwQMqbY
         YDLddZW+q4yqko3e3hjvXTgJYlTXgSknrXim/jyUys1ZGpTd3fsinQ/5k1CkDVTbwGaz
         NQKYIu3rjI94Z7ES2rMcYybAaOx4lEtnFiAchY41w47dRuRNrH6HoYoh26iiC2W/wZtX
         nY02lCNJRhV7LgBYPaIFkZ62BNAM/eeDcvjf1b9mv5HB3iQXTzU0Lrn3yBE0cO08cIs3
         N+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sCwnL9j5tuq9C/zCfZk+GBElwtsC97H/4kGQxJh9yoE=;
        b=MDbRLuU3SWXVJy31MknFyzVdBj4zDScZhRNIxIE4z67fQoKHFLLfVyPuh0pjuZ+IrZ
         5AXhMIMWDVNQcvnr7eCwi/uMQT9suYYK4s6VqWhZDvK5e9m43V+etcAfTebiEN/MZMws
         QW3DMC6sKGNTSdJpy5FgZFmaFY9U759ealt4YjpD98y/2E4gBFaDqVZ6Rdc8hVLTQ/da
         IVYtabxHmMpX+0Gd5uIS/UjT1LqYQDxF5e/ZoAgoGl8Iv9ubC4BAfTU7v3KNOtZ43vlq
         K5WXUrWB5wOkm22jiq5YzbBbA3xvy9uAOWxZhXUa59LWLl0VroBAIVL1xwRuubQUumsA
         M77A==
X-Gm-Message-State: AGi0PubEQQ59Kcxz1ylR25afElZQsWjA/jamsE+rVdLeoAE8g4w4r1zI
        Azi1tKMWuFrqj8GQ78n0Id9uk8BK
X-Google-Smtp-Source: APiQypJQ7Nfrbks03oaOCxMJQ3OHB+u/pNUinmspXJ8F4Pe3OkpqRQo9et58+4EuthMBfNUZtngURw==
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr2015936pjy.136.1588369814033;
        Fri, 01 May 2020 14:50:14 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([171.48.31.149])
        by smtp.gmail.com with ESMTPSA id h26sm2088769pfk.35.2020.05.01.14.50.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 14:50:13 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     b.zolnierkie@samsung.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] video/fbdev/matroxfb: Remove dead code
Date:   Sat,  2 May 2020 03:28:11 +0530
Message-Id: <1588370291-7746-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are dead code since 3.15. If there is no plan to use it further
it can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/matrox/matroxfb_DAC1064.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
index 765e805..9c2a2c0 100644
--- a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
+++ b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
@@ -603,9 +603,6 @@ static void MGA1064_ramdac_init(struct matrox_fb_info *minfo)
 /* BIOS environ */
 static int x7AF4 = 0x10;	/* flags, maybe 0x10 = SDRAM, 0x00 = SGRAM??? */
 				/* G100 wants 0x10, G200 SGRAM does not care... */
-#if 0
-static int def50 = 0;	/* reg50, & 0x0F, & 0x3000 (only 0x0000, 0x1000, 0x2000 (0x3000 disallowed and treated as 0) */
-#endif
 
 static void MGAG100_progPixClock(const struct matrox_fb_info *minfo, int flags,
 				 int m, int n, int p)
@@ -843,9 +840,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
 	struct matrox_hw_state *hw = &minfo->hw;
 
         u_int32_t reg50;
-#if 0
-	u_int32_t q;
-#endif
 
 	DBG(__func__)
 
@@ -927,11 +921,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
 		mga_writeb(minfo->video.vbase, 0x0000, 0xAA);
 		mga_writeb(minfo->video.vbase, 0x0800, 0x55);
 		mga_writeb(minfo->video.vbase, 0x4000, 0x55);
-#if 0
-		if (mga_readb(minfo->video.vbase, 0x0000) != 0xAA) {
-			hw->MXoptionReg &= ~0x1000;
-		}
-#endif
 		hw->MXoptionReg |= 0x00078020;
 	} else if (minfo->devflags.accelerator == FB_ACCEL_MATROX_MGAG200) {
 		pci_read_config_dword(minfo->pcidev, PCI_OPTION2_REG, &reg50);
-- 
1.9.1

