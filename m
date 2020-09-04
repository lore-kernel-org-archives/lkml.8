Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63B8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DB62074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yGxJWlsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgIDPVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbgIDPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:21:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AB6C061247
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:21:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so7136187wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eEZDuStJjJk1FIrMzwflNMl97fxslfVlQl/5yuaVYNI=;
        b=yGxJWlsyeosFf351pC1itNstGCRhwWhmdMXb4VQRFTAu/Qyrsb0OIp5seNKsnrOelE
         zqxYV7mkcv8JyXa/zPwFYsZBbngqzyjOH0OoO0ktkwcBwMbJ27fFg7CSEclPLeEzciJ5
         3aJTlA99yXS4EviRJd4r8inMZVlJOjPUwTiZrP0gQwpgO5EEFbdQNUW6LGUZf1J5n47S
         GUyCiKqxf/u++rcyDtNJnNMc9X46SGlUe/S5YJrDA2x8L3mRyI7isBAIcXYQBYJJZ+my
         gXjX5FS9uP75Uad8hyGEf0cZyeVrOAKIE/jAz3iT6ac0AkBL53NwAaQt27f6F4qUckeM
         QCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEZDuStJjJk1FIrMzwflNMl97fxslfVlQl/5yuaVYNI=;
        b=tE5LexTDu3uPkW/QbXMT7fSr11kKCw9mAbmlzOam0wTMDy+P2vuCZAgvT+Q+MEp8R3
         yDiAi/IR6O08VGfW03r1MaykuUvFKRtblm4ntUzbskX3ZEDg7staRbz0oLfzl0w0v3Jp
         F/g8PJkgoirdsI9dmOKftMi7blOuZDpe84YiBJAD2YetIDF6oSRxfdVknHu84Kn6mAMs
         A8SAZzQV5x56wuJHra0oINybnhNfSwQ6JVlwrsCN9vC1uE0ncC1EoFkzv7wqc2nFtH00
         dKig8oMzgJFlWZzIQ9bC0iThlWfLAgRdch+pvraGg2ZjueOObQsD7HoJFJYwefG/nsHZ
         kbzQ==
X-Gm-Message-State: AOAM531N1lAanBaSyOkFPg++5kwpP07M7btsZq9WBd+0Pu9pBIwsEm0T
        /DRtLy3YwrNnN96c5cooMp4CKPDVS5wGgw==
X-Google-Smtp-Source: ABdhPJwl4h3PqASTyFA1+ncRsFs+j+n3e5ZfX4N1EuqV6KZX9K8bXEhi628kvRJBKe6oBcnZRI/lDw==
X-Received: by 2002:adf:f8d0:: with SMTP id f16mr8793626wrq.66.1599232889418;
        Fri, 04 Sep 2020 08:21:29 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id a11sm7789534wmm.18.2020.09.04.08.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:21:28 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 7/8] rtc: rx8010: fix indentation in probe()
Date:   Fri,  4 Sep 2020 17:21:15 +0200
Message-Id: <20200904152116.2157-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904152116.2157-1-brgl@bgdev.pl>
References: <20200904152116.2157-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Align the arguments passed to devm_rtc_device_register() with the upper
line.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 181fc21cefa8..ed8ba38b4991 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -450,7 +450,7 @@ static int rx8010_probe(struct i2c_client *client,
 	}
 
 	rx8010->rtc = devm_rtc_device_register(&client->dev, client->name,
-		&rx8010_rtc_ops, THIS_MODULE);
+					       &rx8010_rtc_ops, THIS_MODULE);
 
 	if (IS_ERR(rx8010->rtc)) {
 		dev_err(&client->dev, "unable to register the class device\n");
-- 
2.26.1

