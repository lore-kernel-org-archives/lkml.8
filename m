Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CFAC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C489F20885
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930019;
	bh=ieYQdzrY3+Von0WGrYWU5T18p5B4q0CSlpJT2dOY+EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1ZCGAgq+IUS6upGqn9fCUEUfp95kbukwUcQMqTcp7qTepfzvkOt0hyJF8piXIpIh
	 kPWnPP83eK0lOAp5t8na2lF6e6NeFd2cIrDYP2U4Yxid1VKiTINuOazGnrWCGTFE99
	 C1G/MVA01m59QsZx7gQUpy1cuk+5gHTR0TQKWz3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgHHXkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbgHHXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:40:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D6620716;
        Sat,  8 Aug 2020 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596930007;
        bh=ieYQdzrY3+Von0WGrYWU5T18p5B4q0CSlpJT2dOY+EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhiVjE/itkdfhtH9pQMgOaV7pGGDgae0EnBBmyDombtwkl7l/kad9yvZCjanJ+nDj
         /85EqbsDEsqc4pSO4PlJwaFN7nZxlNPKFT1nPE0EduRIN2geWTCPsRoY99n3QKiGkK
         /en1rWY1IL2QPi+TR79l/BjOKEawYYAqYQ8k8rzU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/21] ARM: dts: gose: Fix ports node name for adv7180
Date:   Sat,  8 Aug 2020 19:39:37 -0400
Message-Id: <20200808233941.3619277-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233941.3619277-1-sashal@kernel.org>
References: <20200808233941.3619277-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit d344234abde938ae1062edb6c05852b0bafb4a03 ]

When adding the adv7180 device node the ports node was misspelled as
port, fix this.

Fixes: 8cae359049a88b75 ("ARM: dts: gose: add composite video input")
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20200704155856.3037010-2-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 6b2f3a4fd13d6..9235be8f0f007 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -339,7 +339,7 @@ composite-in@20 {
 			reg = <0x20>;
 			remote = <&vin1>;
 
-			port {
+			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-- 
2.25.1

