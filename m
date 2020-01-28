Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C1FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF2C207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IClkZ/hL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgA1Wgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:36:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39206 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1WgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:36:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id c5so2144527qtj.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u9mCgdnpZfGRVNnvDxmPL1ZG+dTFUtvF99vlLoJ4Ggg=;
        b=IClkZ/hLgC7SwCLqpIoPYAz9jFaEt/IIv+1LuiDVhB0FGq5ZuoEcygORFfustFkDIO
         pBZRpvB2TChsx2uh8L1vspFgUj3CRfXqzZJUKHEfSZMXPwJynuXBwUabZVOzevuH3oI6
         I/je+Ysq4mSQq1nGJjh0HgDyJUGXxDRuN/GEiPLSDSFXb4pNB3sTjPN71ylXKvyP1pGq
         XJJWNHAJLgf2SJP8rJcWzYfQn16/xpy0ueVLVDUhqTCNAlPwdqFylQRNNCvITMJu3kmT
         hQtJLwQcmnJ1x6XPyL6GAldPmRee8fh90IUUxv/bZacKmiMaJtyMi/whygezkTol5jY1
         qMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u9mCgdnpZfGRVNnvDxmPL1ZG+dTFUtvF99vlLoJ4Ggg=;
        b=Lml6Gqv2ksgtGPp0q5K4SW7Q2QWrNfsvDfDtNVMM+IbYgYZP16wsb6lhC0VTBkI+4W
         JrfmYDZdIlDXORnWxvH/i6N3pKBmM8olGKjJaSOHZRElH5yrxvo0lzQUM8HZG4wLiGMi
         w0+n6idGM38sxsxOTvJFjMqsNAUGiTDeH+mNshfcWTbCOCWewgHXjYA+BsPBz686cyh2
         l+rV3f1pIsNjw0rDJEscTUQuDMgfq7SlO7E9mAAWZsr9iPmLYogbxpEbbMaTLiJXGlvt
         rMU9VSbXnrkEcD3E/+R3C2bZT4z7jtJD4LZhDxQH9eZq2jG6umLhMVqPWMuC9MXcJU1p
         lRoQ==
X-Gm-Message-State: APjAAAWu3wSq2c8q62koJYTO9xmqYwrKM+wPOgMlssoDnwH+6ax9Vs5C
        3/tVIbwRBdh1VxUDRT0VM5kwcg==
X-Google-Smtp-Source: APXvYqzzOBYCGms055i6xvvLLh0hL4srZ1uYunhTpABKsq1QqkMCl+g5h4pYPCE8746imZREScSDXw==
X-Received: by 2002:ac8:74cb:: with SMTP id j11mr10080790qtr.304.1580250974910;
        Tue, 28 Jan 2020 14:36:14 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 124sm13014259qko.11.2020.01.28.14.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 14:36:14 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v9 3/8] arm,arm64,drivers:Add infrastructure to store and update instantaneous thermal pressure
Date:   Tue, 28 Jan 2020 17:36:02 -0500
Message-Id: <1580250967-4386-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific APIs to update and track thermal pressure on a
per cpu basis. A per cpu variable thermal_pressure is introduced to keep
track of instantaneous per cpu thermal pressure. Thermal pressure is the
delta between maximum capacity and capped capacity due to a thermal event.

topology_get_thermal_pressure can be hooked into the scheduler specified
arch_cpu_thermal_capacity to retrieve instantaneous thermal pressure of a
cpu.

arch_set_thermal_pressure can be used to update the thermal pressure.

Considering topology_get_thermal_pressure reads thermal_pressure and
arch_set_thermal_pressure writes into thermal_pressure, one can argue for
some sort of locking mechanism to avoid a stale value.  But considering
topology_get_thermal_pressure can be called from a system critical path
like scheduler tick function, a locking mechanism is not ideal. This means
that it is possible the thermal_pressure value used to calculate average
thermal pressure for a cpu can be stale for upto 1 tick period.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v6->v7:
	- Changed the input argument in arch_set_thermal_pressure from
	  capped capacity to delta capacity(thermal pressure) as per
	  Ionela's review comments.

 arch/arm/include/asm/topology.h   |  3 +++
 arch/arm64/include/asm/topology.h |  3 +++
 drivers/base/arch_topology.c      | 11 +++++++++++
 include/linux/arch_topology.h     | 10 ++++++++++
 4 files changed, 27 insertions(+)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 8a0fae9..3a50a19 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -16,6 +16,9 @@
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
+/* Replace task scheduler's default thermal pressure retrieve API */
+#define arch_cpu_thermal_pressure topology_get_thermal_pressure
+
 #else
 
 static inline void init_cpu_topology(void) { }
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index a4d945d..a70896f 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -25,6 +25,9 @@ int pcibus_to_node(struct pci_bus *bus);
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
+/* Replace task scheduler's default thermal pressure retrieve API */
+#define arch_cpu_thermal_pressure topology_get_thermal_pressure
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 6119e11..68dfa49 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -42,6 +42,17 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+DEFINE_PER_CPU(unsigned long, thermal_pressure);
+
+void arch_set_thermal_pressure(struct cpumask *cpus,
+			       unsigned long th_pressure)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpus)
+		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
+}
+
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 3015ecb..88a115e 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -33,6 +33,16 @@ unsigned long topology_get_freq_scale(int cpu)
 	return per_cpu(freq_scale, cpu);
 }
 
+DECLARE_PER_CPU(unsigned long, thermal_pressure);
+
+static inline unsigned long topology_get_thermal_pressure(int cpu)
+{
+	return per_cpu(thermal_pressure, cpu);
+}
+
+void arch_set_thermal_pressure(struct cpumask *cpus,
+			       unsigned long th_pressure);
+
 struct cpu_topology {
 	int thread_id;
 	int core_id;
-- 
2.1.4

