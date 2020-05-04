Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B7EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7290B206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ANDG4jcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgEDMF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728743AbgEDMFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:05:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC97C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 05:05:23 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n14so8122221qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqvaWGKMUCGlMjpPWAbMRQgr5qvZMW0NFZkkESWYhfA=;
        b=ANDG4jcuWtR25st9+2/Scboe6pkHcMMq5b0hKAV97FhyFTMV9dBF5OwsFKkmLcAK9K
         k0Bv0ZdPgSuTVgRQhMwBbWpXK7weFd6BoezGcVvzitZX1pmmCSZlwLY3IO8I5DzKk/lK
         AZazYNbMEJ3yyRafJD9LGodeCL+SgWnEfgvdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqvaWGKMUCGlMjpPWAbMRQgr5qvZMW0NFZkkESWYhfA=;
        b=n3Iw6R7KgeAY4LPLUP05L2oxPJsEPX7koONN0fi1xQx9ttpm5co4G50T0uVknA4Hlz
         gOrEog46ytkkMdmXgVsGr116t3V1zQYZnWBMxZO9Vdq/cHWvF4Q7yqV8Bwpks9/V/olO
         HQuYCS6PRTEJEdvCSPQnt6Szlm0YDJh5d+d/CloYCv8pNES62NQ4pnATU6PY75aeWnEB
         B0tWxm0+n2sCg7mT62QTFtVStb3bVhvqfDrOk7eeBGxmXHk0dfLw0sC5ckXxnS1pul23
         +o2xNKmlMwDfq84/xOkK+g/gFF29jyUKUNhZpsSj04JkcGmD8Mv3h7JZc7fWgJwvDdMm
         ybfQ==
X-Gm-Message-State: AGi0PuaFM4TVuLLAQQPygqL8LWNjZI+a6+SWTk9ycW3I6d1GhNyobc+i
        oHyzTiRXULaxh4VLLG4ACwaP/dGTN+k=
X-Google-Smtp-Source: APiQypJvTR1DsJ5+sfZdzbw+aXFFJv+uqFKH8iqQzP9PWQEPDk6rBBpNsdrMD3ZcX00QMcPRKnA1pg==
X-Received: by 2002:a37:8306:: with SMTP id f6mr15626407qkd.402.1588593922094;
        Mon, 04 May 2020 05:05:22 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y50sm6194534qta.56.2020.05.04.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:05:21 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, vpillai@digitalocean.com
Subject: [PATCH v3 5/5] trace: events: rcu: Change description of rcu_dyntick trace event
Date:   Mon,  4 May 2020 08:05:05 -0400
Message-Id: <20200504120505.89351-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504120505.89351-1-joel@joelfernandes.org>
References: <20200504120505.89351-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

The different strings used for describing the polarity are
Start, End and StillNonIdle. Since StillIdle is not used in any trace
point for rcu_dyntick, it can be removed and StillNonIdle can be added
in the description. Because StillNonIdle is used in a few tracepoints for
rcu_dyntick.

Similarly, USER, IDLE and IRQ are used for describing context in
the rcu_dyntick tracepoints. Since, "KERNEL" is not used for any
of the rcu_dyntick tracepoints, remove it from the description.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 164c43b72ca29..02dcd119f3263 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -437,9 +437,9 @@ TRACE_EVENT_RCU(rcu_fqs,
 /*
  * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
  * as argument:
- * polarilty: "Start", "End", "StillIdle" for entering, exiting or still being
- * in dyntick-idle mode.
- * context: "USER" or "KERNEL" or "IRQ".
+ * polarilty: "Start", "End", "StillNonIdle" for entering, exiting or still not
+ *            being in dyntick-idle mode.
+ * context: "USER" or "IDLE" or "IRQ".
  * NMIs nested in IRQs are inferred with dynticks_nesting > 1 in IRQ context.
  *
  * These events also take a pair of numbers, which indicate the nesting
-- 
2.26.2.526.g744177e7f7-goog

