Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12514C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58BB21D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442499;
	bh=pvXFFlikRX1sr0H7u04Pi2QjezLjA5EYEWdtSY9EDks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ylgjSfyMzbxJsb3XK5hgFVjeQIY/lbwibUXpSMM8GpxYBkHbwNCgfAA8XylIs/uTB
	 rBYzFMeWExed5Do9JpvF4tz25qiGSR2ZWV5vNewmIKD1l20CdEkdpNRk3uEr0VKBqa
	 watWJotqqdUIXBJcLkQlkkrMjXCxp9A0KlPhBDNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFRBIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgFRBIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:08:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD35621D7B;
        Thu, 18 Jun 2020 01:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442492;
        bh=pvXFFlikRX1sr0H7u04Pi2QjezLjA5EYEWdtSY9EDks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnJTmIZWeMZk1tYbtjRiCc4iC1FDfRsOyhoZn4OJXKgcI7D8fZ91lC901QYWE/My+
         saGoRCFV3hcNy53YpPjC4IALdZUnMypHmqgby+Le/waop6xm4KZV0Nzm+XohFL8Ehu
         ToX5dZcFOrQu6taC2zAg1vGtKR7XXEKEKputDraY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 005/388] rtc: rc5t619: Fix an ERR_PTR vs NULL check
Date:   Wed, 17 Jun 2020 21:01:42 -0400
Message-Id: <20200618010805.600873-5-sashal@kernel.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 11ddbdfb68e4f9791e4bd4f8d7c87d3f19670967 ]

The devm_kzalloc() function returns NULL on error, it doesn't return
error pointers so this check doesn't work.

Fixes: 540d1e15393d ("rtc: rc5t619: Add Ricoh RC5T619 RTC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200407092852.GI68494@mwanda
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-rc5t619.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rc5t619.c b/drivers/rtc/rtc-rc5t619.c
index 24e386ecbc7e..dd1a20977478 100644
--- a/drivers/rtc/rtc-rc5t619.c
+++ b/drivers/rtc/rtc-rc5t619.c
@@ -356,10 +356,8 @@ static int rc5t619_rtc_probe(struct platform_device *pdev)
 	int err;
 
 	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
-	if (IS_ERR(rtc)) {
-		err = PTR_ERR(rtc);
+	if (!rtc)
 		return -ENOMEM;
-	}
 
 	rtc->rn5t618 = rn5t618;
 
-- 
2.25.1

