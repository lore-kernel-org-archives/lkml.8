Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591A7C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C6120848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581504536;
	bh=N1tkP7F+IlbxHuqVwHuZJZlGwpiLxK/pweFWiNUDUtQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=A98uTqEhuTwawauUwHzIH5Y7Sg2Eas7VhI08nU7PmbprT585/TUDqtWwv+x0ll8O6
	 OsyJQL6Z1N00F2N+6Ojho69QcYvwoTAqNxUZdvWGOWe8HZO1lTAHjScx2Ggw+z9OCu
	 eckBQOvtIu2ITxItxcN5xNHX41aQr6OPFZYgMIYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgBLKsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:48:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38191 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBLKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:48:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so1258536lfm.5;
        Wed, 12 Feb 2020 02:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cOkNp66IGoQbIflyXRDkdZ3dKJJtmUFr8g6WgxcLYs8=;
        b=CAJoA1ztI3mTqhtCEk7Ln0b4YXl3JY42cv4U0/4VblhA8/W2Li8u0WWnH2jDbhPp+Y
         Zb2PJVuejhaSwRex8yopmuJc7AFPY0D6+y4wOJQQDenizfCakdlwEEdzCzLDodAIoBDV
         nUI19lSLfCN5f5k6uAFNqEyynG/c4IaNNFcETaXSq1vcCLFHopnHnXWxMHdcauuwEwVS
         HX0Je0LMWrcNW9P2JpJlT7JgP4xxbpMP74jVZe8tMT6wnLIWM1zK5n+hDyQrYDrwWM+r
         aU5sTNjW5f96SvHAjyFsIfJ3wBr6ml6/gOLeySifx/cKjAvCQOKyW/PqPaHcnAuaubMQ
         hrJg==
X-Gm-Message-State: APjAAAUe+J9oJj2L0TXVkEfnOYJox+eU6jsMkT5l7l1XnyCPWCuRk4yn
        mArlTRamYoj5dSOsM8UwrDE=
X-Google-Smtp-Source: APXvYqxluaCgDZHx5bFLBMtgb6LfHNDKKEinjQYRPkvz+HQ6X2hXcu02cJCOk2LtsrSTKZbrVPLwSA==
X-Received: by 2002:a19:c82:: with SMTP id 124mr6277588lfm.152.1581504533060;
        Wed, 12 Feb 2020 02:48:53 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id 138sm80214lfa.76.2020.02.12.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:48:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1j1pZb-0005Ji-J9; Wed, 12 Feb 2020 11:48:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] dt-bindings: dma: ti-edma: fix example compatible property
Date:   Wed, 12 Feb 2020 11:48:40 +0100
Message-Id: <20200212104840.20393-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the compatible string in the edma1_tptc1 example node
matches the binding by removing the space between the manufacturer and
model.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
index 0e1398f93aa2..29fcd37082e8 100644
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -180,7 +180,7 @@ edma1_tptc0: tptc@27b0000 {
 };
 
 edma1_tptc1: tptc@27b8000 {
-	compatible = "ti, k2g-edma3-tptc", "ti,edma3-tptc";
+	compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
 	reg =	<0x027b8000 0x400>;
 	power-domains = <&k2g_pds 0x4f>;
 };
-- 
2.24.1

