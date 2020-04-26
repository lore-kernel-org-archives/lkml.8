Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CCFC54FD0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4833D206CD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HLnbjquS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDZLHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbgDZLHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 07:07:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1906BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 04:07:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so5744257plk.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gIwHNQfsxht5gpgEgzCAHjsGxOYw3xhYl1Xs6VhjBg=;
        b=HLnbjquSwdq8Zce53mLav/jtVfvzN14OZHNuRVisauGAC6ptI2k0GHl6JT1NXPh0Kn
         RLq80zMB0jjYecdumep/9J+S+WUIDzojDCAcCb5HwHlgZcE/w9OtcQu+eJwAWjobuhQz
         ZTslBtePnTSz6vIr8CqDpSUFd0hl+0EomF+Ep7uxlJXzrQfzhe5egIh3YiCF0OY0+gLB
         hH1irCG0eqEIxRVdkXvIfWxaGoWWmM3FZ6KFeRy9yP2R9ACr69aavfVDqQgCBfm3v68x
         g/vjJUKaOig9Aryskj8AN6yhqGiE2yWc/a1cQO8ewp23vdIX0Yx5ZRNI5/6gc6OsF1W6
         lkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gIwHNQfsxht5gpgEgzCAHjsGxOYw3xhYl1Xs6VhjBg=;
        b=iTp+tUGLu8K3bZIi3zIF0IcSpHxuI0atWZ9ZxO77gT0mHiEPfpsBvuqL3RUxz69WiJ
         Y1GP2vaUl61XOgnz/y/iuEi5sW+ojxBT1DsY4NW/lDNfcTP9JJwdmMR5PDm5edEtt8rz
         FGs+UjSsblZsuEegBy61c44lEX1faDvAN4LIw9D3f553FXfwj+Jnf/wDp8xxUtNhoaGc
         iA9G79BZWw96Q7s7XVoWnoykbJXa3446JJv6w5c724P7pEQc1y1YhVNVF2FJ24WhzDgA
         XDxZ+IVOxJpoMlZw737eVUfjP7WswU9zK7yJuOiV3YuMR0HiBGo074Rx1MRLR/oCiSR9
         2b6w==
X-Gm-Message-State: AGi0PuZjx4QIoFLy6Td70K5HIL+/IDr53c03IrlC8FLQn9ne6KvYK+VL
        7BPpKz/jX0a0B0CE6gy+uY2cjw==
X-Google-Smtp-Source: APiQypLU2/3p37XU8avcrm/98FrcDbT+mjIivFbW6du/XkbUrmrGn2/M/rztjac2fQUXtvTY5oJMsg==
X-Received: by 2002:a17:902:ed13:: with SMTP id b19mr18817426pld.254.1587899265549;
        Sun, 26 Apr 2020 04:07:45 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id h31sm9123564pjb.33.2020.04.26.04.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 04:07:44 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        anup@brainfault.org
Cc:     david.abdurachmanov@sifive.com, Zong Li <zong.li@sifive.com>
Subject: [PATCH] irqchip/sifive-plic: allow many cores to handle IRQs
Date:   Sun, 26 Apr 2020 19:07:40 +0800
Message-Id: <20200426110740.123638-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, driver forces the IRQs to be handled by only one core. This
patch provides the way to enable others cores to handle IRQs if needed,
so users could decide how many cores they wanted on default by boot
argument.

Use 'irqaffinity' boot argument to determine affinity. If there is no
irqaffinity in dts or kernel configuration, use irq default affinity,
so all harts would try to claim IRQ.

For example, add irqaffinity=0 in chosen node to set irq affinity to
hart 0. It also supports more than one harts to handle irq, such as set
irqaffinity=0,3,4.

You can change IRQ affinity from user-space using procfs. For example,
you can make CPU0 and CPU2 serve IRQ together by the following command:

echo 4 > /proc/irq/<x>/smp_affinity

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/irqchip/irq-sifive-plic.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index d0a71febdadc..bc1440d54185 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -111,15 +111,12 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 static void plic_irq_unmask(struct irq_data *d)
 {
 	struct cpumask amask;
-	unsigned int cpu;
 	struct plic_priv *priv = irq_get_chip_data(d->irq);
 
 	cpumask_and(&amask, &priv->lmask, cpu_online_mask);
-	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
-					   &amask);
-	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
-		return;
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	cpumask_and(&amask, &amask, irq_data_get_affinity_mask(d));
+
+	plic_irq_toggle(&amask, d, 1);
 }
 
 static void plic_irq_mask(struct irq_data *d)
@@ -133,24 +130,20 @@ static void plic_irq_mask(struct irq_data *d)
 static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
-	unsigned int cpu;
 	struct cpumask amask;
 	struct plic_priv *priv = irq_get_chip_data(d->irq);
 
 	cpumask_and(&amask, &priv->lmask, mask_val);
 
 	if (force)
-		cpu = cpumask_first(&amask);
+		cpumask_copy(&amask, mask_val);
 	else
-		cpu = cpumask_any_and(&amask, cpu_online_mask);
-
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+		cpumask_and(&amask, &amask, cpu_online_mask);
 
 	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	plic_irq_toggle(&amask, d, 1);
 
-	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+	irq_data_update_effective_affinity(d, &amask);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
-- 
2.26.1

