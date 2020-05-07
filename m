Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A85C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E24020870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hsq7csMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgEGSLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728446AbgEGSKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:10:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE81BC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:10:39 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ev8so6693212qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zZWvTUfx/wRuyyDcQxDeif3qbH8vMyyGM38ys5fdFsY=;
        b=Hsq7csMm3aKxHXFy3vU5SjedQTdFGmje4EFFn7pUNQI+7Tt5gipsk3gojrKeqv0oZA
         zKJmEc4qjOnoV2Poo1wux8oWp7druRmTRThDjQx0nXRmvka5WsF9eIK05U+G5BZ5kwA9
         7QtfLulqPmZBLYbI0vKZu/6D5HO6i4g2a6I7enOxrKuX3hdzh9btnYC61l0lBlUK9g6G
         nIOYbvEzOurFENmE7JQ0pSeNgQ5IUaGVHwya8NGk1H3C8O8Gh3pvyYFCxt45XHtnr/q4
         xHM22KlaIb+SQa38QzZsQOlVjsp4CDU+E/SvPDegyt/YmQrsmOX/1Q6cfHLV37HoscxQ
         DBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zZWvTUfx/wRuyyDcQxDeif3qbH8vMyyGM38ys5fdFsY=;
        b=WQBYO1B8dvGALbw5wvoiS5m5DBGqtT02eLPgHWvHYppPIMlFML7u4jbjs0dphyoxBG
         yGJV1GHMxupXNjA0FoPl1CghoJcgfrPMrs9qNh5XQmaWwYw3ffV46VPB5Uon1fZoZvMH
         DI5Lxb1l80tvn+ndJisfAz7KU67eNIjrTcsWx2pShxQfLkC/FjNAo03QAXSPa+DQo2J6
         VoSp5MZJRufHPByg5bBsPi4vys0n34VSuprc/SAkdeRIEy/lkZiZREH23Bo7HiIQYV6O
         +OEeaHsz5emfPM7+/+gpk9P6eFcyNgPb/CfoM5cA1/ZarfxdfTkemSDSuZ03YtswXs2N
         XSaQ==
X-Gm-Message-State: AGi0PuYOBPQQiMMaIXIo4pL4vv9stOvf1DprLf80h+9hf1zcRsN6v4L9
        HkZNjMWW2z2Jcz9EpzZ+arRc86wcQlYjXVO2jggyldusnVLiqe/sQkPV4R3lrZk3du7C7rl2orG
        3kNT0egOGpkGLz6xyFCtlgkoSx54wapi99Y32+4byzrZlDrxQgalVI5ZBVsEb196t3GU0o2Y3
X-Google-Smtp-Source: APiQypLtVxYcoBCGLT2opMHxryNuYGnQnZvm1aIxlatafdQirXZzAlFCc71e959iGzwoL9cFGjpKT/1CxlGY
X-Received: by 2002:a0c:facb:: with SMTP id p11mr14758771qvo.17.1588875038848;
 Thu, 07 May 2020 11:10:38 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:09 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-12-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 11/14] tick/sched: Export tick_nohz_get_idle_calls_cpu
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be needed by schedutil once modularized, export it.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/time/tick-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e2dc9b8858c..3b1050cabb58 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1122,6 +1122,7 @@ unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
 
 	return ts->idle_calls;
 }
+EXPORT_SYMBOL_GPL(tick_nohz_get_idle_calls_cpu);
 
 /**
  * tick_nohz_get_idle_calls - return the current idle calls counter value
-- 
2.26.2.526.g744177e7f7-goog

