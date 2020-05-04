Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2BBC47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A1E206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GxbjPhAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgEDRut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730491AbgEDRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:50:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C796EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:50:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so228423pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/AK+JAkG8AocWziltXofgXSpvQiWbZdp+MJy5gRIXI=;
        b=GxbjPhAxClfMPq6Ig4vZD/GnEFTCE58onBjQ9vrB+PfUJzmpiGKhngrrFSZ3UAkjB6
         r2vJHK1oVzSqlOwDc3R9pNbKlSfr6Y20Cc9aNrflCZRcCSysM/xSt+A8JUHE1U466l5L
         2Dpvbe9DTYsg1csGIgDnZc2fEDt5kVFZ2myRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/AK+JAkG8AocWziltXofgXSpvQiWbZdp+MJy5gRIXI=;
        b=Mw8dj1vkfoh827Lno173HhOho0XUhINPpLJhlfi+lvtk12fE2HX+8OL6ukGzXdxmS4
         vmH+wegVo8W1LAiOE2nhBSROvQFL1sf5R1DANkk1FkBWR9e6nczeN2kp5ScRPNmdwv1Q
         Q50sDN80gxlpmuOIQoUvgbh6rjkDqsX0+05XnbofMQhrjOTvEYe9sokDEuNYO5apf6FA
         k6vjXJSTK5tUbRVfC3+3b9vFNJ6iWjA7eJwQnSSCMwqLZxOtOLkXTz0HxnegK4QIQsWb
         BRp3b4KHG9wBD+CQZ1WQz/L/oNJMMhpdFXH74pW58x+PrGVIEuU5wlDASQMxBoVdJs9G
         WmwQ==
X-Gm-Message-State: AGi0PuaTzuh28nxiMD7Ad+50WyoCgYiHJRS8JpvQsTM1jwTVjd39OX8K
        nhUxYxysWF8W8YG3bV2P5e1wOw==
X-Google-Smtp-Source: APiQypIWcFYx1ZC2mKbogBoKHibhu5EPSONeP3jQWgvXL/NxWLEF4zBLuyqZbo1QO+00/YPD3092YQ==
X-Received: by 2002:a17:902:bd02:: with SMTP id p2mr375570pls.72.1588614643361;
        Mon, 04 May 2020 10:50:43 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id t3sm9402062pfq.110.2020.05.04.10.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:50:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     evgreen@chromium.org, swboyd@chromium.org, mka@chromium.org,
        mkshah@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/5] kernel/cpu_pm: Fix uninitted local in cpu_pm
Date:   Mon,  4 May 2020 10:50:17 -0700
Message-Id: <20200504104917.v6.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
References: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
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
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
This seems to be an ownerless file.  I'm hoping this patch can just go
through the Qualcomm tree.  It would be nice if we could get an Ack
from Rafael or Greg KH though.

Changes in v6: None
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
2.26.2.526.g744177e7f7-goog

