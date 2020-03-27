Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A97C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B61206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgC0LHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:07:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0LHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:07:15 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jHmpD-0004W4-L3; Fri, 27 Mar 2020 12:06:55 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CA5991040BD; Fri, 27 Mar 2020 12:06:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Boqun Feng <boqun.feng@gmail.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        pkondeti@codeaurora.org, jpoimboe@redhat.com, pavel@ucw.cz,
        konrad.wilk@oracle.com, mojha@codeaurora.org, jkosina@suse.cz,
        mingo@kernel.org, hpa@zytor.com, rjw@rjwysocki.net
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:smp/hotplug] cpu/hotplug: Abort disabling secondary CPUs if wakeup is pending
In-Reply-To: <20200327025311.GA58760@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <1559536263-16472-1-git-send-email-pkondeti@codeaurora.org> <tip-a66d955e910ab0e598d7a7450cbe6139f52befe7@git.kernel.org> <20200327025311.GA58760@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Date:   Fri, 27 Mar 2020 12:06:44 +0100
Message-ID: <874kuaxdiz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:
> From the commit message, it makes sense to add the pm_wakeup_pending()
> check if freeze_secondary_cpus() is used for system suspend. However,
> freeze_secondary_cpus() is also used in kexec path on arm64:

Bah!

> 	kernel_kexec():
> 	  machine_shutdown():
> 	    disable_nonboot_cpus():
> 	      freeze_secondary_cpus()
>
> , so I wonder whether the pm_wakeup_pending() makes sense in this
> situation? Because IIUC, in this case we want to reboot the system
> regardlessly, the pm_wakeup_pending() checking seems to be inappropriate
> then.

Fix below.

Thanks,

        tglx

8<------------

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -133,12 +133,18 @@ static inline void get_online_cpus(void)
 static inline void put_online_cpus(void) { cpus_read_unlock(); }
 
 #ifdef CONFIG_PM_SLEEP_SMP
-extern int freeze_secondary_cpus(int primary);
+int __freeze_secondary_cpus(int primary, bool suspend);
+static inline int freeze_secondary_cpus(int primary)
+{
+	return __freeze_secondary_cpus(primary, true);
+}
+
 static inline int disable_nonboot_cpus(void)
 {
-	return freeze_secondary_cpus(0);
+	return __freeze_secondary_cpus(0, false);
 }
-extern void enable_nonboot_cpus(void);
+
+void enable_nonboot_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
 {
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1200,7 +1200,7 @@ EXPORT_SYMBOL_GPL(cpu_up);
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
-int freeze_secondary_cpus(int primary)
+int __freeze_secondary_cpus(int primary, bool suspend)
 {
 	int cpu, error = 0;
 
@@ -1225,7 +1225,7 @@ int freeze_secondary_cpus(int primary)
 		if (cpu == primary)
 			continue;
 
-		if (pm_wakeup_pending()) {
+		if (suspend && pm_wakeup_pending()) {
 			pr_info("Wakeup pending. Abort CPU freeze\n");
 			error = -EBUSY;
 			break;
