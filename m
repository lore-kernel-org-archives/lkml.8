Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B98C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3461422B4E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597923686;
	bh=mtsko70TWTc6ttCymmwY8gqp2jWH6kl8tFnY4Qf8wsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7OYLfRlA+KXURT+MPM1W6OUAbBMluUnmz8poz7mZKbuiHTd2Y1a+YnLIm4q2/SO8
	 r/hDPbuV2DQLfx8hYDwA1nFLo4dfUfmEqdpJ+zrmjIvBvg3Hb8fceJRRBcsqRQe0KD
	 2gKn3jUxbFmM8oJuG+UPfTM9Vr2w59tsDIoEDJmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgHTLlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730621AbgHTKEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:04:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE9020738;
        Thu, 20 Aug 2020 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917887;
        bh=mtsko70TWTc6ttCymmwY8gqp2jWH6kl8tFnY4Qf8wsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgBUDJCZ6RYBwSDJFupOOihlMku+XPgK+bNX9pqeGMC6FscrAGu9+3VmTGmHvshIa
         bxX4t/RfYOr6zmXl6qAxTN6WscjSS7EdS6Ug2T3z5ORPMK4YiapIeYo/p/njqIgXaY
         SLfwSuxwYn9babjNHkjoTS0uqQ3jotIERrjbsjxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 192/212] mfd: arizona: Ensure 32k clock is put on driver unbind and error
Date:   Thu, 20 Aug 2020 11:22:45 +0200
Message-Id: <20200820091612.075808891@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit ddff6c45b21d0437ce0c85f8ac35d7b5480513d7 ]

Whilst it doesn't matter if the internal 32k clock register settings
are cleaned up on exit, as the part will be turned off losing any
settings, hence the driver hasn't historially bothered. The external
clock should however be cleaned up, as it could cause clocks to be
left on, and will at best generate a warning on unbind.

Add clean up on both the probe error path and unbind for the 32k
clock.

Fixes: cdd8da8cc66b ("mfd: arizona: Add gating of external MCLKn clocks")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/arizona-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 1f0c2b594654e..3382845d4b67d 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -1537,6 +1537,15 @@ int arizona_dev_init(struct arizona *arizona)
 	arizona_irq_exit(arizona);
 err_pm:
 	pm_runtime_disable(arizona->dev);
+
+	switch (arizona->pdata.clk32k_src) {
+	case ARIZONA_32KZ_MCLK1:
+	case ARIZONA_32KZ_MCLK2:
+		arizona_clk32k_disable(arizona);
+		break;
+	default:
+		break;
+	}
 err_reset:
 	arizona_enable_reset(arizona);
 	regulator_disable(arizona->dcvdd);
@@ -1558,6 +1567,15 @@ int arizona_dev_exit(struct arizona *arizona)
 	regulator_disable(arizona->dcvdd);
 	regulator_put(arizona->dcvdd);
 
+	switch (arizona->pdata.clk32k_src) {
+	case ARIZONA_32KZ_MCLK1:
+	case ARIZONA_32KZ_MCLK2:
+		arizona_clk32k_disable(arizona);
+		break;
+	default:
+		break;
+	}
+
 	mfd_remove_devices(arizona->dev);
 	arizona_free_irq(arizona, ARIZONA_IRQ_UNDERCLOCKED, arizona);
 	arizona_free_irq(arizona, ARIZONA_IRQ_OVERCLOCKED, arizona);
-- 
2.25.1



