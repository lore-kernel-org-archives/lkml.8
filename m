Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A28C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB353207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ihs+I0Do"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAMMCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:02:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42092 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAMMCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:02:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so3746100plk.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Brn/blormLMYfyweaOtw1e9dY3O44xYZohHiyY5zVcw=;
        b=ihs+I0DoZfUhnE+RxtXdP2ZiM2ecide11T2L4eZD455WFhMjAre+5W9PyNsrndtJBf
         QdlkZSFtYTRy+nw84RFlxMyWf+WNEuVxOooGk55Ry7Hr3JdaTJfe00rkQL1yZXbtMvws
         1qSqOz4owjq3l1hLQ3jZMp2FJqrzvCJ1L/KhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Brn/blormLMYfyweaOtw1e9dY3O44xYZohHiyY5zVcw=;
        b=AIpmhR5/DZZnRoSdVt8zZpDcnvPBJ6VVg91SKN9ibtq9WzEiWXID93I6hzUKcANYZB
         ZHBuyzK1p93YX4YAdMsQSn6xlXy04zm1NjM906/7+soZYFTHUrjF+CLI9XRscyZ2Eaid
         I2UNUbdEoeQDnz1XYXN08zjnBKA4gczOlfHxgJ2dOxHoz+LucEOSxp5fFk8c68HpM2sa
         7E7ZkzelcuZW/GOa4LL8f1ZgjfdQteArhLD9f40F6U8OYgCJq5zoI5qSUH6fO4O3oo2U
         FqNvt727KdM+WEUyaZAc1mZB8Az2aD42td8a6cYehseg3EJDQcCmq/2/4y7xK+AjebQz
         RCyg==
X-Gm-Message-State: APjAAAVdB6RgFRW7k7X2o6wwqNJGArvN/Be9wteOAPa5NE6iELf/dsFB
        CfLrJEROFHEDNqaL9eg5G0V8FA==
X-Google-Smtp-Source: APXvYqyCA7s6sAFyxPrLzf8/Mc4OzJnOETBju4Kl4rw16lnsugojoL4qEabm4CXVze0xslj6hwr2tw==
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr21951650pjb.30.1578916941206;
        Mon, 13 Jan 2020 04:02:21 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id z64sm14435324pfz.23.2020.01.13.04.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 04:02:20 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v3 1/3] reboot: support hotplug CPUs before reboot
Date:   Mon, 13 Jan 2020 20:01:55 +0800
Message-Id: <20200113120157.85798-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200113120157.85798-1-hsinyi@chromium.org>
References: <20200113120157.85798-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently system reboots uses architecture specific codes (smp_send_stop)
to offline non reboot CPUs. Most architecture's implementation is looping
through all non reboot online CPUs and call ipi function to each of them. Some
architecture like arm64, arm, and x86... would set offline masks to cpu without
really offline them. This causes some race condition and kernel warning comes
out sometimes when system reboots.

This patch adds a config REBOOT_HOTPLUG_CPU, which would hotplug cpus in
migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
checking online cpus would be an empty loop. If architecture don't enable this
config, or some cpus somehow fails to offline, it would fallback to ipi
function.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/Kconfig        |  6 ++++++
 include/linux/cpu.h |  3 +++
 kernel/cpu.c        | 19 +++++++++++++++++++
 kernel/reboot.c     |  8 ++++++++
 4 files changed, 36 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 48b5e103bdb0..a043b9be1499 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -52,6 +52,12 @@ config OPROFILE_EVENT_MULTIPLEX
 
 	  If unsure, say N.
 
+config REBOOT_HOTPLUG_CPU
+	bool "Support for hotplug CPUs before reboot"
+	depends on HOTPLUG_CPU
+	help
+	  Say Y to do a full hotplug on secondary CPUs before reboot.
+
 config HAVE_OPROFILE
 	bool
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 1ca2baf817ed..3bf5ab289954 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -118,6 +118,9 @@ extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int cpu_down(unsigned int cpu);
+#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
+extern void offline_secondary_cpus(int primary);
+#endif
 
 #else /* CONFIG_HOTPLUG_CPU */
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af713fb..52afc47dd56a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1057,6 +1057,25 @@ int cpu_down(unsigned int cpu)
 }
 EXPORT_SYMBOL(cpu_down);
 
+#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
+void offline_secondary_cpus(int primary)
+{
+	int i, err;
+
+	cpu_maps_update_begin();
+
+	for_each_online_cpu(i) {
+		if (i == primary)
+			continue;
+		err = _cpu_down(i, 0, CPUHP_OFFLINE);
+		if (err)
+			pr_warn("Failed to offline cpu %d\n", i);
+	}
+	cpu_hotplug_disabled++;
+
+	cpu_maps_update_done();
+}
+#endif
 #else
 #define takedown_cpu		NULL
 #endif /*CONFIG_HOTPLUG_CPU*/
diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b7f1b4..fda84794ce46 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt)	"reboot: " fmt
 
+#include <linux/cpu.h>
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
@@ -220,7 +221,9 @@ void migrate_to_reboot_cpu(void)
 	/* The boot cpu is always logical cpu 0 */
 	int cpu = reboot_cpu;
 
+#if !IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
 	cpu_hotplug_disable();
+#endif
 
 	/* Make certain the cpu I'm about to reboot on is online */
 	if (!cpu_online(cpu))
@@ -231,6 +234,11 @@ void migrate_to_reboot_cpu(void)
 
 	/* Make certain I only run on the appropriate processor */
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
+
+	/* Hotplug other cpus if possible */
+#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
+	offline_secondary_cpus(cpu);
+#endif
 }
 
 /**
-- 
2.25.0.rc1.283.g88dfdc4193-goog

