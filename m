Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AACC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8B4207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pz1BOCQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGJXSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgGJXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:18:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E65C08E6DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:18:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so3185658pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qCGYxi6L0dmDdYzHShkkSHiKc6T34aWWoWuQkkFnaWU=;
        b=Pz1BOCQB0pXjBmo0xAku7n+cwdXdjkY8Qu/3gwY1QOKhNMztkqxXIGamSB0+URD4zJ
         bWGsle4ItBlbOYOFz3XZNcJ+GUr8J7HxfpiuyudOZpOdtLYbAAwglyH0n3zi4kk2nhcS
         mvQ133SopxNOT2bwP33RuYrlCnRwVtE3wmrCetH7/Q9qh0nPSPrysb9a3+/s2XmyxP+Y
         ulNhRUI6X5nAUpZHovYN2PASbHMZkbriStlea5f8FcJEhpZClmWwbmd7xaj0AuMhmyoq
         xQYYHC0uckxurGhu1x+gXqb2mo/0ksmiHT6dXqmO1uiAHdW9omZK3wwUwJpvSjfFFDWf
         mi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCGYxi6L0dmDdYzHShkkSHiKc6T34aWWoWuQkkFnaWU=;
        b=I2PjaH5fPNZO74e013ZXb2T03cWogBKh32CAsQYyaSyZAjeU86Tclr4ywZoqgUtAIe
         lnE7u0mFyR4klq1APxWnP1MuXGiSdlex6VIp1jI4ndiYWunOToCmG0qRtWUKr1bE4PgD
         Tz+IzMTSh8vr/Es70KdIGLtvCrN+4K6zuz6asxPnYX0InFcFZhYwjOlnnWofVM/5Wj/9
         SZkjVpUwC6hNa0KY4EMiuG/rLsOhdB7A++IUSv2yXt0UrtYVLHJbMfL9RBkp2rLJuOUF
         3HyL2fcv2V1HZJpDCZILQDPvYx0LcdGqVYEE6DKs49v4XQyrp4wyRNBEy3YsC27Dppat
         lP/Q==
X-Gm-Message-State: AOAM532Coemobs3Gmg7t5tlbZ1yWvmTT+KaKIjMSvD+MDMqFASpG9yB9
        0ZJAHljRbbdkhRpQY4ociDekXEnZT1I=
X-Google-Smtp-Source: ABdhPJxxd7gWIsbfCYIPEz7NG3FjvS01GFW7aSmOlHcok8aGrenQft1MCuaHlreDug7QVzY2Ybcl0w==
X-Received: by 2002:a63:8c5a:: with SMTP id q26mr58143248pgn.312.1594423114697;
        Fri, 10 Jul 2020 16:18:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id c14sm7296382pfj.82.2020.07.10.16.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:18:34 -0700 (PDT)
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
Subject: [PATCH v3 1/3] irq: irqdomain: Export irq_domain_update_bus_token
Date:   Fri, 10 Jul 2020 23:18:22 +0000
Message-Id: <20200710231824.60699-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710231824.60699-1-john.stultz@linaro.org>
References: <20200710231824.60699-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add export for irq_domain_update_bus_token() so that
we can allow drivers like the qcom-pdc driver to be
loadable as a module.

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
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a4c2c915511d..ca974d965fda 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -281,6 +281,7 @@ void irq_domain_update_bus_token(struct irq_domain *domain,
 
 	mutex_unlock(&irq_domain_mutex);
 }
+EXPORT_SYMBOL_GPL(irq_domain_update_bus_token);
 
 /**
  * irq_domain_add_simple() - Register an irq_domain and optionally map a range of irqs
-- 
2.17.1

