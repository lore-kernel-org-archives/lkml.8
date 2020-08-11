Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A7EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8079620734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="jWElF0wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgHKBIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:08:06 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:48026 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgHKBHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:07:43 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQZSY2hWzzL3;
        Tue, 11 Aug 2020 03:07:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597108061; bh=XBigUQcy+V9cJkV3vEIxp3zZ8VW9N8bjjMb3WXILdFs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=jWElF0wWl0RXfF9CyawDJe+2SCeIiU4od9RBi/GJMtx1NzFe+rGY+IfvH9vXBOWwq
         urMnQRHRNnxT8YXWziMVy8ABSkkwIAYMoOAgV+8a75epbaXxvR2o018Xd/KnNrgisj
         BjPKvzFwktqF4CqzocFPKJz+hQD1uQ8a47tBkrN5/sh1mLqqJ74z5UFe65L/QKg2Ar
         mDlWM4w5+zfAwVlcmQ8oIb0FRI2gp/Jn2msvm/rgGchPaY2HbWC2LA89uBH/pCPN8K
         f0ucJ219nZHjQYFpLXRWYK2DK7zl2Y5sSJljhpq6vTEFv4Kz6PYsJAgQ2oRtLagS9A
         3dsuk9EJgaEMg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 03:07:40 +0200
Message-Id: <eb061133ecd1dd856ddff2dfe7a891e00a56e3f0.1597107682.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 6/7] regulator: cleanup regulator_ena_gpio_free()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since only regulator_ena_gpio_request() allocates rdev->ena_pin, and it
guarantees that same gpiod gets same pin structure, it is enough to
compare just the pointers. Also we know there can be only one matching
entry on the list. Rework the code take advantage of the facts.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a9ff2ad55ee7..b85ec974944e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2260,19 +2260,19 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 
 	/* Free the GPIO only in case of no use */
 	list_for_each_entry_safe(pin, n, &regulator_ena_gpio_list, list) {
-		if (pin->gpiod == rdev->ena_pin->gpiod) {
-			if (pin->request_count <= 1) {
-				pin->request_count = 0;
-				gpiod_put(pin->gpiod);
-				list_del(&pin->list);
-				kfree(pin);
-				rdev->ena_pin = NULL;
-				return;
-			} else {
-				pin->request_count--;
-			}
-		}
+		if (pin != rdev->ena_pin)
+			continue;
+
+		if (--pin->request_count)
+			break;
+
+		gpiod_put(pin->gpiod);
+		list_del(&pin->list);
+		kfree(pin);
+		break;
 	}
+
+	rdev->ena_pin = NULL;
 }
 
 /**
-- 
2.20.1

