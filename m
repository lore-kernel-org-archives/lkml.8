Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F93EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0947D21D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQApDRLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIITla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:41:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DCFC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:41:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a65so3410481wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krsC5TlDTzFA7N4jXvevywXfD40E1ld+Bd6bF1uKPo0=;
        b=jQApDRLWrd0HRK0Vx11RKynsnzL2LCzupHBZ2iu7Sr/BrT11O0VQG0DVMS23c/deNS
         SC33nesbW4f1JNxaKn/txaZlt7+sZDvy5c1jPtXR3GuwLl62XVBaAp8JIJ7IvWwHGcJV
         BouAmtu3kK+n8e+lbRp0Be3BIhWYk21qJlKEVPGtjmtg9XutvYprq67RzvKIgtps0WJi
         CiSjV++ZUc4xOZh6gFp5NMerA0RD0iNSTlHKnqYbfdX0lFcXPw2Z6S2tlD2q8TUfca97
         9tKrlCH2FY8kEKw8uZcOmT9ovcZznME5NvT1eGyg294sJtMQDS2XyWkeldcWpZG7jGqo
         R+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krsC5TlDTzFA7N4jXvevywXfD40E1ld+Bd6bF1uKPo0=;
        b=g6ao/hJ7R/bSJT9gtXH9gWszXZ5fo3CaBce4fxpHjWc7Fx8720SQs6JIwHtPZrOTZ7
         EjDtHTBtFaeQi7xVjCB+MaaF8dUhTkMn4Koh5W7UZQHATvaAS73lxPdNDV7b87Fi6ZRg
         hutvu0DL/3umTZbkfUCV2WeXLQDfaDnh8JTDd9QhMwlePDbaMccLB7RQsr5giMkkJ7Ht
         QJUBhdGVuoAgiZeYHkz73XVCFG+1x4rjtGFRYccY5hjGZuo7fkHVXk+iyB9Ja52jOa4e
         gcm+vxRZNHmq9sV7ZE7vPCRvYGoAHaykbqByHMHKO6CG76sLsoE/fdSd8V2BHIeyCK9q
         hg8A==
X-Gm-Message-State: AOAM531zukD8NQ8naG1lGlBCUia3HRJGb/K6fNECdcrUPGgJT3E9tQM8
        YeS/f0onqrngOgcD8AG143U=
X-Google-Smtp-Source: ABdhPJx4SJ5ySAYxLXHiT1bLYcJi4lRCVVLiy5Md3vYJ6vTjQ5z1ij+xpGy6S+uEKcOFRtYiST6JBA==
X-Received: by 2002:a1c:800f:: with SMTP id b15mr4806472wmd.114.1599680486179;
        Wed, 09 Sep 2020 12:41:26 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id j7sm5402892wrs.11.2020.09.09.12.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:41:25 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] w1: Use kfree_sensitive instead of memset+kfree
Date:   Wed,  9 Sep 2020 20:41:21 +0100
Message-Id: <20200909194122.212486-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue identified with Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/w1/w1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index e58c7592008d..4f597b0fd1da 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -71,8 +71,7 @@ static void w1_master_release(struct device *dev)
 	struct w1_master *md = dev_to_w1_master(dev);
 
 	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
-	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
-	kfree(md);
+	kfree_sensitive(md);
 }
 
 static void w1_slave_release(struct device *dev)
-- 
2.28.0

