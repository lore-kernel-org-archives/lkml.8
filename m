Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D085C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE5A2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661937;
	bh=5LLjVvfKIhhhhAkFZRcbjo1i0HT3vVmmCAbHlZmRPu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1CKmcyVzOiBpgRP9clNHgkvTSAw71rAD/cOByK1w9itsPU+DHMq7McyCETdsF3kKi
	 ycndUkJKf24XBSv0tDsqOLYdpK7PKt7QjBwtTkDdj+oSDj8NqM8rknhdyyAyxk2fou
	 hqyWBHctKqrM7ZePM4z9KQftpAMJunZEZYlUIJNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbgFIAS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730642AbgFHXSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACC8F2088E;
        Mon,  8 Jun 2020 23:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658310;
        bh=5LLjVvfKIhhhhAkFZRcbjo1i0HT3vVmmCAbHlZmRPu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqMOUOUXzw7EppOfjI6E/lRtrNk2N5ggpW4fFArH6JQlNa0IoONwRe5wFmK9IzfxF
         aQAvfIne7v53da6KEFDzRn9AhVQKXdU4cbh0widUUOBsQ6xUeJtCCQ7ayr4MIsyX8V
         XEHJEJ9jYwpl+C/9QHpCm4OXC2CLebkg8+06JA1M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 311/606] ARM: dts: mmp3-dell-ariel: Fix the SPI devices
Date:   Mon,  8 Jun 2020 19:07:16 -0400
Message-Id: <20200608231211.3363633-311-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit 233cbffaa0b9ca874731efee67a11f005da1f87c ]

I've managed to get about everything wrong while digging these out of
OEM's board file.

Correct the bus numbers, the exact model of the NOR flash, polarity of
the chip selects and align the SPI frequency with the data sheet.

Tested that it works now, with a slight fix to the PXA SSP driver.

Link: https://lore.kernel.org/r/20200419171157.672999-16-lkundrak@v3.sk
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/mmp3-dell-ariel.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/mmp3-dell-ariel.dts b/arch/arm/boot/dts/mmp3-dell-ariel.dts
index 15449c72c042..b0ec14c42164 100644
--- a/arch/arm/boot/dts/mmp3-dell-ariel.dts
+++ b/arch/arm/boot/dts/mmp3-dell-ariel.dts
@@ -98,19 +98,19 @@ &twsi4 {
 	status = "okay";
 };
 
-&ssp3 {
+&ssp1 {
 	status = "okay";
-	cs-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
+	cs-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
 
 	firmware-flash@0 {
-		compatible = "st,m25p80", "jedec,spi-nor";
+		compatible = "winbond,w25q32", "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <40000000>;
+		spi-max-frequency = <104000000>;
 		m25p,fast-read;
 	};
 };
 
-&ssp4 {
-	cs-gpios = <&gpio 56 GPIO_ACTIVE_HIGH>;
+&ssp2 {
+	cs-gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.25.1

