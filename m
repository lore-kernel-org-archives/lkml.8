Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800C9C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5707820880
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738527;
	bh=ta6P7W4Qxx76cOxWAlSlu27XJGWgczrHYC2HaYJxa4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lqH00XbD0+hUvfFF/niO8jxP9Trd1c03mD0ANYPUKjAa7ACFmrw9MJb9jOYgj2O6w
	 qwB9N1Ka9K8W1cZexKftUXRMDZdubEuEvVIgqckJdifu3sxz3wQI7LL6dRvCH3rkss
	 q/XZ8I1O2b5qmTI21xxLjGfSQH/tD/9W25mYnVw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgAKK2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:28:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbgAKK2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:28:42 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EBD20842;
        Sat, 11 Jan 2020 10:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738521;
        bh=ta6P7W4Qxx76cOxWAlSlu27XJGWgczrHYC2HaYJxa4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmAFWTT0D51njg+k6A88p6jq2Y7H8Uw0C2+7Q5OK7zONNKzYrsyxWBn7n5zuyBFSY
         wzGz4G0nNwc+cL3bTI5cNOZB+zD9PSNPrFhQUpL4U2393b4zgI2y2pyS3EComqI/o7
         5Y044l//2YYfWGmNwzSj2dsMZdFuA/BOpC/7T+ys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 093/165] clk: at91: fix possible deadlock
Date:   Sat, 11 Jan 2020 10:50:12 +0100
Message-Id: <20200111094929.009311856@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 6956eb33abb5deab2cd916b4c31226b57736bc3c ]

Lockdep warns about a possible circular locking dependency because using
syscon_node_to_regmap() will make the created regmap get and enable the
first clock it can parse from the device tree. This clock is not needed to
access the registers and should not be enabled at that time.

Use the recently introduced device_node_to_regmap to solve that as it looks
up the regmap in the same list but doesn't care about the clocks.

Reported-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lkml.kernel.org/r/20191128102531.817549-1-alexandre.belloni@bootlin.com
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/at91/at91sam9260.c | 2 +-
 drivers/clk/at91/at91sam9rl.c  | 2 +-
 drivers/clk/at91/at91sam9x5.c  | 2 +-
 drivers/clk/at91/pmc.c         | 2 +-
 drivers/clk/at91/sama5d2.c     | 2 +-
 drivers/clk/at91/sama5d4.c     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 0aabe49aed09..a9d4234758d7 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -348,7 +348,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 0ac34cdaa106..77fe83a73bf4 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -83,7 +83,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 0855f3a80cc7..086cf0b4955c 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -146,7 +146,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 0b03cfae3a9d..b71515acdec1 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -275,7 +275,7 @@ static int __init pmc_register_ops(void)
 
 	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
 
-	pmcreg = syscon_node_to_regmap(np);
+	pmcreg = device_node_to_regmap(np);
 	if (IS_ERR(pmcreg))
 		return PTR_ERR(pmcreg);
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 0de1108737db..ff7e3f727082 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -162,7 +162,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 25b156d4e645..a6dee4a3b6e4 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -136,7 +136,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
-- 
2.20.1



