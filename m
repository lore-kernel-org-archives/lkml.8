Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E6DC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18FE208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GG/IWn/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBVAwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:52:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45717 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBVAwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id a2so3596161qko.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3NipQ4L+3teHeOCgu/TzhU1JtcGO/hYc9QwCY4H/Bs=;
        b=GG/IWn/Gu3D/7sJXlUXMqcDa24+HqrlVR+Yc34FPXBnl1U2Omzl8FBQKSRjQWJCAnP
         OnX0AMBdu/6AIt9HNJHEkxw0+QDFpTQkID7HVOsPbppweIwJJ1nPLI+pFa7XRH4JVOAP
         uGPbFxxN5aOJWYWFGlg9tQWDXywMccf1Nla45WpU+eVDUJ+s/Sq3svSlPTx09i76Tl7v
         wViiibeflfY/mW1o4d2mM1RvczsssrR2W1hsJ7BcwYRJLRXEKyyX3PdJOSgg627GaXdR
         XGSDYy2dEh0xL7eUGjNUStqJ4GQhC/FkwjDltEwCgLJNcG5ngj+EBpARvqIPPnEDNgVl
         /ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3NipQ4L+3teHeOCgu/TzhU1JtcGO/hYc9QwCY4H/Bs=;
        b=MGA2vqMagM2K9oSVr3WQLHw/A6YDfv1Tpe2u8hfNQ5ffYeNcPrHsCUXJQX4nPm1sie
         FYWUTA7izScPTTpVEomvYR+57Wu2h79tKbGp9sq9wN28u7VjUuw3FvWm3JyYBl/OaLVu
         +WI+Tsw9CkE6v0QlnA/dyOzPbtmaZQEpCRU16MdNp/A1t4HQrkhenMUPeY7LHk9J8MlY
         XfIHyG3RegD1ZQoQCj3jfy+uO/gZ4pQ+AxXhCHYZDfbcYg7G5deljDaToy5cH61x0MqI
         W/U9NEh5z5A0lhPVVv8s5mbBuLjtbSq/O8aSMh8iYVXoG4rMW/N6uNLfA1Y8RwAICS07
         vk3w==
X-Gm-Message-State: APjAAAVwZxU919PpU6TIP4LJPoSKY91GbznoKJTdyEEEEzO9PGqld0ip
        FtZzl6s9NTLyLKBGkkmds/ydFA==
X-Google-Smtp-Source: APXvYqyxuQ5OeZ4Ba8JjA/5GgIL5x2iNxHVRMK0zBxb8aBduh46SfYpHMBi00309XX0AHQbuJSPTvA==
X-Received: by 2002:a05:620a:b07:: with SMTP id t7mr37650731qkg.11.1582332738242;
        Fri, 21 Feb 2020 16:52:18 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 12sm359559qkj.136.2020.02.21.16.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:17 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v10 2/9] sched/topology: Add hook to read per cpu thermal pressure.
Date:   Fri, 21 Feb 2020 19:52:06 -0500
Message-Id: <20200222005213.3873-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222005213.3873-1-thara.gopinath@linaro.org>
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce arch_scale_thermal_pressure to retrieve per cpu thermal
pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v6->v7:
	- Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
	  as per review comments from Peter, Dietmar and Ionela.
v9->v10:
	- Renamed arch_cpu_thermal_pressure to arch_scale_thermal_pressure
	  as per review comments from Dietmar.

 include/linux/sched/topology.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index f341163fedc9..af9319e4cfb9 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -225,6 +225,14 @@ unsigned long arch_scale_cpu_capacity(int cpu)
 }
 #endif
 
+#ifndef arch_scale_thermal_pressure
+static __always_inline
+unsigned long arch_scale_thermal_pressure(int cpu)
+{
+	return 0;
+}
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
-- 
2.20.1

