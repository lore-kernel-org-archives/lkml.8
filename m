Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F656C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6492420736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YacZq7PZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgDXLLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:11:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623E3C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f7so4639827pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VxQ4o9PvJLeDXlCdKC6FnBvF+Rh/OB42QR1xOvGVmug=;
        b=YacZq7PZlYzawRE/JiR4rFErkePmBp3ThfIGiML8t+nhfJ0kt+oFtkRos1HE7c/4zM
         9jNUz/wb7GU1eHxtS4Qg6wF38dlfF6j7kM7V4Zm7PXK8tJL6Am8vbaImoAlhnfqg4jmJ
         GIXimV9vmSiTSuISRhnd4c1lvIPs4lOfv7oJO4IaCm5Xa/6PrUz6X97dC54BXanvgqOa
         ZfaRNIK7Sht6YUCwwj9ezBpg5CS0Y51cepH8ZiCazq0sdoZ1uCyiL1fzgRGVwjnPwHKJ
         g7MEvkNL1pv1CHsK2gOWkQx4if0WwWMILQaviXmVHfBjNenrJOgSgFm2aQjtmNc/SkHJ
         Zdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VxQ4o9PvJLeDXlCdKC6FnBvF+Rh/OB42QR1xOvGVmug=;
        b=OYLlTu/0GzWutk4GHt/mfL5iT49tGEkXoi35WS2hXg5tLrq+7WSaeszrsO4vn+A6w9
         GnSK2vo73V53uiIror/aylYezmDAu/o0Fsi3EWHOMX7Cy2rIzY5Wa787A5HkrFmUfrnr
         Wl3Gn7xdSzUxYM1qornI27Ldn5Ma27PnsRGHz7szEC5M5ePN+zixHT/gI8y7O1IvCEso
         bf2+DBEhp29vdOeF7JQQCE7hHByhzed4lj7dNzgk8IEvbaoj6YEMWyhj96COklfPNcYU
         autOc/7OSSSughlEuvud2c5sk8nkGhoHfzVGGpmtMER6r4/RjQyKuXt18uQHA68Asrds
         Irag==
X-Gm-Message-State: AGi0PuZNwIyCCTT/+KEFNX0Af5/URrSAMfFS8bYWZY1PW+a432hfFrUB
        d50ycFJgzMNlDHCMAcpbSV1kqw==
X-Google-Smtp-Source: APiQypKsve8n7Z+70T9CcZrjuYG102mPugIIPPAH3Qu3Es+6cyhZhldMNasw9Iy9/gJxspU7QTFreA==
X-Received: by 2002:aa7:874f:: with SMTP id g15mr9462253pfo.45.1587726706941;
        Fri, 24 Apr 2020 04:11:46 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.186])
        by smtp.gmail.com with ESMTPSA id o11sm4637628pgd.58.2020.04.24.04.11.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 04:11:46 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC Patch v1 3/4] irqchip/gic-v3: Enable arch specific IPI as pseudo NMI
Date:   Fri, 24 Apr 2020 16:39:13 +0530
Message-Id: <1587726554-32018-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to mark arch specific IPI as pseudo NMI. Currently its used
to allows arm64 specific IPI_CALL_NMI_FUNC to be marked as pseudo NMI.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/kernel/smp.c      |  5 +++++
 drivers/irqchip/irq-gic-v3.c | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 42fe7bb..27c8ee1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -802,6 +802,11 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_CALL_NMI_FUNC, "NMI function call interrupts"),
 };
 
+int arch_get_ipinr_nmi(void)
+{
+	return IPI_CALL_NMI_FUNC;
+}
+
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
 	trace_ipi_raise(target, ipi_types[ipinr]);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index be361bf..a3d2cf3 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1048,6 +1048,11 @@ static int gic_dist_supports_lpis(void)
 		!gicv3_nolpi);
 }
 
+int __weak arch_get_ipinr_nmi(void)
+{
+	return -1;
+}
+
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
@@ -1072,6 +1077,15 @@ static void gic_cpu_init(void)
 
 	gic_cpu_config(rbase, gic_data.ppi_nr + 16, gic_redist_wait_for_rwp);
 
+	if (gic_supports_nmi()) {
+		int ipinr;
+
+		ipinr = arch_get_ipinr_nmi();
+		if (ipinr >= 0 && ipinr < 16)
+			writeb_relaxed(GICD_INT_NMI_PRI,
+				       rbase + GICD_IPRIORITYR + ipinr);
+	}
+
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
 }
-- 
2.7.4

