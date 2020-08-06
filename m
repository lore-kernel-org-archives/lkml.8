Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF79C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCEC22CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2x3Pctw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHFAPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgHFAOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:14:53 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041DFC0617A3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:14:50 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id y30so5983421qvy.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O7nU7lYRfe2R9ziGF333WHlsyARaR/Q4/HWduypodHg=;
        b=P2x3PctwOJH5TuP9RSIAld4PsP/j3XNf0AvQXQ/DodKu083Iwcspo5T0atbcBDsOrJ
         0muuNfCGfJv2UYZs4THq+0JJHbABbX5/d+U9rXKBjhLAcqh/qA9l+wDxBWI5FlGn48GT
         n//FasAVkPn21NR0+MvA0EQn1nxFbtKy6fABVAr7Mp1OMARjoHZ8T/jsqEcUhx3bj6/2
         V+ADQDg90iYizGu72GdVwVjhB0p43nWwLP9qqQSCMCjudSGp4lbe1Y6GvsMCowNuzxah
         1ljHzyW2xnvEJmsBpWAhJgQzacZvfeFe36VRxoG3XAwexV99oPDYkDxdZgV3+aIYp2vJ
         VEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O7nU7lYRfe2R9ziGF333WHlsyARaR/Q4/HWduypodHg=;
        b=CJvkahFqeZC+JuLNJOCsi2HhwN7j5uu4CORKwneMJyhUqoVHoRaRv7E65XBTuKVr7y
         JPOUguaH6raBuGUSiH9MBVlW0Va+qkJ4OYcAh5VkYYozx1MLHS4FwDVvEaUYEqgSFADt
         QGuZVZWIEiX8J7B5AFWuUrM1k2teakOuKjKb72a2Xr8b8DyOLQufl25fcKgdM1k2yfTp
         aJup5COkR0DUOd0RjwpelFddxDXJoMRYEmjGV9JLCm+0SQMiZo/MnN6jjpbADfef2z+3
         11+GfGEiVhAUGEOHz/rKH6zMysCnEIB/rI/NBKoSBRlG6jr7rtk4MP89aiHEx8yCCkpA
         tK0w==
X-Gm-Message-State: AOAM5333s0ISD5G/TpJY1UrQ6gfT8RObRSX1VsqnE54K5Us8ijdvywkY
        ewVscl2sKu5jP+EG2DlqPa6POZfh2XHjWD7o6VzFexyEWEuLkqxIeOWj+dJITBRWRciBsoUF827
        epju0O54QCxjFWvKALtozDgXjw2oVgIWH8z232vdFxz/4lxqDc6p0cKmEUszaerDCig5ep1c=
X-Google-Smtp-Source: ABdhPJwdyTprB9qz0EIRwUGruGxBVFwvWVEzapoGVgGGJXsE7/AA/AyXt0lpcFDiRYIFwQKbOSD1eVkGKwTK
X-Received: by 2002:ad4:4ea5:: with SMTP id ed5mr6415961qvb.130.1596672885491;
 Wed, 05 Aug 2020 17:14:45 -0700 (PDT)
Date:   Wed,  5 Aug 2020 17:14:28 -0700
In-Reply-To: <20200806001431.2072150-1-jwadams@google.com>
Message-Id: <20200806001431.2072150-5-jwadams@google.com>
Mime-Version: 1.0
References: <20200806001431.2072150-1-jwadams@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [RFC PATCH 4/7] core/metricfs: expose softirq information through metricfs
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

Add metricfs support for displaying percpu softirq counters.  The
top directory is /sys/kernel/debug/metricfs/softirq.  Then there
is a subdirectory for each softirq type.  For example:

    cat /sys/kernel/debug/metricfs/softirq/NET_RX/values

Signed-off-by: Jonathan Adams <jwadams@google.com>

---

jwadams@google.com: rebased to 5.8-pre6
	This is work originally done by another engineer at
	google, who would rather not have their name associated with this
	patchset. They're okay with me sending it under my name.
---
 kernel/softirq.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4201b7f42b1..1ae3a540b789 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -25,6 +25,8 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/jump_label.h>
+#include <linux/metricfs.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -738,3 +740,46 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
 {
 	return from;
 }
+
+#ifdef CONFIG_METRICFS
+
+#define METRICFS_ITEM(name) \
+static void \
+metricfs_##name(struct metric_emitter *e, int cpu) \
+{ \
+	int64_t v = kstat_softirqs_cpu(name##_SOFTIRQ, cpu); \
+	METRIC_EMIT_PERCPU_INT(e, cpu, v); \
+} \
+METRIC_EXPORT_PERCPU_COUNTER(name, #name " softirq", metricfs_##name)
+
+METRICFS_ITEM(HI);
+METRICFS_ITEM(TIMER);
+METRICFS_ITEM(NET_TX);
+METRICFS_ITEM(NET_RX);
+METRICFS_ITEM(BLOCK);
+METRICFS_ITEM(IRQ_POLL);
+METRICFS_ITEM(TASKLET);
+METRICFS_ITEM(SCHED);
+METRICFS_ITEM(HRTIMER);
+METRICFS_ITEM(RCU);
+
+static int __init init_softirq_metricfs(void)
+{
+	struct metricfs_subsys *subsys;
+
+	subsys = metricfs_create_subsys("softirq", NULL);
+	metric_init_HI(subsys);
+	metric_init_TIMER(subsys);
+	metric_init_NET_TX(subsys);
+	metric_init_NET_RX(subsys);
+	metric_init_BLOCK(subsys);
+	metric_init_IRQ_POLL(subsys);
+	metric_init_TASKLET(subsys);
+	metric_init_SCHED(subsys);
+	metric_init_RCU(subsys);
+
+	return 0;
+}
+module_init(init_softirq_metricfs);
+
+#endif
-- 
2.28.0.236.gb10cc79966-goog

