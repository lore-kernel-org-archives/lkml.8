Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60897C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8832067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTQCp4W4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHXRoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHXRoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:44:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76798C061573;
        Mon, 24 Aug 2020 10:44:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a5so9683451wrm.6;
        Mon, 24 Aug 2020 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXooCNGdhbuCs38z5vOfPrPzquVwWGwJseeAUQIr3dI=;
        b=iTQCp4W4bnKDurMqnF9xz+FFQWCsZ7QeRAPt3KjIVEHR2InNqejYz6MyUzv93PW4aS
         WyZwtA/F3UKwIaVU/KvdA3Nv9lp5LXXtirqDZpOniKaWsLeVW77XiGZEoE5d/0bYZkRC
         FOyQX6o8HfXmo5r3GRobQe/q8ZGeNfZh6/gRc9gpX7z3daiXERyOK8VQm1Rz7csQFtpB
         zZcUQK+RQI/FNAq+EELAMH9/0FmdCQpckS1vilSX1afoClvoQj7SFBCGvhJ/YykaKG/0
         COheMc2pNwqdgg95ISwKlP8oF6sZLtIavbPS1iWIOlTS1Yqr3zijv+Cl1Tfv1BIRbm4n
         r/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXooCNGdhbuCs38z5vOfPrPzquVwWGwJseeAUQIr3dI=;
        b=pudCV+Lu7ngveoaLfSHBjWYKJfq+a4oEXyRWdX7Wx5iCL6ZcO7XIsM9ADYp/xCL781
         VzorB/UEds2JfCy1mqN9mwT0JAUGJWIvMRDEhDqlv88VvRlDmj9x2E0nLJdAr48Ysq4o
         eRAW1syu/8nLN8lOtGw6Pd/iCTDTVUvj60Bc2XWJaduZDeKzFqlVbg37m0vcSVC/y48v
         7De6Ljvjc5cbgE3q5LlxRBcDP3lQM/He9MJflMaXwQM2AoFgTsPKGVE+DCR0VHA9dypj
         0DIyFi1VDxlZE8f4WaJih1wmklyltg0yOMsuzMmcOotsy0RsMUENlBwtbm9vNj7enV0y
         Lvlw==
X-Gm-Message-State: AOAM532/l+eb+l0Vbrm180ByNqxIq2LuXSjWWAcPAzEmA3cZpXNBYe6m
        NXbWA/Zs1no7Pf6UN0mCFQMtJLS6kflKTCJC
X-Google-Smtp-Source: ABdhPJw7TMgowMg/jub8r23jyDF6m4NIDyBitGVovsMaVGfdJyBBpTjsvU/TA22pDCl+TmPubgjUgQ==
X-Received: by 2002:adf:f086:: with SMTP id n6mr3470862wro.208.1598291054224;
        Mon, 24 Aug 2020 10:44:14 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id a7sm446977wmj.24.2020.08.24.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:44:13 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: replace spurious snprintf() with sprintf()
Date:   Mon, 24 Aug 2020 18:44:03 +0100
Message-Id: <20200824174407.429817-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

par->vgapass is a u8, so if we are assuming that buf is at least
PAGE_SIZE then the extra checking is pointless.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/video/fbdev/sstfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index afe6d1b7c3a0..c05cdabeb11c 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -733,7 +733,7 @@ static ssize_t show_vgapass(struct device *device, struct device_attribute *attr
 {
 	struct fb_info *info = dev_get_drvdata(device);
 	struct sstfb_par *par = info->par;
-	return snprintf(buf, PAGE_SIZE, "%d\n", par->vgapass);
+	return sprintf(buf, "%d\n", par->vgapass);
 }
 
 static struct device_attribute device_attrs[] = {
-- 
2.28.0

