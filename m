Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84BDC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825D520714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euDoeWWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDYKDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:03:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26800 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDYKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlhDMWII8SsE3aQs5qJ4MI4Q8CJwVI/eRFmefyOp2VQ=;
        b=euDoeWWI256rC5/gMuZ0gmHTQp3GoPpMiAzS4TpjYmVw/eLKuSjGG1NZqkjP+syb10ksSE
        AwG2zcNXxzXODTHrS6P0cMNJJajlEzgdFU84nOuPcUEt9ykmvM8tWE2XkW9JC3KBpt0V+9
        pq+ATn3K0INSmADkFWjGb094NmSNhl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-goB7E3gzPW-vkGoXw0swLQ-1; Sat, 25 Apr 2020 06:03:28 -0400
X-MC-Unique: goB7E3gzPW-vkGoXw0swLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C554B10052E4;
        Sat, 25 Apr 2020 10:03:26 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BE0160624;
        Sat, 25 Apr 2020 10:03:25 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 05/11] x86/entry/64: Fix unwind hints in rewind_stack_do_exit()
Date:   Sat, 25 Apr 2020 05:03:04 -0500
Message-Id: <68c33e17ae5963854916a46f522624f8e1d264f2.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

The leaq instruction in rewind_stack_do_exit moves the stack pointer
directly below the pt_regs at the top of the task stack before calling
do_exit(). Tell the unwinder to expect pt_regs.

Fixes: 8c1f75587a18 ("x86/entry/64: Add unwind hint annotations")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 34a588950fe1..9fe0d5cad8e4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1739,7 +1739,7 @@ SYM_CODE_START(rewind_stack_do_exit)
=20
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
 	leaq	-PTREGS_SIZE(%rax), %rsp
-	UNWIND_HINT_FUNC sp_offset=3DPTREGS_SIZE
+	UNWIND_HINT_REGS
=20
 	call	do_exit
 SYM_CODE_END(rewind_stack_do_exit)
--=20
2.21.1

