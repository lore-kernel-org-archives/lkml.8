Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F0C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706782467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmO+WrH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAVUmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:42:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39918 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgAVUmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:42:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so124057wmj.4;
        Wed, 22 Jan 2020 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eeX2JNGz9HgVPRGIoEvaZTiS7IkFyrAlD7or7JXr8vc=;
        b=XmO+WrH6qgO7Ne8nEAm0qLG4GTHSp4ISjzysPA+T9cbl87pd43WV5D1FUSeCXy7MRT
         /mBFUrLVUdoJHC/cTbtrHTLL97j/U0kFc0OCK7vOXN7HkQ7vKCy5HD3xvSdgcgcY8+/H
         PmZDVXYuimI/uLvjmx+5XDqLhyzcZKa43ZC5OpU5s3uTxxP58d8CvAMMRAJsjZOjjq2w
         DsBKXux9OjGRkF/5LR3SBQ8H9Pg2NL3OOJuVEt9G0uTPDe9BMxcJ3H5MJaUTAPXCYhAU
         edkWSaIpHvxvpTf770Jo5ESsGtWVsl3KA3Q3bpEqM5AGbGFfoW/4EF6O/QK1Rl+kRO3n
         CRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eeX2JNGz9HgVPRGIoEvaZTiS7IkFyrAlD7or7JXr8vc=;
        b=ccnRjBhxca9usCzPn3ZmaWRQG0rA7JlHPHd1pduWE9uZ/jkTwDfuyLbY2xekIXhfaB
         cHtaLg1b0Lc/l4FU4Hca9UBB77V6aMJoLvXm0Vfq354/ytoPNdNeBP73PaxEUNLfctxs
         s/Y9nzzk5Xkv+8FXNyN7ekQhJ3Y4tgPY6JrUADCSrW/LHMWD+0bquF7k3GVh6JMU5W6d
         /L8PiaYGIyoZK7VCT3JIZ8qyhgKx0kBr2/POjizs5GLGSYZkgiKj02jDjot1/N6KjD/N
         LVjiVIonxjM2WVT5UAj6lzwp0ounGzXC6KgEnIEN4gT5Qy37Gcq333cWyl9ZoN13ZAbu
         we2Q==
X-Gm-Message-State: APjAAAW7yn6rfTUZZKDCBMo5AWciCGZUB28sB7bbDF3EFeMO6e+aJXvp
        Kb/ifg1F/Pfo5Pl7IGLrerQJBWJo
X-Google-Smtp-Source: APXvYqzjJmS3tK7eQWlg6JpwLB9Y75eZZTMwk5rQl/gsFfC8eW5kvb2gCBg+6vIiN13AGheMV7dwDA==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr21182wmj.117.1579725735539;
        Wed, 22 Jan 2020 12:42:15 -0800 (PST)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x132sm6216302wmg.0.2020.01.22.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 12:42:15 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH V3 1/3] dt: bindings: brcmnand: Add support for flash-edu
Date:   Wed, 22 Jan 2020 15:41:09 -0500
Message-Id: <20200122204111.47554-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for EBI DMA unit (EDU).

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 .../devicetree/bindings/mtd/brcm,brcmnand.txt          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
index 82156dc8f304..05651a654c66 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
@@ -35,11 +35,11 @@ Required properties:
                      (optional) NAND flash cache range (if at non-standard offset)
 - reg-names        : a list of the names corresponding to the previous register
                      ranges. Should contain "nand" and (optionally)
-                     "flash-dma" and/or "nand-cache".
-- interrupts       : The NAND CTLRDY interrupt and (if Flash DMA is available)
-                     FLASH_DMA_DONE
-- interrupt-names  : May be "nand_ctlrdy" or "flash_dma_done", if broken out as
-                     individual interrupts.
+                     "flash-dma" or "flash-edu" and/or "nand-cache".
+- interrupts       : The NAND CTLRDY interrupt, (if Flash DMA is available)
+                     FLASH_DMA_DONE and if EDU is avaialble and used FLASH_EDU_DONE
+- interrupt-names  : May be "nand_ctlrdy" or "flash_dma_done" or "flash_edu_done",
+                     if broken out as individual interrupts.
                      May be "nand", if the SoC has the individual NAND
                      interrupts multiplexed behind another custom piece of
                      hardware
-- 
2.17.1

