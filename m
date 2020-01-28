Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459FDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1995C207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222335;
	bh=YGvwK8iRc3LVChJ9irN+HSCVeRZqt8+L1CL2oYqkIiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wQ4jjN/wLy9dDO04Pkjh9wHdIkpvQvXAoxNaX7XSasa+zDeCQt6QZJHqHb5f1IRDK
	 C4diwYvQg6I7CWyKl18el22WD+34d9xEnPi8IAgFKZN98cg0W/zHOlZWjUo1XyduOR
	 LJY/66b7qwLkvyXAsiGwUNJ0kgGntDNhKlS0uOW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgA1OSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730579AbgA1ORz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:17:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2128321739;
        Tue, 28 Jan 2020 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221074;
        bh=YGvwK8iRc3LVChJ9irN+HSCVeRZqt8+L1CL2oYqkIiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgUkTJvXFf9q7IQ/IS03s1N24BUqSlAe/nwFsKmXGPvSIIQACbOs/OnxEI7DstghF
         W2mjEt2mV4PM/piim8cI6la2GC7sJgeCITpjLvv4UG4ZffDoohOUQaZDeDvWBcGmIR
         EstGYYIYxRAgqYtNL7FTHtr3v+P7y1VUNARMXH2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 079/271] regulator: pv88080: Fix array out-of-bounds access
Date:   Tue, 28 Jan 2020 15:03:48 +0100
Message-Id: <20200128135858.436677287@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 954a20eeb26f8..a40ecfb772107 100644
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



