Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90089C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569282087F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMRqKWE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgAKP7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:59:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35731 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbgAKP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:59:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so4810155qka.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 07:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ui1UWT3XjxwsXbc5J4SYo0+lZb6l6gnf1hsDYBb+xTU=;
        b=XMRqKWE4SRlQUdki8sy9J3gjBKKPNnHwiB4DR9xYub0B++7PhOZJK3AHyLXilJpTjB
         qwmr5Lw0dvQd0J3HOiC/nXAGoioz++rHNoPJvq6fXyH9DM+mzQmBCL4gLUAJMTe5D4oM
         +/DydSeQ2Z400DrOw9wEunFRI+dYiDmFWI14BU+7hISoHj3l0VM+jyvHmB9gK+Dl+U3W
         r+0PCUAYwVDMNazbECCDkdAx7jFbHs+pP+ylC0OliakmiMNq5Sjl853E8X7C5oD8RghE
         9Y0iWl6Wzycv7FzslKtFX4OTaOz/02RZh5eYwP/KlOtraLBfc7JI9gTnSafUmBSQC9Gh
         daAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ui1UWT3XjxwsXbc5J4SYo0+lZb6l6gnf1hsDYBb+xTU=;
        b=Qr4wblTi7fFQQahosO2Af7XS2IvuOG9tZpbzJTSstG/P6x6pBUhijagK0aeBpfjZlG
         Jrg+1mOTk+pdJa/HS9MgyNmyl8s4XactuDhA9/bQStxZ14wKhIiLn8JqOBTwfVmLyauo
         PS9Tqvhi912skcoS9TH9sXPRsqvL6Sjf02UpLkX5NBYTXqUsz5KMCKVFAY3XWQXp2ZJX
         v3UkNeoPh5gA8dD1oANWVt4U1n+eFr5eJ8G96HRQiKPKjKbCLSf9xsU2SduK+RFyvqKU
         DmFZ83US/BvWuQCgKeNCuuV33qXDXTwo4T3Fj47kqMxW5v3q0zBmnxLYxVWlWvo6vJP8
         L2vA==
X-Gm-Message-State: APjAAAWoGRp/8RsXjGJsLtotXVuvkgEGJbWKl/rePwAPua0V3nOLBMDq
        F9kV39fwpyDCI2MOQTktISO+kg==
X-Google-Smtp-Source: APXvYqy8qlPIFdirx6KwBmCsyOYKga57of2p2v9dWoiIhJC2xWTDkWe0OnXBoePwL5tZ7WhQCWCDSQ==
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr8569316qka.286.1578758352431;
        Sat, 11 Jan 2020 07:59:12 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id l49sm2843478qtk.7.2020.01.11.07.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Jan 2020 07:59:11 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v7 2/7] sched/topology: Add hook to read per cpu thermal pressure.
Date:   Sat, 11 Jan 2020 10:59:01 -0500
Message-Id: <1578758346-507-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
References: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce arch_cpu_thermal_pressure to retrieve per cpu thermal
pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v6->v7:
	- Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
	  as per review comments from Peter, Dietmar and Ionela.

 include/linux/sched/topology.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index f341163..850b3bf 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -225,6 +225,14 @@ unsigned long arch_scale_cpu_capacity(int cpu)
 }
 #endif
 
+#ifndef arch_cpu_thermal_pressure
+static __always_inline
+unsigned long arch_cpu_thermal_pressure(int cpu)
+{
+	return 0;
+}
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
-- 
2.1.4

