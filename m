Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD24C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D872073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198303;
	bh=kRST8YbOWgOCAkrrsvEVjtUC26+1pzchNnWP+K27Axk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UzaN25j4/KhcDgQhmS/fKhguBf7Vmz4+hLFSG751KWWJ6jpRDYCg4PC9gpT7GPxSP
	 OHaa92RARlWuhIQxfCdVvotPcbc1auxeTNj5NTilCDO4ZwZDZQgzXMeZ5f8l9x/Ful
	 3198XzTJnvaTGf8rbrRsijaYzQxzMfp41Sfgib0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395236AbgAPSLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405368AbgAPRh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C11FD246C8;
        Thu, 16 Jan 2020 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196248;
        bh=kRST8YbOWgOCAkrrsvEVjtUC26+1pzchNnWP+K27Axk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6DZb1c0I6jIMZsUCimAOYCw/S0h4II5WtYJwQ6Yipxic3Z9/jXJTRhzC3m1QENZS
         dLMHj+Zp77SBcJSdyxD0cBF4TpcfeZsanFEb5tEnZwXZqkOSOFfz/0V3NlZXtE9yB7
         D6e1IE02eSIEVWI0Ad/3Eay/mPKp8EMqqtNo94Ss=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 076/251] regulator: pv88060: Fix array out-of-bounds access
Date:   Thu, 16 Jan 2020 12:33:45 -0500
Message-Id: <20200116173641.22137-36-sashal@kernel.org>
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

[ Upstream commit 7cd415f875591bc66c5ecb49bf84ef97e80d7b0e ]

Fix off-by-one while iterating current_limits array.
The valid index should be 0 ~ n_current_limits -1.

Fixes: f307a7e9b7af ("regulator: pv88060: new regulator driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pv88060-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index 6c4afc73ecac..d229245d2b5e 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -135,7 +135,7 @@ static int pv88060_set_current_limit(struct regulator_dev *rdev, int min,
 	int i;
 
 	/* search for closest to maximum */
-	for (i = info->n_current_limits; i >= 0; i--) {
+	for (i = info->n_current_limits - 1; i >= 0; i--) {
 		if (min <= info->current_limits[i]
 			&& max >= info->current_limits[i]) {
 			return regmap_update_bits(rdev->regmap,
-- 
2.20.1

