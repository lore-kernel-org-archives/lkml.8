Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F4AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926562479D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697483;
	bh=MLyC7p5DCKqMmpilfaOF4DuT3roGEBIotitr0W0Cwvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FQbOIQYsxOkuq7b0nFFDPymvReVRvWMDQoBpf34Szc0lQElQNGAz9A7nYwixqE9me
	 Cb10e/90IrpYGcClbJoHuoU3PKm7DQvJBzLsJOov8AWigkX3CviwXZ97Uvrip3j1vV
	 +L6VcaLwqiaRFLE93H0lKHF8yZsuBXZXAabNBbk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405959AbgBNQYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393004AbgBNQWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:22:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1604224764;
        Fri, 14 Feb 2020 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697374;
        bh=MLyC7p5DCKqMmpilfaOF4DuT3roGEBIotitr0W0Cwvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GeYiI3sq78bvCQFIlAAJ6dM05ed1kGH6DyZb9r8vwHdD+4Bag/NgVTBaH3JahPqQ+
         QHSZNFq5erVl6uxwIRyh3hBh6leNBgXFbERvXtY4vliHOKYRyvR/WFO2dDEs6vtrXb
         NZY+hqtlYSbCGz+k9CegW/96mmmXN1J+lft87mLs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Zhou <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 072/141] net/wan/fsl_ucc_hdlc: remove set but not used variables 'ut_info' and 'ret'
Date:   Fri, 14 Feb 2020 11:20:12 -0500
Message-Id: <20200214162122.19794-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

[ Upstream commit 270fe2ceda66b6964d4c6f261d7f562a02c1c786 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/wan/fsl_ucc_hdlc.c: In function ucc_hdlc_irq_handler:
drivers/net/wan/fsl_ucc_hdlc.c:643:23:
	warning: variable ut_info set but not used [-Wunused-but-set-variable]
drivers/net/wan/fsl_ucc_hdlc.c: In function uhdlc_suspend:
drivers/net/wan/fsl_ucc_hdlc.c:880:23:
	warning: variable ut_info set but not used [-Wunused-but-set-variable]
drivers/net/wan/fsl_ucc_hdlc.c: In function uhdlc_resume:
drivers/net/wan/fsl_ucc_hdlc.c:925:6:
	warning: variable ret set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 87bf05a81db50..7c4a30391f746 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -591,11 +591,9 @@ static irqreturn_t ucc_hdlc_irq_handler(int irq, void *dev_id)
 	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)dev_id;
 	struct net_device *dev = priv->ndev;
 	struct ucc_fast_private *uccf;
-	struct ucc_tdm_info *ut_info;
 	u32 ucce;
 	u32 uccm;
 
-	ut_info = priv->ut_info;
 	uccf = priv->uccf;
 
 	ucce = ioread32be(uccf->p_ucce);
@@ -826,7 +824,6 @@ static void resume_clk_config(struct ucc_hdlc_private *priv)
 static int uhdlc_suspend(struct device *dev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(dev);
-	struct ucc_tdm_info *ut_info;
 	struct ucc_fast __iomem *uf_regs;
 
 	if (!priv)
@@ -838,7 +835,6 @@ static int uhdlc_suspend(struct device *dev)
 	netif_device_detach(priv->ndev);
 	napi_disable(&priv->napi);
 
-	ut_info = priv->ut_info;
 	uf_regs = priv->uf_regs;
 
 	/* backup gumr guemr*/
@@ -872,7 +868,7 @@ static int uhdlc_resume(struct device *dev)
 	struct ucc_fast __iomem *uf_regs;
 	struct ucc_fast_private *uccf;
 	struct ucc_fast_info *uf_info;
-	int ret, i;
+	int i;
 	u32 cecr_subblock;
 	u16 bd_status;
 
@@ -917,16 +913,16 @@ static int uhdlc_resume(struct device *dev)
 
 	/* Write to QE CECR, UCCx channel to Stop Transmission */
 	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
-	ret = qe_issue_cmd(QE_STOP_TX, cecr_subblock,
-			   (u8)QE_CR_PROTOCOL_UNSPECIFIED, 0);
+	qe_issue_cmd(QE_STOP_TX, cecr_subblock,
+		     (u8)QE_CR_PROTOCOL_UNSPECIFIED, 0);
 
 	/* Set UPSMR normal mode */
 	iowrite32be(0, &uf_regs->upsmr);
 
 	/* init parameter base */
 	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
-	ret = qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, cecr_subblock,
-			   QE_CR_PROTOCOL_UNSPECIFIED, priv->ucc_pram_offset);
+	qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, cecr_subblock,
+		     QE_CR_PROTOCOL_UNSPECIFIED, priv->ucc_pram_offset);
 
 	priv->ucc_pram = (struct ucc_hdlc_param __iomem *)
 				qe_muram_addr(priv->ucc_pram_offset);
-- 
2.20.1

