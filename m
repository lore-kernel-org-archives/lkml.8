Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63360C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3319A207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VssvdQa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgA1Wge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:36:34 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:42076 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgA1WgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:36:24 -0500
Received: by mail-qk1-f182.google.com with SMTP id q15so15140383qke.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TPZrEScBnZoX/nJN/69JHkLrofxkVsFmHVQXsfBS4cg=;
        b=VssvdQa71tR4DMEbLbIQHOj1SJ+bYSwvZ24kp3TjFeWbki584/abj/WmtyLHbiVCSq
         k3mztEw685Rsb5l4NnbDmwOWslGniBjQCQhAU77Yv/lcBmEOe//2XZDzu5ykfeUjOMgR
         KxZy4P4+nRxjznZox24wOtIAOmUyqh/mXpBVweLYFe0gBFdT2RBLecdB1lY25PGnyZ9I
         kcCNMXOhbVKfR8UPDZrpwFPRrbB4L9o/DlTBhQyUoejpd9Jp0PrCHzd+Yr5hueyzoDdN
         vejpgvsckAYGgX2791IalSmoi2vDjil3j12xvSAEJNxS1KCf+6eOeHmgMos/YpivzW7/
         OxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TPZrEScBnZoX/nJN/69JHkLrofxkVsFmHVQXsfBS4cg=;
        b=U9GDJDWCdgYLX/ZGxEneRqLKZMvrmBYokVgZ8oyzvJrfafh/1UzyykkYkJQZwoopGQ
         uEtBfl4f51thqzuSRXh5gILc1wjLHpWAhvgFe//3yW5Lg3K4JizdgPesE3+zhbQ9kpbU
         KORoPTnHivTyw/CLrIvUYk8sDXsnCFc6lVRCAqRhDTQsOMDsxnjaox3IaUU9QnzGZb9b
         9Hgu781nPWp6jPSXK9ZV9645UFtAdUIyVMdn3siOGAWCWo2ofepdTwyBdpIcISWt6v0r
         3spGRmpm9otvY2l2qSf6Auk1Al9aUQcKPLQMh8hkWDjtzUI1kwrgYeJ6WzV1amiUX8QG
         ioOw==
X-Gm-Message-State: APjAAAXuFDUW07dUkkQ1NKgpydHyNswJ8Rl9iMZIKprGtH4HsjwKZAqS
        E6QpHKjKIpDlLNfPa1siV4NyAQ==
X-Google-Smtp-Source: APXvYqyrFK6m0XukXygyxBZCuFZnkXa9X5cHtzWZkf5vqKdJk4gPWwYI6naFrJMWWiVC9vwntpfmgg==
X-Received: by 2002:a05:620a:16ad:: with SMTP id s13mr24807512qkj.388.1580250983641;
        Tue, 28 Jan 2020 14:36:23 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 124sm13014259qko.11.2020.01.28.14.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 14:36:23 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v9 8/8] arm64: Enable averaging of thermal pressure for arm64 based SoCs
Date:   Tue, 28 Jan 2020 17:36:07 -0500
Message-Id: <1580250967-4386-9-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_HAVE_SCHED_THERMAL_PRESSURE in arm64 defconfig.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0565a61..7a8145b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -5,6 +5,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_IRQ_TIME_ACCOUNTING=y
+CONFIG_HAVE_SCHED_THERMAL_PRESSURE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASK_XACCT=y
-- 
2.1.4

