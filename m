Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B79FC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6D120728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCcC7xwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgDXQrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgDXQrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80746C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:47:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r14so5058230pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HFY5EWQxJQBE/a8g9zWXLsX7Zf8fLYpIOthjFiz7W8w=;
        b=TCcC7xwDHAu9bmMF/+GZJa9vYkDZgMmKcLfjPMMC7WxFy96i5XJInX1GDHyX5hGgdn
         k0DHASh+feTCGxn6dHfnxFh+vuxggc5OZU1RyzKGe7xq/76OwHGkQczLW1lVwVC3cIfQ
         4oRy227wWf7qGKFO47+zGDd0ULkr361+0sQ9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFY5EWQxJQBE/a8g9zWXLsX7Zf8fLYpIOthjFiz7W8w=;
        b=tw7hTaCvhf0IAO25SEFpvEtfOoAKJoqVlmzLGCrTz1bBigfSOXx9v5mOp+TAJI8hCF
         zhuBUaQt5Jjfb+/7nCMsbsrmJsD+pLuh2W4l81Ee+DUjUmPAYdbBVgkc0EHwDnFmFfb7
         K1qKoVaK68aG83Avip+fFo/Mz9DhrHZBsruClEsEguAZoie/ZiHB/8LBwxa8UCMWEpb4
         CvZlScZT8WM/ilA5E8X/TgSgFSEo/C8YRjjcmfX7RXs0xvqkoucqhNgGf62VwKY2Ax1H
         LkMzbHPuD2vEHPCbSRr95+MNYD1sQhctjle1HbuNvWTh03tWnO3v4vZB+0Y/H/neOBft
         a7oA==
X-Gm-Message-State: AGi0PubBlBYOGrtaCK5F3wf6ZWL0bGbVMObMy9WpKNzFAOw2G+H5W0HD
        92T62ik3XZvLimVXN3iR1SJLTQ==
X-Google-Smtp-Source: APiQypIU9WC6dqpnAcgs7R17BJDS/b7tHDKVfdKkVuZq6Y7Pm+lUdGcpnWbBzhUHBvqJ4l0wSWprDA==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr9550995pgd.277.1587746842085;
        Fri, 24 Apr 2020 09:47:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r28sm6319205pfg.186.2020.04.24.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:47:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     evgreen@chromium.org, mka@chromium.org, mkshah@codeaurora.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] kernel/cpu_pm: Fix uninitted local in cpu_pm
Date:   Fri, 24 Apr 2020 09:46:55 -0700
Message-Id: <20200424094610.v5.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200424094610.v5.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
References: <20200424094610.v5.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
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
2.26.2.303.gf8c07b1a785-goog

