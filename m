Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E0CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD5B2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="sDRzU2RP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgEDUTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:19:22 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:41009 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgEDUTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:19:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GDj13YWCzHm;
        Mon,  4 May 2020 22:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588623557; bh=qurSsxw8gxgEaJlTZWv0ARKxkbeqg3RGBABaCIKMM88=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=sDRzU2RPd2KjzxAPOMF2noX+pvHaC9OwStIvcGrLzkuLxqeNz3ibG/nGOu42/f1BV
         KvbnqnyIQqsJA/znkkxGstMNQ/KtxjYjkbARTrxb1vpxHJv7pCNfzvnaC2w0KGuv6m
         Q1rbGJZINnONr8SnSsqj4VZHhn2GoSiN7w30y45MtNaJF+2t3B8xydyItTfqoRX0cW
         +1XiBstqtqJ71g2EAIX7bVlO2y4+4PZ4wc0wgLQ24VJsX5RzyvWU1cZm1Ec8rVhDIC
         IqHiVpd4bZZ4CPi6nIArvEvwj+0lHJ1/xtS0mCZmzpSGkDO+7d2wB1jdTypOuoA7er
         uwf1WxFDOQbeg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 22:19:17 +0200
Message-Id: <fd3fb7de733608bc49db5d3628335b75b7759f9b.1588623391.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588623391.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588623391.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 1/3] clk: at91: optimize pmc data allocation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alloc whole data structure in one block. This makes the code shorter,
more efficient and easier to extend in following patch.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
v2: rebase and update to clk/clk-at91 branch
v3: use struct_size() and C99 trailing array
    as suggested by Stephen Boyd
v4: fixed sign-off
v5: no changes
v6: no changes
---
 drivers/clk/at91/at91sam9260.c |  2 +-
 drivers/clk/at91/at91sam9rl.c  |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  2 +-
 drivers/clk/at91/pmc.c         | 34 ++++++++--------------------------
 drivers/clk/at91/pmc.h         |  3 ++-
 drivers/clk/at91/sam9x60.c     |  2 +-
 drivers/clk/at91/sama5d2.c     |  2 +-
 drivers/clk/at91/sama5d4.c     |  2 +-
 8 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index a9d4234758d7..946f03a09858 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -462,7 +462,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	return;
 
 err_free:
-	pmc_data_free(at91sam9260_pmc);
+	kfree(at91sam9260_pmc);
 }
 
 static void __init at91sam9260_pmc_setup(struct device_node *np)
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 77fe83a73bf4..cc739d214ae3 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -166,6 +166,6 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	return;
 
 err_free:
-	pmc_data_free(at91sam9rl_pmc);
+	kfree(at91sam9rl_pmc);
 }
 CLK_OF_DECLARE_DRIVER(at91sam9rl_pmc, "atmel,at91sam9rl-pmc", at91sam9rl_pmc_setup);
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 086cf0b4955c..aac99d699568 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -278,7 +278,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	return;
 
 err_free:
-	pmc_data_free(at91sam9x5_pmc);
+	kfree(at91sam9x5_pmc);
 }
 
 static void __init at91sam9g15_pmc_setup(struct device_node *np)
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index b71515acdec1..ac46ea1b9fda 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -76,48 +76,30 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data)
 	return ERR_PTR(-EINVAL);
 }
 
-void pmc_data_free(struct pmc_data *pmc_data)
-{
-	kfree(pmc_data->chws);
-	kfree(pmc_data->shws);
-	kfree(pmc_data->phws);
-	kfree(pmc_data->ghws);
-}
-
 struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
 				   unsigned int nperiph, unsigned int ngck)
 {
-	struct pmc_data *pmc_data = kzalloc(sizeof(*pmc_data), GFP_KERNEL);
+	unsigned int num_clks = ncore + nsystem + nperiph + ngck;
+	struct pmc_data *pmc_data;
 
+	pmc_data = kzalloc(struct_size(pmc_data, hwtable, num_clks),
+			   GFP_KERNEL);
 	if (!pmc_data)
 		return NULL;
 
 	pmc_data->ncore = ncore;
-	pmc_data->chws = kcalloc(ncore, sizeof(struct clk_hw *), GFP_KERNEL);
-	if (!pmc_data->chws)
-		goto err;
+	pmc_data->chws = pmc_data->hwtable;
 
 	pmc_data->nsystem = nsystem;
-	pmc_data->shws = kcalloc(nsystem, sizeof(struct clk_hw *), GFP_KERNEL);
-	if (!pmc_data->shws)
-		goto err;
+	pmc_data->shws = pmc_data->chws + ncore;
 
 	pmc_data->nperiph = nperiph;
-	pmc_data->phws = kcalloc(nperiph, sizeof(struct clk_hw *), GFP_KERNEL);
-	if (!pmc_data->phws)
-		goto err;
+	pmc_data->phws = pmc_data->shws + nsystem;
 
 	pmc_data->ngck = ngck;
-	pmc_data->ghws = kcalloc(ngck, sizeof(struct clk_hw *), GFP_KERNEL);
-	if (!pmc_data->ghws)
-		goto err;
+	pmc_data->ghws = pmc_data->phws + nperiph;
 
 	return pmc_data;
-
-err:
-	pmc_data_free(pmc_data);
-
-	return NULL;
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 9b8db9cdcda5..fc3ef772b9d9 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -24,6 +24,8 @@ struct pmc_data {
 	struct clk_hw **phws;
 	unsigned int ngck;
 	struct clk_hw **ghws;
+
+	struct clk_hw *hwtable[];
 };
 
 struct clk_range {
@@ -95,7 +97,6 @@ struct clk_pcr_layout {
 #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
 struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
 				   unsigned int nperiph, unsigned int ngck);
-void pmc_data_free(struct pmc_data *pmc_data);
 
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range);
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index cc19e8fb83be..a7d4f648db26 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -299,7 +299,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	return;
 
 err_free:
-	pmc_data_free(sam9x60_pmc);
+	kfree(sam9x60_pmc);
 }
 /* Some clks are used for a clocksource */
 CLK_OF_DECLARE(sam9x60_pmc, "microchip,sam9x60-pmc", sam9x60_pmc_setup);
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index ff7e3f727082..b2560670e5af 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -350,6 +350,6 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	return;
 
 err_free:
-	pmc_data_free(sama5d2_pmc);
+	kfree(sama5d2_pmc);
 }
 CLK_OF_DECLARE_DRIVER(sama5d2_pmc, "atmel,sama5d2-pmc", sama5d2_pmc_setup);
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index a6dee4a3b6e4..4ca9a4619500 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -267,6 +267,6 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	return;
 
 err_free:
-	pmc_data_free(sama5d4_pmc);
+	kfree(sama5d4_pmc);
 }
 CLK_OF_DECLARE_DRIVER(sama5d4_pmc, "atmel,sama5d4-pmc", sama5d4_pmc_setup);
-- 
2.20.1

