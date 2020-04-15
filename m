Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D733C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B48320768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhOW0LP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441674AbgDOTNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416868AbgDOSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:50:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12520C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:50:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d77so836255wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HxG0r7hAOihPQolhiAxiSpbfJApEZjUojCdyDxEKaME=;
        b=WhOW0LP0WSkxBIxmIudr/kHzIGLgmxz4wfb1q2QmUH1rHOcIi1ByObTmVdUVydbvIX
         sbj1Ilay83nb8NWkB0KHCAAITGOThoT6pTS1JS3BGOOONMu5KOI0klloxRsZK3U4B1k8
         u03ho6QlmEranl40DzWLacHt3b06UwzuQ0nef5K/HrIrcyVcRw/E37eAIgwXg/nsPKZ3
         12AuvCeyh3QMIuXfs+ivUK0WvMIo1gzB1gA4l7ujyTtgsDppAcu54tGMSol/O75UeAmY
         0uuHuNkgxXJUCQKWjRtYZ52KiH+iKm6Z/UyDdgO0/imK82/UxcxxNYpwYeC/msJ1Ls1D
         CCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxG0r7hAOihPQolhiAxiSpbfJApEZjUojCdyDxEKaME=;
        b=CU3ri2vuEui5Nzg1GrtfeLnBQR+eZuU7GxxBeQQZY7O3pkUoF7N47sXtkjEDU8KTbM
         rZchhTjBzM/4/uwAO0ZcZk2aOTMqNiA41ZebvQTXx8OmGsM4Pi1W4TeQZGaz2cQnHWUf
         1P3guIX+r8QDdTd3Xo6BTJvHg6Mm8T6idfX1wdZkhY+B/gvbnZbr8ukF9TZiIzRSsQ8O
         YM/FWOfbWpic5/nTnEaWxk01C4aAoSiT4RTLKWNFkI13ogekvfgl43NX2hrW9cFvKyt/
         wpFB/XzldMulXSXSW9lj9WEcpW5lL8IaYEz2TmnMHPwfkQ3kyRN8NtAtEHFNK7r5CYnz
         WDyg==
X-Gm-Message-State: AGi0PuaUXuT55+y/Y1aZ4Vyzk40yjPz/9MBnrrkmBEyUUYNwwEAwZD+B
        dRd68Ph5gUt90y/pxaqcSq3bAy+QuqhW
X-Google-Smtp-Source: APiQypJV8x2h4LVXyK95Cuo6S9zkHKN7YGpqDtNLNkYj27uheKPDHGd0nP+GdMRbkbEW0FDHExr6AQ==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr671829wme.49.1586976615589;
        Wed, 15 Apr 2020 11:50:15 -0700 (PDT)
Received: from ninjahost.lan (79-73-33-244.dynamic.dsl.as9105.com. [79.73.33.244])
        by smtp.gmail.com with ESMTPSA id w7sm24757618wrr.60.2020.04.15.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:50:15 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Qian Cai <cai@lca.pw>,
        Eiichi Tsukata <devel@etsukata.com>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 1/1] cpu: Add annotation inside clear_tasks_mm_cpumask()
Date:   Wed, 15 Apr 2020 19:49:37 +0100
Message-Id: <20200415184937.32373-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415184937.32373-1-jbi.octave@gmail.com>
References: <20200415184937.32373-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning

warning: context imbalance in clear_tasks_mm_cpumask() - different lock contexts for basic block

The root cause is the missing annotation inside clear_tasks_mm_cpumask()

Add the missing __acquire(&t->alloc_lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af713fb..d8c452a8dd09 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -834,6 +834,7 @@ void clear_tasks_mm_cpumask(int cpu)
 		t = find_lock_task_mm(p);
 		if (!t)
 			continue;
+		__acquire(&t->alloc_lock);
 		cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
 		task_unlock(t);
 	}
-- 
2.24.1

