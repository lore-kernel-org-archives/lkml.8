Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343CDC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A2720733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9/0eKER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgC2O6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:58:49 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54948 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbgC2O6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 10:58:48 -0400
Received: by mail-pj1-f66.google.com with SMTP id np9so6391292pjb.4;
        Sun, 29 Mar 2020 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BcxV8pGWJr7R5GyeodoBfbjlgHj70bMVXWL1P/PRiA=;
        b=c9/0eKER41JmgTmkyLd4o0N090jCq6vEQVUWvqTldbNa/noBczXdbXylNqfn+9GDH+
         WGXuLdCTMG//pUS+UM8lEUR7MA5baNxvn2KWJWrJr06077S5i9dmGx2pU9iPCmlo4QhD
         cfyv9CJ5k8xLLoLOtzWh+bDRd76EN+7xuXlvkJDBFjZUxcyr2C+wiy1FA4GLjFod2sTA
         AXv3wdotCT3B5p6HfqEMT2hGMGIhEI9LcAOzL6NmVT9wX5P6aQW/lyoljBuQw70u8AdB
         Elc0qoUk6G7T5WEE4P4HifwYr+DwOyjh+v/bDwiACJG52nZTYo4hEJ5UADrMe7UG8P4e
         qelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BcxV8pGWJr7R5GyeodoBfbjlgHj70bMVXWL1P/PRiA=;
        b=Y1qatms2Q/VnstzqYToiYIBzzn/gh8oFsPqvcpmPRwwM2UedwknmJimkPgs5O5Oh4s
         2XY+oYm3/IybLS0KkbbWahVq7cSCHgDIG848X6MUM+xQIyF1BeozfVv+tdO5uKFQYpbN
         q2RTykIQ57qujxX6I11wV9/HqAoA9zVv2MM7PCsGtU13edHGI1J1+jNj0GiMtIx3xGqR
         rBVg7dGNTQ18nhZw7bbI4bdqJ7eXdr0eNt841rxZpe98wBSV1nyVsFvYrBy2zANCgv2i
         n5wMoZi+SBpFcZXn948D3jRuJ5H/vwDjGdemVx2Ql1/9Zn63jBLdEVeCXQPRRek4QRRt
         nnpQ==
X-Gm-Message-State: AGi0PuZFuRO+w11HOBZG/IfywQuJbDkSghEqY38dPhyhEUxIRV79JRb+
        E23XKGH5kKmVIpMHRNh0MNakrlLL
X-Google-Smtp-Source: APiQypJeUUa8fwtqNZ7WFemPga2cu7l9NOhSfiE3izJjKXKkOQ1zmtu+VGTFwmE2NCLNG6icNn1Bwg==
X-Received: by 2002:a17:90a:be18:: with SMTP id a24mr3578860pjs.92.1585493927244;
        Sun, 29 Mar 2020 07:58:47 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id j65sm7883215pgc.16.2020.03.29.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 07:58:46 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4] video: fbdev: vesafb: add missed release_region
Date:   Sun, 29 Mar 2020 22:58:39 +0800
Message-Id: <20200329145839.20076-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to free the I/O region in remove and probe
failure.
Add the missed calls to fix it.

Since the success of request_region() is optional, add the "region" field
in vesafb_par to represent whether request_region() succeeds.
Then only call release_region() when "region" is not null.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v4:
  - Add a field in vesafb_par to represent whether request_region() succeeds.
  - Only call release_region() when request_region() succeeds.
  - Adjust the order in the error handler of probe.
  - Modify commit message.

 drivers/video/fbdev/vesafb.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index a1fe24ea869b..df6de5a9dd4c 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -32,6 +32,7 @@
 struct vesafb_par {
 	u32 pseudo_palette[256];
 	int wc_cookie;
+	struct resource *region;
 };
 
 static struct fb_var_screeninfo vesafb_defined = {
@@ -411,7 +412,7 @@ static int vesafb_probe(struct platform_device *dev)
 
 	/* request failure does not faze us, as vgacon probably has this
 	 * region already (FIXME) */
-	request_region(0x3c0, 32, "vesafb");
+	par->region = request_region(0x3c0, 32, "vesafb");
 
 	if (mtrr == 3) {
 		unsigned int temp_size = size_total;
@@ -439,7 +440,7 @@ static int vesafb_probe(struct platform_device *dev)
 		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
 			vesafb_fix.smem_len, vesafb_fix.smem_start);
 		err = -EIO;
-		goto err;
+		goto err_release_region;
 	}
 
 	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
@@ -458,19 +459,22 @@ static int vesafb_probe(struct platform_device *dev)
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENOMEM;
-		goto err;
+		goto err_release_region;
 	}
 	if (register_framebuffer(info)<0) {
 		err = -EINVAL;
 		fb_dealloc_cmap(&info->cmap);
-		goto err;
+		goto err_release_region;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
-err:
+err_release_region:
 	arch_phys_wc_del(par->wc_cookie);
 	if (info->screen_base)
 		iounmap(info->screen_base);
+	if (par->region)
+		release_region(0x3c0, 32);
+err:
 	framebuffer_release(info);
 	release_mem_region(vesafb_fix.smem_start, size_total);
 	return err;
@@ -481,6 +485,8 @@ static int vesafb_remove(struct platform_device *pdev)
 	struct fb_info *info = platform_get_drvdata(pdev);
 
 	unregister_framebuffer(info);
+	if (((struct vesafb_par *)(info->par))->region)
+		release_region(0x3c0, 32);
 	framebuffer_release(info);
 
 	return 0;
-- 
2.26.0

