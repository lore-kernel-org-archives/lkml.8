Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0302073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpoiQoXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHaJ1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgHaJ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:27:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1BCC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:27:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mm21so323902pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU+ye3DFPZbAV6pQiN8wFPJa6aARNezf++/kyW/uVuI=;
        b=EpoiQoXcv7ag2BZboESNDV8ueXVg7gPRhJwh0HJmK0jjxVOplU9RU+KzVm9W9WqBC9
         JHHOX0WWO9bODH9Di16FMFHq8OzWErkqnpA9HXxWGtiN+LyEjiMmfESPZ+kv+Do6OqVX
         ifi6XiPNhiW9ZYjFRCo6WupZEH13dMoZ4x4+Y4VBrmhcq/1SAN4c6raMNNuV0n8rqLrR
         RPONK2LGjM13mM60e+GgF6Vl5vCeZJw5JbuMxChUkW5ixwPuVph9G2oEQpUYvLEuxAKh
         W7GxKOLwkKM/AuTgHjiG0ZocABjLNggfN5OauAJ0iUnqFcmhtB7mGUUisQm65OcULL5R
         qhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU+ye3DFPZbAV6pQiN8wFPJa6aARNezf++/kyW/uVuI=;
        b=CuTL+KqdIx9zljqmwZkXqZydBg8tyxoG+TGWv3LwQdzTJ3S2YWjYG9IrP1hGsTOAVD
         ruFwDRJZi+8hqprebnOiUQr4tlbXqsrT4arjfCtOrHwOXcdVK8az7hVxPc7EdVTWzMSC
         +G3lhr3UGvDKfsJ/gfnMXDjWwc19XLZYsBkudFVXALQkdowCEnYwzse4QX8mf+TSCo9f
         eI2H4Vn95QhAwR4LCODxpmINMtKI4LUfPVU8tcyNLjh8/iMcaaWjC4I8U1UYrht8g8aR
         pAWkreMGTeyJMWkibcM4cK9fe9/6wnoVMYYPaCfGEN6jgI7WzUn7bOFP+izc0jHM5kZE
         EPRA==
X-Gm-Message-State: AOAM5312k22v3DL0SK3aN8KS3jvwcUZ+uuYpFpJ5Ap1v5c07T3hbGjx0
        3ix78Q2udg1P67rJBNpxBZKsFA==
X-Google-Smtp-Source: ABdhPJwMKSI/DxgWWVduGT7bfBgazAzmC0cUQbGNmOrklC5B/CSMw6tk2YWg7AIdKXeKpPRtr5YA9Q==
X-Received: by 2002:a17:902:8a93:: with SMTP id p19mr426722plo.320.1598866033880;
        Mon, 31 Aug 2020 02:27:13 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id h5sm7865081pfk.0.2020.08.31.02.27.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 02:27:13 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Don't drop reference for an OPP table that was never parsed
Date:   Mon, 31 Aug 2020 14:56:56 +0530
Message-Id: <922ff0759a16299e24cacfc981ac07914d8f1826.1598865786.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_remove_table() should drop a reference to the OPP table only
if the DT OPP table was parsed earlier with a call to
dev_pm_opp_of_add_table() earlier. Else it may end up dropping the
reference to the OPP table, which was added as a result of other calls
like dev_pm_opp_set_clkname(). And would hence result in undesirable
behavior later on when caller would try to free the resource again.

Fixes: 03758d60265c ("opp: Replace list_kref with a local counter")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 22 ++++++++++++++++------
 drivers/opp/opp.h  |  2 +-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9d7fb45b1786..31ce5d19ee9e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1291,13 +1291,19 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
-void _opp_remove_all_static(struct opp_table *opp_table)
+bool _opp_remove_all_static(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp, *tmp;
+	bool ret = true;
 
 	mutex_lock(&opp_table->lock);
 
-	if (!opp_table->parsed_static_opps || --opp_table->parsed_static_opps)
+	if (!opp_table->parsed_static_opps) {
+		ret = false;
+		goto unlock;
+	}
+
+	if (--opp_table->parsed_static_opps)
 		goto unlock;
 
 	list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
@@ -1307,6 +1313,8 @@ void _opp_remove_all_static(struct opp_table *opp_table)
 
 unlock:
 	mutex_unlock(&opp_table->lock);
+
+	return ret;
 }
 
 /**
@@ -2409,13 +2417,15 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 		return;
 	}
 
-	_opp_remove_all_static(opp_table);
+	/*
+	 * Drop the extra reference only if the OPP table was successfully added
+	 * with dev_pm_opp_of_add_table() earlier.
+	 **/
+	if (_opp_remove_all_static(opp_table))
+		dev_pm_opp_put_opp_table(opp_table);
 
 	/* Drop reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
-
-	/* Drop reference taken while the OPP table was added */
-	dev_pm_opp_put_opp_table(opp_table);
 }
 
 /**
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e51646ff279e..c3fcd571e446 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -212,7 +212,7 @@ struct opp_table {
 
 /* Routines internal to opp core */
 void dev_pm_opp_get(struct dev_pm_opp *opp);
-void _opp_remove_all_static(struct opp_table *opp_table);
+bool _opp_remove_all_static(struct opp_table *opp_table);
 void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
-- 
2.25.0.rc1.19.g042ed3e048af

