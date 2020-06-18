Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B377C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E3821534
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447188;
	bh=cuJrbmG3TmaVXuupUw8nPnl9fKIu2qpNoPb6EAre7wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IxV0Dj7iv70h2MdlD/n82WTAQBAUPaftb5os0ItOlPav9hTTl3whKAKMXP9zvkZTH
	 Ov0uaM60PpsOg0sHWMfw7i/xEO6gx4LyfEBLZhMzmkD04pxeM1/ow4Gwg3mCXoleVE
	 Ous9VGvopPg/Hdk4w4GzTd1ngQCKuWDr9rQ8jpXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgFRC00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbgFRBRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:17:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684CD21D80;
        Thu, 18 Jun 2020 01:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443025;
        bh=cuJrbmG3TmaVXuupUw8nPnl9fKIu2qpNoPb6EAre7wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4Us9Zw2fT1s+G2ulOYkTxpWTkW9ScmlNETeUMfo6dup+12srKNgY/dV4pxVCdmts
         r3aCUmJ5/2T+lbBnJUDqParfuRDt6db+L/tdafH5ZY1pozUQ8HcSOg5YbHbfnmbRQv
         3wrxgV7aF2Twz0lF7+OS67ofTFnkabHDK+YiSnxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 025/266] rtc: mc13xxx: fix a double-unlock issue
Date:   Wed, 17 Jun 2020 21:12:30 -0400
Message-Id: <20200618011631.604574-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 8816cd726a4fee197af2d851cbe25991ae19ea14 ]

In function mc13xxx_rtc_probe, the mc13xxx_unlock() is called
before rtc_register_device(). But in the error path of
rtc_register_device(), the mc13xxx_unlock() is called again,
which causes a double-unlock problem. Thus add a call of the
function “mc13xxx_lock” in an if branch for the completion
of the exception handling.

Fixes: e4ae7023e182a ("rtc: mc13xxx: set range")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Link: https://lore.kernel.org/r/20200503182235.1652-1-wu000273@umn.edu
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-mc13xxx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
index afce2c0b4bd6..d6802e6191cb 100644
--- a/drivers/rtc/rtc-mc13xxx.c
+++ b/drivers/rtc/rtc-mc13xxx.c
@@ -308,8 +308,10 @@ static int __init mc13xxx_rtc_probe(struct platform_device *pdev)
 	mc13xxx_unlock(mc13xxx);
 
 	ret = rtc_register_device(priv->rtc);
-	if (ret)
+	if (ret) {
+		mc13xxx_lock(mc13xxx);
 		goto err_irq_request;
+	}
 
 	return 0;
 
-- 
2.25.1

