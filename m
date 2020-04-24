Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61918C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3713F20857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crCr29Iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDXUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:49:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgDXUtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587761382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BCWSJl5PqQm7ozPqGIjNObZ1YK24zpjaMshD3elXd48=;
        b=crCr29IzmPh71CW3c/SDuETRPneKBtjy9S9zXqw9l6CxwuWeseh7Z5lEvmkCj1Nw+nMOH4
        /ibWce+/BhWI5SM0DrtVidLdwqCnBfD29U/K5eSXptUgfhbWaVEiQOxVups03DW74vrM6i
        mrBP8MwbEZ2c5K5Eoy7TwrMckNcpOt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-FmMwr57KOSm2s8R8j82jgA-1; Fri, 24 Apr 2020 16:49:37 -0400
X-MC-Unique: FmMwr57KOSm2s8R8j82jgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F7301800D42;
        Fri, 24 Apr 2020 20:49:36 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6CB71002380;
        Fri, 24 Apr 2020 20:49:35 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] samples/ftrace: Fix asm function ELF annotations
Date:   Fri, 24 Apr 2020 15:49:30 -0500
Message-Id: <86c1cbca67cb353da9f335643ef5fd19bd82988f.1587761369.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable objtool coverage for the sample ftrace modules by adding ELF
annotations to the asm trampoline functions.

  samples/ftrace/ftrace-direct.o: warning: objtool: .text+0x0: unreachabl=
e instruction
  samples/ftrace/ftrace-direct-modify.o: warning: objtool: .text+0x0: unr=
eachable instruction
  samples/ftrace/ftrace-direct-too.o: warning: objtool: .text+0x0: unreac=
hable instruction

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 samples/ftrace/ftrace-direct-modify.c | 4 ++++
 samples/ftrace/ftrace-direct-too.c    | 2 ++
 samples/ftrace/ftrace-direct.c        | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrac=
e-direct-modify.c
index e04229d21475..c13a5bc5095b 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -20,18 +20,22 @@ static unsigned long my_ip =3D (unsigned long)schedul=
e;
=20
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
 "   my_tramp1:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func1\n"
 "	leave\n"
+"	.size		my_tramp1, .-my_tramp1\n"
 "	ret\n"
+"	.type		my_tramp2, @function\n"
 "   my_tramp2:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func2\n"
 "	leave\n"
 "	ret\n"
+"	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
 );
=20
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-d=
irect-too.c
index 27efa5f6ff52..d5c5022be664 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -15,6 +15,7 @@ extern void my_tramp(void *);
=20
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
 "   my_tramp:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
@@ -27,6 +28,7 @@ asm (
 "	popq %rdi\n"
 "	leave\n"
 "	ret\n"
+"	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
=20
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direc=
t.c
index a2e3063bd306..63ca06d42c80 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -13,6 +13,7 @@ extern void my_tramp(void *);
=20
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
 "   my_tramp:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
@@ -21,6 +22,7 @@ asm (
 "	popq %rdi\n"
 "	leave\n"
 "	ret\n"
+"	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
=20
--=20
2.21.1

