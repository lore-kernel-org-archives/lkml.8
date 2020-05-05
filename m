Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DCC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2901720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="WzXRH7om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgEEPAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729235AbgEEPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:00:55 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EC8C061A0F;
        Tue,  5 May 2020 08:00:54 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 94D3423E80;
        Tue,  5 May 2020 17:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1588690853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T8QHJzdQsqxKUorxv0i84+q/jnRbNR+waUrdwg8sxko=;
        b=WzXRH7omIgdod2GwSr7P7NftvohR0t4Z6U/E+DQhKjCkTzaBB6v013s/9EAZW8xkJrpOCB
        5LH8ly/cRqlGucUBJr3oqx/91F/JiXnHp0IaLASdw83rbiHODqxxEmFDqoPURkXME2DpDw
        p7Ylps13Qk4orZFSTsF0mxPa6AnlrNY=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: freescale: sl28: enable LPUART1
Date:   Tue,  5 May 2020 17:00:37 +0200
Message-Id: <20200505150037.32573-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the LPUART has support for the LS1028A SoC, also enable it on
our board.

Signed-off-by: Michael Walle <michael@walle.cc>
---

Hi Shawn,

After adding/fixing the LPUART support for the LS1028A I've forgot to send
this patch to actually enable the LPUART on our boards. It would be great
if this could make it into the fixes queue for the -rc. If not its also ok.

Thanks,
-michael

 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 5eac8a6ab46f..360b3a168c10 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -17,6 +17,7 @@
 		crypto = &crypto;
 		serial0 = &duart0;
 		serial1 = &duart1;
+		serial2 = &lpuart1;
 		spi0 = &fspi;
 		spi1 = &dspi2;
 	};
@@ -189,3 +190,7 @@
 		pagesize = <32>;
 	};
 };
+
+&lpuart1 {
+	status = "okay";
+};
-- 
2.20.1

