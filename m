Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA7C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1A5208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKyEC1FR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgD2Szr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:55:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21181 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2Szo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588186543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIaLFaQGg2nyuh0QfLxI7tJeBjanOQ/yrgdSNuszGiQ=;
        b=SKyEC1FRlfusVwFsPB/rgwOCzhCIyR+GDRa07ZEXfXxrsMC3npdMdrdyDM5ecoTCQAoP1F
        ra+0EZI9CDOoWDx7YOFlNqGvcDqI1PSbrTII6N1lT/UM/S82/+xcEutZbOlvTDo23CmVT0
        Z3cf/fvY4JZ2YSMQ1V7zwErftYeTLPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-IJS93RWjOvOESnVGsPZDxw-1; Wed, 29 Apr 2020 14:55:40 -0400
X-MC-Unique: IJS93RWjOvOESnVGsPZDxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91BFC45F;
        Wed, 29 Apr 2020 18:55:39 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D84CC600EF;
        Wed, 29 Apr 2020 18:55:38 +0000 (UTC)
Date:   Wed, 29 Apr 2020 13:55:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200429185536.5xshpcwtn4be4llh@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428161044.caamvx67t2z4t6vd@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:10:44AM -0500, Josh Poimboeuf wrote:
> > ==> build/x86/0xE0F2ACFF_defconfig/log <==
> > kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame

This one is fixed with the following cleanup:

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] linkage: Convert syscall alias macros to C

There's no need to use inline asm to create ELF alias symbols.
Annotated C function declarations can be used instead.

This also makes the ordering of the ELF symbol table more logical, with
the real function now always coming before the aliases.  This makes it
easier for objtool, objdump and other tools to differentiate them.

This fixes the following warning:

  kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/linkage.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index d796ec20d114..2d7dd6361f91 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -22,18 +22,12 @@
 #define asmlinkage CPP_ASMLINKAGE
 #endif
 
-#ifndef cond_syscall
-#define cond_syscall(x)	asm(				\
-	".weak " __stringify(x) "\n\t"			\
-	".set  " __stringify(x) ","			\
-		 __stringify(sys_ni_syscall))
+#ifndef SYSCALL_ALIAS
+#define SYSCALL_ALIAS(alias, name) __alias(name) typeof(name) alias
 #endif
 
-#ifndef SYSCALL_ALIAS
-#define SYSCALL_ALIAS(alias, name) asm(			\
-	".globl " __stringify(alias) "\n\t"		\
-	".set   " __stringify(alias) ","		\
-		  __stringify(name))
+#ifndef cond_syscall
+#define cond_syscall(x) __weak SYSCALL_ALIAS(x, sys_ni_syscall)
 #endif
 
 #define __page_aligned_data	__section(.data..page_aligned) __aligned(PAGE_SIZE)
-- 
2.21.1


