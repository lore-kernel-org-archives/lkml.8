Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C2C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84B82076B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550677;
	bh=kSl5n1X0fqhL9UVctp/VXku8rEYPoENccDyZLyn7bqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lsTlQ2qChWYmMMKeuF7xmlGUK+7/K6sXqG/7fQpVk2DVQ3MxawbK7RGCTn7b1cCl1
	 fcDuFW9c8jBznDRIJAvpDBZK9Jl7KTDwu/WJook0KyBh6jIpXif78JGkoeXOZYTr16
	 NyACKrgdvjkUF76pRlqmEr3tYLn2GukUNVW56nvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgDVKR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbgDVKQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:16:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49AAD20780;
        Wed, 22 Apr 2020 10:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550615;
        bh=kSl5n1X0fqhL9UVctp/VXku8rEYPoENccDyZLyn7bqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqOy8fmt6FDG8rfJL+Fry4kmN9Bu5jcUJQZzmNQxsdjQd3kV9asG6OvUAu8opSd1s
         RoHxWPMHzywZMgUP3cZEIg31q8R+XPSlfcbjsl8cIOKsK/i3uoj2o4GYvf7y1MhY0W
         6bU4Zz1CAcaMB/AiPV56WRwiJ/6aUUBGnLpgOivg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 5.4 023/118] x86/Hyper-V: Report crash data in die() when panic_on_oops is set
Date:   Wed, 22 Apr 2020 11:56:24 +0200
Message-Id: <20200422095035.568397912@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

commit f3a99e761efa616028b255b4de58e9b5b87c5545 upstream.

When oops happens with panic_on_oops unset, the oops
thread is killed by die() and system continues to run.
In such case, guest should not report crash register
data to host since system still runs. Check panic_on_oops
and return directly in hyperv_report_panic() when the function
is called in the die() and panic_on_oops is unset. Fix it.

Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be more useful")
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20200406155331.2105-7-Tianyu.Lan@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/hyperv/hv_init.c      |    6 +++++-
 drivers/hv/vmbus_drv.c         |    5 +++--
 include/asm-generic/mshyperv.h |    2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
+#include <linux/kernel.h>
 #include <linux/cpuhotplug.h>
 #include <clocksource/hyperv_timer.h>
 
@@ -354,11 +355,14 @@ void hyperv_cleanup(void)
 }
 EXPORT_SYMBOL_GPL(hyperv_cleanup);
 
-void hyperv_report_panic(struct pt_regs *regs, long err)
+void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 {
 	static bool panic_reported;
 	u64 guest_id;
 
+	if (in_die && !panic_on_oops)
+		return;
+
 	/*
 	 * We prefer to report panic on 'die' chain as we have proper
 	 * registers to report, but if we miss it (e.g. on BUG()) we need
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -31,6 +31,7 @@
 #include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <linux/kernel.h>
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 #include "hyperv_vmbus.h"
@@ -75,7 +76,7 @@ static int hyperv_panic_event(struct not
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
 	    && hyperv_report_reg()) {
 		regs = current_pt_regs();
-		hyperv_report_panic(regs, val);
+		hyperv_report_panic(regs, val, false);
 	}
 	return NOTIFY_DONE;
 }
@@ -92,7 +93,7 @@ static int hyperv_die_event(struct notif
 	 * the notification here.
 	 */
 	if (hyperv_report_reg())
-		hyperv_report_panic(regs, val);
+		hyperv_report_panic(regs, val, true);
 	return NOTIFY_DONE;
 }
 
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -163,7 +163,7 @@ static inline int cpumask_to_vpset(struc
 	return nr_bank;
 }
 
-void hyperv_report_panic(struct pt_regs *regs, long err);
+void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 void hyperv_cleanup(void);


