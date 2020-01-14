Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DE7C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EFC24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXkasibS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgANT5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:57:51 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43298 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANT5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:57:49 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so6268082qvo.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+1Z6MDx4XobCI0ghEoan/t4117hnB8BnW9bXN5G/GnQ=;
        b=YXkasibSmroyzZCfF+UQZQ1oFgWiaHhWUb6WN7rujtmpJWaKLiAbIdVhsdvlLSXLsK
         nPWWOGdmYzKRkAfLw2Da9jaIoYP4NiNtEkkLbqJEXCMugRMSDao/x2VVAs4XYIQOR1ND
         zexRAKJQxuaizSQJ7pxRW+yn+OCFkjiFghc+42NG9PZOloPnByekwRye6chnD6hZYsFK
         nOsvw+0dZgzcQh5iBcTj2alfeBe5gPXdBPEgc4mEonN6T9xyHKfRnplKbBvneo8t1sVY
         MwC4O5XUWG0A9dbgI1efTlBwt7XaPHjWyfhUc757LEeYp725Uew1CG/2jkbALkpkW6G1
         jypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+1Z6MDx4XobCI0ghEoan/t4117hnB8BnW9bXN5G/GnQ=;
        b=UguTUBHAS6tTtBYNWBVMqNSeDAj1z8kpyXCBBSuAm4CDlJqbgUicD+65FWSdhmYAY/
         ZTsTjIfRJnE8oGP+FBwTF1n5T5LRTrmtd5/g14ebavuSolYZgS6PsLCyhtyxkFkULvmu
         O8DYDtyycDkH5EZQBGAzZdC+qL5n9jK8XS3O7YcW+uIH+6ABjRSyjMmzUI7I2bgQGpyY
         46HJKG+9gXWH9efJFn6HbIS0pmYM5SrvPD1gNDgHhakQBdYT8e8c/CUZIaI/Qdb+WZG5
         z1w3wISmmnOv2+klooU519tBenmKIKfxsVe8DiUHLBUdT3AV/eOm6SV2dnk9w8vjzx3v
         CGnA==
X-Gm-Message-State: APjAAAWUVVlze6SN9G88lPZNvaYik+4pxbYc/4mDf596LILbskcOKGDY
        Leqf8VKS1esXq68qucNIlLfxHA==
X-Google-Smtp-Source: APXvYqzkGDo2ONlqlNSX8c36WfHfwws8lgE2PgOm4qOA0zkzVazWXBhTvZlxwgeuR6CJQzwYayL+vQ==
X-Received: by 2002:a0c:ed32:: with SMTP id u18mr22985554qvq.2.1579031868679;
        Tue, 14 Jan 2020 11:57:48 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id b81sm7183497qkc.135.2020.01.14.11.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 11:57:48 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v8 3/7] arm,arm64,drivers:Add infrastructure to store and update instantaneous thermal pressure
Date:   Tue, 14 Jan 2020 14:57:35 -0500
Message-Id: <1579031859-18692-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
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
index 1eb81f11..c2c5f1d 100644
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

