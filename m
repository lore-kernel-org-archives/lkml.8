Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD5AC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8402D207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271435;
	bh=L39ewZIAQLtVWClce3+6QIzm4nk1mjYhAteFKAvrzdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xt1mQLUmPmex/UH5hBX2ke6fkzH2Ly2o7vxPcUDmuhdHK3bcK5dFkIrDr5qGEETU6
	 sry3OPOV09vx04UwvG0ens896XIwaha6CKIEhmJfJgQSCBGMC0GfB6TQVn47Y5lqrB
	 Is3GOzKi3vtpupIWSqnxviBdsGsR9Bf0ony/iOOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgBUHue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:50:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbgBUHu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:50:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E486A207FD;
        Fri, 21 Feb 2020 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271428;
        bh=L39ewZIAQLtVWClce3+6QIzm4nk1mjYhAteFKAvrzdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RL5IlDzyA5s61lzslSA6k9sOy6/sMhPWvOBJS2zV1Zt7WWLLon27fRKRTHiIjvjgR
         HMHYrRAMuR6kF3OmmPJddg9UHnRdrdjy6YUAYT9amFhB8922IdBUprMTO1XT2mXx+s
         nYT/EsIL6svOmt/P4m39HFSZIxBcUNfEg3XKRGJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 163/399] clk: qcom: smd: Add missing bimc clock
Date:   Fri, 21 Feb 2020 08:38:08 +0100
Message-Id: <20200221072418.446985310@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

[ Upstream commit 87ec9adcca71801a44ddb311185b17df09839ab5 ]

It turns out booting the modem is dependent on a bimc vote from Linux on
msm8998.  To make the modem happy, add the bimc clock to rely on the
default vote from rpmcc.  Once we have interconnect support, bimc should
be controlled properly.

Fixes: 6131dc81211c ("clk: qcom: smd: Add support for MSM8998 rpm clocks")
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Link: https://lkml.kernel.org/r/20191217165409.4919-1-jeffrey.l.hugo@gmail.com
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 930fa4a4c52a8..e5c3db11bf26c 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -648,6 +648,7 @@ static const struct rpm_smd_clk_desc rpm_clk_qcs404 = {
 };
 
 /* msm8998 */
+DEFINE_CLK_SMD_RPM(msm8998, bimc_clk, bimc_a_clk, QCOM_SMD_RPM_MEM_CLK, 0);
 DEFINE_CLK_SMD_RPM(msm8998, pcnoc_clk, pcnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
 DEFINE_CLK_SMD_RPM(msm8998, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
 DEFINE_CLK_SMD_RPM(msm8998, cnoc_clk, cnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 2);
@@ -671,6 +672,8 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk2_pin, rf_clk2_a_pin, 5);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6);
 DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin, 6);
 static struct clk_smd_rpm *msm8998_clks[] = {
+	[RPM_SMD_BIMC_CLK] = &msm8998_bimc_clk,
+	[RPM_SMD_BIMC_A_CLK] = &msm8998_bimc_a_clk,
 	[RPM_SMD_PCNOC_CLK] = &msm8998_pcnoc_clk,
 	[RPM_SMD_PCNOC_A_CLK] = &msm8998_pcnoc_a_clk,
 	[RPM_SMD_SNOC_CLK] = &msm8998_snoc_clk,
-- 
2.20.1



