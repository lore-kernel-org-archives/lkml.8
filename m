Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5867C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BB720709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="txDXsBLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFUyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:54:25 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:45787 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFUyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:54:24 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2567423E5E;
        Fri,  6 Mar 2020 21:54:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583528062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hzKqrLamkZ42gxVzayrqWzN/O0E6BMz8ovZ+w0kjSIo=;
        b=txDXsBLxUsMt5A8XawCp+G/wo0uMZ9rr6fYz1IJp+K4rneiMU8cp1mThpLnwFs+eQ3o4mk
        STTchkbnKERubAZVngr4SrehGvk4j4S0j3cS6e85HSE9T6I33SwiXw5SidJK6Ad2eOpSVM
        JUKl7oqEGi/Gy52hDOThCO6GDnv4fU8=
From:   Michael Walle <michael@walle.cc>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Peng Ma <peng.ma@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] arm64: dts: ls1028a: add "fsl,vf610-edma" compatible
Date:   Fri,  6 Mar 2020 21:54:03 +0100
Message-Id: <20200306205403.29881-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306205403.29881-1-michael@walle.cc>
References: <20200306205403.29881-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 2567423E5E
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.548];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bootloader does the IOMMU fixup and dynamically adds the "iommus"
property to devices according to its compatible string. In case of the
eDMA controller this property is missing. Add it. After that the IOMMU
will work with the eDMA core.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index b152fa90cf5c..aa467bff2209 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -447,7 +447,7 @@
 
 		edma0: dma-controller@22c0000 {
 			#dma-cells = <2>;
-			compatible = "fsl,ls1028a-edma";
+			compatible = "fsl,ls1028a-edma", "fsl,vf610-edma";
 			reg = <0x0 0x22c0000 0x0 0x10000>,
 			      <0x0 0x22d0000 0x0 0x10000>,
 			      <0x0 0x22e0000 0x0 0x10000>;
-- 
2.20.1

