Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5969C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A57920738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691335;
	bh=0/hszbWEWY+uc1pMJXENVvjhlqC59WOheY0I+GsN32Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zAAzZXgRL4LN+QkDzXCRmWUUrWOflsuV6NIZguNovGLthxYEuGhsOzX8k1FRs/Ud4
	 64LSThhmdZizZOb/1AwzwcyJgcrRtCefhmRzSq/+1PavXbHgpoI5fbWs0v3HAm1+LZ
	 IsdwjgZh4AHH0tlonGtmEzfagRKYWOL5V7O0kyKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392037AbgHQTIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbgHQPmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:42:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA9920760;
        Mon, 17 Aug 2020 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678968;
        bh=0/hszbWEWY+uc1pMJXENVvjhlqC59WOheY0I+GsN32Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQx9louYzBvCiw2ItBQJGKA9y/BYnDPLyYaM6hx3qr2yvBgRrQasgBdV9mGYv93CW
         Q5YRTNp7CrDBRLdBFTs7L789qSC1KZX7XbC79EkUkW02QgrcXCmX764SkRWQercq/X
         Z1AYSZFG+7kad4Sw6OalTBKT+jsh50/jBDjQ7nZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 024/393] arm64: dts: sun50i-pinephone: dldo4 must not be >= 1.8V
Date:   Mon, 17 Aug 2020 17:11:14 +0200
Message-Id: <20200817143820.775296147@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

[ Upstream commit 86be5c789690eb08656b08c072c50a7b02bf41f1 ]

Some outputs from the RTL8723CS are connected to the PL port (BT_WAKE_AP),
which runs at 1.8V. When BT_WAKE_AP is high, the PL pin this signal is
connected to is overdriven, and the whole PL port's voltage rises
somewhat. This results in changing voltage on the R_PWM pin (PL10),
which is the cause for backlight flickering very noticeably when typing
on a Bluetooth keyboard, because backlight intensity is highly sensitive
to the voltage of the R_PWM pin.

Limit the maximum WiFi/BT I/O voltage to 1.8V to avoid overdriving
the PL port pins via BT and WiFi IO port signals. WiFi and BT
functionality is unaffected by this change.

This completely stops the backlight flicker when using bluetooth.

Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for Pine64 PinePhone")
Signed-off-by: Ondrej Jirman <megous@megous.com>
Link: https://lore.kernel.org/r/20200703194842.111845-4-megous@megous.com
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index cefda145c3c9d..342733a20c337 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -279,7 +279,7 @@ &reg_dldo3 {
 
 &reg_dldo4 {
 	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <3300000>;
+	regulator-max-microvolt = <1800000>;
 	regulator-name = "vcc-wifi-io";
 };
 
-- 
2.25.1



