Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65305C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C179206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbxUUygc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFELpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:45:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726324AbgFELpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591357509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JFv6v8Td+T3HmglLfbCJPchJWggyzjDyAdEDpA6f+Dk=;
        b=YbxUUygcxISSuG4ulQGtuUnmI+Pq2M0KoIG9PBRhduwN1qvzeOQBEzjDF6jPdPamA8Mbzb
        /pxcbJ+4Y1vDLIxLZkofGb3JX6WlqVFL5BAEajJ5Gfu3zZFSHwODkNOj//5azqUCFOZV/K
        Dlcl6jYpxk8pryTsiibO6fu3UHhip2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-l7ZAIX_qNjuuNhigNCb2LQ-1; Fri, 05 Jun 2020 07:45:05 -0400
X-MC-Unique: l7ZAIX_qNjuuNhigNCb2LQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E948800685;
        Fri,  5 Jun 2020 11:45:03 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F59F10013C0;
        Fri,  5 Jun 2020 11:45:02 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/split_lock: Sanitize userspace and guest error output
Date:   Fri,  5 Jun 2020 07:44:59 -0400
Message-Id: <20200605114459.22200-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two problems with kernel messages in fatal mode that
were found during testing of guests and userspace programs.

The first is that no kernel message is output when the split lock detector
is triggered with a userspace program.  As a result the userspace process
dies from receiving SIGBUS with no indication to the user of what caused
the process to die.

The second problem is that only the first triggering guest causes a kernel
message to be output because the message is output with pr_warn_once().
This also results in a loss of information to the user.

While fixing these I noticed that the same message was being output
three times so I'm cleaning that up too.

Fix fatal mode output, and use consistent messages for fatal and
warn modes for both userspace and guests.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 166d7c355896..463022aa9b7a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1074,10 +1074,14 @@ static void split_lock_init(void)
 	split_lock_verify_msr(sld_state != sld_off);
 }
 
-static void split_lock_warn(unsigned long ip)
+static bool split_lock_warn(unsigned long ip, int fatal)
 {
-	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
-			    current->comm, current->pid, ip);
+	pr_warn_ratelimited("#AC: %s/%d %ssplit_lock trap at address: 0x%lx\n",
+			    current->comm, current->pid,
+			    sld_state == sld_fatal ? "fatal " : "", ip);
+
+	if (sld_state == sld_fatal || fatal)
+		return false;
 
 	/*
 	 * Disable the split lock detection for this task so it can make
@@ -1086,18 +1090,13 @@ static void split_lock_warn(unsigned long ip)
 	 */
 	sld_update_msr(false);
 	set_tsk_thread_flag(current, TIF_SLD);
+	return true;
 }
 
 bool handle_guest_split_lock(unsigned long ip)
 {
-	if (sld_state == sld_warn) {
-		split_lock_warn(ip);
+	if (split_lock_warn(ip, 0))
 		return true;
-	}
-
-	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
-		     current->comm, current->pid,
-		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
 
 	current->thread.error_code = 0;
 	current->thread.trap_nr = X86_TRAP_AC;
@@ -1108,10 +1107,7 @@ EXPORT_SYMBOL_GPL(handle_guest_split_lock);
 
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
-	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
-		return false;
-	split_lock_warn(regs->ip);
-	return true;
+	return split_lock_warn(regs->ip, regs->flags & X86_EFLAGS_AC);
 }
 
 /*
-- 
2.21.3

