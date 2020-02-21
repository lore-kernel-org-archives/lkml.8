Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F39C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551832465D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272229;
	bh=6lKOMqR9i+K8QwMDVdaLd2gD/Oq+Ml/qLNpP7AQyCxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=13INDMEtI1QCSMhqGHbm8EhJkjB16tnxfg2bRJDcNyfRhxFZsqn4+Fc9CaDU07T+D
	 d+U8qmkbyysIszclm94KeLfw05IN4p5g4TVWOz0vGiJRqQ4nXoyZswYAO27jt9yHON
	 65Kif+gPjL9BnGPPmDn2wUJGBTB69FsZl8MhFAv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbgBUIDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgBUIDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:03:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342E024650;
        Fri, 21 Feb 2020 08:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272224;
        bh=6lKOMqR9i+K8QwMDVdaLd2gD/Oq+Ml/qLNpP7AQyCxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3GMhxVBG0s92AgK9ypOTSG2GeSBXTFnG5Yv6/EKXE1g5QJrusv4hR8QIpW/1o2MH
         U3ZyrDWBF4zt/nLBjRIqzWszZs/vVbYjlHKhh3pEdzfhMZ+LJDAtWFNfVRYVX21P/u
         eI4ncTNJimunE/fVXF7DVV2K1Ok9bWe9bCbJYJIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 061/344] clocksource/drivers/bcm2835_timer: Fix memory leak of timer
Date:   Fri, 21 Feb 2020 08:37:40 +0100
Message-Id: <20200221072354.581014752@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 2b196cbfadb62..b235f446ee50f 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -121,7 +121,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	ret = setup_irq(irq, &timer->act);
 	if (ret) {
 		pr_err("Can't set up timer IRQ\n");
-		goto err_iounmap;
+		goto err_timer_free;
 	}
 
 	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);
@@ -130,6 +130,9 @@ static int __init bcm2835_timer_init(struct device_node *node)
 
 	return 0;
 
+err_timer_free:
+	kfree(timer);
+
 err_iounmap:
 	iounmap(base);
 	return ret;
-- 
2.20.1



