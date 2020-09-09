Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF51C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411EB21556
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1ikBxwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgIIAWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbgIIAVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 20:21:42 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947FC06179A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 17:21:39 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h11so653739ilj.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 17:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXt6HV+Ir2mOjyqv+jsDtLLXzMvpXAXcGItzvsZha8c=;
        b=K1ikBxwOY2ZfMmKbyNAEfa+2REjTqMN5eToafYQxqDBbSkbgmYHhxvACi/tyeBGRuU
         YYlVJsbOjE1qn4oxIJMnuCo2jsxS080MXAa4SsC+XWNS257yjSYa3VBOFh47Cox/ZfKA
         MrFt1VB9WWLDTG8FYVgjeOtWDiwnXS0PIG403ri43pQKqqpnf1/DDayLHncvpXuT+fR/
         YUJhPqJvB0IoSw9DiUJ/G7uR2HGzAAahhgrEz+ao7bb67jFJjrpDVYqYvwiv0KRyE6gI
         TjVyR6PeWVZsQm0KVeM7LKeAydLYQLR7tHOlSKvxMdeQB0R9wxuhC//7VP5+5i/wBBKp
         U/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXt6HV+Ir2mOjyqv+jsDtLLXzMvpXAXcGItzvsZha8c=;
        b=Q4sqwx9Z8TzNtPy64mY7tizd0pbLdvhApbWWxjjYsSxg46nbF1yv3mizkHYOe8SLNI
         D3Fb4yq9cw1zg/NJ+glvcXEYKORaQtq2CVTej05PKV+o4mxfYwd5wAQNmdV/4XQVxpxU
         3nZ9EvfGvJsGjqCovEg90oPV0MmsHd3Xi2tm6dovqUOv7wAezCsfSdHPtTy+201Ghhlr
         H8rc8LMRw8gvg8npcw87HGaMcGhL0MuLYRUnxrSxukJT1gS1ETw0w8iEBtLaPs/kJ7gJ
         Xx4nkTaERnYhl6RntNxagBiB7S82E2rA4yj6QDePG7NAV9zIhqyuTfBxiqmicFLhlIMv
         R8RQ==
X-Gm-Message-State: AOAM530BNyglq5zwZi0moAg0lc1xGDYZAL+n+GXbR65aRuPPzz6GMTd/
        GhJxEUZjww3EMioNKEzAJU+cOg==
X-Google-Smtp-Source: ABdhPJz8Y/hkeZJj/oWXAMsOPa7lCT6ojQegClkfzBAlqYnHR0bugPQcNg9H8Kq5XTc8HyJcAi3YAg==
X-Received: by 2002:a92:9145:: with SMTP id t66mr1300389ild.305.1599610897475;
        Tue, 08 Sep 2020 17:21:37 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f21sm457739ioh.1.2020.09.08.17.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 17:21:37 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] net: ipa: do not enable GSI interrupt for wakeup
Date:   Tue,  8 Sep 2020 19:21:27 -0500
Message-Id: <20200909002127.21089-6-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909002127.21089-1-elder@linaro.org>
References: <20200909002127.21089-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now trigger a system resume when we receive an IPA SUSPEND
interrupt.  We should *not* wake up on GSI interrupts.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 17 ++++-------------
 drivers/net/ipa/gsi.h |  1 -
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 0e63d35320aaf..cb75f7d540571 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1987,31 +1987,26 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev, bool prefetch,
 	}
 	gsi->irq = irq;
 
-	ret = enable_irq_wake(gsi->irq);
-	if (ret)
-		dev_warn(dev, "error %d enabling gsi wake irq\n", ret);
-	gsi->irq_wake_enabled = !ret;
-
 	/* Get GSI memory range and map it */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gsi");
 	if (!res) {
 		dev_err(dev, "DT error getting \"gsi\" memory property\n");
 		ret = -ENODEV;
-		goto err_disable_irq_wake;
+		goto err_free_irq;
 	}
 
 	size = resource_size(res);
 	if (res->start > U32_MAX || size > U32_MAX - res->start) {
 		dev_err(dev, "DT memory resource \"gsi\" out of range\n");
 		ret = -EINVAL;
-		goto err_disable_irq_wake;
+		goto err_free_irq;
 	}
 
 	gsi->virt = ioremap(res->start, size);
 	if (!gsi->virt) {
 		dev_err(dev, "unable to remap \"gsi\" memory\n");
 		ret = -ENOMEM;
-		goto err_disable_irq_wake;
+		goto err_free_irq;
 	}
 
 	ret = gsi_channel_init(gsi, prefetch, count, data, modem_alloc);
@@ -2025,9 +2020,7 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev, bool prefetch,
 
 err_iounmap:
 	iounmap(gsi->virt);
-err_disable_irq_wake:
-	if (gsi->irq_wake_enabled)
-		(void)disable_irq_wake(gsi->irq);
+err_free_irq:
 	free_irq(gsi->irq, gsi);
 
 	return ret;
@@ -2038,8 +2031,6 @@ void gsi_exit(struct gsi *gsi)
 {
 	mutex_destroy(&gsi->mutex);
 	gsi_channel_exit(gsi);
-	if (gsi->irq_wake_enabled)
-		(void)disable_irq_wake(gsi->irq);
 	free_irq(gsi->irq, gsi);
 	iounmap(gsi->virt);
 }
diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index 061312773df09..3f9f29d531c43 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -150,7 +150,6 @@ struct gsi {
 	struct net_device dummy_dev;	/* needed for NAPI */
 	void __iomem *virt;
 	u32 irq;
-	bool irq_wake_enabled;
 	u32 channel_count;
 	u32 evt_ring_count;
 	struct gsi_channel channel[GSI_CHANNEL_COUNT_MAX];
-- 
2.20.1

