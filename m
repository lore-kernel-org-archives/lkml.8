Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C417C43459
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15DC2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vwY0DxAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgGPSVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:21:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36066 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgGPSU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:20:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06GIKedO019894;
        Thu, 16 Jul 2020 13:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594923640;
        bh=cydmKQhdfnYTmfxeA1V/UTrs4wag2D0hxMQWxeyyt0g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vwY0DxAR0E3w1ODjTCdAMhbYw1FUHVPKy8NxRq5vk6L3ZbAa1eAvDh2Fooqm7lGkn
         I1KX7WhJMiMwsdHX+B7WOY3ZgkoN97VrX2ELcHbd1m7veB5LjWZRY7pn1bNjBxC9H3
         NCV725Rh3wVLy9ie1KjmTgARMfPisMe0pHuxert0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06GIKeoS087349
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 13:20:40 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 16
 Jul 2020 13:20:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 16 Jul 2020 13:20:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06GIKejc090137;
        Thu, 16 Jul 2020 13:20:40 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh@kernel.org>,
        <marek.behun@nic.cz>
CC:     <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v31 07/12] ARM: defconfig: u8500: Add LP55XX_COMMON config flag
Date:   Thu, 16 Jul 2020 13:20:02 -0500
Message-ID: <20200716182007.18389-8-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716182007.18389-1-dmurphy@ti.com>
References: <20200716182007.18389-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependencies for the LP55XX LED drivers have been updated so that
the child devices (i.e. LP5521) now depends on the LP55XX_COMMON config
flag as opposed to the device selecting the LP55XX_COMMON flag.  The
LP55XX_COMMON needs to be set in the defconfig.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/configs/u8500_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 28dd7cf56048..dea599e1c17e 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -113,6 +113,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_LM3530=y
 CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_LP55XX_COMMON=y
 CONFIG_LEDS_LP5521=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
-- 
2.27.0

