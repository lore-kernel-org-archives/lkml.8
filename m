Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADE3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BCAB20776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448469;
	bh=ZeP8K0zOh9XWf/M6ZeyFsdFt9/ZjTz/WXT7NJMGHJ0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R+ncsPsI1jvAsrWXKRER8DYqLhkHgJ3F7LwzZfvU5g3dj7GBlSEnmfcl3EJiIikiv
	 obOROAtMkfpo9e/JIO6EfEzAegNh4lFLmqAk1ef40sHVgCOM7xk2REu5zaxqNGALHd
	 MzlPCqWte4s+ue4rR/LXp8OiJtnDLBLkiDcWEaVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFRBKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgFRBKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:10:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 937F321974;
        Thu, 18 Jun 2020 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442613;
        bh=ZeP8K0zOh9XWf/M6ZeyFsdFt9/ZjTz/WXT7NJMGHJ0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCZxilbwtxz18Z/u+R/SCS+fnsOc4+WeUA3Fe94ursURI6skcMPYo0e5I9PnThSoF
         4MzTalCn66s7PnSPQtbSUtprrZVPkrBEJ5cPEJo9WpokznXFtLnxWwaXzYxrFsGQrp
         fsOTBW9ML/GODNtnzuEPay0uq2FO2kplNUhZWMSo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 094/388] ASoC: meson: fix memory leak of links if allocation of ldata fails
Date:   Wed, 17 Jun 2020 21:03:11 -0400
Message-Id: <20200618010805.600873-94-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 6e801dc411329aff592fbd48fb116183d0acdb00 ]

Currently if the allocation of ldata fails the error return path
does not kfree the allocated links object.  Fix this by adding
an error exit return path that performs the necessary kfree'ing.

Fixes: 7864a79f37b5 ("ASoC: meson: add axg sound card support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Addresses-Coverity: ("Resource leak")
Link: https://lore.kernel.org/r/20200604171216.60043-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/meson-card-utils.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index 2ca8c98e204f..5a4a91c88734 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -49,19 +49,26 @@ int meson_card_reallocate_links(struct snd_soc_card *card,
 	links = krealloc(priv->card.dai_link,
 			 num_links * sizeof(*priv->card.dai_link),
 			 GFP_KERNEL | __GFP_ZERO);
+	if (!links)
+		goto err_links;
+
 	ldata = krealloc(priv->link_data,
 			 num_links * sizeof(*priv->link_data),
 			 GFP_KERNEL | __GFP_ZERO);
-
-	if (!links || !ldata) {
-		dev_err(priv->card.dev, "failed to allocate links\n");
-		return -ENOMEM;
-	}
+	if (!ldata)
+		goto err_ldata;
 
 	priv->card.dai_link = links;
 	priv->link_data = ldata;
 	priv->card.num_links = num_links;
 	return 0;
+
+err_ldata:
+	kfree(links);
+err_links:
+	dev_err(priv->card.dev, "failed to allocate links\n");
+	return -ENOMEM;
+
 }
 EXPORT_SYMBOL_GPL(meson_card_reallocate_links);
 
-- 
2.25.1

