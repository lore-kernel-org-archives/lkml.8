Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4657FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2711D2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8pnncAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFPGNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgFPGNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344F4C08C5C5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so7912952plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d8HNtFjVL/HPLva77WTnFKUW0Kvfs2vTc0BrF81DdWI=;
        b=v8pnncAeJ6EXVXBVIROBwY85MaUJaS+3cYpbNNYYzPLk/7pselZhTcoIxYzjCeyVv8
         z7rLz6dynrZeFhSyjXXuzxJss8D71TgLPxY1wSvVrGHHBe36mvLVuJbyV7oeqmPxZPF4
         3bBf2ru+qoskK42o6IV1MKU7khzwkAlxUiF86aroPb9CUN8SmEpvlRuPhbKl/aZW/n7x
         AWmFqLqQFiPnl3Li0QE+BVRXmEQzG3QuSiiUUYtPhE0RXGhRnX5RUcHPWqrprYghVulQ
         elANL0qhyySKvw/JSPWezE64h1v8gJgRUsY4bf8AXuO5qPZruWEfPRgNNcA9UaNhTmde
         rX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d8HNtFjVL/HPLva77WTnFKUW0Kvfs2vTc0BrF81DdWI=;
        b=qcF2dXXUDTKMprMppLGEHkkAYtcNIQHr1ogJGENF8xJBhInRoplckepB/r7547UgDy
         /vaElYO1jIdTUxSmXqn+PUn4jIf39aNmfbP3M5mU3rf12B+rC0hdERGEMOovlwzart3L
         Au1WXe4FirbHAPbJgGuV3oUabwCCdpBd28YTCCLZ8nO8Y+EsrexBNe5ziUXW7TUOMOq3
         N8BkrpLRGCf17W+OuHntiGMij2LGIgbTy+teu8JL7yL+8TMJSqSjZV8OaQq0FFHbo4KV
         wG6yrrEgiMwtA97DSonG8CYrxrw/X5v4SOLNMr9emdpxOi2+VhfmtEofs1FpenINNLPP
         16gg==
X-Gm-Message-State: AOAM533HLxoeOTCBSPosqaXPzx2Sd8xvstrMfLcWPFuLpka+DQWO86wy
        Jq4QrUF9XMa7dck36VxQXVslKYDuliA=
X-Google-Smtp-Source: ABdhPJxCaVz3G+/geS1NzlugB57rAw/I7PZ2XURXxDE8DMjhkDv5DK9XyvrD63NMIlJN57XPvBQpCw==
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr1308713pje.129.1592288024596;
        Mon, 15 Jun 2020 23:13:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id i26sm15642032pfo.0.2020.06.15.23.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:44 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
Subject: [RFC][PATCH 2/5] irq: irqchip: Export irq_chip_retrigger_hierarchy and irq_chip_set_vcpu_affinity_parent
Date:   Tue, 16 Jun 2020 06:13:35 +0000
Message-Id: <20200616061338.109499-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061338.109499-1-john.stultz@linaro.org>
References: <20200616061338.109499-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EXPORT_SYMBOL_GPL entries for irq_chip_retrigger_hierarchy()
and irq_chip_set_vcpu_affinity_parent() so that we can allow
drivers like the qcom-pdc driver to be loadable as a module.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 kernel/irq/chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 41e7e37a0928..ba6ce66d7ed6 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1478,6 +1478,7 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_chip_retrigger_hierarchy);
 
 /**
  * irq_chip_set_vcpu_affinity_parent - Set vcpu affinity on the parent interrupt
@@ -1492,7 +1493,7 @@ int irq_chip_set_vcpu_affinity_parent(struct irq_data *data, void *vcpu_info)
 
 	return -ENOSYS;
 }
-
+EXPORT_SYMBOL_GPL(irq_chip_set_vcpu_affinity_parent);
 /**
  * irq_chip_set_wake_parent - Set/reset wake-up on the parent interrupt
  * @data:	Pointer to interrupt specific data
-- 
2.17.1

