Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D6EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836D820829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdAwNIlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgETLNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgETLNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:13:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B99C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:13:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y18so1381266pfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZG9/oyco7B79XCj6TKIn88+qkDpSNwk8w2d1UWYERo0=;
        b=pdAwNIlvROhiKpL/uEs/CC2blZgu9oXn0Cip5pIyL+nIKtHyciusiYEz1cZHlaoldy
         11bzJLJpdW3zY2XILih4rOtUwCCavUZFMs8eYp8a69jMGrEyovcPGuyMlNMwqRw/J0Nd
         sVGmw/B6Cu9iE1/8flZoqNa5DmIadUAAyYBR2UqNtvdvb/mUlDMknuK2bxsAotyaHJw7
         afeMaBCy/zcIeP6yN4vijo3dtNwFpDuQkl/EyXebZaW6ZH+d28yZT6+wVwxPG5azbPAK
         cAw/AutnoRZ7i1RjlCBe4Pt4M9KMv3aA0uWSM8hY2ouSd+5X/aDy2zXH6Lf5tYsAPZ/U
         HjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZG9/oyco7B79XCj6TKIn88+qkDpSNwk8w2d1UWYERo0=;
        b=J4CR+9eoBdhQKxv3vLMXbb1usrL8lJjxo5oTtJeZwwV4/il1G0+YLnkK7tspNFvtFl
         65PSP+XfGMEcDKVd2wkMusdP9gEhz2kcLCSIcPoVGaZjN860auYgSiHYWh3+UwTrEvwy
         6htz45RXgmIoxA85D4rcBt4UHo1bi2lZxBijYty8y2/u3y/AV108gdQlYCxgzG8ABcL2
         yZzM8MXhfkKemZqBW0PzPYUsUHZxqtn7Jx0of94IlEkLx1kHKMkV7o2b9YlLtjZ1Dzaz
         fer8xkz0M8piwvA/1WuKWjHWkEcfz5bjSr1HBnJFmCjDU0yLUoiC3orNJXR4wTRmY8Dq
         i6/Q==
X-Gm-Message-State: AOAM531Ra5aSRKk9GrODeGSnrtjlVNjDgKqMo2Anuy7+qGWH+KzvohR4
        pRzIS77slkO7m0qZDSbkmFaCTw==
X-Google-Smtp-Source: ABdhPJyAXA8IR3qjB6XDW9mgUh5Gkt/Gfwj2utLLwP9UmxbL/P36lgEOjUZ0/LGMAYySKXzpGmJeRg==
X-Received: by 2002:a62:ee02:: with SMTP id e2mr3672825pfi.161.1589973187571;
        Wed, 20 May 2020 04:13:07 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id q134sm2044974pfc.143.2020.05.20.04.13.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 04:13:06 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 2/4] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Wed, 20 May 2020 16:41:53 +0530
Message-Id: <1589973115-14757-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589973115-14757-1-git-send-email-sumit.garg@linaro.org>
References: <1589973115-14757-1-git-send-email-sumit.garg@linaro.org>
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
index 82095b8..ceef63b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -477,6 +477,11 @@ static int gic_irq_nmi_setup(struct irq_data *d)
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
@@ -514,6 +519,11 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
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
@@ -1675,6 +1685,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -1686,8 +1697,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
2.7.4

