Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAAAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E272087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864254;
	bh=hwYgZxHcGlSrfshCP7E4zwCzcEnaVE/lx8syiNUeXQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XG0YNN01aVzcTEL+xTzW5dKrYs5ICwLT4O9U3yokpChZd76eSzGQCBEjbxdwfflc/
	 1ej1Az+/P1cLVghe2IMc0r+NgM5CgzHwnp+uolQmRmW3IfqpthOAqudBGz7zJ9bUVx
	 eJGjyxKZxREM3HUFJ/cFPd5WEPNFiLud95hYiKRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbgAXLKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389861AbgAXLKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:10:51 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F4820708;
        Fri, 24 Jan 2020 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864251;
        bh=hwYgZxHcGlSrfshCP7E4zwCzcEnaVE/lx8syiNUeXQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbqlzXJ/yt6UjH4yQLH5rjaKJ8SQzsPvvgoyLUgoWLu7f8NM6PXW8dFW+/zEXFt/W
         N6MQFjPkS+dKwr0izxpVfbRYyJxnnGXG+O6Yr+TNEoB8p0h40dcNdeL7hDGCUccoct
         ng7yA4j+7QfUYyfb6L7VH9XXrJ+R+tryJHDIxDMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 214/639] regulator: pv88080: Fix array out-of-bounds access
Date:   Fri, 24 Jan 2020 10:26:24 +0100
Message-Id: <20200124093113.792876512@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
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
index 9a08cb2de501e..6770e4de20978 100644
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



