Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EADC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AEF020639
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nzzQyiNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgIFSJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbgIFSJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 14:09:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6DC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 11:09:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so11420193wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQSqriQ+Oe6AXLkXoxURAgwhIAz5B8mg5HUOyceRaNE=;
        b=nzzQyiNa8rQcUAxBAKtcjxvn8Z/NBnTq1BCOt8tepxUgorNExl1s0ZkDz1CyCc70xC
         bB6xvUMwoV0UTUU+mv8bjg0hWZsvrsrou45DpBCu1+OOH5Vru8A0mFbQVD7cMcVkAOVp
         xropCu5NotExuTib2BY0RPN6qsRiItiRgcwYGWErDtodSMgW/THTIDr8AJDLBNSR/0Q8
         BuShhulLeCJf9gnEO/WeZi4COs/OvEoUU5TdwNCVZvKW9Y+iZoLCtao6AHDCc8bI6As4
         EVclkLAEDCZ+PzcLZF2pVQr+a11H8d7nHYuFG8LyislgqlcZphJTPeufC68EkzllDA7g
         lnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQSqriQ+Oe6AXLkXoxURAgwhIAz5B8mg5HUOyceRaNE=;
        b=qMojK+kPD6Rnb+4U3gaB14gGGj/YZrlCIJWevmjS6CptvqmcaUFbYx1CUsCPt98WNk
         XJEj5JaWE5uhumBQ6wGSdxMvMLIR7+ukQ1EOrPSvaLdfVPl+EkYoUtzioFGL2cOPoQcw
         RBJDm3d0CwMssYm3MTM5vZ+0wbZ1krrXYWvMDKRFK93Yf/p83RmRMgriJuDZ1md3NryW
         f8Z7MZllH1b8WugVIq+qiqKd5Tlw1ZGh3szHRWktRMYUn/lxMN84DPxKc/ogJFzmjW/n
         pWrc1hKidS30TKS5bThdYu5e+nhLhF+M5Q6YzVSq9tkKv+IS/gajyWbGAntO03RuGuOZ
         XwPQ==
X-Gm-Message-State: AOAM532HPl3VXXpZvIDQxk4+T8lzOLO2R8MArYgkECyU03B+VxTZ9cq9
        CvogyzVWpVoTfd8j5ZCU+OZfaA==
X-Google-Smtp-Source: ABdhPJwT0GnOgudgWfvSH7xfMSErDdiy138y71snJGOMmAaWrk+a+mBdo9cAwboSzipzn8KYwteQtw==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr17091888wml.139.1599415787873;
        Sun, 06 Sep 2020 11:09:47 -0700 (PDT)
Received: from localhost.localdomain (208.19.23.93.rev.sfr.net. [93.23.19.208])
        by smtp.gmail.com with ESMTPSA id s11sm24593937wrt.43.2020.09.06.11.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 11:09:47 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, krzk@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: mediatek: Add binding for MT8167 SMI
Date:   Sun,  6 Sep 2020 20:09:37 +0200
Message-Id: <20200906180938.1117526-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings documentation for MT8167 SMI.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/memory-controllers/mediatek,smi-common.txt        | 3 ++-
 .../bindings/memory-controllers/mediatek,smi-larb.txt          | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index b64573680b42..dbafffe3f41e 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -5,7 +5,7 @@ The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
 Mediatek SMI have two generations of HW architecture, here is the list
 which generation the SoCs use:
 generation 1: mt2701 and mt7623.
-generation 2: mt2712, mt6779, mt8173 and mt8183.
+generation 2: mt2712, mt6779, mt8167, mt8173 and mt8183.
 
 There's slight differences between the two SMI, for generation 2, the
 register which control the iommu port is at each larb's register base. But
@@ -20,6 +20,7 @@ Required properties:
 	"mediatek,mt2712-smi-common"
 	"mediatek,mt6779-smi-common"
 	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
+	"mediatek,mt8167-smi-common"
 	"mediatek,mt8173-smi-common"
 	"mediatek,mt8183-smi-common"
 - reg : the register and size of the SMI block.
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
index 8f19dfe7d80e..0c5de12b5496 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
@@ -8,6 +8,7 @@ Required properties:
 		"mediatek,mt2712-smi-larb"
 		"mediatek,mt6779-smi-larb"
 		"mediatek,mt7623-smi-larb", "mediatek,mt2701-smi-larb"
+		"mediatek,mt8167-smi-larb"
 		"mediatek,mt8173-smi-larb"
 		"mediatek,mt8183-smi-larb"
 - reg : the register and size of this local arbiter.
@@ -22,7 +23,7 @@ Required properties:
   - "gals": the clock for GALS(Global Async Local Sync).
   Here is the list which has this GALS: mt8183.
 
-Required property for mt2701, mt2712, mt6779 and mt7623:
+Required property for mt2701, mt2712, mt6779, mt7623 and mt8167:
 - mediatek,larb-id :the hardware id of this larb.
 
 Example:
-- 
2.28.0

