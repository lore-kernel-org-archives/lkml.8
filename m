Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64088C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B32206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460568;
	bh=+E0bitveH20osE1qAh7Cun30LPerQPCMAvFAgZcslfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w+X5yyZov6BMNfhDrSV8E4YAs60ry64ojhKUIOQ+4YL6kMK5kcr/UKKBwVk8/y9KU
	 U5Xn5puRXzaCknoiVQ1ncEmwUGfftKPbEm2z31ixg/LFHUk6tGovWd+sBnmjdctPaB
	 PK3GswChqU/m7dxkdB9AUyZ9SMbTbfb9XV6OlfZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbgF2T4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387654AbgF2TkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B8D248A4;
        Mon, 29 Jun 2020 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444400;
        bh=+E0bitveH20osE1qAh7Cun30LPerQPCMAvFAgZcslfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcpNlfqY3bQhbX8UwegFOLAkiQ64KufLia/s9VV38yoc2fFZT3xU+LUT7DivwmjLg
         RmBEq5C5ZlyIxJNauuhu8f6X+gcxRNGfxpbC5miWLiDad6ydyVO3U2tNqODhGwYDo4
         HY+FyBj8e9rxWeMsQfY2adyG1pykwXdN35HQguIg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 078/178] regmap: Fix memory leak from regmap_register_patch
Date:   Mon, 29 Jun 2020 11:23:43 -0400
Message-Id: <20200629152523.2494198-79-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 95b2c3ec4cb1689db2389c251d39f64490ba641c ]

When a register patch is registered the reg_sequence is copied but the
memory allocated is never freed. Add a kfree in regmap_exit to clean it
up.

Fixes: 22f0d90a3482 ("regmap: Support register patch sets")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200617152129.19655-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 59f911e577192..508bbd6ea4396 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1356,6 +1356,7 @@ void regmap_exit(struct regmap *map)
 	if (map->hwlock)
 		hwspin_lock_free(map->hwlock);
 	kfree_const(map->name);
+	kfree(map->patch);
 	kfree(map);
 }
 EXPORT_SYMBOL_GPL(regmap_exit);
-- 
2.25.1

