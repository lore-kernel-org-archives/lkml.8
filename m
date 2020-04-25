Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E189AC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEE22071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0u14YLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgDYKDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:03:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26090 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726076AbgDYKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTQeurswtsRMklK9POrTxGp038FliTq+3jZmxbn4W4I=;
        b=J0u14YLt6KIynHn5qogEWFXSzHMX93vz1wLuA5ocF/r6sDGfsYcVwTcSGYLAp/7iCr6lPs
        QRNcmm7rgIMrXWPmtJMeCHNHF/eR42JU/yat4xtXYiUlLVazHLwtceWkq5rglio6LV9/cH
        9nEG1PDqz1rlZOWZDOueuTQC/f0rfIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-UbYHQmPpO-iYF2_WK1QRbg-1; Sat, 25 Apr 2020 06:03:25 -0400
X-MC-Unique: UbYHQmPpO-iYF2_WK1QRbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 233CF107ACCA;
        Sat, 25 Apr 2020 10:03:24 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A54E46061E;
        Sat, 25 Apr 2020 10:03:22 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 03/11] x86/entry/64: Fix unwind hints in kernel exit path
Date:   Sat, 25 Apr 2020 05:03:02 -0500
Message-Id: <60ea8f562987ed2d9ace2977502fe481c0d7c9a0.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In swapgs_restore_regs_and_return_to_usermode, after the stack is
switched to the trampoline stack, the existing UNWIND_HINT_REGS hint is
no longer valid, which can result in the following ORC unwinder warning:

  WARNING: can't dereference registers at 000000003aeb0cdd for ip swapgs_=
restore_regs_and_return_to_usermode+0x93/0xa0

For full correctness, we could try to add complicated unwind hints so
the unwinder could continue to find the registers, but when when it's
this close to kernel exit, unwind hints aren't really needed anymore and
it's fine to just use an empty hint which tells the unwinder to stop.

For consistency, also move the UNWIND_HINT_EMPTY in
entry_SYSCALL_64_after_hwframe to a similar location.

Fixes: 3e3b9293d392 ("x86/entry/64: Return to userspace from the trampoli=
ne stack")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Reported-by: Dave Jones <dsj@fb.com>
Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reported-by: Joe Mario <jmario@redhat.com>
Reported-by: Jann Horn <jannh@google.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/x86/entry/entry_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0e9504fabe52..6b0d679efd6b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -249,7 +249,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L=
_GLOBAL)
 	 */
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
-	UNWIND_HINT_EMPTY
 	POP_REGS pop_rdi=3D0 skip_r11rcx=3D1
=20
 	/*
@@ -258,6 +257,7 @@ syscall_return_via_sysret:
 	 */
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
+	UNWIND_HINT_EMPTY
=20
 	pushq	RSP-RDI(%rdi)	/* RSP */
 	pushq	(%rdi)		/* RDI */
@@ -637,6 +637,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_use=
rmode, SYM_L_GLOBAL)
 	 */
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
+	UNWIND_HINT_EMPTY
=20
 	/* Copy the IRET frame to the trampoline stack. */
 	pushq	6*8(%rdi)	/* SS */
--=20
2.21.1

