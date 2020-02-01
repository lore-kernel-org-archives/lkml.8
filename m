Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1619C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967CB20722
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxPv/Jit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBAAEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:04:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34098 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgBAAEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:04:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so9905593wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7HZmuLvPAvtEVH2AwWm+lK2s0FBYOIIxH0tWrnWAKc=;
        b=qxPv/JitVYYoNi+Tq9NH1s2UqbKe+6Nf2+304ksXX4X1w4P9BRrUkE0g3NEfC9vg2Q
         jEzLrtf9scVjikxwkVm1hUmyF0JH8tenikPUyWZasVHUk8bNjIyYdpqWX7GUWCi9LIfA
         qwmA/er70+vdE2+OPzimPMkCG/HiCoofYYva2U+9DmOquTbbtwImpxsVAnAJ394fxHIg
         WGtEqLOnnH9oirfblUZMQeavbx2jDfQBHDVwsZIS4zbVupXifiV61GSb9/qG+to/3+JO
         43PfooE1e3PAf0QreUqFnPBaTbYpJctxYsKeaMfDHhTRMEjAkF+qKoeJ0nfMG2Rdgw8d
         Mhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7HZmuLvPAvtEVH2AwWm+lK2s0FBYOIIxH0tWrnWAKc=;
        b=nz4QGMDLVvgE7eVSgyTj9DlaLwvEjLRCoAsGvox3jcY8MNSRSNITEvfbsCxZdnwfRW
         dSXgLe4Tlg0yFG7ZZFlYJIKNnVQBmcbGW4yPSZu1HTFEWwoBwT4xru8ovzB4xwywmrvf
         5muu3ujLfkAY4JYp6foxrcxuRQrdlG/Et0M7aKTizFdFMZxDBMiW7sQZsmod4YhazO1Y
         hlZAH/QYsOeGdNN8CjQLLGjb0a4dr0Ugr8T4TbMcWkIHYR7eu1WgLAOEFybaSuBnH8Mv
         BTWIv4ZEZ6K+qQnezTAUiWiRPzMPNG27EGD5UwQQMfGzFYmC1lUVZ73dLWoaKgV6gTXK
         3c5g==
X-Gm-Message-State: APjAAAXYgbj/rDSSPOwV1VkD/YNo/WfrMni+JRDy3Tb6c+IXPmTs4TYa
        0rm8Lr5I+BS+vuCBKPuwzQ==
X-Google-Smtp-Source: APXvYqzd77+eReDGPE4FL20WxHfFoBztrScx8hmQUklNxCAmPzQBxQywAx0Vt1UI2VL9Fx/KBwT9rQ==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr7056233wma.134.1580515483998;
        Fri, 31 Jan 2020 16:04:43 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id n10sm13694048wrt.14.2020.01.31.16.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 16:04:43 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 1/3] hrtimer: Add missing annotation to lock_hrtimer_base()
Date:   Sat,  1 Feb 2020 00:04:14 +0000
Message-Id: <20200201000416.91900-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201000416.91900-1-jbi.octave@gmail.com>
References: <0/3>
 <20200201000416.91900-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports several warnings;
warning: context imbalance in lock_hrtimer_base() - wrong count at exit
warning: context imbalance in hrtimer_start_range_ns() - unexpected unlock
warning: context imbalance in hrtimer_try_to_cancel() - unexpected unlock
warning: context imbalance in __hrtimer_get_remaining() - unexpected unlock

The root cause is a missing annotation of lock_hrtimer_base() which
causes also the "unexpected unlock" warnings.

Add the missing __acquires(timer->base) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/time/hrtimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3a609e7344f3..bb8340e2a3b9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -160,6 +160,7 @@ static inline bool is_migration_base(struct hrtimer_clock_base *base)
 static
 struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 					     unsigned long *flags)
+	__acquires(timer->base)
 {
 	struct hrtimer_clock_base *base;
 
-- 
2.24.1

