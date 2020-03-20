Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A0DC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CD220409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCTUuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:50:09 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:35623 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbgCTUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:50:06 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 16:50:04 EDT
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 20 Mar 2020 13:34:56 -0700
Received: from localhost.localdomain (unknown [10.118.101.94])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 72B4BB1D85;
        Fri, 20 Mar 2020 16:35:00 -0400 (EDT)
From:   Alexey Makhalov <amakhalov@vmware.com>
To:     <linux-x86_64@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Alexey Makhalov" <amakhalov@vmware.com>
Subject: [PATCH 2/5] x86/vmware: Remove vmware_sched_clock_setup()
Date:   Fri, 20 Mar 2020 20:34:40 +0000
Message-ID: <20200320203443.27742-3-amakhalov@vmware.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20200320203443.27742-1-amakhalov@vmware.com>
References: <20200320203443.27742-1-amakhalov@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: amakhalov@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move cyc2ns setup logic to separate function.
This separation will allow to use cyc2ns mult/shift pair
not only for the sched_clock but also for other clocks
such as steal_clock.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d280560fd75e..efb22fa76ba4 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -122,7 +122,7 @@ static unsigned long long notrace vmware_sched_clock(void)
 	return ns;
 }
 
-static void __init vmware_sched_clock_setup(void)
+static void __init vmware_cyc2ns_setup(void)
 {
 	struct cyc2ns_data *d = &vmware_cyc2ns;
 	unsigned long long tsc_now = rdtsc();
@@ -132,8 +132,7 @@ static void __init vmware_sched_clock_setup(void)
 	d->cyc2ns_offset = mul_u64_u32_shr(tsc_now, d->cyc2ns_mul,
 					   d->cyc2ns_shift);
 
-	pv_ops.time.sched_clock = vmware_sched_clock;
-	pr_info("using sched offset of %llu ns\n", d->cyc2ns_offset);
+	pr_info("using clock offset of %llu ns\n", d->cyc2ns_offset);
 }
 
 static void __init vmware_paravirt_ops_setup(void)
@@ -141,8 +140,14 @@ static void __init vmware_paravirt_ops_setup(void)
 	pv_info.name = "VMware hypervisor";
 	pv_ops.cpu.io_delay = paravirt_nop;
 
-	if (vmware_tsc_khz && vmw_sched_clock)
-		vmware_sched_clock_setup();
+	if (vmware_tsc_khz == 0)
+		return;
+
+	vmware_cyc2ns_setup();
+
+	if (vmw_sched_clock)
+		pv_ops.time.sched_clock = vmware_sched_clock;
+
 }
 #else
 #define vmware_paravirt_ops_setup() do {} while (0)
-- 
2.14.2

