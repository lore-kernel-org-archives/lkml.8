Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66C1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973A72078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKaW/qhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHQIKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHQIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01683C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so7860704pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c28nS7WM/lTYYOV8e8WUD4cNVy3Nzu7Y0qu9f3pUCU8=;
        b=JKaW/qhiuSNySCEDtskRMrkBRMcOYGrH0RWP8TPo+yYLl2eZCTVycD16UiJAsViA5k
         MkXG7XD47OeYn+hc+/Dq6+RAOz8cem+i9O4jDB6xuiGZjjfLcC+7P3iW2oejT+HjaBij
         Rqz2I8RZEKzf7kizbmX2KnnKxFL9O0u8zAdXxw9Uy/Sa/JRB4o0laqHAYtGuodcS52rI
         zME3rgin9Ca0nJRrNelux/wp7R8tf4X0J0txkY5T8d7JWZYxdj5kOiZxAi+y1Iq77wmA
         47klSV2lR00j9fuVBF2asw1sS/xrgTauYLJB2b5P6UbGbqlDupcwP5YdT23MYcReuUeu
         4YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c28nS7WM/lTYYOV8e8WUD4cNVy3Nzu7Y0qu9f3pUCU8=;
        b=jjzE7Xc10CzxRVKjbpOhX3sd8SGjzyCUZwf2WYdYWqvSQ8C/LjrEFkvKLpOyEDayTX
         D12jBvzQXaQ9SnOIA/m6ckWc8UutX5u3NXU1JxsDhhFPZbhusX9Z92rqPVd4oqil/Qjc
         dtkcHd3s0/+J7ZJNKrVfUYWg5JTuon/4npJB8Rn8to8b+tdOKquGqBlGf2GSc2IL1ylU
         m/Dnumz6ztE0derJ1X5KWp8nGquwSP+mWn+r6D2/r3j6usmXcogwHfUPAUaidaihbMYw
         gnA3n89r2uh5rHtDfPbrURopa4O2gy9Xzo7WotdG36gF4/o7vHQmWJ9L1rMlSYyntI8O
         2yFg==
X-Gm-Message-State: AOAM53112GVmgQ2byt9i5bC232Scnh6K7jHhXXtZvIJjYySQJfgkS5JD
        HHH0Tsq0xm6ZL074M8p5xK8=
X-Google-Smtp-Source: ABdhPJy9BYzbwcPgD8HG385Grr9hWC6WWjeKSMjJrjMJT/p0siFf1MLryVEBt68UMnCJUAKmTrmeNg==
X-Received: by 2002:aa7:8f04:: with SMTP id x4mr10836392pfr.199.1597651842595;
        Mon, 17 Aug 2020 01:10:42 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:42 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, heiko@sntech.de,
        matthias.bgg@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        inux-mediatek@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 08/19] crypto: hifn_795x: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:30 +0530
Message-Id: <20200817080941.19227-9-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817080941.19227-1-allen.lkml@gmail.com>
References: <20200817080941.19227-1-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/crypto/hifn_795x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hifn_795x.c b/drivers/crypto/hifn_795x.c
index 354836468c5d..785d7c4f44e7 100644
--- a/drivers/crypto/hifn_795x.c
+++ b/drivers/crypto/hifn_795x.c
@@ -2443,9 +2443,9 @@ static int hifn_register_alg(struct hifn_device *dev)
 	return err;
 }
 
-static void hifn_tasklet_callback(unsigned long data)
+static void hifn_tasklet_callback(struct tasklet_struct *t)
 {
-	struct hifn_device *dev = (struct hifn_device *)data;
+	struct hifn_device *dev = from_tasklet(dev, t, tasklet);
 
 	/*
 	 * This is ok to call this without lock being held,
@@ -2530,7 +2530,7 @@ static int hifn_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_drvdata(pdev, dev);
 
-	tasklet_init(&dev->tasklet, hifn_tasklet_callback, (unsigned long)dev);
+	tasklet_setup(&dev->tasklet, hifn_tasklet_callback);
 
 	crypto_init_queue(&dev->queue, 1);
 
-- 
2.17.1

