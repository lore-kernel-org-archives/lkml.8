Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBDCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64828206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="qIKRRntN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHITVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:21:21 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:37343 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgHITVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 15:21:21 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BPpqM0Gb7z8y;
        Sun,  9 Aug 2020 21:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597000879; bh=FxMu9VKYnSAZULnqvFb3SCOZdO1jmVriVZ6iSkttly8=;
        h=Date:From:Subject:To:Cc:From;
        b=qIKRRntNOToqP1ljPJT9nGdBdhkiCLDarT1hpSi1qIhoYtDqnNw3QZrmqqssTCIFy
         ko6h+CcVOenKnoYq2FcIZTZbQxZH+4MxWN2kXndPYockkbkszK6DseLwflLMVGhENE
         027zbVK+JPQH4tGIL/LbwFgodSghXlNEeBiF82WjfK5MWR4W2hLCm1HJ0VR/UU6fJQ
         EfITIoiwIOqVyCD0Z/o50hYhx3RL8bYaKyyRJwLf2j5iuGKbtzf0WTFgMTSa5CZerQ
         dwp2XyCfw9Ek7/BpQi7YS8nOLJyBQAnnIpJ7KWymLuFAecT5pvUBpkpxOrkloP1xy+
         9b50VfUNr7UqQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sun, 09 Aug 2020 21:21:16 +0200
Message-Id: <407fbd06a02caf038a9ba3baa51c7d6d47cd6517.1597000795.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] regulator: fix pointer table overallocation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code allocates sizeof(regulator_dev) for a pointer. Make it less
generous. Let kcalloc() calculate the size, while at it.

Cc: stable@vger.kernel.org
Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 75ff7c563c5d..9e18997777d3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5011,20 +5011,20 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 
 static int regulator_init_coupling(struct regulator_dev *rdev)
 {
+	struct regulator_dev **coupled;
 	int err, n_phandles;
-	size_t alloc_size;
 
 	if (!IS_ENABLED(CONFIG_OF))
 		n_phandles = 0;
 	else
 		n_phandles = of_get_n_coupled(rdev);
 
-	alloc_size = sizeof(*rdev) * (n_phandles + 1);
-
-	rdev->coupling_desc.coupled_rdevs = kzalloc(alloc_size, GFP_KERNEL);
-	if (!rdev->coupling_desc.coupled_rdevs)
+	coupled = kcalloc(n_phandles + 1, sizeof(*coupled), GFP_KERNEL);
+	if (!coupled)
 		return -ENOMEM;
 
+	rdev->coupling_desc.coupled_rdevs = coupled;
+
 	/*
 	 * Every regulator should always have coupling descriptor filled with
 	 * at least pointer to itself.
-- 
2.20.1

