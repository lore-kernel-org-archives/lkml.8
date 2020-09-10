Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B99EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA84621D81
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLHZ+M99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIJTrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:47:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28696 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730769AbgIJPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599751512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UQEeRxYOrGoLGB9nBiblTSrr/ssmHsXtBv8lg+YH02U=;
        b=RLHZ+M99unTCxJefSM7gm84nOTOuR4KFNUJmaO62dkN7aC+KXOEkal43q+X0du3nWju9rl
        AlLeLDgUGq15L51TflErnmGHfPVzRBozvSDk8eMFYeOTGT1Dfe0I+IDTbb4ZpVyKMuoB7v
        J3Z1i/j2qF8B1xoAhdaUuIIZcbEyGWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-6uLkSfj2Ny-0totYFoFYqA-1; Thu, 10 Sep 2020 11:25:10 -0400
X-MC-Unique: 6uLkSfj2Ny-0totYFoFYqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07BE318C89CB;
        Thu, 10 Sep 2020 15:25:09 +0000 (UTC)
Received: from treble.redhat.com (ovpn-119-118.rdu2.redhat.com [10.10.119.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62E645D9EF;
        Thu, 10 Sep 2020 15:25:08 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] objtool: Fix noreturn detection for ignored functions
Date:   Thu, 10 Sep 2020 10:24:57 -0500
Message-Id: <5b1e2536cdbaa5246b60d7791b76130a74082c62.1599751464.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a function is annotated with STACK_FRAME_NON_STANDARD, objtool
doesn't validate its code paths.  It also skips sibling call detection
within the function.

But sibling call detection is actually needed for the case where the
ignored function doesn't have any return instructions.  Otherwise
objtool naively marks the function as implicit static noreturn, which
affects the reachability of its callers, resulting in "unreachable
instruction" warnings.

Fix it by just enabling sibling call detection for ignored functions.
The 'insn->ignore' check in add_jump_destinations() is no longer needed
after commit e6da9567959e ("objtool: Don't use ignore flag for fake
jumps").

Fixes the following warning:

  arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_handle_exit_irqoff()+0x142: unreachable instruction

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f24f46..90a66891441a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -619,7 +619,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		if (!is_static_jump(insn))
 			continue;
 
-		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
+		if (insn->offset == FAKE_JUMP_OFFSET)
 			continue;
 
 		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-- 
2.25.4

