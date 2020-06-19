Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E994C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2754D20771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581869;
	bh=9bnpDbtIjXuK5hf81+Zi0XxGmFb2an6nsBRCwIBobCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUKKD/mjTsV5Gq+Ag2WFXe94DPuVr/Zc/T26VNoiFRsjo4dO2p2rDIWO8iKMJFzZd
	 8eFs1kRJcYU3z4X29zb2X3iaFGVc35zEHdFjtd8NSqJpr3d68Ag59ekOpAnQi9WZ2L
	 JCWZWsYD0QjUQXVvIp8+nQ6d7rcboG2DQXAH7Mco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404031AbgFSPYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392705AbgFSPUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:20:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74AB20706;
        Fri, 19 Jun 2020 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580032;
        bh=9bnpDbtIjXuK5hf81+Zi0XxGmFb2an6nsBRCwIBobCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nv0khmXpvNa5lz0VofQUqRpH2pPq6zXDQdbWvME482nCSjGYvvM95hBKwuV/6qltb
         /xtokXDkeSR29bdEwrtTXGmYBXQ+NLoBNojn38mMjXecxN2kistXJ8YsCloqY37Rcm
         mC7Km+kG1LteGeQe4C/xlB00198c3AyWh3pzqzQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 097/376] dt-bindings: display: mediatek: control dpi pins mode to avoid leakage
Date:   Fri, 19 Jun 2020 16:30:15 +0200
Message-Id: <20200619141714.940296667@linuxfoundation.org>
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

From: Jitao Shi <jitao.shi@mediatek.com>

[ Upstream commit b0ff9b590733079f7f9453e5976a9dd2630949e3 ]

Add property "pinctrl-names" to swap pin mode between gpio and dpi mode.
Set the dpi pins to gpio mode and output-low to avoid leakage current
when dpi disabled.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/display/mediatek/mediatek,dpi.txt   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
index 58914cf681b8..77def4456706 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
@@ -17,6 +17,9 @@ Required properties:
   Documentation/devicetree/bindings/graph.txt. This port should be connected
   to the input port of an attached HDMI or LVDS encoder chip.
 
+Optional properties:
+- pinctrl-names: Contain "default" and "sleep".
+
 Example:
 
 dpi0: dpi@1401d000 {
@@ -27,6 +30,9 @@ dpi0: dpi@1401d000 {
 		 <&mmsys CLK_MM_DPI_ENGINE>,
 		 <&apmixedsys CLK_APMIXED_TVDPLL>;
 	clock-names = "pixel", "engine", "pll";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dpi_pin_func>;
+	pinctrl-1 = <&dpi_pin_idle>;
 
 	port {
 		dpi0_out: endpoint {
-- 
2.25.1



