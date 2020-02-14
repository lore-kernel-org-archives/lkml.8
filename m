Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637A5C3B1A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3206D2471A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697123;
	bh=lAkB0FGYBEcU1ex+SWbExJA6tcMV4n0xw9kTIpdIvV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c3RFpUkFZBA6VKD6zYgcXmyqTqq0J67B5hXYODRe6TYUIoO4iLsvc+HxiGkS6oDSY
	 C/hNZxcvFqE/6UjrngTdcPgY6RyIhJtFABEWXC8IdHtvNPKicc1F1xr6WLZP81bs/d
	 hqZbecPSKpFzqAPca/UF99rU2gOAqI2Uykk/02Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404833AbgBNQSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404607AbgBNQR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:17:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98FC2246E1;
        Fri, 14 Feb 2020 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697076;
        bh=lAkB0FGYBEcU1ex+SWbExJA6tcMV4n0xw9kTIpdIvV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHjQrqi1fyi4TItM82NwindJ/fhK07qXK5wzohQV8lOgN7ym+fQa/FaFoH8HkZJLM
         zthgeTeux/Z2YBZYe/8Dx10fB8iHn63bBOE1aaC02jsJ+DFLjTN2ZPRGgMbq+pygD1
         1eSuuE15MhYUm2qFtcf3a3IPGCjAC0U3Xqf6FlN8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 031/186] clocksource/drivers/bcm2835_timer: Fix memory leak of timer
Date:   Fri, 14 Feb 2020 11:14:40 -0500
Message-Id: <20200214161715.18113-31-sashal@kernel.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 2052d032c06761330bca4944bb7858b00960e868 ]

Currently when setup_irq fails the error exit path will leak the
recently allocated timer structure.  Originally the code would
throw a panic but a later commit changed the behaviour to return
via the err_iounmap path and hence we now have a memory leak. Fix
this by adding a err_timer_free error path that kfree's timer.

Addresses-Coverity: ("Resource Leak")
Fixes: 524a7f08983d ("clocksource/drivers/bcm2835_timer: Convert init function to return error")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191219213246.34437-1-colin.king@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/bcm2835_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 39e489a96ad74..8894cfc32be06 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -134,7 +134,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	ret = setup_irq(irq, &timer->act);
 	if (ret) {
 		pr_err("Can't set up timer IRQ\n");
-		goto err_iounmap;
+		goto err_timer_free;
 	}
 
 	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);
@@ -143,6 +143,9 @@ static int __init bcm2835_timer_init(struct device_node *node)
 
 	return 0;
 
+err_timer_free:
+	kfree(timer);
+
 err_iounmap:
 	iounmap(base);
 	return ret;
-- 
2.20.1

