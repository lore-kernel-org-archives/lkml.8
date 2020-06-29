Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7959C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A561B20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FwlutL/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbgF2UpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbgF2TN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70612C00864C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:04:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so2763032pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ly6GQY518rugBZBKaypUfjaHtOs18Gvlz/xTQcFP+uo=;
        b=FwlutL/Q/eEKYRihTTqlzWcZE7NzatpA+2aRZl4vnE+PQ+Ig5lMtw6ZACAqglZLEfo
         yuSIol4GzaOVt6nQHLF+YD63riXx/XSOQIrc68BaP0Cw9GDXvs/1/072SiY/Mbv+WIG7
         6ED9NmAMHgEzeBjHu2WzoZYxF6I/QKzrgiFapmGeIgP5UTs17yv0rEDiliHlkQLqDhen
         fLrb6m/PGZD87Yiw5zsGWeyZfeW11GjUaK/4QedXpAeknQRRdB7gfHi6NyaQmOXa0e/t
         7xpM8idGeiC4zW2IWrvgnrXun960Lkyd/5OgqGfu/0iUjZHRNyvbtFXO0RVv5BxHJCMl
         iM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ly6GQY518rugBZBKaypUfjaHtOs18Gvlz/xTQcFP+uo=;
        b=FwSFFdUmu43LfXk1h08tBHIgnDAB/x1uo8ctwQchUKrH2A/LLUnbGd4/ugrqtTqss4
         +1fcfpWewxWckXx3iHzWwVEi3JBw2q7lFuXk+OAPbO7RgnIGNs4FRuvQkKf148cttaix
         /YidEB2o8/j7BtS0TPSjtMqi6T97fSAT4w90p2Nb7mIo9UKNWElz3We6Xifnjr4rk27o
         YM0XxXkZnhBBLpVEe52sl/63hgOWBvUwAAgzOmStqnq4ZeH8gJE9zEmh/SedJ/KUMKLc
         oBjmza+dAitA1JBo6cVSUDZO5hVPHcO1aZ/s4/xvyYVRpADBa7W7dHsE8EhdddbT51Bw
         MJnQ==
X-Gm-Message-State: AOAM5336PkKoa7Bvb7XRsSLqBZbxHP50MX6vzTYPFlm7d0hg7Tya2t+z
        cJLAbrklJEzf6QgssqNzOzyBDw==
X-Google-Smtp-Source: ABdhPJzxTl5fVMfp7OZOK/Cxx7y/SkzGumBhYNEPOdMQyPBf1+rzq55IntET0rwpKp6rrizLK7fToA==
X-Received: by 2002:a17:902:7483:: with SMTP id h3mr9067587pll.114.1593425084898;
        Mon, 29 Jun 2020 03:04:44 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id z9sm25088302pgh.94.2020.06.29.03.04.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 03:04:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Remove the weakly defined cpufreq_default_governor()
Date:   Mon, 29 Jun 2020 15:34:40 +0530
Message-Id: <2f00a5847708547a57920e24a2ec5e76b265cde9.1593425047.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default cpufreq governor is chosen with the help of a "choice"
option in the Kconfig which will always end up selecting one of the
governors and so the weakly defined definition of
cpufreq_default_governor() will never get called.

Moreover, this makes us skip the checking of the return value of that
routine as it will always be non NULL.

If the Kconfig option changes in future, then we will start getting a
link error instead (and it won't go unnoticed as in the case of the weak
definition).

Suggested-by: Quentin Perret <qperret@google.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Based over the following series:
- [PATCH V4 0/3] cpufreq: Allow default governor on cmdline and fix
  locking issues

 drivers/cpufreq/cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ad94b1d47ddb..036f4cc42ede 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1056,11 +1056,6 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 	return 0;
 }
 
-__weak struct cpufreq_governor *cpufreq_default_governor(void)
-{
-	return NULL;
-}
-
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
@@ -1079,8 +1074,6 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 
 		if (!gov) {
 			gov = cpufreq_default_governor();
-			if (!gov)
-				return -ENODATA;
 			__module_get(gov->owner);
 		}
 
-- 
2.25.0.rc1.19.g042ed3e048af

