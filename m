Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9509BC2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A365206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw8jxJiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgC1CeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 22:34:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40327 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1CeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 22:34:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id c9so10367746qtw.7;
        Fri, 27 Mar 2020 19:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9FUiJnnr5PX2/0tdiYpKEU/w0yDcw3x3MQa3IPxCF8=;
        b=dw8jxJiID7bRFJDPdTiFwwqJqlfjX8HMUqDHr9GcqNPu75kEYsuaXT2+KaS0/6++f4
         LZOvHSW2v/zvknpClBWQM7Zwx2+FNLjxlA8T4OzUs+ZspSE8yczmu1lZzpfUnrd1JIpN
         jHB0qR5Byz+lihhGJomIy1bm6TjbuT8BXUq1FJgWjArqYzbhn+0j3Uif6epT2udRORX1
         2bp26WjVxHi4lry9YPi/tjIjiuneeEAkvp+T4qGJsaizPBQmQzmyuP4nLjEfNMTz1XNl
         /nRYEEPf8u62CGK78uTIo+0C3WvACle7rdEmQk0xSmvSgiOuwY19xNY33f9WPYr6OpRH
         vjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9FUiJnnr5PX2/0tdiYpKEU/w0yDcw3x3MQa3IPxCF8=;
        b=YPdEnDnMwuGBe2XeiZcGsUnLgwBSHoxDMJrOxPzK8FwLzpP+TUvyO3dtlehc3paxwN
         s9/5H8aT4i0g6Neydb7jKgEkNkWoKSTX1QfLN4PLxYiXa5tSPjfFRya/7/oDq50Wz6sk
         yzxBYMqTZaU8xG53Jl+ZsKTLGNYSFqMQnn0ktKODGN31RnZjL9nyZHC1598lso800+Jq
         DdG3gCwAbE/DiOL2KikqssabqHVNigaHU3LHFj3/JyCtv4Vfjn9bp48cR3NpduNCc4AT
         /w8VhR5tNx0fj6N9TpZIGRPqgkndwY7ew9CPYMg1rmkWOFCiUeL0/zUl83a0nczICVz+
         8p3A==
X-Gm-Message-State: ANhLgQ25O4BCT65EbAl6ZmqO9JawmdsqkHUHPug5hkC07va8adF30tOF
        oiRRHa2Hvjx9HsVFGLTktAg=
X-Google-Smtp-Source: ADFU+vv8zDTvr87UFUjjRLpX/3/jOQn9JKQUGc8o7COhSoa7xaMmmQ5xMhKlPTxhG/DT6jD+iHVfxg==
X-Received: by 2002:ac8:3565:: with SMTP id z34mr2390096qtb.168.1585362853420;
        Fri, 27 Mar 2020 19:34:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id p191sm5069913qke.6.2020.03.27.19.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 19:34:12 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mn: Change SDMA1 ahb clock for imx8mn
Date:   Fri, 27 Mar 2020 21:33:53 -0500
Message-Id: <20200328023353.156929-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using SDMA1 with UART1 is causing a "Timeout waiting for CH0" error.
This patch changes to ahb clock from SDMA1_ROOT to AHB which fixes the
timeout error.

Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi support")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a44b5438e842..882e913436ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -661,7 +661,7 @@ sdma1: dma-controller@30bd0000 {
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_SDMA1_ROOT>,
-					 <&clk IMX8MN_CLK_SDMA1_ROOT>;
+					 <&clk IMX8MN_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.25.1

