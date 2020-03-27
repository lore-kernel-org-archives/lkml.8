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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E77C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB112073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTeA/5vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgC0VYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:24:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51919 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgC0VYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id c187so13035015wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RL3xiN8W6cz7dfbCpGqvic4ZrO12rtINmJ/67vPTQI=;
        b=hTeA/5vbANSKBOfgfgihFOWpSkJAhBcEKyTFX75mkuw1DQpvwgEkuL6EFYmAl6htpQ
         DcmRDKfbqSSTKqm00O1zKpLZK6xjeZzH583LaLOJhBEFNy07lKRLuMNhxN/RXB8Yvq8z
         +S9c49lQVipwVUFS5gZf2ZW8rTsrWIMb9R3x43IjatVoYkBpx1DUVol/SHLdYMNfrKQB
         BUQscsqnBPxUfMyERtvtza1DV3cVHzqi/kgn8uT+Fx/yj66s5C6X1x+Jd5lEetNcoIsT
         dy1ide/aQTtRUyfwpPZ3z015M8YlUhZ5NpIAqjbit5ZJ9TOHRe6ot8EL+nf+4tLEyimL
         zYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RL3xiN8W6cz7dfbCpGqvic4ZrO12rtINmJ/67vPTQI=;
        b=TqS3rb8dpYHseCV3tv1wkAfw3QuIBG4VBoe2l9ytW2hJVQHZVUGO5YmBpOqX0ouIgs
         5Id2O/aJIoQyCafHhkNpxkRD1YFubBZIEmB5NR07KTccW160cpxdUQWWSRtI7RmLQEAS
         c5UkNHBzhZ39EOUKTdxPmm53OG0v3ig4QV2l/bOjxzVtDjRe6oXrTFzpYUrM5UtExxfp
         +WG6lwHOnoOiKzsWJkw3Rzp7MGLQraEBQgJomqJhRtx/Z/DhxhWfHQVXOTVxoTcr4hj/
         Y6tXS9XtvkqgIMKdS6KiyK+6OjybbzlGmcu6WUInxSRX5dKKP9HMSaNzPYkB9NWW9SpR
         Ghgg==
X-Gm-Message-State: ANhLgQ2ewTCYnqzbrcjtJokzkNR0P8XDY2QMlwmUB71dLf1pbcG1fc/6
        R4A9/rtVrUwcdZe/2dfewQ==
X-Google-Smtp-Source: ADFU+vtwug51RoUyH5LzFvTkssv7ihCgoPrxnE2ed7vc1qPZLVwxHVvVdJHexLK6kUc7NQUPdIFcJg==
X-Received: by 2002:a7b:c117:: with SMTP id w23mr755644wmi.26.1585344267401;
        Fri, 27 Mar 2020 14:24:27 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:27 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH 07/10] sched/fair: Replace 1 and 0 by boolean value
Date:   Fri, 27 Mar 2020 21:23:54 +0000
Message-Id: <20200327212358.5752-8-jbi.octave@gmail.com>
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

Coccinelle reports a warning at voluntary_active_balance

WARNING: return of 0/1 in function voluntary_active_balance with return type bool

To fix this, 1 is replaced by true and 0 by false.
Given that voluntary_active_balance() is of bool type.
This fixes the warnings.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c1217bfe5e81..b11bb08687a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9082,7 +9082,7 @@ voluntary_active_balance(struct lb_env *env)
 	struct sched_domain *sd = env->sd;
 
 	if (asym_active_balance(env))
-		return 1;
+		return true;
 
 	/*
 	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
@@ -9094,13 +9094,13 @@ voluntary_active_balance(struct lb_env *env)
 	    (env->src_rq->cfs.h_nr_running == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
-			return 1;
+			return true;
 	}
 
 	if (env->migration_type == migrate_misfit)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 static int need_active_balance(struct lb_env *env)
-- 
2.25.1

