Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54E1C4345E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FE0207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281239;
	bh=957oKhyzfJEsn2BNVCIWxTyGK7q0im7wFaa03N9dAic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U2ZObkHJDYYqPEm5ZA2+BTmGE37EA8arSJxWov22PUvAoKwOKcaalju8ssWIPabP8
	 zq8QQ557JqTiILGhIjqHKYXWMgfaxMaD/VDRJIFtt7fbP+eRjEAzeGoaI/GbslzLLA
	 hgHVHie0UmhIFV0svFdFQTPpHX31iOJTTggo1dvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgGTVj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbgGTVjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:39:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE9B22BF5;
        Mon, 20 Jul 2020 21:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281162;
        bh=957oKhyzfJEsn2BNVCIWxTyGK7q0im7wFaa03N9dAic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFARqP/yJw+QropTKGUYHIiLBxDcoggTJfiKfmgsugYA3rAWtCh3BT+uMlTC9GGII
         s45JFZ/4g8HyzG9e1a+7ePLMVVZP87gobXU7N/Jr1yODq2jG5lIR8GUNneIWNySbOF
         ZAVfZHUJYpr5hrht8JkrXrDTZkUwv3MOwWvm//uk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 06/13] regmap: dev_get_regmap_match(): fix string comparison
Date:   Mon, 20 Jul 2020 17:39:07 -0400
Message-Id: <20200720213914.407919-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213914.407919-1-sashal@kernel.org>
References: <20200720213914.407919-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit e84861fec32dee8a2e62bbaa52cded6b05a2a456 ]

This function is used by dev_get_regmap() to retrieve a regmap for the
specified device. If the device has more than one regmap, the name parameter
can be used to specify one.

The code here uses a pointer comparison to check for equal strings. This
however will probably always fail, as the regmap->name is allocated via
kstrdup_const() from the regmap's config->name.

Fix this by using strcmp() instead.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/r/20200703103315.267996-1-mkl@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 013d0a2b3ba0a..4e0cc40ad9ceb 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1242,7 +1242,7 @@ static int dev_get_regmap_match(struct device *dev, void *res, void *data)
 
 	/* If the user didn't specify a name match any */
 	if (data)
-		return (*r)->name == data;
+		return !strcmp((*r)->name, data);
 	else
 		return 1;
 }
-- 
2.25.1

