Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D694DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29DD206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwdP3nRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEOH5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbgEOH5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:57:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10587C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:57:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so587048pfw.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=elQ0qcrtLj23yRuHcP4iQkFYaetay/9RqnWGnNoLGo8=;
        b=WwdP3nRL+VfvcUuP38UNzmDQu7IFRdu3HRlZjjNcZ9XeAC41Z24rK7S+xCMY6M/zp/
         P+bPXlMNQgGDGUTokMXEezvVrV3DVJ7nzCWrSbiocbQ5ZQzZz3MUZPcbaNoTLsaPcm3Y
         oZB+BPrUrc17AX80piWyR0PvhAjZo9ZHt2nBju5MtGRYPp35o/RxhA4z+Sxtb3p7GHC7
         RVlDn2SYgjRAkCEcc/c5AAvIKvUZOinqSoIc0WZ7KyE4YitwSqYMBboSr+HvP4qS2Qps
         5maBaW4el1fmqZWpnmc800sNx/jwkmpZQzRATwQo4IfufYj7I6IxJBHFZLfFbTJ4vVHE
         o6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=elQ0qcrtLj23yRuHcP4iQkFYaetay/9RqnWGnNoLGo8=;
        b=R0DbNIiEuNXfM2rNV0JbPKqPyHevDtYS5tylTKOGp2U3uxWW7G1oY8jcYc5KKFvHxW
         ta3iRSUyx0Fm0RRdtRQcDgBB8goelZJR8qxJplLNP9Xb+6fexkgh/MI0e+LalCqjiNHh
         J8bRGGQ70yupYM2oon2SFfWaMPQZ0LeHzbgYHj5x8c3zl2L/mcTZ/4kfYxZ8wricTT5F
         ZQnDyjRdobrR0sz4AQJRZs4aBzqxog+Yy0yMBXkhMtBYslJxHsOYTuglGDMlMqmmzUtn
         iGf+QaVf74Re6T0oqFG+VVo1eyKawUI+aNCR1r1rL2NdiKmny0sZm/158CyWv5ZNzix2
         Evhw==
X-Gm-Message-State: AOAM532Joq/rJBMHxk/UlgD4VqkR/qa6wHXjNgj04LWBuzmZpDdT5pJC
        SmuWTanVwukeq8VUaAUb+trqWw==
X-Google-Smtp-Source: ABdhPJyWr3A49hhwL3JHGHq0FLYsrWLPnDwiWdm26NyePL1P1skJcLSLHyvPUFgMboqamu2ra0psPw==
X-Received: by 2002:a63:6447:: with SMTP id y68mr1874140pgb.395.1589529452585;
        Fri, 15 May 2020 00:57:32 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id x12sm1213258pfq.209.2020.05.15.00.57.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 00:57:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     k.konieczny@samsung.com, peron.clem@gmail.com,
        m.szyprowski@samsung.com, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] opp: Reorder the code for !target_freq case
Date:   Fri, 15 May 2020 13:27:20 +0530
Message-Id: <e5875b12062c42ba09f9b67feb5f2681ae025f63.1589528491.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1589528491.git.viresh.kumar@linaro.org>
References: <cover.1589528491.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the code a bit to make it more readable. Add additional comment
as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e4f01e7771a2..dda8164fad56 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -817,15 +817,20 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
-		if (opp_table->required_opp_tables) {
-			ret = _set_required_opps(dev, opp_table, NULL);
-		} else if (!_get_opp_count(opp_table)) {
+		/*
+		 * Some drivers need to support cases where some platforms may
+		 * have OPP table for the device, while others don't and
+		 * opp_set_rate() just needs to behave like clk_set_rate().
+		 */
+		if (!_get_opp_count(opp_table))
 			return 0;
-		} else {
+
+		if (!opp_table->required_opp_tables) {
 			dev_err(dev, "target frequency can't be 0\n");
 			ret = -EINVAL;
 		}
 
+		ret = _set_required_opps(dev, opp_table, NULL);
 		goto put_opp_table;
 	}
 
-- 
2.25.0.rc1.19.g042ed3e048af

