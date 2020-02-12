Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3004C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8873C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581504403;
	bh=xOU7PQkgW4q9YMHWoFq9bb7nNnTDoGpTbdZfbr70KEY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oIz0poxYIhasEctzBRX/4qvsyHCY5XoPX568Eh0w+2JqjZcK10fJ5N+8hDu1r0EsY
	 2/lQuIN+uAYEnlmCt36o3715rsHyyfVeceEtJJ9kyXQkLWlifyAFGst3BoF8yxAtpu
	 SnLo1Fie3a6nwlamGVgLe7By2DTyQHs+oonvU3MU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBLKqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:46:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38295 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBLKqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:46:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so1746568ljh.5;
        Wed, 12 Feb 2020 02:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vy/8LlDz/KObVyLZSWteSlNQfy03Ob41JwklHt6HAa8=;
        b=s6WyuQ68jAoEWy3fnzI+cGcNhrP9ESXoooeXtf4FzJZEcPEOT2zQquzcu6TIpr+2Mw
         XxL3YGoVI9NzFDwhLR0JMQwKF4BZaIF1nRtBneBk9q/jqjJbVF4ZLdpJKDUxKOWiAmCI
         Bdjula21mItCuu9AAE1/9UNCIT/sgdvha92ZZUJQUF2lJhU4izDj+VE8xBbl+EQwGNn7
         jRN3fveWHVLYO4jli9fm2H+A6lCmymOm0F+y3uKdKDso6tfcuSj6ajEAYlW9mTUR4prk
         SZRJc8sJBuj518/GEO460CoK2oYMFRjTmMWKTvFtTPANvZOijvasFF1Zbu8m8jDam/Bm
         FK+A==
X-Gm-Message-State: APjAAAUsRsBAxz8qlwhsHogokgVW8SplMfEIsnWivBhyc//Dr4S0TJvL
        K5F6agwyfSsvdsKAVqLEF7w=
X-Google-Smtp-Source: APXvYqyPcIz3R22UQSDl/z8PePXUGeJFtGavWO9nR4gTSGiD2x1BrksDbc0O7BxHh6ChHZgQ8mhxlQ==
X-Received: by 2002:a2e:a490:: with SMTP id h16mr18671lji.115.1581504400351;
        Wed, 12 Feb 2020 02:46:40 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id g15sm40369ljl.10.2020.02.12.02.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:46:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1j1pXS-0005Hh-Q9; Wed, 12 Feb 2020 11:46:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH] ARM: dts: imx6dl-colibri-eval-v3: fix sram compatible properties
Date:   Wed, 12 Feb 2020 11:46:29 +0100
Message-Id: <20200212104629.20272-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sram-node compatible properties have mistakingly combined the
model-specific string with the generic "mtd-ram" string.

Note that neither "cy7c1019dv33-10zsxi, mtd-ram" or
"cy7c1019dv33-10zsxi" are used by any in-kernel driver and they are
not present in any binding.

The physmap driver will however bind to platform devices that specify
"mtd-ram".

Fixes: fc48e76489fd ("ARM: dts: imx6: Add support for Toradex Colibri iMX6 module")
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index cd075621de52..84fcc203a2e4 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -275,7 +275,7 @@ &weim {
 
 	/* SRAM on Colibri nEXT_CS0 */
 	sram@0,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
 		reg = <0 0 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -286,7 +286,7 @@ sram@0,0 {
 
 	/* SRAM on Colibri nEXT_CS1 */
 	sram@1,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
 		reg = <1 0 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.24.1

