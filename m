Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE368C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA28420714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwf4vjvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgDYKDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:03:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbgDYKDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8oICFkq/vVJCy/zBhI+k3DypCtF86mBFwST7Zqu/W4=;
        b=fwf4vjvCOxQNwbAXWHrZGQusz0qmq1t3uw/r2Vf13kOOExbS8k8+Fy2M4ptnMo7g2HkR9A
        ryQlssrkbe7l8jGNwE2q/YXKPKohS0fGYPRk384krnyniGH9J6fXi8s/gSyU4dCUdUSi/8
        oEi5djRBCHWJFU66f310g6eN1uBLW70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-zZCSfQxwNryQKSXju1aHjg-1; Sat, 25 Apr 2020 06:03:27 -0400
X-MC-Unique: zZCSfQxwNryQKSXju1aHjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FCFE80B709;
        Sat, 25 Apr 2020 10:03:25 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FCD760623;
        Sat, 25 Apr 2020 10:03:24 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 04/11] x86/entry/64: Fix unwind hints in __switch_to_asm()
Date:   Sat, 25 Apr 2020 05:03:03 -0500
Message-Id: <03d0411920d10f7418f2e909210d8e9a3b2ab081.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/x86/entry/entry_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6b0d679efd6b..34a588950fe1 100644
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

