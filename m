Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3D9C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7D20736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LW+1i8Mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgCLRbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:31:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29438 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726637AbgCLRbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9Yg10kxsk2gesg/rMdLup8Sz07xlxVNj8h8+4wF8oQ=;
        b=LW+1i8Mt52AjAiKfFLcRlyeSIP7aZu/6NgumEZkUClHHABjuDX9kNuKoDXlEpK9knhTRZe
        B6U/EGhxoBne5OW09jz6jmc2oeQM5I0qfKPLjBhcmwdymk8N1Qxs68mwT5px6hJKhEV2Qm
        QlD4OhSDK1kG5KyRQjDfeC2IdACPSdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-g7Y8hSmtMAqI0UJA1wnorA-1; Thu, 12 Mar 2020 13:30:59 -0400
X-MC-Unique: g7Y8hSmtMAqI0UJA1wnorA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECADA8024FE;
        Thu, 12 Mar 2020 17:30:57 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6A0560BEC;
        Thu, 12 Mar 2020 17:30:54 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Joe Mario <jmario@redhat.com>
Subject: [PATCH 04/14] x86/entry/64: Fix unwind hints in kernel exit path
Date:   Thu, 12 Mar 2020 12:30:23 -0500
Message-Id: <58c05bf0a9f06ac7f2ed6df5e369d3276ccec33c.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/entry_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f2bb91e87877..6a21d7bc60df 100644
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

