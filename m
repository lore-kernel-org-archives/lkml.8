Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C2CC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B85F20661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200637;
	bh=Nj6XKZCEDxGaXQwinQLQ2eXpL34/hG9ANdGyJ2pmAbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZBO4TrcNoUSP5pNLZMv0zZ8mEUUtuHDqF9kknt/CkZEs02iiiF1oRibhYCrictfKM
	 pYI4fIEh57lYDbLDNY4sOz7B4SyA9I1U0tiQbMwWDRayDbyzJlSF+/ROli+KdIcKWO
	 v+ZB8TKMfT+mQxKF5jyJgcRv8t6NHQlvNG1nr4UM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbgAPRJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388255AbgAPRJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2334C2192A;
        Thu, 16 Jan 2020 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194541;
        bh=Nj6XKZCEDxGaXQwinQLQ2eXpL34/hG9ANdGyJ2pmAbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHuT7nlb+bZjAcA83Lp4WdzTSY9ABMLEFOk9j24pyRCMDkwFXBbjxt+VjaNCsKuBM
         1X2upgN3c0140osOHm5e/5ElfWt998xOYaIC/VPohYJnKd1BnX9B+hY7d6MMJ89Q6Q
         /J21zszYgn8gOCJrHfJbcKvK5xj6KcmyTNRe17mE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 427/671] ARM: dts: iwg20d-q7-common: Fix SDHI1 VccQ regularor
Date:   Thu, 16 Jan 2020 12:01:05 -0500
Message-Id: <20200116170509.12787-164-sashal@kernel.org>
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

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

[ Upstream commit d211650a87edc7f4130651c0ccbc0a4583fd72d3 ]

SDR50 isn't working anymore because the GPIO regulator
driver is using descriptors since
commit d6cd33ad7102 ("regulator: gpio: Convert to use descriptors")
which in turn causes the system to use the polarity of the
GPIOs (as specified in the DT) for selecting the states,
but the polarity specified in the DT is wrong.
This patch fixes the regulator DT definition, and that fixes
SDR50.

Fixes: 029efb3a03c5 ("ARM: dts: iwg20d-q7: Add SDHI1 support")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 5cae74eb6cdd..a2c9a1e88c1a 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -87,7 +87,7 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 
-		gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;
 		gpios-states = <1>;
 		states = <3300000 1
 			  1800000 0>;
-- 
2.20.1

