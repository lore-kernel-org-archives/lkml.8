Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A659AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9CC20768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217663;
	bh=K2m3pcjtFaB1WdUGw6/97iAE58R7nthpPofK+CoeoqM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uPKZdu47fil/UDHusQBWZm7eXAQjrgAHqmxaIma2IMAqLKEwb2Ccgz3D7o6gEJd5n
	 19xyJaoiIydUYg/hvnWltGhbksVIBijqLLfgdHjGWZdjJcmW9mmTF8/RMArXH92CSi
	 pEC3Xukh8oK175KQE1NRdEqxSRe9onADJCVboEmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDGABB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgDGABB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:01:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E6F620768;
        Tue,  7 Apr 2020 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217660;
        bh=K2m3pcjtFaB1WdUGw6/97iAE58R7nthpPofK+CoeoqM=;
        h=From:To:Cc:Subject:Date:From;
        b=Kknbdf+TIFolbtAz2Wr8pqEth8WWfUisNdQawJitN2wcMDnKoxmdIlekd4wirxnqW
         +4XfyZhdZy3/v2IGLZpFpUqS6Jg8ZS3YUhkkUxoyuWc+b0xqDNjOsJMfCyYu8CjNRr
         9kxKlt7S4iJQ4GvGi85h6gFR1jqvWHOD4wJCa2HE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 01/35] ARM: dts: sun8i-a83t-tbs-a711: HM5065 doesn't like such a high voltage
Date:   Mon,  6 Apr 2020 20:00:23 -0400
Message-Id: <20200407000058.16423-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

[ Upstream commit a40550952c000667b20082d58077bc647da6c890 ]

Lowering the voltage solves the quick image degradation over time
(minutes), that was probably caused by overheating.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index f781d330cff50..e8b3669e0e5d8 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -374,8 +374,8 @@
 };
 
 &reg_dldo3 {
-	regulator-min-microvolt = <2800000>;
-	regulator-max-microvolt = <2800000>;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
 	regulator-name = "vdd-csi";
 };
 
-- 
2.20.1

