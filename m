Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF24C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887882087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599503653;
	bh=t266Nu1lB7LStASkQx6vx6QrRbEc2k7w1JLEvAlzAJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nYbwH/bLztARnQko8jd8ONl1MSTj82ZcBQR0uMHUTy52U63VrIatuEoVwWFApyQxr
	 2gzx/IsesvnKW/6vbPBCL0s3bHA1qTseF2w3MwWaXy1lB4FsNPWN41zV+Joy2obB83
	 YMkFcKNz+ySTQD9NDTlcrfoOwx11DUSvxuEUuu3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgIGSeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730226AbgIGSdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:33:54 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0FA72087D;
        Mon,  7 Sep 2020 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599503634;
        bh=t266Nu1lB7LStASkQx6vx6QrRbEc2k7w1JLEvAlzAJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUBHzOWIgCRdcU0dSwV3do+czaKmzBjG/mqhWRLUmK5mQkpZdrxYisfCl2NN/sRWf
         v9Q4apQPRU2UhKc3dwOO7KbfQtnBY8IFUywDR8798XNegaf0770XfhU6Z8Pagitg8i
         KJQPGkxPXp3CiH0aK0F3vGuaiGYsbVwX3gVZyPFA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lihua Yao <ylhuajnu@outlook.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 10/11] ARM: dts: s3c24xx: add address to CPU node
Date:   Mon,  7 Sep 2020 20:33:12 +0200
Message-Id: <20200907183313.29234-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907183313.29234-1-krzk@kernel.org>
References: <20200907183313.29234-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU nodes should be described as children of "cpus" bus node with
appropriate "reg" properties:

  cpus: '#address-cells' is a required property
  cpus: '#size-cells' is a required property
  cpu: 'device_type' is a required property
  cpu: 'reg' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c2416.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index d1dec9f52f69..4f084f4fe44f 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -18,8 +18,13 @@
 	};
 
 	cpus {
-		cpu {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
 			compatible = "arm,arm926ej-s";
+			reg = <0x0>;
 		};
 	};
 
-- 
2.17.1

