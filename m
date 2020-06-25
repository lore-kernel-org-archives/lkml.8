Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE14AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F8C20706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOF1Yhix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbgFYAKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388686AbgFYAKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:10:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241DC061797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 17:10:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so1913991plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 17:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qCGYxi6L0dmDdYzHShkkSHiKc6T34aWWoWuQkkFnaWU=;
        b=rOF1YhixiSD8M50+j5CiMzpdohF2arfJt6iyO3UNYlYzhcfBE1/ym4B6dvjJpTZQXZ
         zNVl2oHPobEbAf/+XE2fkhaKapUULh2NUBFuLnvMJpyrqa8xhuu4qGqnVEr92Hp1cXAH
         QQaYRDNL3+IxM2eAoostdDGI9aTtunbnEzAclrm8dcD0BhYaha73Pc10WKlQIrMw4nxg
         75l1QGAhHoBHeSHNEKMgI82S4ZsIAl9YBGDMdZeoKr7tX9q0TN//+8jFTFf9KrKkZQYF
         OuDtsKWUUZAau3d1SAJhBktN2QePVibBmLBb7cygtwzBQmNZ/HXDf1LYhCdnotpzASWL
         PR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCGYxi6L0dmDdYzHShkkSHiKc6T34aWWoWuQkkFnaWU=;
        b=Kkn7LnV4N6NzG+8giEFm5M4e2swRksTA/zeUscWuwGPWNC3QhmYHBEMdi6orjxjH8o
         R4DYI+E0PXzpT9/yeK0nKVKMVUJhHkEwd1RlRh8D00xcZecic8Skei1PpojLIjfD28Jj
         NucIbp8U/0w6yRfHgROqXMtCGwOrzrFMKOp8LhRBbiCsN0jbHdN05sj+JoJFdyWGTpZz
         IcDoXaSvjnfj/Jm5Cx40SB5pygWb4lrwDZvQE+ogYYkC7/BdBeuBl7eSi2WUFMEw0Gb7
         87knKQby3LjXwYYLwtRCwdSILNtcyQVcm3SeDxSGHfXBs9G/Utj/wpG/IRf3k8/IjUGV
         e6qg==
X-Gm-Message-State: AOAM531+cOtJdreaYBy3Q0w15gZYuvyXABydUW6HiyBvRBy8x1CikwkV
        AlV96yeZoIiBHmQDRovvb9AtGj8Spvg=
X-Google-Smtp-Source: ABdhPJxGeqEMqjAA50eBDK/+kqthZdDuh3xyYY2kWfjMLxc1bNitFm5ktScRYkrsfEUgv5rN5ZagFQ==
X-Received: by 2002:a17:90a:1781:: with SMTP id q1mr392515pja.8.1593043844977;
        Wed, 24 Jun 2020 17:10:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id n19sm17458671pgb.0.2020.06.24.17.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 17:10:44 -0700 (PDT)
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
Subject: [PATCH v2 1/5] irq: irqdomain: Export irq_domain_update_bus_token
Date:   Thu, 25 Jun 2020 00:10:35 +0000
Message-Id: <20200625001039.56174-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625001039.56174-1-john.stultz@linaro.org>
References: <20200625001039.56174-1-john.stultz@linaro.org>
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

