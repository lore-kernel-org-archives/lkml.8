Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE6C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B874F206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqX/K3bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBVAwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:52:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35590 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBVAwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id l13so927981qkk.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fmYqUo9ZnmA2UTXyVRTEs66bilKAJzOSAbx27Z0Zc0=;
        b=RqX/K3bj40cRddLtL5dyYFr5stEdFUKGsM2slU8kuwMp4HrcI8h+Hv16ffEMovEDAA
         RLbGBIC8j0ShtmkFJD7xQqnx+0pUItWAamx3UmuePX7F902zuHe+8DInp1Sj+UvQAoed
         5wPnez6eIgzdhrs0HS7gmWLS4FW2LymFDU6ig+pMYPmwgOjmRUwkLQ3xFq/1Y0hkDaUs
         bAZt5OwyOFsl/EpPWhtbZmuBJCVjk+p7B4dJvzV21MZ9To6pydv/Km17hKmslnRegbae
         AlXICRou8usMeF/LfWtjj6K4SPL8mJXaGtX3UcQ5iw9AC5KikBc9QRG+YL/4rvKE5hwf
         I5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fmYqUo9ZnmA2UTXyVRTEs66bilKAJzOSAbx27Z0Zc0=;
        b=PfN6Qp2ZwBQDzvsL9AFNTV7DadMsjRGG01qLKGyZ9ZaE08zYh6MjXerSTg8o0TeJmq
         jQ5obJlNIWHx3heAC1AqxKBK5lZZIiAiLfP5LEVOpSfHs4/VSBRnbZBXOW7HPmf6tlt4
         E73D4qh604pOG5kBTKNw27H/q9Hm+SwKlN4vonGvJPo/A2esbyScay1JAJC07xUgbwrN
         2re3wZDCO2lzjGPbSR08//psYdL0NF15pUgOedPlOX083N4FZJMNqEogvVsJdM+VQveL
         SS5AQoJ7iNrIqxkhX3vqP1Oe+PSbhmXtdu0EqDfTDU+bIlIoAlUynpbeX/lAhHJgAwCu
         s4bg==
X-Gm-Message-State: APjAAAVzUko3ns+nOtj+G0YfTo0pjXlvyXhopcB4+VZ0KIXLKaBdVH6C
        3akPqJJDyRoOYFb54zFfG4yHDg==
X-Google-Smtp-Source: APXvYqyvYzPAi0tPR1dXwzia0klEqYPp5rdsUjzo1+r5evQkFkVWx2iuNvOP6hExHeS6k4Uh+9PxQw==
X-Received: by 2002:a37:a9d2:: with SMTP id s201mr36313729qke.171.1582332741077;
        Fri, 21 Feb 2020 16:52:21 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 12sm359559qkj.136.2020.02.21.16.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:20 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v10 4/9] arm64/topology: Populate arch_scale_thermal_pressure for arm64 platforms
Date:   Fri, 21 Feb 2020 19:52:08 -0500
Message-Id: <20200222005213.3873-5-thara.gopinath@linaro.org>
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
 arch/arm64/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index a4d945db95a2..cbd70d78ef15 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -25,6 +25,9 @@ int pcibus_to_node(struct pci_bus *bus);
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
+/* Replace task scheduler's default thermal pressure retrieve API */
+#define arch_scale_thermal_pressure topology_get_thermal_pressure
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
-- 
2.20.1

