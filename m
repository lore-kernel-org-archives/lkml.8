Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74542C35670
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476AD206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6bc4h8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBVAwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:52:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43688 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBVAwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id p7so3601732qkh.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+ZxPJznoEPUfiqyrXwCulsBLwujoyfJz8x/7U9rRwY=;
        b=x6bc4h8r0e3oZSXqEk4DjlT2CgZ7ux7ct8qhv+YkhJGvBMcuAHiIfQYYDoXnBSSSb8
         s69b0sPE01EtdWsJed/dVdl7pGEm0svbl/2dCwHjIhj8MHj9/Ll4bU5x3pZtSOcQINbh
         2bsYQCQTk41oLYT1s5LQt8o8bqhuDUhonHD8+BPVaQOK2wUWIydMzyrDw2RUzmQW/s3D
         HaZs+FlBVxBSpyk8VXtbs4mjlowYTiFhfyJt41BSLAv5BrmgDCf4K42OJcdaXRrOuLA1
         gKXgBG35vDZkX3ZuJljyW+xQL6nyCXHukLLpbKOxdYIoIMjfRuHzNUv3nvowqG3Sv9KO
         PO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+ZxPJznoEPUfiqyrXwCulsBLwujoyfJz8x/7U9rRwY=;
        b=aQ8CEqwfWKknmATeUCsYxEFWhDUbmqJujOgipdNHEAv/UVMeAUppRG1HTliUzKafvI
         Q60Bi3W50j5xRU7N4yPxj6Bmgmdf1xLSHUEmyv0YV5yTcXR3wzN7Q7wsXPjm2z5n8UZ8
         H5Efxh6VQpltRA0CT2zQIbhrXUlBAW/9jB5+f7FosCLI2TWL0yIVE4FvPlEeUZx42T7s
         KujDFN9eg1Es4rwQdDNTjcJSVykaoUJuXXOVGF+W/tzdpgu36HUdZIwIMFmmyYlBgVpF
         DJQnCLD8iKZc1TwyospYvWPchvKbevDG3+uMzvFshteUZ4d4ve8vD6Fi4/dxYudghJdx
         iMpA==
X-Gm-Message-State: APjAAAWWfByZEbf+4qJZ+8BzZi49D1X9bYX0eq1+Qla3vDK+vxQaF/aQ
        pxJjCZJ7NO1iP+0x0hmOQruTeg==
X-Google-Smtp-Source: APXvYqxBNg9parclQhmAGBadMxHFvsdVANWEGHp4DjRm/RmsIsMDdfH8m4qnoYYQcL85UnzdNQq3mw==
X-Received: by 2002:a05:620a:12b4:: with SMTP id x20mr331347qki.308.1582332739680;
        Fri, 21 Feb 2020 16:52:19 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 12sm359559qkj.136.2020.02.21.16.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:19 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v10 3/9] drivers/base/arch_topology: Add infrastructure to store and update instantaneous thermal pressure
Date:   Fri, 21 Feb 2020 19:52:07 -0500
Message-Id: <20200222005213.3873-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222005213.3873-1-thara.gopinath@linaro.org>
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific APIs to update and track thermal pressure on a
per cpu basis. A per cpu variable thermal_pressure is introduced to keep
track of instantaneous per cpu thermal pressure. Thermal pressure is the
delta between maximum capacity and capped capacity due to a thermal event.

topology_get_thermal_pressure can be hooked into the scheduler specified
arch_scale_thermal_pressure to retrieve instantaneous thermal pressure of
a cpu.

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
v9->v10:
	- Split the patch into three thus separating out arch/arm
	  and arch/arm64 specific code into individual patches as
	  suggested by Amit Kucheria.

 drivers/base/arch_topology.c  | 11 +++++++++++
 include/linux/arch_topology.h | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 6119e11a9f95..68dfa49d3b63 100644
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
index 3015ecbb90b1..88a115e81f27 100644
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
2.20.1

