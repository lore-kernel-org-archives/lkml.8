Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E514C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104C12072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCt6b3cG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgEBUmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 16:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgEBUmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 16:42:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0DBC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 13:42:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so5103308plt.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nSeRL+v4vCg/JlCwuxAlOvIi6+lQZ0s1gPbPPC1SQo4=;
        b=OCt6b3cG0YLdLxYA5cJvtZbCTTAHTEI7a0AtEVm8ffCG56DV3uQk+vhc3LN3vL+BIE
         sEC8sUGDEOhYxyJX5cwjYJJgL23kpAe9kh8n8gHqwS6vjFW4X/wd6CIjaf3jVIPg1H4i
         peRikUnM20G/bQgUF2frryCueKkWtPAP070g1OG8SrgYpdNQZ1NMe+2/Mx6cObR36vgR
         jHf+NhXYuyOMASrtrLD6Q1CAyG+XVmbIpDq/hwi3G4MZXcmMdiCIka28Bmc8uVrI4EmB
         RE6dc8q6NO3c9CPNxPXciQZmqApUbrS59U8Z9AgUp50mQPeNZLLvcqiASqCLqMDPkgEv
         43og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nSeRL+v4vCg/JlCwuxAlOvIi6+lQZ0s1gPbPPC1SQo4=;
        b=thdoBinAb/3szb2L4LgMm+tW3RdFQbMPQqygdOyMkSS3kQEJNrR0ts+rK7BmTTg+gl
         Mpbf+fc7DPW3EWDJZE8THSAgigXWEbCG2GoBXSfVjV92aAuP0o/zypQx77Mi2hLpC3RF
         zpD+8JxMdx56P/fJ9mohk/Um4nOPLu9Drt6b70J0ecd+nObhAOQv7j6Tq7917IoePxik
         oUJyioiatojlNAwy5WGTKHI+DxdIomF0EqgBnqvwV/H/SUlSA+s+GcDxzc2vdN2X/wgK
         gGGwBsUpFhMcnT1+18xP+TFbwNlVJpkYd+Sqe6bS/iSp7oVTVtPuURW0ZxR6D2Y4F5Sx
         MJ2w==
X-Gm-Message-State: AGi0PuY2154y9owH3ED5a4RmI9kRd5S8Jy1+B8HsplNEipeU7RXXpqO+
        D2nnvT/oHRi+WM2rMYPVDBI=
X-Google-Smtp-Source: APiQypIxaji5kSHFkExlIHwZrR5Ew04BoUZDXSNrqnvkxTM6b2AlFyL4Fwjiv6RXBufl6jAVF44AVA==
X-Received: by 2002:a17:902:ee15:: with SMTP id z21mr10489150plb.71.1588452122460;
        Sat, 02 May 2020 13:42:02 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b3sm4683469pga.48.2020.05.02.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 13:42:02 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [Patch] mtd:rawnand: brcmnand: Fix PM resume crash
Date:   Sat,  2 May 2020 16:41:36 -0400
Message-Id: <20200502204137.37134-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes crash observed on PM resume. This bug
was introduced in the change made for flash-edu support.

Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index e4e3ceeac38f..8f9ffb46a09f 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2728,9 +2728,8 @@ static int brcmnand_resume(struct device *dev)
 		flash_dma_writel(ctrl, FLASH_DMA_ERROR_STATUS, 0);
 	}
 
-	if (has_edu(ctrl))
+	if (has_edu(ctrl)) {
 		ctrl->edu_config = edu_readl(ctrl, EDU_CONFIG);
-	else {
 		edu_writel(ctrl, EDU_CONFIG, ctrl->edu_config);
 		edu_readl(ctrl, EDU_CONFIG);
 		brcmnand_edu_init(ctrl);
-- 
2.17.1

