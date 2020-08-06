Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8063C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C615B22CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/SP0oGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgHFAPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHFAOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:14:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F93C0617A0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:14:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d26so26401548yba.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iVslrzv4xFzBXNEn359Z/Whm6d2iMTLeHC3W31lAdWA=;
        b=C/SP0oGOW1Or0jT1oy8iTM7UpU1UdLCVB8XtXPbbhM8nUGF/k9zuT96H8/k1S2BPKz
         GH5kyP4tdhCcsLhgn8rcadoYQlTO83PD9GurtMSGz+82arCK0ifyqSXg8TZyHvUT4g+e
         +k4VMFJphoSzYgDTwtYuYzosOEyZMlvPAM+opXYtnM/8i5eXMcqXDWbrgHh3H4hgN6ur
         5ydu82s+kCbf12Ocmgq1tZDBYQzWVBiShHlJEbsTOnLSQmCiDniGXpO2VNiZGWV5aQ+5
         K8kUk72cHvQAzLwAVzFnwSI06Ek+xEWFPcxTlNM8G7BoLXXbXC4tSuIo7jY5To7ZNcVV
         QcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iVslrzv4xFzBXNEn359Z/Whm6d2iMTLeHC3W31lAdWA=;
        b=PStpmtNG5l0gOnfJPDVsPqCZ5KvS2xEyyF23/3eFo1LfrwpQXXf9D9oDDidXE563qX
         siy/FDzDXdMS5BciTB4aYCglov6wJqikOd3A1p1aYc1QxqUcyKpPXsMFisLtxpd548kW
         PCTcQkRUEM/Q0JqoELXGTILcLARH8hJhGgMgM870DU5qTpwAXheBITAlzzyIF8K647pf
         ktdGJCzwEM0Q9q+iO+RhXZEduJp3OifzJLt4FGpDfs6t+UoOdbrQRadJ4WSHNnWkfnrU
         abtupGPn8wpfn+sSOFNcQGP7m0q5OooABS2XU80YxtNLJRbDiOAART3Owy3ucWCdqv7l
         2ZQQ==
X-Gm-Message-State: AOAM532gbKHL4AgmXF7NP0mMJj2TqZg5XNslX+el+660RJjo2HSWPDqI
        9SvSi74sPc0qyfFdx9+2U2XNahd3hdSLSiPQ0aeEHmM53OzhuJD4J6rqUN2IfEWfysxi11pngq8
        mG8clfhBGvfF29L7oTk0f/pz9NwRqq2O9sR5eT2rECZQjxnlLJ1Cfmwc9c8ZRawPQyP2K1xg=
X-Google-Smtp-Source: ABdhPJySwxnkEmF4OtYZyg3Lz9Wk5GKLTOnJhkx2H+LHVcgdTtgb++K+3ddPPhSTVHbV3Od9xyNUGIbZg7Zb
X-Received: by 2002:a25:32d6:: with SMTP id y205mr9190286yby.77.1596672887452;
 Wed, 05 Aug 2020 17:14:47 -0700 (PDT)
Date:   Wed,  5 Aug 2020 17:14:29 -0700
In-Reply-To: <20200806001431.2072150-1-jwadams@google.com>
Message-Id: <20200806001431.2072150-6-jwadams@google.com>
Mime-Version: 1.0
References: <20200806001431.2072150-1-jwadams@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [RFC PATCH 5/7] core/metricfs: expose scheduler stat information
 through metricfs
From:   Jonathan Adams <jwadams@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add metricfs support for displaying percpu scheduler counters.
The top directory is /sys/kernel/debug/metricfs/stat (analogous
to /proc/stat).  Then there is a subdirectory for each scheduler
stat.  For example:

    cat /sys/kernel/debug/metricfs/stat/user/values

Signed-off-by: Jonathan Adams <jwadams@google.com>

---

jwadams@google.com: rebased to 5.8-pre6
	This is work originally done by another engineer at
	google, who would rather not have their name associated with this
	patchset. They're okay with me sending it under my name.
---
 fs/proc/stat.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 46b3293015fe..deb378507b0b 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -13,6 +13,7 @@
 #include <linux/irqnr.h>
 #include <linux/sched/cputime.h>
 #include <linux/tick.h>
+#include <linux/metricfs.h>
 
 #ifndef arch_irq_stat_cpu
 #define arch_irq_stat_cpu(cpu) 0
@@ -237,3 +238,59 @@ static int __init proc_stat_init(void)
 	return 0;
 }
 fs_initcall(proc_stat_init);
+
+#ifdef CONFIG_METRICFS
+#define METRICFS_ITEM(name, field, desc) \
+static void \
+metricfs_##name(struct metric_emitter *e, int cpu) \
+{ \
+	int64_t v = kcpustat_field(&kcpustat_cpu(cpu), field, cpu); \
+	METRIC_EMIT_PERCPU_INT(e, cpu, v); \
+} \
+METRIC_EXPORT_PERCPU_COUNTER(name, desc, metricfs_##name)
+
+#define METRICFS_FUNC_ITEM(name, func, desc) \
+static void \
+metricfs_##name(struct metric_emitter *e, int cpu) \
+{ \
+	struct kernel_cpustat cpustat; \
+	int64_t v; \
+	kcpustat_cpu_fetch(&cpustat, cpu); \
+	v = func(&cpustat, cpu); \
+	METRIC_EMIT_PERCPU_INT(e, cpu, v); \
+} \
+METRIC_EXPORT_PERCPU_COUNTER(name, desc, metricfs_##name)
+
+METRICFS_ITEM(user, CPUTIME_USER, "time in user mode (nsec)");
+METRICFS_ITEM(nice, CPUTIME_NICE, "time in user mode niced (nsec)");
+METRICFS_ITEM(system, CPUTIME_SYSTEM, "time in system calls (nsec)");
+METRICFS_ITEM(irq, CPUTIME_IRQ, "time in interrupts (nsec)");
+METRICFS_ITEM(softirq, CPUTIME_SOFTIRQ, "time in softirqs (nsec)");
+METRICFS_ITEM(steal, CPUTIME_STEAL, "time in involuntary wait (nsec)");
+METRICFS_ITEM(guest, CPUTIME_GUEST, "time in guest mode (nsec)");
+METRICFS_ITEM(guest_nice, CPUTIME_GUEST_NICE,
+	"time in guest mode niced (nsec)");
+METRICFS_FUNC_ITEM(idle, get_idle_time, "time in idle (nsec)");
+METRICFS_FUNC_ITEM(iowait, get_iowait_time, "time in iowait (nsec)");
+
+static int __init init_stat_metricfs(void)
+{
+	struct metricfs_subsys *subsys;
+
+	subsys = metricfs_create_subsys("stat", NULL);
+	metric_init_user(subsys);
+	metric_init_nice(subsys);
+	metric_init_system(subsys);
+	metric_init_irq(subsys);
+	metric_init_softirq(subsys);
+	metric_init_steal(subsys);
+	metric_init_guest(subsys);
+	metric_init_guest_nice(subsys);
+	metric_init_idle(subsys);
+	metric_init_iowait(subsys);
+
+	return 0;
+}
+module_init(init_stat_metricfs);
+
+#endif
-- 
2.28.0.236.gb10cc79966-goog

