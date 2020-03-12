Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773F82073E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJwpGBBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgCLRbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:31:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45182 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgCLRbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVZaKhTpMlXPAfPxhwtwYxcRIn9IOGezRlEEOxKaFu4=;
        b=cJwpGBBYAFaTjMlGyZJJtk8BBeGc/oU3coCOhxMRxyzAJCrb0PBoXyocCbZRE29rCIfMxv
        kCZovwvesX2vvalokumWgNBrPc7KhvkXefKQQp8KYJOONWyxlSSWMMqYOQFenU+wRTs+9T
        KVJGUEI7DN/4ZJf2qgdoLcALZGyEnKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-i6VSTGa5Mom_ULN6kg7zXQ-1; Thu, 12 Mar 2020 13:31:01 -0400
X-MC-Unique: i6VSTGa5Mom_ULN6kg7zXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51EC5802CB8;
        Thu, 12 Mar 2020 17:30:59 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 235D660BEC;
        Thu, 12 Mar 2020 17:30:58 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 05/14] x86/entry/64: Fix unwind hints in __switch_to_asm()
Date:   Thu, 12 Mar 2020 12:30:24 -0500
Message-Id: <8dfd5f7f8cd8bb7a3704b8fb9d615c6b115b33fa.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNWIND_HINT_FUNC has some limitations: specifically, it doesn't reset
all the registers to undefined.  This causes objtool to get confused
about the RBP push in __switch_to_asm(), resulting in bad ORC data.

While __switch_to_asm() does do some stack magic, it's otherwise a
normal callable-from-C function, so just annotate it as a function,
which makes objtool happy and allows it to produces the correct hints
automatically.

Fixes: 8c1f75587a18 ("x86/entry/64: Add unwind hint annotations")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/entry_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6a21d7bc60df..5d6dac54e487 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -279,8 +279,7 @@ SYM_CODE_END(entry_SYSCALL_64)
  * %rdi: prev task
  * %rsi: next task
  */
-SYM_CODE_START(__switch_to_asm)
-	UNWIND_HINT_FUNC
+SYM_FUNC_START(__switch_to_asm)
 	/*
 	 * Save callee-saved registers
 	 * This must match the order in inactive_task_frame
@@ -321,7 +320,7 @@ SYM_CODE_START(__switch_to_asm)
 	popq	%rbp
=20
 	jmp	__switch_to
-SYM_CODE_END(__switch_to_asm)
+SYM_FUNC_END(__switch_to_asm)
=20
 /*
  * A newly forked process directly context switches into this address.
--=20
2.21.1

