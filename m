Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78083C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507DE206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SwzhoYXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgHOV52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgHOVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:05 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CABC061372
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:24 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id f19so3978155qtp.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/2iDSYA0ccf1wgSM6kN386IyfUIBy/ynbBnxkfnRLM=;
        b=SwzhoYXy2Xy8D20ypwVIUdc4W0AKN9CBGpyIT6vcXtuULPzpuZEFtWd5byMnCBgyT2
         V44rFt9lJzZZozLpVRP/3DrID/6YL2X+Zkete6cNmkgWxm7iSLxMz6YXLKq2Kw5Uou92
         u9TCiJCaAMfiqtTDoUNe6HDIYGLoVtq6Ou8fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/2iDSYA0ccf1wgSM6kN386IyfUIBy/ynbBnxkfnRLM=;
        b=TYJTFT5rKfb9M0EA8jEXd8831DQ8cr1stz9Vv8Tcii73P6D2QrP38zTMhd8xCnZde8
         0dtrEzMYXLAx8R/ONQhavOt+MLS6dzqm+Y81gUfxKfegZwICWHDI3QJQLY2sVvzst+pZ
         gSgUBjkTPaydRRhNuCc5AHqcypcmbjOYU7Oi+9VxkOC0ujx7q9/eAWM5k5G/D8LXFrXv
         KrowCQAldJZbiJFC+wHq6fB7ODjAx+K9hkE98FAq/nlQ5COy5vlpAvkpkICVF0oWNCy7
         QCQ9x/BuKmcnZ3DnTFR/z+G9ctmXyusD2lom24T82RkBRZ9y9sAztqwdC1xOGJKp9SsS
         MaEw==
X-Gm-Message-State: AOAM530tPaPlJC/rYfI8aL50f9BhxuyPES5gYrODHLT4eWB6ko+OWJT6
        fY/6gtUDPOZT/7Px6Aty2o6BGbEC4JwlLg==
X-Google-Smtp-Source: ABdhPJxe8dlX794Fx6Jim+YqqPRlSSp3cGb/8xRQJSVXenDuq+3v1PAvf6bbp0M0xMGIuf/jO7SYWQ==
X-Received: by 2002:ac8:6b84:: with SMTP id z4mr4905626qts.279.1597461563363;
        Fri, 14 Aug 2020 20:19:23 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:22 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 01/12] irq_work: Add support to detect if work is pending
Date:   Fri, 14 Aug 2020 23:18:57 -0400
Message-Id: <20200815031908.1015049-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an unsafe region is entered on an HT, an IPI needs to be sent to
siblings to ensure they enter the kernel.

Following are the reasons why we would like to use irq_work to implement
forcing of sibling into kernel mode:

1. Existing smp_call infrastructure cannot be used easily since we could
   end up waiting on CSD lock if previously an smp_call was not yet
   serviced.

2. I'd like to use generic code, such that there is no need to add an
   arch-specific IPI.

3. IRQ work already has support to detect that previous work was not yet
   executed through the IRQ_WORK_PENDING bit.

4. We need to know if the destination of the IPI is not sending more
   IPIs due to that IPI itself causing an entry into unsafe region.

Support for 4. requires us to be able to detect that irq_work is
pending.

This commit therefore adds a way for irq_work users to know if a
previous per-HT irq_work is pending. If it is, we need not send new
IPIs.

Memory ordering:

I was trying to handle the MP-pattern below. Consider the flag to be the
pending bit. P0() is the IRQ work handler. P1() is the code calling
irq_work_pending(). P0() already implicitly adds a memory barrier as a
part of the atomic_fetch_andnot() before calling work->func(). For P1(),
this patch adds the memory barrier as the atomic_read() in this patch's
irq_work_pending() is not sufficient.

        P0()
        {
                WRITE_ONCE(buf, 1);
                WRITE_ONCE(flag, 1);
        }

        P1()
        {
                int r1;
                int r2 = 0;

                r1 = READ_ONCE(flag);
                if (r1)
                        r2 = READ_ONCE(buf);
        }

Cc: paulmck@kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/irq_work.h |  1 +
 kernel/irq_work.c        | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 30823780c192..b26466f95d04 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -42,6 +42,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu);
 
 void irq_work_tick(void);
 void irq_work_sync(struct irq_work *work);
+bool irq_work_pending(struct irq_work *work);
 
 #ifdef CONFIG_IRQ_WORK
 #include <asm/irq_work.h>
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index eca83965b631..2d206d511aa0 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -24,6 +24,17 @@
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 
+bool irq_work_pending(struct irq_work *work)
+{
+	/*
+	 * Provide ordering to callers who may read other stuff
+	 * after the atomic read (MP-pattern).
+	 */
+	bool ret = atomic_read_acquire(&work->flags) & IRQ_WORK_PENDING;
+
+	return ret;
+}
+
 /*
  * Claim the entry so that no one else will poke at it.
  */
-- 
2.28.0.220.ged08abb693-goog

