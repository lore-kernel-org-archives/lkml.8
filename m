Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1BBC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E632246DD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196276;
	bh=QZCARvEMUr1zPyIifMPAW1+PRX3vQYXWdpQCzacwjtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MCnnKk68i+A1Wjc+6JKjWfKwoT2mZU7sGAsJClXYV7YFC4rbU/3u69SUez7VMx3sB
	 e5Aa3MU4/w6SOmSNbNbkaiajE7rHKraOSRES/BzLKk9RkYpc5Y5FQqEE8kq3q1zags
	 fj5L8Hfx1KhQ66j2hKidgn0X+/v8ur58iY6HxS1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393221AbgAPRhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405380AbgAPRhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1106C246C8;
        Thu, 16 Jan 2020 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196250;
        bh=QZCARvEMUr1zPyIifMPAW1+PRX3vQYXWdpQCzacwjtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRcKR/4W84JBeKZ+MqOW6RcnKU4yQBx3U2bbrxrB/6K2DX4LrAJpd33CNDTTMMe4z
         riR9TmQvMDmn/vEgb4yWXl2z76PMpw8oS4VJimb8rOXX1RX6kauhm5f/9PJo07FQVD
         y+kaGfBJjfQcaCi/YW7N82EYyyJPgHTDsZiP6IR4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 078/251] regulator: pv88090: Fix array out-of-bounds access
Date:   Thu, 16 Jan 2020 12:33:47 -0500
Message-Id: <20200116173641.22137-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit a5455c9159414748bed4678184bf69989a4f7ba3 ]

Fix off-by-one while iterating current_limits array.
The valid index should be 0 ~ n_current_limits -1.

Fixes: c90456e36d9c ("regulator: pv88090: new regulator driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pv88090-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index 421641175352..789652c9b014 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -157,7 +157,7 @@ static int pv88090_set_current_limit(struct regulator_dev *rdev, int min,
 	int i;
 
 	/* search for closest to maximum */
-	for (i = info->n_current_limits; i >= 0; i--) {
+	for (i = info->n_current_limits - 1; i >= 0; i--) {
 		if (min <= info->current_limits[i]
 			&& max >= info->current_limits[i]) {
 			return regmap_update_bits(rdev->regmap,
-- 
2.20.1

