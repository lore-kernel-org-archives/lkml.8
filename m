Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B793AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2672073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202272;
	bh=MjlK7QQIMLtiwZMtfGCJVeq9TdAvUUqsvkIw//F19u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QVznvq2e3gcdsGwRyILYu40qR5KtC8IpiBv25rYahQFRfhl+NslkIl/zatquSF4Yi
	 /H1K+tvKfS+vnAsw8iXyXkYt8aUiEm2Qb/vrP8PJkhlJKvrN4iQKiq0FcU0W+idBcP
	 swpdyTh9PczVuEdqtQ4ECQGl+3U7wz+quqVG03sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbgAPQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730682AbgAPQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5175824656;
        Thu, 16 Jan 2020 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193707;
        bh=MjlK7QQIMLtiwZMtfGCJVeq9TdAvUUqsvkIw//F19u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3M2P9jzaa7mcugPnfOPRFF9X8/u49Ud+/aiXknYZw7HKRJLJ4Ubrooxt1ae1U7zX
         kgFPpNwxY4BN/6py4PNSBFXxHLfsZq+WXSRnK8ClU77BiG4fAlgcBj3kRmvvALmKuV
         XVMIxe6TDo72wJxE4wGRZJTvexy2R+i9O2cxL7+A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 003/671] ARM: dts: at91: nattis: make the SD-card slot work
Date:   Thu, 16 Jan 2020 11:43:54 -0500
Message-Id: <20200116165502.8838-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit f52eb2067929d533babe106fbc131c88db3eff3d ]

The cd-gpios signal is assumed active-low by the driver, and the
cd-inverted property is needed if it is, in fact, active-high. Fix
this oversight.

Fixes: 0e4323899973 ("ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index bfa5815a0721..4308a07b792e 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -221,6 +221,7 @@
 		reg = <0>;
 		bus-width = <4>;
 		cd-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+		cd-inverted;
 	};
 };
 
-- 
2.20.1

