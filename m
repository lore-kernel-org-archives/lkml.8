Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25D6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D33A20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrKBu1Jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgICPMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgICM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:26:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B4C061247
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 05:05:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o68so2173857pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqVh90gZA+Jv+sQxaZ1mzbNqmtA+iD77lIe6xdCdvDA=;
        b=ZrKBu1JhDqa2E6DWCiORaYi2MHc650K/DlmYKis/qZYjWXXy6O+yn0bP6TzIzsFBSm
         euxbxOw6IhVyzcAW8Vg3CiZLCvCk3y+3OPvMHWw5RBKjrPdfM6xu/rqNc8R2NLafIsih
         PAvlVMhgYWUB6A0ZSUT/CM7hHt+s3sfhx0dBkWYjvktZgVl+5nkLfmMY8VKHP4DnGpQ2
         sK/R6N2wlyYaKb/BxxT0IkjO9QEoKIQ4C72kgiwS2cWKnj7odSv2/WeCxtlsxpyaiDih
         3IrOJGvYyomi7nArQs1weOdsUN/13cCauS5AEJoB5Sximm3RWvnsUGOUrGAHd+Zh0Mc7
         9wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kqVh90gZA+Jv+sQxaZ1mzbNqmtA+iD77lIe6xdCdvDA=;
        b=KVVdX4jedEi44PZcUvkH9O0qjAKpW2Nz6ND9zAAWYw0bDfJplitRxLjyZQUWR32cxf
         8e9ZWYE6ZDOBAqb94P/mAE98Y8CeZeBoinFLAYqPSBX3wxFzQ1oqfejS8rB5d3PaSAXe
         +MSO4GsAeY8pJXcVGO7YDFhUpbHCIyf2FLNy4S/TnSh8cBR77QOI2AsZq0vJQWFnep7o
         YsVdyPPkVB8JVLkNfbQCPEss8xK55Y4CH6E9D6w5vFx0q5yq/AD8SbSRMifiV6P3dlkr
         d2XBSXDRUTcjxZ311yS3+3GThYukogY2ElaJMXIlHBFOPM5qsc76t5WffU+52d8qXyko
         VciQ==
X-Gm-Message-State: AOAM530bJP7ZY3X459gBvWKaZT/9qr2Mxdun1+IcxRuQjiTmbWYZY70r
        J9XA6T+f7wN4kGwiTF91mBkz8A==
X-Google-Smtp-Source: ABdhPJxdTtirKYDBW9CeUl6CQDwTBIH7Lx0gi0PsvFrbdxpYkigdH3s+GR3erecKM5HMZcA9+JJmag==
X-Received: by 2002:aa7:90c4:: with SMTP id k4mr3398751pfk.79.1599134755991;
        Thu, 03 Sep 2020 05:05:55 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.248])
        by smtp.gmail.com with ESMTPSA id s1sm2922022pgh.47.2020.09.03.05.05.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 05:05:55 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 2/4] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Thu,  3 Sep 2020 17:35:10 +0530
Message-Id: <1599134712-30923-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
References: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to handle SGIs as regular NMIs. As SGIs or IPIs defaults to a
special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
handler update in case of SGIs.

Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
as IRQs/NMIs happen as part of this routine.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 7170645..dfd8e03 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -476,6 +476,11 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 	if (WARN_ON(gic_irq(d) >= 8192))
 		return -EINVAL;
 
+	if (get_intid_range(d) == SGI_RANGE) {
+		gic_irq_set_prio(d, GICD_INT_NMI_PRI);
+		return 0;
+	}
+
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
 		u32 idx = gic_get_ppi_index(d);
@@ -513,6 +518,11 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	if (WARN_ON(gic_irq(d) >= 8192))
 		return;
 
+	if (get_intid_range(d) == SGI_RANGE) {
+		gic_irq_set_prio(d, GICD_INT_DEF_PRI);
+		return;
+	}
+
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
 		u32 idx = gic_get_ppi_index(d);
@@ -1666,6 +1676,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -1677,8 +1688,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
2.7.4

