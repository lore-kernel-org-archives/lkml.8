Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0595CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF9621D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442559;
	bh=X4xB1K/pK6AIDnqxWt4QrweV8512VBFuawqM9U17/ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YV1dDxIOmpCf3CCTpxYAnCPSN+ASYZnfPVuZ/P+EdY6Bck0moJ4hTcoooliAJfVhY
	 7wtkkrNkjOi3hWBp5iEKOnP0/99ID3MwidZjj938tEjA2UrdBOTsRurAMkuwSr4TNk
	 55rwJE1lbBghdzbx3POVwO9XPk0O4wsmT/dobprY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFRBJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbgFRBJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:09:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A04A82193E;
        Thu, 18 Jun 2020 01:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442551;
        bh=X4xB1K/pK6AIDnqxWt4QrweV8512VBFuawqM9U17/ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSrJdBsCQbsSoesdi//jRKg3+ZAwXI1eZ6ZxdyecIgVGiAxrhALNh3Q1++pbr3oy3
         0e3ASt7LC/2S4cFnkP0njzk4zP9Y3w/FZ1aPx0LMVDhpcxwU2qZucdE7V+FAf/tnWX
         MwzCrdLItYjles4ftwqWztO+ewQjTOOco+DI+3a8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 049/388] arm64: dts: armada-3720-turris-mox: fix SFP binding
Date:   Wed, 17 Jun 2020 21:02:26 -0400
Message-Id: <20200618010805.600873-49-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <marek.behun@nic.cz>

[ Upstream commit c2671acbbbd822ef077cc168991e0a7dbe2172c9 ]

The sfp compatible should be 'sff,sfp', not 'sff,sfp+'. We used patched
kernel where the latter was working.

Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 47fee66c70cb..0e0491ca2930 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -95,7 +95,7 @@ sdhci1_pwrseq: sdhci1-pwrseq {
 	};
 
 	sfp: sfp {
-		compatible = "sff,sfp+";
+		compatible = "sff,sfp";
 		i2c-bus = <&i2c0>;
 		los-gpio = <&moxtet_sfp 0 GPIO_ACTIVE_HIGH>;
 		tx-fault-gpio = <&moxtet_sfp 1 GPIO_ACTIVE_HIGH>;
-- 
2.25.1

