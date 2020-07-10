Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C65C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7714F2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fb2laGua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGJXSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGJXSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:18:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B574C08E6DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:18:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so3181586pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+LAKpRiBafd2oOjp/6TfYpZhYF0M8uCnrw227kRHd7U=;
        b=Fb2laGua2O0o3qIqAFaaFHeDOkX2Z7Sq4CysZLHkLud6BHKz7RjNEDQoC5zg+gdNRW
         l64bwkrGWxENZzaGdE49CdjfCWmeTUpd14CG/9Ea+BuiUN8kv4ApLd2gVTRe3z4magmR
         /XwHgns0ezmupMVonilKBcWoXcOnMTYozNC5ES7ifUTfqH2sgImqCOF62Phuf4Kszvzl
         +FemTUwsgBfpnPH36Y1zR/5tLM5bOqN7ha3p8bIkHr1EEnGS56QYXSjXfNoXh3E/MI7e
         uBh6LC8Nb0jgO/h3+mfxpKQjb79mjvvEB2SbYBWgz1rl4bCt3oeRAQCH+eVBmZ06lORX
         dcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+LAKpRiBafd2oOjp/6TfYpZhYF0M8uCnrw227kRHd7U=;
        b=lcXvTi0f08eezPUizKuAUIKgNyTeLLNKAL5hgp9b8W4vi/HPqUajnrkf6Jwdi9jXri
         Uhf6hI9uGuw0iDbzyyI9pqG4KoMkOPOTsfNMdjk6tkCqBW3ZeTTsBYCdOL4Bb0bVEOQj
         nbXvzcya3k5FvR30PjCaf3L4+rd8P6mz46TsXPwJkzUryR8nPvRJPt9ytvtPe6V7b/hj
         vnnxxH/G2LlnP9cDGUJ/fcjGrq14cGVd5sn4kJMeBSzO+3qqIvAwfQMNXRxWVk6MM49W
         V8+87FTgx3UhuhtD6tmp0P42fjSgdZdi/UsF920gHlcEPnSvH7yklAOWeJAMJYOs6Kpx
         +9Xg==
X-Gm-Message-State: AOAM530M+K9MkFE3Kk8YPINOuyPZ+ocyb+ngbBPbYB0z1h9Bd39DtEvT
        I9+wgi8tEiIeWmUJ8JdbeZG1eusMee4=
X-Google-Smtp-Source: ABdhPJxazz3b2K1meU8hdEkjra2QvmoMn+ofo3x6qLL7NuVHq/rd+1PfJ28IeoTLBIcjHFUnIpZasQ==
X-Received: by 2002:a63:fd03:: with SMTP id d3mr60360119pgh.76.1594423116626;
        Fri, 10 Jul 2020 16:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id c14sm7296382pfj.82.2020.07.10.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:18:36 -0700 (PDT)
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
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 2/3] irq: irqchip: Export irq_chip_retrigger_hierarchy and irq_chip_set_vcpu_affinity_parent
Date:   Fri, 10 Jul 2020 23:18:23 +0000
Message-Id: <20200710231824.60699-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710231824.60699-1-john.stultz@linaro.org>
References: <20200710231824.60699-1-john.stultz@linaro.org>
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
Cc: Maulik Shah <mkshah@codeaurora.org>
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

