Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70352C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C72320707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947820;
	bh=pIqGEiiYOAPthQ/PQLIKaUXsGbSSPmjyud+zQSSKwQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KjPqvaGS58QUYcWAdVeiKWppP+OpQDTSNY1wQl3EzYv4SD7T1WwABLigXv62/xwCh
	 zEOeIiMDnS7eaOdXlUAgfbbZZLF0UuKg4d8JxcByWLgISJ7JbKhLuQEvCkCGUhu8qj
	 ZK1uq6KeepGCuD8kDkxg3bgZqM6gsPoy9MqbH3vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393595AbgFWVaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389160AbgFWUOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:14:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A50B3206C3;
        Tue, 23 Jun 2020 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943248;
        bh=pIqGEiiYOAPthQ/PQLIKaUXsGbSSPmjyud+zQSSKwQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y3fU2719ZJg+f70e5Ebl7HEay0SPx4f8hAoDZFpXxrkIOJGW4FWTo86G3ZvmVzp5J
         ys8OR10TeMSCCyWweXol2PKrpzeEUL6a36zPaYjSDLYOEZtuBV6q7NeGRWZe2mLctF
         CsdMvgcrY9HHnp7y85HhVfmK5jErRZGY6im1aCjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 318/477] pinctrl: freescale: imx: Use devm_of_iomap() to avoid a resource leak in case of error in imx_pinctrl_probe()
Date:   Tue, 23 Jun 2020 21:55:15 +0200
Message-Id: <20200623195422.561156018@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ba403242615c2c99e27af7984b1650771a2cc2c9 ]

Use 'devm_of_iomap()' instead 'of_iomap()' to avoid a resource leak in
case of error.

Update the error handling code accordingly.

Fixes: 26d8cde5260b ("pinctrl: freescale: imx: add shared input select reg support")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200602200626.677981-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 1f81569c7ae3b..cb7e0f08d2cf4 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -824,12 +824,13 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 				return -EINVAL;
 			}
 
-			ipctl->input_sel_base = of_iomap(np, 0);
+			ipctl->input_sel_base = devm_of_iomap(&pdev->dev, np,
+							      0, NULL);
 			of_node_put(np);
-			if (!ipctl->input_sel_base) {
+			if (IS_ERR(ipctl->input_sel_base)) {
 				dev_err(&pdev->dev,
 					"iomuxc input select base address not found\n");
-				return -ENOMEM;
+				return PTR_ERR(ipctl->input_sel_base);
 			}
 		}
 	}
-- 
2.25.1



