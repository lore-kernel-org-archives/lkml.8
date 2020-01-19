Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67106C33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3814720714
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YZcpiFLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgASDp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 22:45:27 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39855 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgASDp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:45:27 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so30155378ioh.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 19:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iN+0dT0AtvYpl1GzQb+Z68gF7cClxoyVzgffCez1D2Q=;
        b=YZcpiFLRB7Y42w1n9UVzr+1Jn8efyHe8VI/Pfvh9uZbMkPiw/n5iTr6YaY9GdeJFtT
         lJJKCTw0gmzayyNRwEuZSHqH8hPN5OsIpL8r90vipqb7n6FPR8gNZYzkXfli+nJ0aLDy
         Q/Fmj4KhgxI7Au6SSwzf/waYI+JamnXVDVxObdDW14l2dZUnyT9ykDsvv4sfRG6XmJXp
         983wlMGkvUcBXNTl+nBQMxorOnSn99hToTRKxdTdyl3WUaItMAD380170I3WndZvszsS
         +gtXmFsqy11Cs2ihXRc+JRxhMRPktpPg41/gXUTeqNrmKNkcQ80LxfsRXURuuBg0zc5X
         WwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iN+0dT0AtvYpl1GzQb+Z68gF7cClxoyVzgffCez1D2Q=;
        b=tUnT8z4xRD4VDzmXA4uJE3i/pCTgVjEhh9m9hd9YLcZREJAMrWRukTXEfz6fgiuhLx
         IW5pREynFxKHWKdmhW3bwBu7WVOqIUJkkvyCjpHFhCcxvOD0zhRjxc3/SEixNvmGtygU
         sFjGlusMConKCCcONnxN4hQWptlPE0isz7QWTmzkyI2p9LrVkLvHdk+dZV5md+aKhOGN
         fwr4m7clWodcLf0hxMqfjAX+ffErei5VTrGpkaqg8Z4Ke/RaIxXqADZgcZgJbs+05TNT
         5A5cka/elWoNUWu4zUnQtctwbJwvh/zaWF9bwxNaZ8rdXHwuzVq1Qy4Oiy7cTyWChFaR
         jUqA==
X-Gm-Message-State: APjAAAURVAmWZ9+x/TzGZRNIXxmOmf4q/lDflshWIoYaWxw9xoNpcF/L
        F5XkrZCuOcQHKCSny68CoMkRUA==
X-Google-Smtp-Source: APXvYqwkddTdFbxzbi0eKTIRo8TYya7y6TPAY/oNziITaaaN9DAFDnvKd9TXrwdgag9dV8ihyHaldA==
X-Received: by 2002:a5e:8f41:: with SMTP id x1mr38308114iop.113.1579405525812;
        Sat, 18 Jan 2020 19:45:25 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id g62sm9797127ile.39.2020.01.18.19.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 19:45:25 -0800 (PST)
Date:   Sat, 18 Jan 2020 19:45:22 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Olof Johansson <olof@lixom.net>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Less inefficient gcc tishift helpers (and export
 their symbols)
In-Reply-To: <20191217040631.91886-1-olof@lixom.net>
Message-ID: <alpine.DEB.2.21.9999.2001181938470.55560@viisi.sifive.com>
References: <20191217003057.39300-1-olof@lixom.net> <20191217040631.91886-1-olof@lixom.net>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019, Olof Johansson wrote:

> The existing __lshrti3 was really inefficient, and the other two helpers
> are also needed to compile some modules.
> 
> Add the missing versions, and export all of the symbols like arm64
> already does.
> 
> This fixes a build break triggered by ubsan:
> 
> riscv64-unknown-linux-gnu-ld: lib/ubsan.o: in function `.L2':
> ubsan.c:(.text.unlikely+0x38): undefined reference to `__ashlti3'
> riscv64-unknown-linux-gnu-ld: ubsan.c:(.text.unlikely+0x42): undefined reference to `__ashrti3'
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Thanks Olof.  I modified the patch description to note that the code is 
based on libgcc per our off-list discussion, and to use 
SYM_PROC_ENTRY/EXIT per commit ffedeeb780dc5 ("linkage: Introduce new 
macros for assembler symbols"), and have queued the following patch.


- Paul


From: Olof Johansson <olof@lixom.net>
Date: Mon, 16 Dec 2019 20:06:31 -0800
Subject: [PATCH] riscv: Less inefficient gcc tishift helpers (and export their
 symbols)

The existing __lshrti3 was really inefficient, and the other two helpers
are also needed to compile some modules.

Add the missing versions, and export all of the symbols like arm64
already does.

This code is based on the assembly generated by libgcc builds.

This fixes a build break triggered by ubsan:

riscv64-unknown-linux-gnu-ld: lib/ubsan.o: in function `.L2':
ubsan.c:(.text.unlikely+0x38): undefined reference to `__ashlti3'
riscv64-unknown-linux-gnu-ld: ubsan.c:(.text.unlikely+0x42): undefined reference to `__ashrti3'

