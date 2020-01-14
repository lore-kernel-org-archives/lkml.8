Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F9FC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A798207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="GtEjjpPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgANG67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:58:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43957 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgANG66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:58:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so6107012pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 22:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IqutdMrtiR/MNyXPTOZkYPWqFk/2zL1F47UaQEyd6/E=;
        b=GtEjjpPUtcVznasR5fBc5ZBKgHx5KawysiBgkDU61Wah6UB7vZ7awyZHrIGWbzMMFv
         vnQw0fJmQSrxhNYeUp9JukJ32vSQam/+wXDfwFmFFl0qgA9ZJZPzRwcP2TaUfWeKQcl1
         hUfMcCCc10npetX3FgaRaI47pWt2T6f/uqdi6gMEyu/cOzew+kFG9ezTLH1sz/IXqmum
         QC3Vg1T+FQsXP10UKHcomWVdEkYFJRjzbjwILPp2Jb6PjfxZD7PbvgTc42DmU5uCM6h8
         ZYbmlEYe2EqHSi2uNrNJopZUvjbBJMgVVFtkyLCl4eLp8PPrOLPU3HMtHEioo+XSe5GN
         jC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IqutdMrtiR/MNyXPTOZkYPWqFk/2zL1F47UaQEyd6/E=;
        b=DlU1uMEbaU7thIzoc8cX5uSRppOO1giNLXH8SkWfJwv8sPKFNEY+B5JBGghbV15moJ
         OLK9e+dXNeFT5HNYAj2uSEYXmXT7u8WJZLU7+1awjs7LS3ueUDSUnDGPWcWBakADMEJM
         xLl6AF2oBknAXl9II8AfjvwE7DSBm9OCeF9IHCtXj7bNgxtUU70f7b2MWIJ7w+FWrfam
         7WzA1A0cdigruXEvqDE2hKCaFXEqiTx0JPLpLXi1NpjP6htHRV0jP7xXe33ZvGuNRn3U
         E7z2ZfHP/Yc24Xiuexiiv0zUINuj41CO1edRUZeXxldFLu69fg1a2GsJGkLoYsiyyhiK
         DTdQ==
X-Gm-Message-State: APjAAAXsAJ9GeRrVGVPzlGBirSoLmMLGeD1btaETHeca+jgKA7Vz/jaR
        AY8ut+JxqylSAuXi2wTdSmKXDGMjzJQ=
X-Google-Smtp-Source: APXvYqxS+n57UQss3+VHux12v/lwHGoubJ1zYCN/O04J8iWcWZnBn8zStdwWzj4QV8oODYDAOhpsaA==
X-Received: by 2002:a63:78cf:: with SMTP id t198mr24727859pgc.287.1578985138127;
        Mon, 13 Jan 2020 22:58:58 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id p21sm16320432pfn.103.2020.01.13.22.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 22:58:57 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mantas Pucka <mantas@8devices.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: vqmmc-ipq4019: Remove ipq4019_regulator_remove
Date:   Tue, 14 Jan 2020 14:58:46 +0800
Message-Id: <20200114065847.31667-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is using devm_regulator_register() so no need to call
regulator_unregister() in ipq4019_regulator_remove().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/vqmmc-ipq4019-regulator.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index dae16094d3a2..42a2368e9ef7 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -81,15 +81,6 @@ static int ipq4019_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ipq4019_regulator_remove(struct platform_device *pdev)
-{
-	struct regulator_dev *rdev = platform_get_drvdata(pdev);
-
-	regulator_unregister(rdev);
-
-	return 0;
-}
-
 static const struct of_device_id regulator_ipq4019_of_match[] = {
 	{ .compatible = "qcom,vqmmc-ipq4019-regulator", },
 	{},
@@ -97,7 +88,6 @@ static const struct of_device_id regulator_ipq4019_of_match[] = {
 
 static struct platform_driver ipq4019_regulator_driver = {
 	.probe = ipq4019_regulator_probe,
-	.remove = ipq4019_regulator_remove,
 	.driver = {
 		.name = "vqmmc-ipq4019-regulator",
 		.owner = THIS_MODULE,
-- 
2.20.1

