Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B75DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C05D20772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHSHu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:50:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47923 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHSHuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:50:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k8Is0-0002uD-C9; Wed, 19 Aug 2020 07:50:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] soc: ti: omap-prm: fix spelling mistake "unusupported" -> "unsupported"
Date:   Wed, 19 Aug 2020 08:50:52 +0100
Message-Id: <20200819075052.48833-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_warn warning. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/ti/omap_prm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index 980b04c38fd9..30862fc174ae 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -343,7 +343,7 @@ static int omap_prm_domain_attach_dev(struct generic_pm_domain *domain,
 		return ret;
 
 	if (pd_args.args_count != 0)
-		dev_warn(dev, "%s: unusupported #power-domain-cells: %i\n",
+		dev_warn(dev, "%s: unsupported #power-domain-cells: %i\n",
 			 prmd->pd.name, pd_args.args_count);
 
 	genpd_data = dev_gpd_data(dev);
-- 
2.27.0

