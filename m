Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC39C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9806E2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEOQlfEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgEGSKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728415AbgEGSKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:10:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D703C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:10:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s8so7933819ybj.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4lcduyr6+J6gjW9QNJps5OFAxCiY2gXgkQhtQfZmlTA=;
        b=cEOQlfEVMyYdUWmraiQv6868nByrpJRpaaymVgBwUTg6wEdgwdIVUponU3hyLSlvTp
         5fiab1SKPl//PLD9mpej/wjBU00SMNMDS/A6fS41QZb3XHBzUwGFrYDzviO9ErMIFElp
         LwjjpHOlYW87TavxsSdPCcg22n61ccvSbxkoFAZDeYUmjLjjj4SVs55GP1gwTD4sufrO
         1E+2tAPiEMo1TUE9sizh8TCAFsd4mfShxMp1rSgIjvOIDptPPsdc8eHYXWVvI/Knbn3T
         e3CUlcs//sah/3XJ5uIYx6vHAdrtdPm6R0cTeDtF/EcwT6CcWJezEkkN2nUm9CU5LFel
         gO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4lcduyr6+J6gjW9QNJps5OFAxCiY2gXgkQhtQfZmlTA=;
        b=U/L/o3RiWOTOV4LzrcECvCx8wREA9RiH3kMrUOoQQlr6c8cGmWd6sUeLmqCkyiWE7O
         3okc3/D7cACMt+tMQotVk7a0iOSqdnuKOr620nExentYaR40TxsONdCl3nMkqDkdl/bn
         n3WNKatgvS55aC03JM+ugO9+Sd4R2KT7JUKO9fgjdcIcHllSiI3I1Cuc0DD4sXlMNNjh
         u150PEaNTQzDY7rykWk5WQXu2FVG3U7JeDDd25ppsD1ZnSACm22wcavgaPRZEASVJvBX
         AM1YsJwp4Beog+jhSbsBj6WN3KfyLgZWxmCL7im7eXNeWiWGKIClwMtwRSiN/v1TEKe/
         Ayag==
X-Gm-Message-State: AGi0PuahDUB5wjZucFejCQXzXhXT0gf9ndxpvmxkmwbx7iIPdzt/asIV
        aU8pFFGNUgGLP9PUf6xgvbyCZ37HLvsguNnC1oPd+OZchMTbq4p9nGPvYBDnQemvq9cQ8ccfxzk
        8E0hcQPy4G00fgzIpveu4Nn1j/CEquldqoQO4jdEfrC71Q6NfN8ATNqkZTLGsnlHPWmyQeSew
X-Google-Smtp-Source: APiQypJPdsp8s/0FJ9HkF1hHrjGbTTy5ACV7cG92EmYwZKI6DWKFrz6S0o0PVs9GwAJo3DvMiOded7dIskOr
X-Received: by 2002:a5b:707:: with SMTP id g7mr13422225ybq.489.1588875036707;
 Thu, 07 May 2020 11:10:36 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:08 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-11-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 10/14] sched/fair: Export cpu_util_freq()
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
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dadf0a060abe..b7b43aeff969 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6488,6 +6488,7 @@ unsigned long cpu_util_freq(int cpu, unsigned long max)
 {
 	return aggregate_cpu_util(cpu, cpu_util(cpu), max, FREQUENCY_UTIL, NULL);
 }
+EXPORT_SYMBOL_GPL(cpu_util_freq);
 
 /*
  * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
-- 
2.26.2.526.g744177e7f7-goog

