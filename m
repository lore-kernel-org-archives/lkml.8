Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E758AC5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56912073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="ioOI8Qk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDVPKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgDVPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:10:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558EBC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:10:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so2844691wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6MfGdNbZJAtx4H50hH+DJeAeTdpR6Yb4aC2XJdjmZcs=;
        b=ioOI8Qk02luRJQZNiFXlin0DEScq6GZWagj2tKS5PCDSEhMedbS13Q4GNVvzdo2vy4
         DZwFDXZ7sgv6C1VQ1pPCh63UL1VIydQ8FZLGh4iO0qj5SUeykL+uxy36VcPptq1QxJFu
         H8Bqx688cpISC/FaFWDhhLMCGttqs8YXW0oS79uH2Kfn3Qe2JHUqyDOqIaa05yAR3rAh
         vwdYYk5qN4Da9GCsLoRneIqq9QxqcpnFYInTzYrwEKLpvVRLZOyH9fdYQ6/khF3tnmUl
         y+cteCPFRB4DlyyrNd+165c8hOI7XfrBAo3g0Q7csVGy9ZuRYYxJltoS4WEXR0bP6qjs
         gJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6MfGdNbZJAtx4H50hH+DJeAeTdpR6Yb4aC2XJdjmZcs=;
        b=NdyFjYKxsBUJN63XXyPxhqEApNmIA+VOTyBti3nccVwA75I4gTycgZfFDm1sUOsF9U
         LefcowniKeOnrpwckhvLsxMbJrjkymj2m4jyvDLgXnPxCHIHYmKP+MY8sAv4/gYkq4Bq
         hXThVCS2h6byIbBsTeDF60zt5r3H/GxARKekUDmJ1Xy2WsCoixbaQik5ly9MNHsBl3Vv
         +mPk1dKSImURM4ZHbTK/7C6vei1mDCW0RYBw+MUG0EcOSC0tyA4Dmw10fz45l9pSZPEN
         F8/np+fdI7iT88+aRYli3Yg/+DcCQEje5dlspxJoaRSKADYCev0EQLBsZ1tompculRvC
         7mFQ==
X-Gm-Message-State: AGi0PubxjBxIWc0kT9ciEkB28vpkx2FGXPqTxo9Anjwpia1EdtHRL9pc
        ZpS9MUF7anFU+dfg9x9PmeM8lg==
X-Google-Smtp-Source: APiQypJxOab/iAg7Da5ViwCTxFBi4v/oDkYFV5ylPpVXFYWtYN+0CYNdP05BuGEA0h9tODKNKecFxw==
X-Received: by 2002:a5d:4dd1:: with SMTP id f17mr28911341wru.383.1587568233067;
        Wed, 22 Apr 2020 08:10:33 -0700 (PDT)
Received: from localhost ([188.252.226.236])
        by smtp.gmail.com with ESMTPSA id s14sm7901194wmh.18.2020.04.22.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 08:10:32 -0700 (PDT)
From:   Jakov Petrina <jakov.petrina@sartura.hr>
To:     jason@lakedaemon.net
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        vladimir.vid@sartura.hr, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: [PATCH] arm: dts: uDPU: switch PHY operation mode to 2500base-x
Date:   Wed, 22 Apr 2020 17:09:15 +0200
Message-Id: <20200422150915.3355073-1-jakov.petrina@sartura.hr>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves issues with certain SPF modules.

Signed-off-by: Jakov Petrina <jakov.petrina@sartura.hr>
Signed-off-by: Vladimir Vid <vladimir.vid@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 7eb6c1796cef..b6e2a9c68b2a 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -144,7 +144,7 @@ lm75@49 {
 };
 
 &eth0 {
-	phy-mode = "sgmii";
+	phy-mode = "2500base-x";
 	status = "okay";
 	managed = "in-band-status";
 	phys = <&comphy1 0>;
@@ -152,7 +152,7 @@ &eth0 {
 };
 
 &eth1 {
-	phy-mode = "sgmii";
+	phy-mode = "2500base-x";
 	status = "okay";
 	managed = "in-band-status";
 	phys = <&comphy0 1>;
-- 
2.24.1

