Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212E6C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFB4214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050483;
	bh=YvEO37qKCjWeczjWU6192GteB1w/O74tNl8rInnF+to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wb/Px/oxx7oc32Af4cE4HYOuwzM675syKgBuY9bStc3sls4JHye4CjTEZOLnqQzkf
	 LAF7tElwNPQvzgopXORtgDc8kkM6mkE4vB63yfI4PXP3k1FPnjIk6dAc5+AzyxkYxV
	 dciFZYuA9AzTvxv7ASgYcsc9ZEqrqi1niYGcz4bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392166AbgDPPVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898627AbgDPNqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:46:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F5C208E4;
        Thu, 16 Apr 2020 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044806;
        bh=YvEO37qKCjWeczjWU6192GteB1w/O74tNl8rInnF+to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1nj8Rdabzv399htP5Gu8MUs/8t2uTpLWzogsQz8V33OpEtbXo5GEy0DdOrBSu61+
         PYkUdAt0JvuEvzYz/rfgqdbs5ijfqq/ZrHmapQE5ZLQimgA9xLwZ9Y+gPW88WtC2Sh
         A+VEYXApTRyBSrLf2d01FGnkZUHBpasgrFXYiDMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>
Subject: [PATCH 5.4 109/232] cpu/hotplug: Ignore pm_wakeup_pending() for disable_nonboot_cpus()
Date:   Thu, 16 Apr 2020 15:23:23 +0200
Message-Id: <20200416131328.777564526@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit e98eac6ff1b45e4e73f2e6031b37c256ccb5d36b upstream.

A recent change to freeze_secondary_cpus() which added an early abort if a
wakeup is pending missed the fact that the function is also invoked for
shutdown, reboot and kexec via disable_nonboot_cpus().

In case of disable_nonboot_cpus() the wakeup event needs to be ignored as
the purpose is to terminate the currently running kernel.

Add a 'suspend' argument which is only set when the freeze is in context of
a suspend operation. If not set then an eventually pending wakeup event is
ignored.

Fixes: a66d955e910a ("cpu/hotplug: Abort disabling secondary CPUs if wakeup is pending")
Reported-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/874kuaxdiz.fsf@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/cpu.h |   12 +++++++++---
 kernel/cpu.c        |    4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -138,12 +138,18 @@ static inline void get_online_cpus(void)
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
@@ -1212,7 +1212,7 @@ EXPORT_SYMBOL_GPL(cpu_up);
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
-int freeze_secondary_cpus(int primary)
+int __freeze_secondary_cpus(int primary, bool suspend)
 {
 	int cpu, error = 0;
 
@@ -1237,7 +1237,7 @@ int freeze_secondary_cpus(int primary)
 		if (cpu == primary)
 			continue;
 
-		if (pm_wakeup_pending()) {
+		if (suspend && pm_wakeup_pending()) {
 			pr_info("Wakeup pending. Abort CPU freeze\n");
 			error = -EBUSY;
 			break;


