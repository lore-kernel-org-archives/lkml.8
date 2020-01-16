Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE32C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD3B206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199518;
	bh=Mh2Tn7eWn8y9bDcNeYvSE7du4a5ckL384vsDHsccghA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wsHBwlF5gYPVfNLx66g219SGZTC6UPt55TP39sbyvKke6U9tttSI34SvUNmG7XKuM
	 NApz3LgElNw2COmXapuSpWAxCWo9DB9CoCyJcxIoMOeugs+g9xGN1VEUM7Q1ahs+/+
	 j82W9BId26y+tV6ZpAfTS0IDraTkNVe2jb3k4ZFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbgAPSb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbgAPRZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2D6246CC;
        Thu, 16 Jan 2020 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195508;
        bh=Mh2Tn7eWn8y9bDcNeYvSE7du4a5ckL384vsDHsccghA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wg1V703apL4u/BaBc46RTvAmHseZdwG01CuEDAgp1ioXzdoyWn9ZguV0HV5eE9Q/n
         5wtwDDjguTF4sO0S6hFA7+/XEXEcLdZSHkWiJD2t/M6aqKbhqyomPG4/qlROvK+ch3
         3Rg79a9QlOmmERGltHvOf2XC0GCwKS6xsnNwMRTg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 108/371] regulator: pv88080: Fix array out-of-bounds access
Date:   Thu, 16 Jan 2020 12:19:40 -0500
Message-Id: <20200116172403.18149-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit 3c413f594c4f9df40061445667ca11a12bc8ee34 ]

Fix off-by-one while iterating current_limits array.
The valid index should be 0 ~ n_current_limits -1.

Fixes: 99cf3af5e2d5 ("regulator: pv88080: new regulator driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pv88080-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 9a08cb2de501..6770e4de2097 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -279,7 +279,7 @@ static int pv88080_set_current_limit(struct regulator_dev *rdev, int min,
 	int i;
 
 	/* search for closest to maximum */
-	for (i = info->n_current_limits; i >= 0; i--) {
+	for (i = info->n_current_limits - 1; i >= 0; i--) {
 		if (min <= info->current_limits[i]
 			&& max >= info->current_limits[i]) {
 				return regmap_update_bits(rdev->regmap,
-- 
2.20.1

