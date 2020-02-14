Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F307C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D88024649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703936;
	bh=bnOL5fjRatBmkkTriyNL4q9SJ8zUH9lQkVmaEAXikjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eAbjgamekiAjXXZ3C3yn4O/FU8p3VYyqtmHLEB6PvuLk9wvDZnAdiq94KbD3M34Zc
	 rFfyJuGBJ/hNVjVR7I/QKa6Te9VfZ1sHiYYxt8G3KJcUhFy3Ka5NeQa1R4SPE6rcr3
	 itkbcesWnRu0G2RvcGepR7vb35WKczbAnK8lxdNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393229AbgBNSMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:12:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731181AbgBNPxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:53:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89FBD222C4;
        Fri, 14 Feb 2020 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695593;
        bh=bnOL5fjRatBmkkTriyNL4q9SJ8zUH9lQkVmaEAXikjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqQtUy94FCZqxUvqAeaKCXjoOMmKpwIUxEddH0GXdtU7P+6b4bzRNJG+Z5Ia/7oSg
         J7uq5bZ3MkxAm7/l3nMczbmAMfMO1FBCtil6UrbKflBulGWpCvPQAHkakCDfOvTk9K
         y7Y4lZHkVS55Pk+p8A385BYxgnhdiHA6zuDfwHSs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 199/542] ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
Date:   Fri, 14 Feb 2020 10:43:11 -0500
Message-Id: <20200214154854.6746-199-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

[ Upstream commit 6bb1e09c4c375db29770444f689f35f5cbe696bc ]

Cabling used to connect devices to USBH1 on RDU2 does not meet USB
spec cable quality and cable length requirements to operate at High
Speed, so limit the port to Full Speed only.

Reported-by: Chris Healy <cphealy@gmail.com>
Reviewed-by: Chris Healy <cphealy@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 4ec9fb332610e..cbafadbe86f45 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -776,6 +776,7 @@
 &usbh1 {
 	vbus-supply = <&reg_5p0v_main>;
 	disable-over-current;
+	maximum-speed = "full-speed";
 	status = "okay";
 };
 
-- 
2.20.1

