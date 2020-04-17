Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C5B20780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LDmaaFc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgDQAc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725858AbgDQAcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:32:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A262C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:32:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so290703plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjEXDjSMTeg2qVqhFWHQox519X/O5z/MdvyGKQSYndw=;
        b=LDmaaFc7SjAfeaLjtN3Xfse/r3ppwmmVEI46gLQez/PP+e7i5BXX4wTRkxDnG1No27
         oLp4tdQEIQRBa1kCjs81iBdDLPm54g6Z3Qy9eUNM7xhZV7bZOAdmIWzQCU1wP859XiDn
         pX6GKjh3egk0qRy1bwh+GR2CY9gZAHJCl4Dhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjEXDjSMTeg2qVqhFWHQox519X/O5z/MdvyGKQSYndw=;
        b=KVlVz9PCwVaerk+0q07WzFxQafK78Cp3ikj+yDgv1obKalURjiYQoa9ubYpdoy1ALn
         k2GgGw/PS9lKBDPv1xXuR8sxw1eHo+2HRto4Ap09QQXVUTKrIAoCXMD4BWB/5cwcB+gA
         mBRzhnEc4rVvjwCRO7YKZF1CcGYr8/4WF6dircc3DAEjjAZXE6CKbu7tNS01HnVRdx/O
         LjVWesrLl+kGsSV3oRjh8N3gZziCrbQ8gCgy6XRC/5gyuBx1er7HHns3O/7YNi+K2o8A
         Ag8VMImfVDLdOGRexSMS4h8ZPtwHZsUjSIANjUGUAtkEhnLth5dJDvWGSpccepP9FCc/
         +pxw==
X-Gm-Message-State: AGi0PubF4cdr1d/DycfoK/jeGre+tgmwYHRf9DPRr3D+thESv+/35qfG
        K2mHZUTcJYWrjjv/gNkpqL54qg==
X-Google-Smtp-Source: APiQypIUfoKuVMKzZkLigx0C2OWMM4kG7ADkQPRcepu9jeOBo+1Fqe4/7Op8k+zsY5m41MhOXZpzRw==
X-Received: by 2002:a17:90a:6548:: with SMTP id f8mr1146021pjs.114.1587083544658;
        Thu, 16 Apr 2020 17:32:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm18090658pfv.118.2020.04.16.17.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 17:32:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mkshah@codeaurora.org, evgreen@chromium.org, swboyd@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] kernel/cpu_pm: Fix uninitted local in cpu_pm
Date:   Thu, 16 Apr 2020 17:31:59 -0700
Message-Id: <20200416173145.v2.1.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
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

