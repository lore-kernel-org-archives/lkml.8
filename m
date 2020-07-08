Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F2EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EAF20774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594214918;
	bh=VhMSss2jA7ZhAMNmYaOiFgdnMaIpMf97N72d87vx7Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LcouR8ncLl+SK3qo01CL4RuOhoX3c9Vahq8dV9NUK/+EIX4vT1f2taWJ5uxwnrM6/
	 FWjME+q1uTuwtffhG7RwmH720lszmFbxmDtxdvK2MNTQl/6qqJRzfxJBIKKAXJCrT0
	 SH6Ue+W+CXiQmGdCEyHvk29GsqsALtTEfTqo05vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgGHN2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbgGHN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:28:35 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91EA220720;
        Wed,  8 Jul 2020 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594214915;
        bh=VhMSss2jA7ZhAMNmYaOiFgdnMaIpMf97N72d87vx7Gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCVvskzcXISwIX0hhlIjsLDR50x5u8DPdSbnWaotV7x7VQKs+030CtZD+x2jtQNqP
         bnX+WXRKoXTncGQBuAzKC6DTYO3JoZsVmqq/PMqIy/iNwi4P4ngjV18XdYjQKw4TON
         sfcF+kst0qp2jxO90ylqceEGtb25W+1fdFjTO9zM=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 6/6] phy: stm32: use NULL instead of zero
Date:   Wed,  8 Jul 2020 18:58:09 +0530
Message-Id: <20200708132809.265967-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708132809.265967-1-vkoul@kernel.org>
References: <20200708132809.265967-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_clk_get() and devm_reset_control_get() expect a const char *id for
the last arg, but a value of zero was provided. This results in below
sparse warning:

drivers/phy/st/phy-stm32-usbphyc.c:330:42: warning: Using plain integer as NULL pointer
drivers/phy/st/phy-stm32-usbphyc.c:343:52: warning: Using plain integer as NULL pointer

Instead of zero, use NULL

Cc: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 56bdea4b0bd9..2b3639cba51a 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -327,7 +327,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 	if (IS_ERR(usbphyc->base))
 		return PTR_ERR(usbphyc->base);
 
-	usbphyc->clk = devm_clk_get(dev, 0);
+	usbphyc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(usbphyc->clk)) {
 		ret = PTR_ERR(usbphyc->clk);
 		dev_err(dev, "clk get failed: %d\n", ret);
@@ -340,7 +340,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	usbphyc->rst = devm_reset_control_get(dev, 0);
+	usbphyc->rst = devm_reset_control_get(dev, NULL);
 	if (!IS_ERR(usbphyc->rst)) {
 		reset_control_assert(usbphyc->rst);
 		udelay(2);
-- 
2.26.2

