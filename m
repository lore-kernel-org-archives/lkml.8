Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A32EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1193521D95
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7VdKgxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbgGaNU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgGaNUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:20:55 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104DBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:55 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 1so20852462qkm.19
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=evCrDeDl40PK8tQYA287KciiJFZ+88x9kt3Qo3tXcbw=;
        b=o7VdKgxQCSSYoocE3F40S21gIBlPyWctlDUqWnc3OG5cpjU9K5ciJhmU3Bqjsak7Y1
         HHiSULFwwvEZXgcCUyxBIVby5d0XcFuLVWR9CN+jXSSjYK+PLOb5aGZEe0DzARZBLB1F
         XV2g0MMJ+uhw+m2ZKuGEG6eEr9VXeEwE7WmTptaX6kgNA4oDLlK3odu91eiP/i8uA0Fa
         eTTSmd1G103bSXOgbKM0tRcjGZw2WS8G8IiOtDjcjzEKJdqyhR2RMevgshdT7qF+Vd0F
         P4WxKhPdEiw7CT5pZjryPOjTalDwrep9ZFlhlX3KI7lIm/4m2fJjFmd7OFhJ7QIbfNSv
         U40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=evCrDeDl40PK8tQYA287KciiJFZ+88x9kt3Qo3tXcbw=;
        b=TtcLA/tDOsVbG1iKQqPYq/5S6Y89ZkNSozHfL3NPVycB4nlIpb4o3Daoj0RPjO3GK6
         WfEu2mAfziTB1IDbRLEJvnGk8VbsqV/1tMctwYcmvfQVqNPkdbXEfCX3yCWhzVDi1k9n
         N7bCKdqPj8+YzFVkjRlGUZH7ptaRBSiiKMRySXJrhX97+9NINCmPco6cBriOK7t8gLpR
         wYYB1KGKunnJnbRhlsHZXtlvZU1HMf5Ex4X9NJLvKa50yS8ZQ/zfyTTwahMBT2mm19br
         wAlQmyG3L86Kyw1YXfMVLzzziLglOoFni9Guj8AfRpCSezg8F/apiLBWjbUWRMScWS4p
         1bmQ==
X-Gm-Message-State: AOAM533+POIgocXNarvmkcCS+oyZ/ioB+jLkMRp6CyodcqdBG1LBAmYE
        i1yAUucy72uyiwxjscXpxvkxJnCCo1ScWKy4
X-Google-Smtp-Source: ABdhPJz/IdkmTWODy6uNdNCndSQBvUsuBuekmlNP84MdsovzBWlo1RYnI51/aqZjGGd4xNBPfrwZy+JY12louwin
X-Received: by 2002:a0c:aac8:: with SMTP id g8mr4080160qvb.70.1596201654097;
 Fri, 31 Jul 2020 06:20:54 -0700 (PDT)
Date:   Fri, 31 Jul 2020 15:20:39 +0200
In-Reply-To: <cover.1596199677.git.andreyknvl@google.com>
Message-Id: <55d432671a92e931ab8234b03dc36b14d4c21bfb.1596199677.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596199677.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 2/4] kasan, arm64: don't instrument functions that enable kasan
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares Software Tag-Based KASAN for stack tagging support.

With stack tagging enabled, KASAN tags stack variable in each function
in its prologue. In start_kernel() stack variables get tagged before KASAN
is enabled via setup_arch()->kasan_init(). As the result the tags for
start_kernel()'s stack variables end up in the temporary shadow memory.
Later when KASAN gets enabled, switched to normal shadow, and starts
checking tags, this leads to false-positive reports, as proper tags are
missing in normal shadow.

Disable KASAN instrumentation for start_kernel(). Also disable it for
arm64's setup_arch() as a precaution (it doesn't have any stack variables
right now).

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/setup.c | 2 +-
 init/main.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index c793276ec7ad..87e81d29e6fb 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -276,7 +276,7 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
-void __init setup_arch(char **cmdline_p)
+void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
diff --git a/init/main.c b/init/main.c
index 2d74985e09b1..c73a16ff213e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -829,7 +829,7 @@ void __init __weak arch_call_rest_init(void)
 	rest_init();
 }
 
-asmlinkage __visible void __init start_kernel(void)
+asmlinkage __visible __no_sanitize_address void __init start_kernel(void)
 {
 	char *command_line;
 	char *after_dashes;
-- 
2.28.0.163.g6104cc2f0b6-goog

