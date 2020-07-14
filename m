Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0ABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2400223B0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753555;
	bh=euUSQ0+G+OQuEWGJtnQ7V1xuV+jzYS4hNg0f3Bg3v18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0inIMYglpGN6XwBVcMVQDIfBVFRX36/2S4iBl+JcDrYH+tHkOy6+wZZtjVwKnBbF
	 69V/5+Pa1A6AGEgojy7RlhiGIBilcuk/Di9lp23CvZgxy0SVMS3jKHe3z+GZ6Ys0xF
	 pMJA3+zX15nu8N+n7P4CVpKbmtVqp5NBthny25XI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgGNSxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbgGNSxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:53:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4921622B45;
        Tue, 14 Jul 2020 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752825;
        bh=euUSQ0+G+OQuEWGJtnQ7V1xuV+jzYS4hNg0f3Bg3v18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKyFmUUT90UlGJOaL0NJSOc2cTTHdoZ+F2/HiZFWu1kFx8XiomgYYYZYqj2pDjx9g
         V/DIXhgJmdKDkurEZU83X7PrAN3xlJuwbqLHk1BkmJYQVY0y9AF3J5+42lGBAKBpv4
         ICNE+IqE9JL4uWO3i+ovn5SPN8WTcm3EEd9W2Ddc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, maemo-leste@lists.dyne.org,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 007/166] ARM: dts: omap4-droid4: Fix spi configuration and increase rate
Date:   Tue, 14 Jul 2020 20:42:52 +0200
Message-Id: <20200714184116.228638624@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 0df12a01f4857495816b05f048c4c31439446e35 ]

We can currently sometimes get "RXS timed out" errors and "EOT timed out"
errors with spi transfers.

These errors can be made easy to reproduce by reading the cpcap iio
values in a loop while keeping the CPUs busy by also reading /dev/urandom.

The "RXS timed out" errors we can fix by adding spi-cpol and spi-cpha
in addition to the spi-cs-high property we already have.

The "EOT timed out" errors we can fix by increasing the spi clock rate
to 9.6 MHz. Looks similar MC13783 PMIC says it works at spi clock rates
up to 20 MHz, so let's assume we can pick any rate up to 20 MHz also
for cpcap.

Cc: maemo-leste@lists.dyne.org
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index e39eee628afd6..08a7d3ce383f2 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -13,8 +13,10 @@
 		#interrupt-cells = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		spi-max-frequency = <3000000>;
+		spi-max-frequency = <9600000>;
 		spi-cs-high;
+		spi-cpol;
+		spi-cpha;
 
 		cpcap_adc: adc {
 			compatible = "motorola,mapphone-cpcap-adc";
-- 
2.25.1



