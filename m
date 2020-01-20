Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9577C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8198A24125
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUbBarYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgATSOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:14:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40570 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727465AbgATSO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579544068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J71L9QdvENUhS9kjik2O6eWrK+QzMj6JCklsr38AS4E=;
        b=HUbBarYyBaNQcNNR2hD5HN08vs2PoyxORV6oMEAAfOG+N5VFgHNvjrjy0xvC3mfzKdroZ9
        1WgI2ZO9cY8qFAAEoGKEA2S8VO0cbaKIlyuPPFAyV3xGcvmcVfqMGP5dsZ2bV+Svk8t4ft
        vVMTwITvljRYczFCU+f28l5V1xatKNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-ms-BOgNoNcqCNc_msDZ9Jg-1; Mon, 20 Jan 2020 13:14:24 -0500
X-MC-Unique: ms-BOgNoNcqCNc_msDZ9Jg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BBFE800D41;
        Mon, 20 Jan 2020 18:14:23 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-19.rdu2.redhat.com [10.10.125.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33A1E1001B30;
        Mon, 20 Jan 2020 18:14:22 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH 2/3] objtool: Fix ARCH=x86_64 build error
Date:   Mon, 20 Jan 2020 12:14:08 -0600
Message-Id: <d5d11370ae116df6c653493acd300ec3d7f5e925.1579543924.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1579543924.git.jpoimboe@redhat.com>
References: <cover.1579543924.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shile Zhang <shile.zhang@linux.alibaba.com>

Building objtool with ARCH=3Dx86_64 fails with:

   $make ARCH=3Dx86_64 -C tools/objtool
   ...
     CC       arch/x86/decode.o
   arch/x86/decode.c:10:22: fatal error: asm/insn.h: No such file or dire=
ctory
    #include <asm/insn.h>
                         ^
   compilation terminated.
   mv: cannot stat =E2=80=98arch/x86/.decode.o.tmp=E2=80=99: No such file=
 or directory
   make[2]: *** [arch/x86/decode.o] Error 1
   ...

The root cause is that the command-line variable 'ARCH' cannot be
overridden.  It can be replaced by 'SRCARCH', which is defined in
'tools/scripts/Makefile.arch'.

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index d2a19b0bc05a..ee08aeff30a1 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -2,10 +2,6 @@
 include ../scripts/Makefile.include
 include ../scripts/Makefile.arch
=20
-ifeq ($(ARCH),x86_64)
-ARCH :=3D x86
-endif
-
 # always use the host compiler
 HOSTAR	?=3D ar
 HOSTCC	?=3D gcc
@@ -33,7 +29,7 @@ all: $(OBJTOOL)
=20
 INCLUDES :=3D -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/arch/$(ARCH)/include
+	    -I$(srctree)/tools/arch/$(SRCARCH)/include
 WARNINGS :=3D $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wn=
o-packed
 CFLAGS   :=3D -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(=
LIBELF_FLAGS)
 LDFLAGS  +=3D $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
--=20
2.21.1

