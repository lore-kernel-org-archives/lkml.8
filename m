Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276CBC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20A7206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yExeNO0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgBVAws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:52:48 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:35954 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgBVAwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:24 -0500
Received: by mail-qk1-f173.google.com with SMTP id f3so679108qkh.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXF66T0+Pbnrsx76EBXYwbN00fGKYSGHdWCqkNe6hnA=;
        b=yExeNO0ju10sVD8qMMAOU2xcEqvqVXac77F6HmYAnIUOYJ5cC0gfrlX5xkoJFYsxZt
         8GQXC0xZHdxlVP6MWOKfv6bNBw/L6Spoy5GGLiO6t1SHG2Wx+cq0enWB/evJVzCof0WN
         qFSpU0GyuNXgxCjJnC2Ye4dysK/fNHkh66t0sX18Z9GNcthkVTlfAvTcUNUoGVW04aPP
         FOVvrCnBbpQg5R5XARcMnsson88/oy2aQHIKKwI0uhi11P7hvShUGYfmRm1HAkUId8YG
         NlVCwz2AFLZoSdOPEZxxoq7M/z2Q15anLFI/WCDmrpYzGyHqOp2oJKiszagN7Krsj3Ud
         OAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXF66T0+Pbnrsx76EBXYwbN00fGKYSGHdWCqkNe6hnA=;
        b=bTchEqCYQKn4tFYZOt0M8IdKPIXwxPx/nKe1X05G6stPhWNl9yT68PE3cgV1Y3x/2A
         r+WbWY/iidJ8hcD//Xgl05IrOj3CmipVC4roHv14+i25Z0pxCEy5l4uvWmRA9JqgifNb
         9lhVS1HDIPMcBmArnyz49829191tX6PMv4IitFelhDkotqoSrN0zL6M3+KlENE+2KVsN
         FJSGue0GELuAXS+D1t5NWLMSBO2CciHpVqVmRfSxKj5Gs0ZcHpCzR9sSwKDvbGPwGqyd
         PL+lSZnwtugUf9HsJHYIabiC+bLbyvaMvlGhXlNFDkVnJ36A+UBuDnN5zjwTTvqBGmXA
         dX0w==
X-Gm-Message-State: APjAAAWDXKKS1O1yBnD2mZ10t1n3CkaKnU9SEUreqIRIR4FxdFfTA59F
        byXj67gS2WbcHsXfZcRfPY7FSw==
X-Google-Smtp-Source: APXvYqxEHn2w5pQG3+6Oer2jJk3Bum2Rj88gX41Dow6eHy+sOsLM/5dW/xHpIoJeRCEPHKpt64DOkg==
X-Received: by 2002:a37:a38e:: with SMTP id m136mr35203222qke.116.1582332742515;
        Fri, 21 Feb 2020 16:52:22 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 12sm359559qkj.136.2020.02.21.16.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:21 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v10 5/9] arm/topology: Populate arch_scale_thermal_pressure for arm platforms
Date:   Fri, 21 Feb 2020 19:52:09 -0500
Message-Id: <20200222005213.3873-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222005213.3873-1-thara.gopinath@linaro.org>
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up topology_get_thermal_pressure to arch_scale_thermal_pressure thus
enabling scheduler to retrieve instantaneous thermal pressure of a cpu.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 8a0fae94d45e..3a50a19c7c28 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -16,6 +16,9 @@
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
+/* Replace task scheduler's default thermal pressure retrieve API */
+#define arch_scale_thermal_pressure topology_get_thermal_pressure
+
 #else
 
 static inline void init_cpu_topology(void) { }
-- 
2.20.1

