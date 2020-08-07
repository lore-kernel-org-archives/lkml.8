Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED04C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F63F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX43fKQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHGC3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgHGC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:29:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D38C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 19:29:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k18so199369pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 19:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KiS95mxcuAqTgPcWKhZw6vHzo/GdjTxbtnTWqIq3Ltg=;
        b=JX43fKQRhHjSM2/3D7ZOX9BOiyM+BCPkIAmPR34QAg+oPKs9H1RbTODLvLGLO+4LV4
         t5XF9JJ75lMYv2/8oE7PmAuILShkpLNmBwy0Jy5pYQHTzRBsdQKJhFDbKsDObhwEIX1w
         L+icWYDoZdeH7c1IlIL0gOLpx0kbwou5KJgO+QScTX4cRJNtFyjTh9+DY7uALQrtqIaB
         ckUEWyrsHjqN20vgE8cPtZqWu7Nzj4KhwyipHpjei9sLj87Ne2lxRToBvjAbFlB+EGPx
         q6hK1RNWmR0jliqz/f/dHPatw5aXne/EKsswKxsIDjp42mtNORDcFvmH0INFsBNqRJm7
         a7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KiS95mxcuAqTgPcWKhZw6vHzo/GdjTxbtnTWqIq3Ltg=;
        b=OQaqhdVt4j9yfBeGqwlGq2hZu0faekOU0MwmTRu7wBEuh3KfbTMyHuwIJlDIyRNYoX
         l9EufRa4NgKUxHJ4li9nYum2Ofgi9Y1c3Qxf/wqjaJWtJkgRc/8AcZnWCyiKnX0wz6cZ
         8GbBEOagpOLSnlnuNSIvoyjSR5xZH/WVbR+y9qTu/dkOrMw4WvPm4wx6pqx8Qlz2Rcmp
         SHyCUCeyDscxnmHMotluC4dNt4SzTyvxRu+m8PyZikv1sTWzz/ivF+MM0zN7OPYuC8H3
         eRMegCwzxQ1L1N2gURUxcOURNh8fqIdf69Nqpzi1m+jwh53u5F2wy4A/QBHPw4/zhPjD
         oLHg==
X-Gm-Message-State: AOAM533ubLyndxaDSh6Lt+jDWkj7S9zGFXKRT/lzgJRO5+lGLFQzOonN
        NizpqdY9ZCTV6mtdgvLM7VI=
X-Google-Smtp-Source: ABdhPJwTjobPNu3nU0N9mowtEngIUhZZezCT3xGLug6ghDqMDFENSPx4ijWXiiGIawv8XP0li4Lk9w==
X-Received: by 2002:a63:2d42:: with SMTP id t63mr9872527pgt.450.1596767384423;
        Thu, 06 Aug 2020 19:29:44 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 144sm10037681pfu.114.2020.08.06.19.29.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 19:29:43 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH] timer: mask unnecessary set of flags in do_init_timer
Date:   Fri,  7 Aug 2020 10:29:38 +0800
Message-Id: <1596767378-27241-1-git-send-email-zhaoqianligood@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

do_init_timer can specify flags of timer_list,
but this function does not expect to specify the CPU or idx.
If user invoking do_init_timer and specify CPU,
The result may not what we expected.

E.g:
do_init_timer invoked in core2,and specify flags 0x1
final result flags is 0x3.If the specified CPU number
exceeds the actual number,more serious problems will happen

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 026ac01..17e3737 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -789,7 +789,7 @@ static void do_init_timer(struct timer_list *timer,
 {
 	timer->entry.pprev = NULL;
 	timer->function = func;
-	timer->flags = flags | raw_smp_processor_id();
+	timer->flags = (flags & ~TIMER_BASEMASK & ~TIMER_ARRAYMASK) | raw_smp_processor_id();
 	lockdep_init_map(&timer->lockdep_map, name, key, 0);
 }
 
-- 
2.7.4

