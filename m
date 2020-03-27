Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938E0C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B61A206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki/AziaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgC0VYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:24:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51907 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgC0VYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id c187so13034380wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2U7oLUCsJOQ4a/FLlJ460vCsETAhV3DLpMjadPQVC5c=;
        b=ki/AziaDhT4ywGicvQ/vCu4L+QgCFYdcK6+O79hjwsD210Ks1920AJhKVDC1+qJspu
         YCxtKpnOt4fu8KFH1IHTMe+AHsuux+Q4Mgti7+rKo9FR1kt6+nwhwHLO+RxEqqZfQmul
         joAZlzHzoCTbAer4s/c2WE9JTBgRWyOIreg9s18UeVCcIhkC1D3bdB/QryomEVjt+y6G
         46O+pLYN0TMVtcQn1roKGMdNFcyopmdIZEFmOpAyO96BNAQ3jP88V5z9BmTQmWb2h3QN
         K/PCbTE0APX6hZRGE1STrdocLxnYwt258rus9XExM6dcrdXk7TLIv4jCUSX2iP4gETqW
         6uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2U7oLUCsJOQ4a/FLlJ460vCsETAhV3DLpMjadPQVC5c=;
        b=Ix0gJlAQoKIldd7QeBNQL26rm5uTHMgZHwwgcygrrO7LPhGDpdIKvD0kmfAjrf+vIF
         y5k42CykWZpxd0ywvCMWW7zfn6tUcinD3N3J4ZgQPPFmKLg+N+hp0U5Hv2dkQJAC0EEG
         y1t9cHXMl0kJ3K8H8cXITvw8rEwC9D65oqIB/82GKA+MjMI2HZqKKHXZwaXyojEO0oGi
         4oSqBmffkH+WG4DepRSPiJgnNPdt1FlwbLkY9o2GUpWMefhTyKIJP3svMUR2vwmR9Awf
         Ce9Scu1A4YMNwCnAkmReLfzXf7p83CT8zXRCfuPBwhblurY6k2WTsU797JVt1t6l5Cbv
         r3GQ==
X-Gm-Message-State: ANhLgQ2Hp94YaCDQ14br6m3/AFF6dk0Ii4iWp6PeNGc7Q3N3ID4Nfwp0
        8XENmWVgNJMIG2mrmtsqIQ==
X-Google-Smtp-Source: ADFU+vuzNcwEIl8sV7OiTZxgepkTU/u9e4cuenG2/rP9HYNlCa5AB/zqHiH5pI79GP860PjzebpZXA==
X-Received: by 2002:a05:600c:20a:: with SMTP id 10mr739151wmi.135.1585344257389;
        Fri, 27 Mar 2020 14:24:17 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:16 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@example.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH 02/10] sched/topology: Replace 1 and 0 by boolean value
Date:   Fri, 27 Mar 2020 21:23:49 +0000
Message-Id: <20200327212358.5752-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327212358.5752-1-jbi.octave@gmail.com>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Irenge <jbi.octave@example.com>

Coccinelle reports a warning inside sched_energy_aware_handler()

WARNING: Assignment of 0/1 to bool variable

To fix this, 1 is replaced by true and 0 by false.
Given that variable sched_energy_update is of bool type.
This fixes the warnings.

Signed-off-by: Jules Irenge <jbi.octave@example.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dfb64c08a407..9d70cc68e549 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -221,9 +221,9 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
 		state = static_branch_unlikely(&sched_energy_present);
 		if (state != sysctl_sched_energy_aware) {
 			mutex_lock(&sched_energy_mutex);
-			sched_energy_update = 1;
+			sched_energy_update = true;
 			rebuild_sched_domains();
-			sched_energy_update = 0;
+			sched_energy_update = false;
 			mutex_unlock(&sched_energy_mutex);
 		}
 	}
-- 
2.25.1

