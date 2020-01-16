Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA27C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AAD2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202419;
	bh=m8FwfF/7ssiYfl558Wspl69t91XkEG5uQyQsqlGl1m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EzEqUVwdwFpCD5pGjw4391xs3HwJdScaNDQXma/+KWgmNsVap7Qy3G4yN6YL9wG94
	 raHz9Uqv/e2Xv3WIfsZCjv0g2WlzLz8K8aDJS7c1u6PQzDnN/Iae3IO/z3I9uz6zrI
	 2BiSI9Kqy7GiEpk8XY258wv42az7o1MvraKRoXzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437624AbgAPTUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731455AbgAPQyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:54:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01172467A;
        Thu, 16 Jan 2020 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193642;
        bh=m8FwfF/7ssiYfl558Wspl69t91XkEG5uQyQsqlGl1m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0xgIW7lW7D81Hc61/FltlggPL9Q93BNGXf4ALoP6mW2yEVEXs/6hz+c3CRMH8SXW
         sYnzs8849wJcL82a0WS0B14d/BRxzhLsMzW1Fx1Ghs8ch5eP7EeUZnNvcTtuWrpht2
         10iYp/6o5y6T4PR1ZzQ0sv761CM4Ar6JrdP8K47M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 173/205] ARM: dts: Fix sgx sysconfig register for omap4
Date:   Thu, 16 Jan 2020 11:42:28 -0500
Message-Id: <20200116164300.6705-173-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 3e5c3c41ae925458150273e2f74ffbf999530c5f ]

Looks like we've had the sgx sysconfig register and revision register
always wrong for omap4, including the old platform data. Let's fix the
offsets to what the TRM says. Otherwise the sgx module may never idle
depending on the state of the real sysconfig register.

Fixes: d23a163ebe5a ("ARM: dts: Add nodes for missing omap4 interconnect target modules")
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 7cc95bc1598b..e5506ab669fc 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -330,8 +330,8 @@
 
 		target-module@56000000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			reg = <0x5601fc00 0x4>,
-			      <0x5601fc10 0x4>;
+			reg = <0x5600fe00 0x4>,
+			      <0x5600fe10 0x4>;
 			reg-names = "rev", "sysc";
 			ti,sysc-midle = <SYSC_IDLE_FORCE>,
 					<SYSC_IDLE_NO>,
-- 
2.20.1

