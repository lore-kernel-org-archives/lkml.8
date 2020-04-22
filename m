Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D15C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB5521D79
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hO4Hi8MG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDVVzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:55:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F0DC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:55:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so1837379pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wu6rd3tUIo0urKDW7FHRI8bts8pWDDPJv5e+oxOpE44=;
        b=hO4Hi8MGx9eLnl+pLA+BDPLAvfzlGhY/Bu6gAF5WLjwgBz00y3N9U38zlTj3+2QwHE
         tjxX8SN4v4Ek3NMKRDzZaLFNuU+1IOyY1KHjB/CYE29Wr/T0bUHYimUSh5f7edIvBW0Y
         q6YH6R31YPFwckzXnm2qfN4n5f9XrdX6lCcHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wu6rd3tUIo0urKDW7FHRI8bts8pWDDPJv5e+oxOpE44=;
        b=OCZDcACDcJSl6F+pDOPCKVJOg9Y7qC4Mmlp6zyAYtHZZo7kHgHU7rmssoUUWL85OpG
         5ZBuuc79Nr0I1PA+z4m4ptvkvdmavoDnuTZuRwhU80RCBAxPpp2ZUcosaO+T9i/eJFHT
         3GHTDtLrT2/mhGcDdmL+XvlGMT2bvabKaBIZl1QsQvPuynVaU7pi4H3geYC9hEFIpteo
         7fQ1WIr2XkGacc29vR2gcPS1l9FZnriyECudNEUKaOeHkn4HSQqStk4UPY1+cxQdR9e+
         CaCsjKCCL+4m46KqrDjIgVyMNjgV6ceDkN7+eGU6X5/zG8h3Jvw4WdHYzER+lwkYIYX3
         cMGQ==
X-Gm-Message-State: AGi0PuYzzt0JEPPzxuLssag8AZe892BcrR4wDJ9lcDuJ9+Unxwsy0dOn
        Bus6d+ul6dUCcj0IaoR8pglahQ==
X-Google-Smtp-Source: APiQypJRhu2jQCK+Eoy+4WRMxy1UQE1ZOHAlvv3VuS8vKGsD9p22H+atqdaP5vZwYh9bpGJphSsRNw==
X-Received: by 2002:a62:e113:: with SMTP id q19mr584566pfh.107.1587592526907;
        Wed, 22 Apr 2020 14:55:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r4sm211072pgi.6.2020.04.22.14.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 14:55:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, swboyd@chromium.org, mkshah@codeaurora.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] kernel/cpu_pm: Fix uninitted local in cpu_pm
Date:   Wed, 22 Apr 2020 14:55:01 -0700
Message-Id: <20200422145408.v4.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
References: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_pm_notify() is basically a wrapper of notifier_call_chain().
notifier_call_chain() doesn't initialize *nr_calls to 0 before it
starts incrementing it--presumably it's up to the callers to do this.

Unfortunately the callers of cpu_pm_notify() don't init *nr_calls.
This potentially means you could get too many or two few calls to
CPU_PM_ENTER_FAILED or CPU_CLUSTER_PM_ENTER_FAILED depending on the
luck of the stack.

Let's fix this.

Fixes: ab10023e0088 ("cpu_pm: Add cpu power management notifiers")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
- ("Fix uninitted local in cpu_pm") new for v2.

 kernel/cpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index cbca6879ab7d..44a259338e33 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -80,7 +80,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
  */
 int cpu_pm_enter(void)
 {
-	int nr_calls;
+	int nr_calls = 0;
 	int ret = 0;
 
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
@@ -131,7 +131,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_exit);
  */
 int cpu_cluster_pm_enter(void)
 {
-	int nr_calls;
+	int nr_calls = 0;
 	int ret = 0;
 
 	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
-- 
2.26.1.301.g55bc3eb7cb9-goog

