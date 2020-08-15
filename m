Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D6C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FC0205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DBYuSEfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgHOWGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgHOVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A140C061379
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:32 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l13so5230015qvt.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sz9J9n5LJAX7KClHXQuFpMY4XStGHjRFIOCICHV1+xA=;
        b=DBYuSEfaGrHBZ6Ox30YL3/iF80Lbym84DzzCTT44BqXZbCQrCWIHiVVstkjiPp5D3D
         0Yc0zxknsWLouhfVyupvLylPPu3mlSvCJ5Bk3JVOHGtboT8kJHczbvJJyeBgQgbt2mKm
         OvZouILkJD+chgktd8mY35fv05p4iyQsNd3Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sz9J9n5LJAX7KClHXQuFpMY4XStGHjRFIOCICHV1+xA=;
        b=gdI9z1vOdBqP2GNy5V2RKiZUK/rZOom8u4wjZ4KqYW/nGe8KRfqNr+NrfQo4s71PXX
         anf4vx4M0clpffg2XTn1vjGYHLihomOk6CQgvQobbMUnhWjv3FE0q6bLMfkWpIreITeA
         omQo/bvq7KHWoG22hJHyfjkl/MatXOwb/uyex51C9y93Z1wlkRPgJWHIfUWbgC7PfXQQ
         z9KDTqF7DGUzW0B7cyQyKqGmopsNY9W7wgMMucDEkLzHMAacpNPGPAFi8SMvvAcHDGyM
         bj8BVO56DqqBSPcN5EFVy6b00KOZFJm/orRJdVQ+tTh8gaVjig6OYX8lYzotkXBb+NaE
         WTHw==
X-Gm-Message-State: AOAM533aYd99z0NINb+AiRRPfpm3I1bbz529LUdkN2Lwyr4V5fuRatxm
        6vMHuciM9KQiLgTAz+zVrku5MqF5EmLHJA==
X-Google-Smtp-Source: ABdhPJyg1Gs1MEeJSpdLbF1HcBYbQH7Ao2UZcesb0jCMGvIW5YPYA4FBd8gsxBOrIUvIyEV3Hz58NQ==
X-Received: by 2002:a0c:b310:: with SMTP id s16mr5320090qve.5.1597461571554;
        Fri, 14 Aug 2020 20:19:31 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 08/12] cpumask: Introduce a new iterator for_each_cpu_wrap_or
Date:   Fri, 14 Aug 2020 23:19:04 -0400
Message-Id: <20200815031908.1015049-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

Hotplug fixes to core-scheduling require a new cpumask iterator which iterates
through all online cpus in both the given cpumasks. This patch introduces it.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/cpumask.h | 42 ++++++++++++++++++++++++++++++++
 lib/cpumask.c           | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d6ac39..03e8c57c6ca6 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -207,6 +207,10 @@ static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
 #define for_each_cpu_and(cpu, mask1, mask2)	\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
+#define for_each_cpu_or(cpu, mask1, mask2)	\
+	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
+#define for_each_cpu_wrap_or(cpu, mask1, mask2, start)	\
+	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2, (void)(start))
 #else
 /**
  * cpumask_first - get the first cpu in a cpumask
@@ -248,6 +252,7 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 }
 
 int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
+int cpumask_next_or(int n, const struct cpumask *, const struct cpumask *);
 int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
@@ -278,6 +283,8 @@ int cpumask_any_and_distribute(const struct cpumask *src1p,
 		(cpu) < nr_cpu_ids;)
 
 extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
+extern int cpumask_next_wrap_or(int n, const struct cpumask *mask1,
+				 const struct cpumask *mask2, int start, bool wrap);
 
 /**
  * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
@@ -294,6 +301,22 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 	     (cpu) < nr_cpumask_bits;						\
 	     (cpu) = cpumask_next_wrap((cpu), (mask), (start), true))
 
+/**
+ * for_each_cpu_wrap_or - iterate over every cpu in both masks, starting at a specified location
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ * @start: the start location
+ *
+ * The implementation does not assume any bit both masks are set (including @start).
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_wrap_or(cpu, mask1, mask2, start)					\
+	for ((cpu) = cpumask_next_wrap_or((start)-1, (mask1), (mask2), (start), false);	\
+	     (cpu) < nr_cpumask_bits;						\
+	     (cpu) = cpumask_next_wrap_or((cpu), (mask1), (mask2), (start), true))
+
 /**
  * for_each_cpu_and - iterate over every cpu in both masks
  * @cpu: the (optionally unsigned) integer iterator
@@ -312,6 +335,25 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 	for ((cpu) = -1;						\
 		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
 		(cpu) < nr_cpu_ids;)
+
+/**
+ * for_each_cpu_or - iterate over every cpu in both masks
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ *
+ * This saves a temporary CPU mask in many places.  It is equivalent to:
+ *	struct cpumask tmp;
+ *	cpumask_and(&tmp, &mask1, &mask2);
+ *	for_each_cpu(cpu, &tmp)
+ *		...
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_or(cpu, mask1, mask2)				\
+	for ((cpu) = -1;						\
+		(cpu) = cpumask_next_or((cpu), (mask1), (mask2)),	\
+		(cpu) < nr_cpu_ids;)
 #endif /* SMP */
 
 #define CPU_BITS_NONE						\
diff --git a/lib/cpumask.c b/lib/cpumask.c
index fb22fb266f93..0a5cdbd4eb6a 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -42,6 +42,25 @@ int cpumask_next_and(int n, const struct cpumask *src1p,
 }
 EXPORT_SYMBOL(cpumask_next_and);
 
+/**
+ * cpumask_next_or - get the next cpu in *src1p | *src2p
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Returns >= nr_cpu_ids if no further cpus set in both.
+ */
+int cpumask_next_or(int n, const struct cpumask *src1p,
+		    const struct cpumask *src2p)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_or_bit(cpumask_bits(src1p), cpumask_bits(src2p),
+		nr_cpumask_bits, n + 1);
+}
+EXPORT_SYMBOL(cpumask_next_or);
+
 /**
  * cpumask_any_but - return a "random" in a cpumask, but not this one.
  * @mask: the cpumask to search
@@ -94,6 +113,40 @@ int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 }
 EXPORT_SYMBOL(cpumask_next_wrap);
 
+/**
+ * cpumask_next_wrap_or - helper to implement for_each_cpu_wrap_or
+ * @n: the cpu prior to the place to search
+ * @mask1: first cpumask pointer
+ * @mask2: second cpumask pointer
+ * @start: the start point of the iteration
+ * @wrap: assume @n crossing @start terminates the iteration
+ *
+ * Returns >= nr_cpu_ids on completion
+ *
+ * Note: the @wrap argument is required for the start condition when
+ * we cannot assume @start is set in @mask.
+ */
+int cpumask_next_wrap_or(int n, const struct cpumask *mask1, const struct cpumask *mask2,
+			   int start, bool wrap)
+{
+	int next;
+
+again:
+	next = cpumask_next_or(n, mask1, mask2);
+
+	if (wrap && n < start && next >= start) {
+		return nr_cpumask_bits;
+
+	} else if (next >= nr_cpumask_bits) {
+		wrap = true;
+		n = -1;
+		goto again;
+	}
+
+	return next;
+}
+EXPORT_SYMBOL(cpumask_next_wrap_or);
+
 /* These are not inline because of header tangles. */
 #ifdef CONFIG_CPUMASK_OFFSTACK
 /**
-- 
2.28.0.220.ged08abb693-goog

