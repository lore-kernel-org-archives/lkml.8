Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75A3C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8AF206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOtN0dEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgAKP7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:59:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39609 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbgAKP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:59:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so4779980qko.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+1Z6MDx4XobCI0ghEoan/t4117hnB8BnW9bXN5G/GnQ=;
        b=FOtN0dEGjOs9wNAC7UerI6b4cYYz0/Dvg7OM/osA1UqrZBG84q5GCQfpz1tONECbcE
         S/EmEBhbo80T2ekYMXn65840I+ZnV9M0fm0xGM2JNSoueIC9PQr0O5JY9sq/9uwdhUiY
         CA/aMS3X6yMa5XQ6KdAEO8bvyQOJ8O85IVZ2lq4mkclMOQxMVSJmnKlIp2VAYGAMHerE
         AFRJF9Z+EAvLJuYj1QWenWvc0Sfg0KEsjfUvgxKDS62OTAA/r5JPw9IuXVZuYbmL6EXB
         kxhlbgK+3m56T/oMNbMKTscRwDh6l5wjSbGusWzeUFJ0r6xWJyz22sZ5k1ZeHytPq7zY
         8UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+1Z6MDx4XobCI0ghEoan/t4117hnB8BnW9bXN5G/GnQ=;
        b=qQMflHmU59SGWCgxPYOsaw5G2+cXC0WDbQIs6HA0QfOvvoZg/4JRVtqPxKdUJlNetk
         yVJz0qOPvKImiiB6nUH4clbORIujRk5CB2SopAIn3VIaiCjpae51GCJN2oDEEDFvlaG0
         CDQTSkc7ZQ/CfViV+OGS143Ks0R3QBlohr8D+q2oVVjhUCtWU6N8kDTsrbliBC+nE2/g
         rqd126WadeQ/FCYDepOJlvfNuQkR5OQBTrQ1BsN/hFCwBn8jZcYOkjSU2+UmuVc04Vo5
         Ouf4KwJoBOTF6Hnh7j4nsVXFadEi31LTlI6MHj+UUIur2KXLKfJia/K4GGluAVM9r7jI
         t5Pg==
X-Gm-Message-State: APjAAAUTkYlpWOD/oA+YJs0abbn+z4lytzNgp38TdlKcKjT2Ye89qLT9
        mMhmY8yvm4Zd59y1E4bMYg1gXg==
X-Google-Smtp-Source: APXvYqxUsSO1W6dyQvGvGLEGzSzSPsk4jrXSNf4uT5v3C0OijYyferGcU6O6pPi9QMU2W8W69gbeVg==
X-Received: by 2002:a05:620a:997:: with SMTP id x23mr4006508qkx.143.1578758353700;
        Sat, 11 Jan 2020 07:59:13 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id l49sm2843478qtk.7.2020.01.11.07.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Jan 2020 07:59:13 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v7 3/7] arm,arm64,drivers:Add infrastructure to store and update instantaneous thermal pressure
Date:   Sat, 11 Jan 2020 10:59:02 -0500
Message-Id: <1578758346-507-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
References: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
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

