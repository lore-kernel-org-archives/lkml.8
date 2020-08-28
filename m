Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE30C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA3C20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="HuRwy781"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgH1TxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgH1Twd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A21BC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so678329qkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=G60hQ4nTgEWlrRqvOh+leiUPnjtniQs2oiZi5U5DhNA=;
        b=HuRwy781r1wSLNlzvsFzAilSQODOhOdQDo+iHaz3XU659kfEqlTna+tB2XbgxkaDr6
         VPPj8zweCF1MO81XHESgci9at4zBZoEJk/7hnjpM+h2tyUoefCLyuJXiRSfccQbYw7hq
         zXbPlDZpfvk7gTo/HmMaT/+WICrRu5qYlzq3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=G60hQ4nTgEWlrRqvOh+leiUPnjtniQs2oiZi5U5DhNA=;
        b=fpurwTBwpihGNCp3Rp4+cWEz8hGVneozplyK9lctXdvABHSa/IS8PH9gXPLAaKz+H6
         R7GgEUgZEyWjpkr2qoC7hM//KvCr3cLLND+JEv+B1M6sTx+ByROIEu3MShHYIBpXODX4
         R/tMUSRixvgFSDtxfF4+u2XTDI1B5a6dPIEVB493D5iWwOgQDj9bbIpsmn08WNm1xywK
         LkL74Gw3/SMYPV5sZBrG9S++2frR7Ni47dVNNTfbZ8oD66hxXgWz796vOIUVCgCmCjbG
         VzJG2MBhwnG6ROv7/34dafC2pJG7YgN6mNZFTUBhjbpnUP7UCKPWoA6khG+dr5lxgbvA
         DLLA==
X-Gm-Message-State: AOAM532jJfXhVaFFmi8EEk7ED68Ey48NGecL1tGpjZcCX0sKkSsQX3PW
        DSY5Lbxjeh08OdL3fUXVK3aeJw==
X-Google-Smtp-Source: ABdhPJy1Dh/h9fepXsaK+sJcvSPCCpSNwABel9a2snAY1bq7pdYNECbpPXIy2vw3q+cgt7CrQu7wNA==
X-Received: by 2002:a37:9801:: with SMTP id a1mr772340qke.112.1598644352228;
        Fri, 28 Aug 2020 12:52:32 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:31 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 07/23] cpumask: Introduce a new iterator for_each_cpu_wrap_or
Date:   Fri, 28 Aug 2020 15:51:08 -0400
Message-Id: <b32e11c67051bc60f78dc0b84cf46e6d6034d62c.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

Hotplug fixes to core-scheduling require a new cpumask iterator
which iterates through all online cpus in both the given cpumasks.
This patch introduces it.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/cpumask.h | 42 ++++++++++++++++++++++++++++++++
 lib/cpumask.c           | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d6ac39..27e7e019237b 100644
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
+ * for_each_cpu_or - iterate over every cpu in (mask1 | mask2)
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ *
+ * This saves a temporary CPU mask in many places.  It is equivalent to:
+ *	struct cpumask tmp;
+ *	cpumask_or(&tmp, &mask1, &mask2);
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
index 85da6ab4fbb5..351c56de4632 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -43,6 +43,25 @@ int cpumask_next_and(int n, const struct cpumask *src1p,
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
@@ -95,6 +114,40 @@ int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
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
2.17.1

