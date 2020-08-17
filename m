Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D0B206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597679957;
	bh=PkKczme5tW5pmLkOMAZI0L7Dfxsl6ApuLO0C0aQmgH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lnRDdxUUZ70xlgzV3JsNJID8V74fEfiOjtawc6wZMEky/uGa+4sh72ztObqTAnMmw
	 h9z6TCklzm5ecc1havxDYjR6OlWV5QNc0zqULd9oNGMMzF4cRWt9rYBtRJtAfD/jUx
	 6a3iaoN1bcViVh5Vazj7fQlLPASMkH8x16f47hKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbgHQP7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387560AbgHQPme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:42:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79F6222BF3;
        Mon, 17 Aug 2020 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678954;
        bh=PkKczme5tW5pmLkOMAZI0L7Dfxsl6ApuLO0C0aQmgH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMHpHeqGc+saEF/9YC8PL8WTKq7+aQg0EjN+UfR9It0OrgXYnZhQYcg0YVQxymhZ5
         JW12ROvWTt+pJzSFh3sRn91oWS5LAFNkFJUWCMnBzOZrKqe6aw4JJtYByItm3FxTTo
         6G/bDDdsA292wWPiwi3DcOyFHKxKYp2F9/ZWCtSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 046/393] arm64: dts: meson: fix mmc0 tuning error on Khadas VIM3
Date:   Mon, 17 Aug 2020 17:11:36 +0200
Message-Id: <20200817143821.850179161@linuxfoundation.org>
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

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit f1bb924e8f5b50752a80fa5b48c43003680a7b64 ]

Similar to other G12B devices using the W400 dtsi, I see reports of mmc0
tuning errors on VIM3 after a few hours uptime:

[12483.917391] mmc0: tuning execution failed: -5
[30535.551221] mmc0: tuning execution failed: -5
[35359.953671] mmc0: tuning execution failed: -5
[35561.875332] mmc0: tuning execution failed: -5
[61733.348709] mmc0: tuning execution failed: -5

I do not see the same on VIM3L, so remove sd-uhs-sdr50 from the common dtsi
to silence the error, then (re)add it to the VIM3L dts.

Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
Fixes: 700ab8d83927 ("arm64: dts: khadas-vim3: add support for the SM1 based VIM3L")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Link: https://lore.kernel.org/r/20200721015950.11816-1-christianshewitt@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi     | 1 -
 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 1ef1e3672b967..ff5ba85b7562e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -270,7 +270,6 @@ &sd_emmc_a {
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index dbbf29a0dbf6d..026b21708b078 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -88,6 +88,10 @@ &pcie {
 	status = "okay";
 };
 
+&sd_emmc_a {
+	sd-uhs-sdr50;
+};
+
 &usb {
 	phys = <&usb2_phy0>, <&usb2_phy1>;
 	phy-names = "usb2-phy0", "usb2-phy1";
-- 
2.25.1



