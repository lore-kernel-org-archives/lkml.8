Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21839C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9C720691
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFBiOJFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgGRAGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbgGRAGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:06:50 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA93DC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 8so8878124pjk.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cSGrpEWuKSVf97iW7EL4KZRFYPfb7+inZKxBuLQuvAE=;
        b=oFBiOJFotgQsYiohUpKbkZXbMk0anIOETUAPGMRKbKBtkpfPEd8xLg6XTAXbyZcfoi
         BwNvvIaw6/t2CBTYGbvsBkLGxWK6++vWST3Aj1KHKgiLKceg0RQ/9jN9Ao2iWcVkzj7h
         2Q0AYvvuyzQfl95ZIplngHYn1lLuX9YOT4GvpS3gMS4mvYXyjnqEy+kxckIutRo4ELHv
         PD8Cy2kj4InW3oDPlbSPrZZ65B1YVO/rND51vigqVYZQjN2CHT4NeULpOgwFAekw8cce
         JpLLDWTXvh8nLo3nGfEzbkbAHILC+wrXQ/qljDHEhrL2d39+3a69ylcOh6DBU7A+ud7z
         0n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cSGrpEWuKSVf97iW7EL4KZRFYPfb7+inZKxBuLQuvAE=;
        b=Bs1FGRqCUwKxTZbCVvmHiyEIPCofBSG2qtnJ1pECvK5kYa7VRd+VoUpFa8DV52FPuX
         LcJBhDRnwEKZzdBG2udc1WWwoEu7nmOJqLzTPuXHOisXxmUSROE/sMnL2+f+o0Eop3vR
         Znt+zyWeBuMOjJONbkm2LVVa9/OHpEV/NsIsetcfg0q2n5TrqjZ28BffezmY7y1I6tgR
         NZgA4lk5HA5PbcKYUo8CpJi1SOBKclSoyvM0JdzDJNyK458UyK0A4vPD+XCRQRnPenim
         mcr3lsZ6KUdb8v4jIy9ejytBY7BmgmJPuuCQu4ueChSGgkBy3+Ie9CN6JBwIikPrFP/R
         AaeA==
X-Gm-Message-State: AOAM533nr6GbtvOT2mLZxUq1/h/3QpqSWSaE7aQYMcadcY4P5hYkShro
        ZSpHXbFyhzvWw6wnieB5rCCqPQHi/iD4GcA=
X-Google-Smtp-Source: ABdhPJzKJZr8KDd4Yo0Wm5lo4eKhPkLN/TRhN4fCypWCbhR0OyB2ssX8VqDuXN35b/Dzh+f6roB+vXsTyHzgnyQ=
X-Received: by 2002:a63:7d16:: with SMTP id y22mr10135672pgc.136.1595030810200;
 Fri, 17 Jul 2020 17:06:50 -0700 (PDT)
Date:   Fri, 17 Jul 2020 17:06:37 -0700
In-Reply-To: <20200718000637.3632841-1-saravanak@google.com>
Message-Id: <20200718000637.3632841-5-saravanak@google.com>
Mime-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 4/4] irqchip/mtk-cirq: Convert to a platform driver
From:   Saravana Kannan <saravanak@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver can work as a platform driver. So covert it to a platform
driver.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/irqchip/irq-mtk-cirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 69ba8ce3c178..62a61275aaa3 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -295,4 +295,6 @@ static int __init mtk_cirq_of_init(struct device_node *node,
 	return ret;
 }
 
-IRQCHIP_DECLARE(mtk_cirq, "mediatek,mtk-cirq", mtk_cirq_of_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_cirq)
+IRQCHIP_MATCH("mediatek,mtk-cirq", mtk_cirq_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(mtk_cirq)
-- 
2.28.0.rc0.105.gf9edc3c819-goog

