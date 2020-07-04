Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8507C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1B7208E4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="UppMAbcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGDUqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:46:47 -0400
Received: from smtp90.iad3b.emailsrvr.com ([146.20.161.90]:55281 "EHLO
        smtp90.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgGDUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593895108;
        bh=O6glA4IE1cHXwt+X4FOTNeQIZuKguXoehyGtlHjClgw=;
        h=From:To:Subject:Date:From;
        b=UppMAbcjv3sCHvOkbSb8mLrTOGjD+LIlfOFUkNyz2F2orOrRKRPf/ajE2yBOf6HcI
         hkHUWgw24svzYvNXC3ouDTj7nHRHAsZbspE8taBlRZs/Zhlw0E3+l3eiVV34wp9b34
         gu8GAA+oz+AQoRZrDBw9ONVJzp859SsBfMqw2m9c=
X-Auth-ID: dpreed@deepplum.com
Received: by smtp20.relay.iad3b.emailsrvr.com (Authenticated sender: dpreed-AT-deepplum.com) with ESMTPSA id 55609A00F6;
        Sat,  4 Jul 2020 16:38:27 -0400 (EDT)
From:   "David P. Reed" <dpreed@deepplum.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "David P. Reed" <dpreed@deepplum.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] Force all cpus to exit VMX root operation on crash/panic reliably
Date:   Sat,  4 Jul 2020 16:38:09 -0400
Message-Id: <20200704203809.76391-4-dpreed@deepplum.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704203809.76391-1-dpreed@deepplum.com>
References: <20200629214956.GA12962@linux.intel.com>
 <20200704203809.76391-1-dpreed@deepplum.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 64370b40-6b65-46c7-a817-521193c95a46-4-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the logic during crash/panic reboot on Intel processors that
can support VMX operation to ensure that all processors are not
in VMX root operation. Prior code made optimistic assumptions
about other cpus that would leave other cpus in VMX root operation
depending on timing of crash/panic reboot.
Builds on cpu_ermergency_vmxoff() and __cpu_emergency_vmxoff() created
in a prior patch.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: David P. Reed <dpreed@deepplum.com>
---
 arch/x86/kernel/reboot.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0ec7ced727fe..c8e96ba78efc 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -543,24 +543,18 @@ static void emergency_vmx_disable_all(void)
 	 * signals when VMX is enabled.
 	 *
 	 * We can't take any locks and we may be on an inconsistent
-	 * state, so we use NMIs as IPIs to tell the other CPUs to disable
-	 * VMX and halt.
+	 * state, so we use NMIs as IPIs to tell the other CPUs to exit
+	 * VMX root operation and halt.
 	 *
 	 * For safety, we will avoid running the nmi_shootdown_cpus()
 	 * stuff unnecessarily, but we don't have a way to check
-	 * if other CPUs have VMX enabled. So we will call it only if the
-	 * CPU we are running on has VMX enabled.
-	 *
-	 * We will miss cases where VMX is not enabled on all CPUs. This
-	 * shouldn't do much harm because KVM always enable VMX on all
-	 * CPUs anyway. But we can miss it on the small window where KVM
-	 * is still enabling VMX.
+	 * if other CPUs might be in VMX root operation.
 	 */
-	if (cpu_has_vmx() && cpu_vmx_enabled()) {
-		/* Disable VMX on this CPU. */
-		cpu_vmxoff();
+	if (cpu_has_vmx()) {
+		/* Safely force out of VMX root operation on this CPU. */
+		__cpu_emergency_vmxoff();
 
-		/* Halt and disable VMX on the other CPUs */
+		/* Halt and exit VMX root operation on the other CPUs */
 		nmi_shootdown_cpus(vmxoff_nmi);
 
 	}
-- 
2.26.2

