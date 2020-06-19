Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6DDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B82020757
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580678;
	bh=efE9qh+gRAoqSgGMofKgX7fsB1wxtB4Sw4lVk2loedU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HIV0BQaIEDmO7i3IPNMBea1hkKnBOuJps6LgjDqBv9kyAAaB088zxU5AQrycu73nr
	 hNX7B6SOHLGfFB8bSjMbwuIkRd4LIycEMRR9wTYzz3wDgqEkQ1LIfjYzmHSWqYa15t
	 qC2kkKE6F+nPd66k1zvNwwhCyqg4JK57hLYsus9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393804AbgFSPbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393769AbgFSPbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:31:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E156B206B7;
        Fri, 19 Jun 2020 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580661;
        bh=efE9qh+gRAoqSgGMofKgX7fsB1wxtB4Sw4lVk2loedU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvTIgpKaU90H6WMuuca8gpoa1UrtTZREIQgXhfDl1rZIjegOJkiCAvSkhvUWMwkrt
         3NlpbIZ7tdtw6ZpJuS/0ELsL6oqeZR5ANWzDK0I9M04G2WT+n4xEgKngaFhq40B5vk
         CU/W6H6Up/XVmds1PSWj8oH52UInpQzAPPjhN9oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.7 334/376] ARM: dts: exynos: Fix GPIO polarity for thr GalaxyS3 CM36651 sensors bus
Date:   Fri, 19 Jun 2020 16:34:12 +0200
Message-Id: <20200619141726.139875972@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 8807d356bfea92b0a8f04ce421800ed83400cd22 upstream.

GPIO lines for the CM36651 sensor I2C bus use the normal not the inverted
polarity. This bug has been there since adding the CM36651 sensor by
commit 85cb4e0bd229 ("ARM: dts: add cm36651 light/proximity sensor node
for exynos4412-trats2"), but went unnoticed because the "i2c-gpio"
driver ignored the GPIO polarity specified in the device-tree.

The recent conversion of "i2c-gpio" driver to the new, descriptor based
GPIO API, automatically made it the DT-specified polarity aware, what
broke the CM36651 sensor operation.

Fixes: 85cb4e0bd229 ("ARM: dts: add cm36651 light/proximity sensor node for exynos4412-trats2")
CC: stable@vger.kernel.org # 4.16+
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
+++ b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
@@ -68,7 +68,7 @@
 
 	i2c_cm36651: i2c-gpio-2 {
 		compatible = "i2c-gpio";
-		gpios = <&gpf0 0 GPIO_ACTIVE_LOW>, <&gpf0 1 GPIO_ACTIVE_LOW>;
+		gpios = <&gpf0 0 GPIO_ACTIVE_HIGH>, <&gpf0 1 GPIO_ACTIVE_HIGH>;
 		i2c-gpio,delay-us = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;


