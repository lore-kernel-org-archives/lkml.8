Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B787C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F015720B80
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795803;
	bh=0k4H7Q91aKB86OEDNFKolR/4CT2CooJBHkKZWNLbmzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Crcx6H+cWFUG4nFPH9C9YgNJ/9hMtz7C5WBdIR2KeEXHiXute9zofiahuV7RXclU4
	 VbhJf2Yee0GcV28iHHhWPB4w0RHGh2bahFHV93+pkGsuuEcKE7scRVdKMy0xAefdJH
	 tVmp+X+4mQqxE3tgsLZtIEu3aQXMrsHr7KBKm+h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGCRDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgGCRDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:03 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE5A2088E;
        Fri,  3 Jul 2020 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795783;
        bh=0k4H7Q91aKB86OEDNFKolR/4CT2CooJBHkKZWNLbmzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hu4PR9XikPauhuDQ+wvF9gKVgvvvIMe6HEQ01uhCDIlYo7v8//dFQA0h2Oop1bZLm
         /8DsAjZxwObD1qIM8k3K8a8ElZE3qQSTR/1/yZ4KbsVf3kEXpS4aHVVWDdYy+rbHlx
         KKaII9h09eOpNfzQCihfVsYcgqw0qw5JJISdOj8U=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH entry v2 2/6] x86/entry, selftests: Further improve user entry sanity checks
Date:   Fri,  3 Jul 2020 10:02:54 -0700
Message-Id: <881de09e786ab93ce56ee4a2437ba2c308afe7a9.1593795633.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593795633.git.luto@kernel.org>
References: <cover.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chasing down a Xen bug caused me to realize that the new entry sanity
checks are still fairly weak.  Add some more checks.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/common.c                  | 19 +++++++++++++++++++
 tools/testing/selftests/x86/syscall_nt.c | 11 +++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f392a8bcd1c3..e83b3f14897c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -49,6 +49,23 @@
 static void check_user_regs(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
+		/*
+		 * Make sure that the entry code gave us a sensible EFLAGS
+		 * register.  Native because we want to check the actual CPU
+		 * state, not the interrupt state as imagined by Xen.
+		 */
+		unsigned long flags = native_save_fl();
+		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
+				      X86_EFLAGS_NT));
+
+		/* We think we came from user mode. Make sure pt_regs agrees. */
+		WARN_ON_ONCE(!user_mode(regs));
+
+		/*
+		 * All entries from user mode (except #DF) should be on the
+		 * normal thread stack and should have user pt_regs in the
+		 * correct location.
+		 */
 		WARN_ON_ONCE(!on_thread_stack());
 		WARN_ON_ONCE(regs != task_pt_regs(current));
 	}
@@ -577,6 +594,7 @@ SYSCALL_DEFINE0(ni_syscall)
 bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
+		check_user_regs(regs);
 		enter_from_user_mode();
 		return false;
 	}
@@ -710,6 +728,7 @@ void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
  */
 void noinstr idtentry_enter_user(struct pt_regs *regs)
 {
+	check_user_regs(regs);
 	enter_from_user_mode();
 }
 
diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index 970e5e14d96d..a108b80dd082 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -81,5 +81,16 @@ int main(void)
 	printf("[RUN]\tSet NT|AC|TF and issue a syscall\n");
 	do_it(X86_EFLAGS_NT | X86_EFLAGS_AC | X86_EFLAGS_TF);
 
+	/*
+	 * Now try DF.  This is evil and it's plausible that we will crash
+	 * glibc, but glibc would have to do something rather surprising
+	 * for this to happen.
+	 */
+	printf("[RUN]\tSet DF and issue a syscall\n");
+	do_it(X86_EFLAGS_DF);
+
+	printf("[RUN]\tSet TF|DF and issue a syscall\n");
+	do_it(X86_EFLAGS_TF | X86_EFLAGS_DF);
+
 	return nerrs == 0 ? 0 : 1;
 }
-- 
2.25.4