Signed-off-by: Olof Johansson <olof@lixom.net>
[paul.walmsley@sifive.com: use SYM_FUNC_{START,END} instead of ENTRY/ENDPROC; note
 libgcc origin]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/asm-prototypes.h |  4 ++
 arch/riscv/lib/tishift.S                | 75 +++++++++++++++++++------
 2 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index dd62b691c443..27e005fca584 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -5,4 +5,8 @@
 #include <linux/ftrace.h>
 #include <asm-generic/asm-prototypes.h>
 
+long long __lshrti3(long long a, int b);
+long long __ashrti3(long long a, int b);
+long long __ashlti3(long long a, int b);
+
 #endif /* _ASM_RISCV_PROTOTYPES_H */
diff --git a/arch/riscv/lib/tishift.S b/arch/riscv/lib/tishift.S
index 15f9d54c7db6..ef90075c4b0a 100644
--- a/arch/riscv/lib/tishift.S
+++ b/arch/riscv/lib/tishift.S
@@ -4,34 +4,73 @@
  */
 
 #include <linux/linkage.h>
+#include <asm-generic/export.h>
 
-ENTRY(__lshrti3)
+SYM_FUNC_START(__lshrti3)
 	beqz	a2, .L1
 	li	a5,64
 	sub	a5,a5,a2
-	addi	sp,sp,-16
 	sext.w	a4,a5
 	blez	a5, .L2
 	sext.w	a2,a2
-	sll	a4,a1,a4
 	srl	a0,a0,a2
-	srl	a1,a1,a2
+	sll	a4,a1,a4
+	srl	a2,a1,a2
 	or	a0,a0,a4
-	sd	a1,8(sp)
-	sd	a0,0(sp)
-	ld	a0,0(sp)
-	ld	a1,8(sp)
-	addi	sp,sp,16
-	ret
+	mv	a1,a2
 .L1:
 	ret
 .L2:
-	negw	a4,a4
-	srl	a1,a1,a4
-	sd	a1,0(sp)
-	sd	zero,8(sp)
-	ld	a0,0(sp)
-	ld	a1,8(sp)
-	addi	sp,sp,16
+	negw	a0,a4
+	li	a2,0
+	srl	a0,a1,a0
+	mv	a1,a2
+	ret
+SYM_FUNC_END(__lshrti3)
+EXPORT_SYMBOL(__lshrti3)
+
+SYM_FUNC_START(__ashrti3)
+	beqz	a2, .L3
+	li	a5,64
+	sub	a5,a5,a2
+	sext.w	a4,a5
+	blez	a5, .L4
+	sext.w	a2,a2
+	srl	a0,a0,a2
+	sll	a4,a1,a4
+	sra	a2,a1,a2
+	or	a0,a0,a4
+	mv	a1,a2
+.L3:
+	ret
+.L4:
+	negw	a0,a4
+	srai	a2,a1,0x3f
+	sra	a0,a1,a0
+	mv	a1,a2
+	ret
+SYM_FUNC_END(__ashrti3)
+EXPORT_SYMBOL(__ashrti3)
+
+SYM_FUNC_START(__ashlti3)
+	beqz	a2, .L5
+	li	a5,64
+	sub	a5,a5,a2
+	sext.w	a4,a5
+	blez	a5, .L6
+	sext.w	a2,a2
+	sll	a1,a1,a2
+	srl	a4,a0,a4
+	sll	a2,a0,a2
+	or	a1,a1,a4
+	mv	a0,a2
+.L5:
+	ret
+.L6:
+	negw	a1,a4
+	li	a2,0
+	sll	a1,a0,a1
+	mv	a0,a2
 	ret
-ENDPROC(__lshrti3)
+SYM_FUNC_END(__ashlti3)
+EXPORT_SYMBOL(__ashlti3)
-- 
2.25.0.rc2


