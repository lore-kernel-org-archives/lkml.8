Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03D8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 04:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E7D2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 04:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le5kU22e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgHBEv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 00:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgHBEv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 00:51:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E6C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 21:51:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so19176353plx.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 21:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9fTOiCO40iiD8tO5XrUmAYBh4gt26Udf/w1rmUkrP8=;
        b=Le5kU22eaEv/VutZS7aIQsNrxXMXdvJ/qna8ixX2Tlgk8H/v4DtLEi5h5CxfIhsDVc
         Q30YX+7Gb5jRNLC6q2yddPNrt1VmSmAFGVWN5q7haVFFe0SPQX3Ak//9POv5sfiE1qkP
         JyEzs1XH0uZ2dqo0iBzIKfK2DfEfhUyM6sxlmSqd95zQ6vGB2QxmRTNp03O2Fc5mr73p
         bKYraphllpweHMugUq9tTB5xqw1+/3nfgzFGy+pET0+WnRYJPx1ysq/6iHGTAQqAvN+Q
         UoNYQMp3bxggiuccwA8PiaM5n/4IVpFS5pG70frAFKs/EXQoPyycP6aYc/a/YCa0KKVv
         H2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9fTOiCO40iiD8tO5XrUmAYBh4gt26Udf/w1rmUkrP8=;
        b=UGSB/IiEfnHoAgzUi9RtLl/gnpBQnHH2WGl2+LTxZgTeg1SW1OLXnNW5MF3qRLkUAF
         g5stS51sLW6JBCPs/JqXKz+O8hI5IWcv/WFgi3VuAa5KEhwcfPv6hNo12okYoAbS5/dg
         wenOYZLJZ7UPR0w3QG8y4A83GQAVInradAbsqOu6UB1NsqvaYatTlGg6PTQDGFYgPgJW
         6ooF2piYU0Isk35W9YkuABlJruJS5tJUIDjxlslbVZPPo3Nf+Tbayzd4uYAIEeGHOqrd
         GlyaLkkLk+KBBLADn/fPY2Z9V756BsH05i5cfC0xa4HSuvPbgZwLJusetTmdtFexATzc
         luUQ==
X-Gm-Message-State: AOAM530wY+osVxpPdypx3cvZ+XqKcfUq2BfJ1CfYHvgPe5sp/fJiKr5N
        WbrOdnVWHdXdMkiQijGmPp0=
X-Google-Smtp-Source: ABdhPJzU3avUhnSgYi4KQISW/th9OmIZTLnx31//sLYIxz7ahWZAl1lWZEGS4m4VbnHoe6TMJ01mNQ==
X-Received: by 2002:a17:90a:6285:: with SMTP id d5mr11444698pjj.85.1596343918241;
        Sat, 01 Aug 2020 21:51:58 -0700 (PDT)
Received: from localhost.localdomain ([107.191.53.228])
        by smtp.gmail.com with ESMTPSA id f15sm15883414pfk.58.2020.08.01.21.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 21:51:57 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] sched/fair: Fix the logic about active_balance in load_balance()
Date:   Sun,  2 Aug 2020 12:51:41 +0800
Message-Id: <20200802045141.130533-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the unbalance scenario here should be that we need to
do active balance but it is not actually done. So fix it.

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ba8f230feb9..6d8c53718b67 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9710,7 +9710,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	} else
 		sd->nr_balance_failed = 0;
 
-	if (likely(!active_balance) || voluntary_active_balance(&env)) {
+	if (likely(!active_balance) && voluntary_active_balance(&env)) {
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
 	} else {
-- 
2.25.1

