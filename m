Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A74C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BD620409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgCTUuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:50:07 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:58152 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgCTUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:50:06 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 20 Mar 2020 13:34:57 -0700
Received: from localhost.localdomain (unknown [10.118.101.94])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 9AEECB28A1;
        Fri, 20 Mar 2020 16:35:01 -0400 (EDT)
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
Subject: [PATCH 5/5] x86/vmware: Use bool type for vmw_sched_clock
Date:   Fri, 20 Mar 2020 20:34:43 +0000
Message-ID: <20200320203443.27742-6-amakhalov@vmware.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20200320203443.27742-1-amakhalov@vmware.com>
References: <20200320203443.27742-1-amakhalov@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: amakhalov@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be aligned with other bool variables.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 0c65d661d88b..54e57931051d 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -122,14 +122,14 @@ static unsigned long vmware_get_tsc_khz(void)
 
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
-static int vmw_sched_clock __initdata = 1;
+static bool vmw_sched_clock __initdata = true;
 static DEFINE_PER_CPU_DECRYPTED(struct vmware_steal_time, steal_time) __aligned(64);
 static bool has_steal_clock;
 static bool steal_acc __initdata = true; /* steal time accounting */
 
 static __init int setup_vmw_sched_clock(char *s)
 {
-	vmw_sched_clock = 0;
+	vmw_sched_clock = false;
 	return 0;
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
-- 
2.14.2

