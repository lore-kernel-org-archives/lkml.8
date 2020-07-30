Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11002C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E177B2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyNuIyzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgG3I2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgG3I2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:28:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF84C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:28:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w19so400454plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kqu2uX/Fv5DOCCvKFWtef/4APYguI7Tp/Hp1ZpDXv30=;
        b=gyNuIyzS81L9oBmnvMesqBJln6m3FMCjjAObRVxoBLjUt85xE8FOljda5xqTixZXQS
         m/1mpF1ieN2uPujM3iK3HvS7HNRXcnkJLvAVtVLBtzfKztiLXtnanZ058Vr3p0noqzu/
         xsXjY3nHLCKIc532lJN4S8YycCAeOxb9V2qjxkcp58yOaMJNheyzob8pKdEkOukxK3rw
         +/PJsvZIX1EWP+j+GBXo3m0weTvSWc5tdk7+kbMl2hSC42JZulTnSJeIuk2duub0myYv
         xsFJ6USFtIeT/TYAeaasNHMDIzsvGNCUuSH9zPjVZOfbyZh87EVmq0ZVd6xJCue4hpdt
         wwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kqu2uX/Fv5DOCCvKFWtef/4APYguI7Tp/Hp1ZpDXv30=;
        b=gVAuNqCDcvhUIuM9UEYz8Kd31wVOAZVUheP3nau42nw6lgiC/S2PEdG1U316zanndk
         c/a4iZ41UHfyYDyzoNrsQU+qUfgEN4jT/w9hdDxzaBDoyb5bRoYIgrr7OpmYZQvTYQ9n
         v5P2PWVD+KiiTMr6L5xCy1O5CF3c1yZPqeWWrXlPo/LL0FgTCrF+U+P1bNPBYkQkT8j/
         /+yXY+jEjE0+tpbBAKPOaM8F7GerF6VeYSxweHmfDn/Jf1yWoiFBoFOB9uQCnpLOMbOI
         aHrU6VtdKD3POT4LaHNsjUmfq71CiiAAWYQEQguIDLVRqEsT4pBTaY9ScP1D/WGFw3ap
         /2gw==
X-Gm-Message-State: AOAM530OBtmVHJ4VH04O9ZUZKX0rn0bpjL8If8MORHFoRYIpu/eJQL2j
        0LXXpcA5fGNT9sYLHrE/bYO4bhB2
X-Google-Smtp-Source: ABdhPJwvNYif3xqkvFhQHVM9WRQfjFL8lIjQUD0omf7L8CqveKrGWCSnFIh1RdxbAi3dfY5QOixgHg==
X-Received: by 2002:a17:90b:196:: with SMTP id t22mr2170907pjs.13.1596097725562;
        Thu, 30 Jul 2020 01:28:45 -0700 (PDT)
Received: from pek-lpggp6.wrs.com (unknown-105-123.windriver.com. [147.11.105.123])
        by smtp.gmail.com with ESMTPSA id d29sm5150685pgb.54.2020.07.30.01.28.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jul 2020 01:28:45 -0700 (PDT)
From:   Kevin Hao <haokexin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing/hwlat: Drop the duplicate assignment in start_kthread()
Date:   Thu, 30 Jul 2020 16:23:17 +0800
Message-Id: <20200730082318.42584-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have set 'current_mask' to '&save_cpumask' in its declaration,
so there is no need to assign again.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 kernel/trace/trace_hwlat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index e2be7bb7ef7e..ddb528a6cd51 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -371,7 +371,6 @@ static int start_kthread(struct trace_array *tr)
 		return 0;
 
 	/* Just pick the first CPU on first iteration */
-	current_mask = &save_cpumask;
 	get_online_cpus();
 	cpumask_and(current_mask, cpu_online_mask, tracing_buffer_mask);
 	put_online_cpus();
-- 
2.26.2

