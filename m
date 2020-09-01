Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F18C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137002064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974893;
	bh=4JnsdTGj/2nkFYG2TIBnS6ZWAGrfNDmIoYlXW1EQwJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FOAsNCdolb7f5mORwMT13jN72xlzabxPzMBYktvirGPL8aRdMWekPjrsb2q6sEXSS
	 cJNC7zVqKopF6y+qpXjzAINrzg68EXc48aTtseD1lajK065SCxOn+ZH0FC3GdB+23C
	 yNPGWs/afxHVQss6sDp7y+k9nO+plDWpKyGCuYbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgIAPla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbgIAPjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:39:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2290320866;
        Tue,  1 Sep 2020 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974759;
        bh=4JnsdTGj/2nkFYG2TIBnS6ZWAGrfNDmIoYlXW1EQwJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dj/19nkkYx6++qce1joW0CpRvTb0pQVJdyCSJ1ghR41E9tgDt4xJZuia0vETvDRY3
         DQmCQnoqN9wLIs94sG29NBjih1Wp2vG8gx8bgRsjx38b7whOQdytqF3jNZPo+63fAc
         hHJu0Pnc5VW807/M0ZRTiiCOVZx4JD7dBFZnfRu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sham Muthayyan <smuthayy@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 079/255] PCI: qcom: Add missing ipq806x clocks in PCIe driver
Date:   Tue,  1 Sep 2020 17:08:55 +0200
Message-Id: <20200901151004.518354390@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ansuel Smith <ansuelsmth@gmail.com>

[ Upstream commit 8b6f0330b5f9a7543356bfa9e76d580f03aa2c1e ]

Aux and Ref clk are missing in PCIe qcom driver. Add support for this
optional clks for ipq8064/apq8064 SoC.

Link: https://lore.kernel.org/r/20200615210608.21469-2-ansuelsmth@gmail.com
Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5dd1740855770..aa25a3040f7cc 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -106,6 +106,8 @@ struct qcom_pcie_resources_2_1_0 {
 	struct clk *iface_clk;
 	struct clk *core_clk;
 	struct clk *phy_clk;
+	struct clk *aux_clk;
+	struct clk *ref_clk;
 	struct reset_control *pci_reset;
 	struct reset_control *axi_reset;
 	struct reset_control *ahb_reset;
@@ -264,6 +266,14 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->phy_clk))
 		return PTR_ERR(res->phy_clk);
 
+	res->aux_clk = devm_clk_get_optional(dev, "aux");
+	if (IS_ERR(res->aux_clk))
+		return PTR_ERR(res->aux_clk);
+
+	res->ref_clk = devm_clk_get_optional(dev, "ref");
+	if (IS_ERR(res->ref_clk))
+		return PTR_ERR(res->ref_clk);
+
 	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
 	if (IS_ERR(res->pci_reset))
 		return PTR_ERR(res->pci_reset);
@@ -296,6 +306,8 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
 	clk_disable_unprepare(res->phy_clk);
+	clk_disable_unprepare(res->aux_clk);
+	clk_disable_unprepare(res->ref_clk);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -326,16 +338,28 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_assert_ahb;
 	}
 
+	ret = clk_prepare_enable(res->core_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable core clock\n");
+		goto err_clk_core;
+	}
+
 	ret = clk_prepare_enable(res->phy_clk);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable phy clock\n");
 		goto err_clk_phy;
 	}
 
-	ret = clk_prepare_enable(res->core_clk);
+	ret = clk_prepare_enable(res->aux_clk);
 	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_core;
+		dev_err(dev, "cannot prepare/enable aux clock\n");
+		goto err_clk_aux;
+	}
+
+	ret = clk_prepare_enable(res->ref_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable ref clock\n");
+		goto err_clk_ref;
 	}
 
 	ret = reset_control_deassert(res->ahb_reset);
@@ -411,10 +435,14 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	return 0;
 
 err_deassert_ahb:
-	clk_disable_unprepare(res->core_clk);
-err_clk_core:
+	clk_disable_unprepare(res->ref_clk);
+err_clk_ref:
+	clk_disable_unprepare(res->aux_clk);
+err_clk_aux:
 	clk_disable_unprepare(res->phy_clk);
 err_clk_phy:
+	clk_disable_unprepare(res->core_clk);
+err_clk_core:
 	clk_disable_unprepare(res->iface_clk);
 err_assert_ahb:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-- 
2.25.1



