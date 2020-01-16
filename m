Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E937C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C0B24693
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194908;
	bh=xHcOnfwwM0uHhVJFzTJSecvsmr1mhXGmkpIu8atzssE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qc3nCuuhsFGQoEh9veqkwpbT+PKxBO8OsdFuQgihTRSey48T2wtD+1HXhoFtjdZb6
	 SDbqZdq3qgivi7s7yTssQJW2BP6Wk3gn3TNwHH1ile9QOPG8WJ2Xoo/5rryOov/u7F
	 b7RuGJSEEW8y/DncCaQPSv/V0Bf7Qtt1Wsdwh84s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391132AbgAPRPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391073AbgAPROn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:14:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341F22469D;
        Thu, 16 Jan 2020 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194883;
        bh=xHcOnfwwM0uHhVJFzTJSecvsmr1mhXGmkpIu8atzssE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGW2+6BaTMt9whcz48HDii99ywcxvHt/xu5ciqQpnfeZx0rHKH9eRS0SxynaDzk1K
         WspeyjfQ2Mtq4DU/f56EYDhuPJHsXIpFM3xJFbH3FIP64qH17t9UesyJoZMprQihfd
         +rv3JDav/RkVHjqNF2tojTIyEzeRAWLdT011D/aE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 671/671] arm64: dts: meson-gxm-khadas-vim2: fix uart_A bluetooth node
Date:   Thu, 16 Jan 2020 12:05:09 -0500
Message-Id: <20200116170509.12787-408-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit 388a2772979b625042524d8b91280616ab4ff5ee ]

Fixes: 33344e2111a3 ("arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth support")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 785240733d94..bdf7c6c5983c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -413,6 +413,9 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
 
-- 
2.20.1

