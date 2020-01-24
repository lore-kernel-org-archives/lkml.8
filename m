Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FFAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6CF20838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876737;
	bh=m50/OUe2xxBl9ap4i6GvXtg5TbSS//D+WuXbEtrqyBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpvqU/k/vzzAE6sBA7gqsT24Q5yduE9ArEzfjNwguqBS2XcWQLfJXdNHGoVCkG9Yy
	 e9VdsnMuuvmY9WBZVEZHw7IC2PdMpMYmGQhkC8CqMOhAE1R0ECdde2nsOjWMXYlB3L
	 RdhhBUT8RXrFMiSrVv8EovH0XG6HaPhXn5Mb/vzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbgAXOi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390829AbgAXOSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09983214DB;
        Fri, 24 Jan 2020 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875512;
        bh=m50/OUe2xxBl9ap4i6GvXtg5TbSS//D+WuXbEtrqyBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnuHbv4w5H8IGIIkpACzs8EpBUJqgDKCXCC6LeLNXDSBu/Nl7IwJG/br7xjpUURCj
         Q3dICElUzHaBOBgLwXV+n78Qgi1BC/lyzqjjXrb8qPSJ/whjFQskJAzrCRnfmGpcB3
         1ZjRAVyaoxMF4n9Ftw2CEHeDXpm9JI76Ew8X7JMc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 013/107] ARM: dts: imx6q-dhcom: fix rtc compatible
Date:   Fri, 24 Jan 2020 09:16:43 -0500
Message-Id: <20200124141817.28793-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 7d7778b1396bc9e2a3875009af522beb4ea9355a ]

The only correct and documented compatible string for the rv3029 is
microcrystal,rv3029. Fix it up.

Fixes: 52c7a088badd ("ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM and PDK2")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-dhcom-som.dtsi b/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
index 387801dde02e2..08a2e17e0539b 100644
--- a/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
@@ -206,7 +206,7 @@
 	};
 
 	rtc@56 {
-		compatible = "rv3029c2";
+		compatible = "microcrystal,rv3029";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc_hw300>;
 		reg = <0x56>;
-- 
2.20.1

