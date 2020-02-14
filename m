Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03353C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67E224722
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697215;
	bh=dE5/nvNLJI0zjMewiymZtePjfK0j8kzyC/D2KWwxLCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nT2eTowZSNrJkBBA1ZINM//ZLgQpZLTWG/pGc8EAd7bTIxnbP7rk1m8NeYRi0bS0B
	 m5ZinW0aMB4pqWwUyI5UCZ5msJEA5cca4oN0eXj7qEWn8IbbAjfZECgT9Qmv+d0hfU
	 6fw/tpDoCD3qZdmy1POUJ529gkt392KAIokbSPtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405163AbgBNQUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392773AbgBNQTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:19:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE14C24702;
        Fri, 14 Feb 2020 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697150;
        bh=dE5/nvNLJI0zjMewiymZtePjfK0j8kzyC/D2KWwxLCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4NOACL/zmUfV9Bvxdjlwrqu2XcSPz1qRouBHQ3Ybf1DnDi47wrFbox/q7i6ii2ve
         bTLuFRhNfhhkWeQkzz6TScJIy2bBd/KaaHVmadpsgT6OJfNMwqLLGXVUdYBIh1OxgS
         mvliyYdTLA1GUw5at+hW41YFd5nXNYoc64YvdNPc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 089/186] rtc: hym8563: Return -EINVAL if the time is known to be invalid
Date:   Fri, 14 Feb 2020 11:15:38 -0500
Message-Id: <20200214161715.18113-89-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit f236a2a2ebabad0848ad0995af7ad1dc7029e895 ]

The current code returns -EPERM when the voltage loss bit is set.
Since the bit indicates that the time value is not valid, return
-EINVAL instead, which is the appropriate error code for this
situation.

Fixes: dcaf03849352 ("rtc: add hym8563 rtc-driver")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Link: https://lore.kernel.org/r/20191212153111.966923-1-paul.kocialkowski@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-hym8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index e5ad527cb75e3..a8c2d38b24112 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -105,7 +105,7 @@ static int hym8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	if (!hym8563->valid) {
 		dev_warn(&client->dev, "no valid clock/calendar values available\n");
-		return -EPERM;
+		return -EINVAL;
 	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, HYM8563_SEC, 7, buf);
-- 
2.20.1

