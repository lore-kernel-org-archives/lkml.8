Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675B8C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47093207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595956186;
	bh=Vc2rMDS5cOizIyVH8O3qqpisYycogDLFoYxum968D7o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Wr9UEAgzkJER/LQUXvzDgleeIVCZmhMTOBNHXZBNHklxzlJGgnMfLHNqUwo80I/mo
	 HrHhvipxy26fmRdEPppR88q92TgokdJKM/P/Wz8M5TwyluJLb1pyzjldyKkA9U63/y
	 TFtNTmuzEeIH5RcgNAKXzLnYtLA/d68QlEgFOi5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgG1RJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1RJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:09:44 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DEF20786;
        Tue, 28 Jul 2020 17:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956184;
        bh=Vc2rMDS5cOizIyVH8O3qqpisYycogDLFoYxum968D7o=;
        h=From:To:Cc:Subject:Date:From;
        b=qHuYyuwqh5urEGHmKOBY7VYwAq9K+8QG/tt9zPJMFOI3WY0jQsXZv/NPYp4+kuifW
         NnUvl6v+K9i0gUfTj1rj1N7f0ojQjcvvejl/5QZkke9BlItAy2UxLf47ikL307zwP+
         9mvsrmrNP0JeIqaIIyo34HMrdEkeSdmIsdeSfgIE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dmaengine: ti: omap-dma: Drop of_match_ptr to fix -Wunused-const-variable
Date:   Tue, 28 Jul 2020 19:09:39 +0200
Message-Id: <20200728170939.28278-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_device_id is included unconditionally by of.h header and used
in the driver as well.  Remove of_match_ptr to fix W=1 compile test
warning with !CONFIG_OF:

    drivers/dma/ti/omap-dma.c:1892:34: warning: 'omap_dma_match' defined but not used [-Wunused-const-variable=]
     1892 | static const struct of_device_id omap_dma_match[] = {

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/ti/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 918301e17552..c9fe5e3a6b55 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1904,7 +1904,7 @@ static struct platform_driver omap_dma_driver = {
 	.remove	= omap_dma_remove,
 	.driver = {
 		.name = "omap-dma-engine",
-		.of_match_table = of_match_ptr(omap_dma_match),
+		.of_match_table = omap_dma_match,
 	},
 };
 
-- 
2.17.1

