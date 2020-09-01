Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C0C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D95206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977786;
	bh=Zn5iuplSmikrE6kXcerU2XXERhdllL1cvIoyTaS5vW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zXercJ14dA0pwOhvypZ0eNvv5pKEww6jDmqzwbpU7f/onuuE5ez3f3K456SejrRjF
	 4gb/ulzKmtELcDxpY6PgwugnTeFkTjdbhcFByv+ntuExAIeWTehAKdVjsAzmS4cvPB
	 kW4IlxTZuALwxnkK48/q8Ldz8iDftKSIg/j868Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgIAPb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730526AbgIAP3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:29:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9961E20684;
        Tue,  1 Sep 2020 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974172;
        bh=Zn5iuplSmikrE6kXcerU2XXERhdllL1cvIoyTaS5vW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jOhnLvxQo0+QvhUrhhc13l4QbUSyv7HBVYSdheEfN80uSDzYErBIdr7CIh9t881f4
         R5lPquPZypIeTkyp/E3E7/Y7lo/PhOXe+s1vDtlcTlUkqp86K8otXDO784Zzv7Wl7E
         6OTvuGMUyqhbwFxnLe2+P09Jbt4k7lI21Mv97PXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/214] PM / devfreq: rk3399_dmc: Fix kernel oops when rockchip,pmu is absent
Date:   Tue,  1 Sep 2020 17:09:13 +0200
Message-Id: <20200901150956.473202802@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 63ef91f24f9bfc70b6446319f6cabfd094481372 ]

Booting a recent kernel on a rk3399-based system (nanopc-t4),
equipped with a recent u-boot and ATF results in an Oops due
to a NULL pointer dereference.

This turns out to be due to the rk3399-dmc driver looking for
an *undocumented* property (rockchip,pmu), and happily using
a NULL pointer when the property isn't there.

Instead, make most of what was brought in with 9173c5ceb035
("PM / devfreq: rk3399_dmc: Pass ODT and auto power down parameters
to TF-A.") conditioned on finding this property in the device-tree,
preventing the driver from exploding.

Cc: stable@vger.kernel.org
Fixes: 9173c5ceb035 ("PM / devfreq: rk3399_dmc: Pass ODT and auto power down parameters to TF-A.")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/rk3399_dmc.c | 42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 24f04f78285b7..027769e39f9b8 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -95,18 +95,20 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 
 	mutex_lock(&dmcfreq->lock);
 
-	if (target_rate >= dmcfreq->odt_dis_freq)
-		odt_enable = true;
-
-	/*
-	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
-	 * timings and to enable or disable the ODT (on-die termination)
-	 * resistors.
-	 */
-	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
-		      dmcfreq->odt_pd_arg1,
-		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
-		      odt_enable, 0, 0, 0, &res);
+	if (dmcfreq->regmap_pmu) {
+		if (target_rate >= dmcfreq->odt_dis_freq)
+			odt_enable = true;
+
+		/*
+		 * This makes a SMC call to the TF-A to set the DDR PD
+		 * (power-down) timings and to enable or disable the
+		 * ODT (on-die termination) resistors.
+		 */
+		arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
+			      dmcfreq->odt_pd_arg1,
+			      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
+			      odt_enable, 0, 0, 0, &res);
+	}
 
 	/*
 	 * If frequency scaling from low to high, adjust voltage first.
@@ -371,13 +373,14 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	}
 
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
-	if (node) {
-		data->regmap_pmu = syscon_node_to_regmap(node);
-		of_node_put(node);
-		if (IS_ERR(data->regmap_pmu)) {
-			ret = PTR_ERR(data->regmap_pmu);
-			goto err_edev;
-		}
+	if (!node)
+		goto no_pmu;
+
+	data->regmap_pmu = syscon_node_to_regmap(node);
+	of_node_put(node);
+	if (IS_ERR(data->regmap_pmu)) {
+		ret = PTR_ERR(data->regmap_pmu);
+		goto err_edev;
 	}
 
 	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
@@ -399,6 +402,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		goto err_edev;
 	};
 
+no_pmu:
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
 		      ROCKCHIP_SIP_CONFIG_DRAM_INIT,
 		      0, 0, 0, 0, &res);
-- 
2.25.1



