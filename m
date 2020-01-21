Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D423C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332FA2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlFqOs0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAUUAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:00:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46993 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgAUUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:00:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so2017502pff.13;
        Tue, 21 Jan 2020 12:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eeX2JNGz9HgVPRGIoEvaZTiS7IkFyrAlD7or7JXr8vc=;
        b=UlFqOs0X9yC5fqiMCEgHjeGUefzh3fJ/FdvxvkBy25yIKgMFlYTZkUmpDcRVBEdlgF
         ZUR71N8z2yAkKbb01kfMh9nrdSr9a3jQyKklhi8pORyOx2F48pWtCL7SDCV5kUYLFbfj
         A/6zRjM0wgnykN0SLUXAWZmLwNhPwM20CVx7WUKQBeOdwm+e4WLIinqeFaDYPZ0C0sy7
         YjjRflOWXmANDIET32nY3CfBQrUvFa+t+v9HZMVIUgx5LURr/P/Q7n9+R8Q9fpN7OJs0
         i8IcKpfWQcTlzHzCI96q5NwSLtKodwMFHjPce6nR7OGqQaNCAJhNNWcr3hsgODln4HZF
         pxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eeX2JNGz9HgVPRGIoEvaZTiS7IkFyrAlD7or7JXr8vc=;
        b=Uk1ScOcYWmInzulGXeBBcaOtg+xv7fEVIXZFQHNG8bVWycoHa11nQqqguXqES/R5Yp
         Vmj9fP+B7kWwT+nfcIHbJcEU2YwU+ns9mOVu0GBhJHStnJ77V7LRYx8qPXhTudGBpOwh
         FtmJs1/RwTYutuB4APhsu55381P1h4kTPpMKsjjAkyzGgFtTTzHcVULTsH5PkcSBj+kp
         a4Ep56LznGH7ccL1t/OUpTED96ymee1+qWrARdklcYpiV7pzGFDFDjcgHjGp+tZkFInF
         thhaLuuWkZgcnX1S+rjBJAYG7WqR6eK5qkhr6LqiVKEUprcxnfaIICpLf47+eSBMjemx
         ZEwQ==
X-Gm-Message-State: APjAAAVHkEBDfqm7PUmX5t9Th7kNMclWZx2h9WoxwtdZwniBIj5+Gfz5
        mqW28riwiWwGVEUE3WfOjME=
X-Google-Smtp-Source: APXvYqxKq2oDlprFk1+QK2TFgGB5hdnvvHi3lXqLm35fMfkoRjqwMH0R05FaBJfIZvrz79we+8RMcg==
X-Received: by 2002:a63:2cc8:: with SMTP id s191mr7137691pgs.206.1579636815427;
        Tue, 21 Jan 2020 12:00:15 -0800 (PST)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id d2sm261576pjv.18.2020.01.21.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 12:00:15 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH V2 1/3] dt: bindings: brcmnand: Add support for flash-edu
Date:   Tue, 21 Jan 2020 15:00:06 -0500
Message-Id: <20200121200011.32296-1-kdasu.kdev@gmail.com>
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

