Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7170C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E7C2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700994;
	bh=ziU2LQvecB031qFlSj7TR1K2PZbsOwUjUK6JJxE8rWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T2v9NulsRTwnHWtc8kj8l+fgX5PXskXQQgRyi4APLAtEGdJuWPrJgfgLGZFDsRscZ
	 Px1OCAVA3jIbB2i7HRLo2E6nIuuexfK3GINgz38UkLlp1u/LsS39RrNigJrhwBLwp9
	 YE/GZcR8nox01OeKlMjAgpEPOTrHrGGJ1vdI3RRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404470AbgBNRXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391326AbgBNQJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00DC124650;
        Fri, 14 Feb 2020 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696579;
        bh=ziU2LQvecB031qFlSj7TR1K2PZbsOwUjUK6JJxE8rWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1ZzmrMDYt22c5sFluoYtRLoyB6GH1dXyefl2rm3RN9fQ/LPwNGMMdmeSI7lSg5nx
         zMhCptOwqkNBKeEDO4+K2p5ITSaHjyk89KzZ8A+Pv1ngsi/0XGsTN7nm0s+Gdf/S/X
         AjFve9NGU0BrYF/82t6Z6lPyM5qyheFrKQWDdYdE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Whitten <ben.whitten@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 368/459] regmap: fix writes to non incrementing registers
Date:   Fri, 14 Feb 2020 11:00:18 -0500
Message-Id: <20200214160149.11681-368-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

[ Upstream commit 2e31aab08bad0d4ee3d3d890a7b74cb6293e0a41 ]

When checking if a register block is writable we must ensure that the
block does not start with or contain a non incrementing register.

Fixes: 8b9f9d4dc511 ("regmap: verify if register is writeable before writing operations")
Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
Link: https://lore.kernel.org/r/20200118205625.14532-1-ben.whitten@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 19f57ccfbe1d7..59f911e577192 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1488,11 +1488,18 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 
 	WARN_ON(!map->bus);
 
-	/* Check for unwritable registers before we start */
-	for (i = 0; i < val_len / map->format.val_bytes; i++)
-		if (!regmap_writeable(map,
-				     reg + regmap_get_offset(map, i)))
-			return -EINVAL;
+	/* Check for unwritable or noinc registers in range
+	 * before we start
+	 */
+	if (!regmap_writeable_noinc(map, reg)) {
+		for (i = 0; i < val_len / map->format.val_bytes; i++) {
+			unsigned int element =
+				reg + regmap_get_offset(map, i);
+			if (!regmap_writeable(map, element) ||
+				regmap_writeable_noinc(map, element))
+				return -EINVAL;
+		}
+	}
 
 	if (!map->cache_bypass && map->format.parse_val) {
 		unsigned int ival;
-- 
2.20.1

