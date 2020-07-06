Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A70EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB94D206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZH/gSL6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgGFIhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgGFIhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:37:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF98C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 01:37:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 207so16496165pfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDPVa/N3+ZUhvoRViqdPQuinT4r2KBmw7AgHYWQpXaA=;
        b=ZH/gSL6NxrKlkOJdEjmRdJfg84atT3SGryBcqvwJxgXifGEQU/myuLaGsECCGWHy02
         hIpvBgTnrMsLWGrwRzi6MQw61zYE+LqvgbkC/Pa4YFYpPzfLti69KDZXzwkVCybQMiTh
         vgVvih10X5hM74DnXwSQGhxhVPlUn7lLkC6aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDPVa/N3+ZUhvoRViqdPQuinT4r2KBmw7AgHYWQpXaA=;
        b=bcpbVXDz5nOJWos8Cv+2rmPYzmXTJCavtTgKlyF18Gxvu7+Imlt2BqYvDJvUWlU0Iy
         +yAUcFCMvQ/zw/Xgbdu9Z5Xk3nM8IxnLQ0lprmR0BsisNTJS9rnTGWyi3hfIbTLi8d6+
         sWg4pMt7ZgufMRdcHMQ9QkYNdwmV/d15g48B/gl8mBJMmoz7TJAeGx8NsFuEpX8jQmPn
         auVmMrGYO1qOAeLGvzJGZGn1H8i4NKAdvSqBo5k8nNcL2HROHYLa3gzmBieTyekkyGqN
         Jj+cqhsgOPbSL0RgProjLN5YLK4F6+H2h+bHzXH1xJ1B0HGKPeewn8daaKWHKRFZgOpj
         YU3g==
X-Gm-Message-State: AOAM531XGPlmzOxzokZVitJ4fQTK/Axc5VGGp+fGRTa7Czd6J7AzXL8T
        2Dt8MrxQbBQHfNL0h0p+2xrQsQ==
X-Google-Smtp-Source: ABdhPJx0l2boOlf6QipzFSm9Oam/wQo9MTfVhN3BnUkyzGrJjWzbyT0fJys4WkerFMUBKouOJnQ8rQ==
X-Received: by 2002:a62:2ad0:: with SMTP id q199mr33712673pfq.229.1594024637530;
        Mon, 06 Jul 2020 01:37:17 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id bf11sm17657345pjb.48.2020.07.06.01.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 01:37:17 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        ikjn@chromium.org
Subject: [PATCH] arm64: dts: mt8173: Re-measure capacity-dmips-mhz
Date:   Mon,  6 Jul 2020 16:37:05 +0800
Message-Id: <20200706083705.2343150-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re measure capacity-dmips-mhz on elm and hana:

cpu 1:  9502 DMIPS @ 1703 Mhz
cpu 3: 16250 DMIPS @ 2106 Mhz

==> 740 : 1024

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 70b1ffcab7f0..5e046f9d48ce 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -167,7 +167,7 @@ cpu0: cpu@0 {
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
-			capacity-dmips-mhz = <526>;
+			capacity-dmips-mhz = <740>;
 		};
 
 		cpu1: cpu@1 {
@@ -182,7 +182,7 @@ cpu1: cpu@1 {
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
-			capacity-dmips-mhz = <526>;
+			capacity-dmips-mhz = <740>;
 		};
 
 		cpu2: cpu@100 {
-- 
2.27.0.212.ge8ba1cc988-goog

