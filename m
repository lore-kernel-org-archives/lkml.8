Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA97C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1EE206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9hdq+lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgFKSec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgFKSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:34:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790CAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:34:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e192so7501657ybf.17
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=COXpdfYzdd6T2PLhteaDM1tUQElcqbQJ6tIcGD3EDRg=;
        b=o9hdq+lDTGdQ7pL6eS2ne+STn2zEfYAr6Sd9feD0gHCYpOzUsbmVOKpoiBtQP4hRhP
         0vd+WlglqyfcLJ9dwxfzJSViO0X4kGcUGdetOJVW7F8FeiZ3juWzPuV4sYw8rkN4ZUFy
         ylPg5u3vQGVe4MIfSCCWw6tJHtuBZQwPWcIIZrmAC2kmzRmTpimzaiVMSBkDHqWhdaOb
         ltCNz/98+IdgtXrP5J6B/vhq33ooa+nN/IByEuPkV65mBCzcpLEHo9u945AUVWVPhjSJ
         vXHubQ1UlbdcVVpDy6aFT+gAJEiM3RnQ/3xkqa7FelQYD7aZpbTIWafK9jGSDpUUzR1q
         HAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=COXpdfYzdd6T2PLhteaDM1tUQElcqbQJ6tIcGD3EDRg=;
        b=NbisULiaOD08I4CflxApm2xjp/ezUXpeNvd1H/7FcB+cjYCSOnPc+vJtnWo1lsnNzw
         DonXsrMkix7kDKIUMnUCA9bQ/nkIZX2hvKz/G/FmyoJtas+xOpG6gB77EKpPY6fgLcaQ
         93nRCTpG9gTAgGmTqcKi8gq4IrGpaZxj3PB1s8nLJE+aRg1+tvW6fWAYroON3YAGbUms
         hho5qEn+mdNtWw6RozGb8AZXcV2SqB+1k2DHFCdS1bVNX2Azz0F/ggo5xMtvwDvaQ5N9
         WpmiKvOfA23kCgkurLBCgEgT5isej9ucokg3fRWZNKDvc2O6OwfSjZqPs2KbZIbHGo5r
         6ZKw==
X-Gm-Message-State: AOAM533U6W6wII4ArxIYWpHUeTE7G1PS3zA2RtaqTxkS8fMrlShDLbhv
        xUessvGIDpgrb0A357U0LAPw/lGC4Q==
X-Google-Smtp-Source: ABdhPJycnzJzYBE1uCXDWobHSfMgy7yeM2Oc8KQ/6LbE+KEXMBUsHdFKo8h/UNp7B8daeNUFZH40Nkv7kQ==
X-Received: by 2002:a25:3103:: with SMTP id x3mr17950241ybx.36.1591900468187;
 Thu, 11 Jun 2020 11:34:28 -0700 (PDT)
Date:   Thu, 11 Jun 2020 18:32:35 +0000
Message-Id: <20200611183235.37508-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH] riscv/atomic: Fix sign extension for RV64I
From:   Nathan Huckleberry <nhuck@google.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The argument passed to cmpxchg is not guaranteed to be sign
extended, but lr.w sign extends on RV64I. This makes cmpxchg
fail on clang built kernels when __old is negative.

To fix this, we just cast __old to long which sign extends on
RV64I. With this fix, clang built RISC-V kernels now boot.

Link: https://github.com/ClangBuiltLinux/linux/issues/867
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 arch/riscv/include/asm/cmpxchg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index d969bab4a26b..262e5bbb2776 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -179,7 +179,7 @@
 			"	bnez %1, 0b\n"				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
+			: "rJ" ((long)__old), "rJ" (__new)		\
 			: "memory");					\
 		break;							\
 	case 8:								\
@@ -224,7 +224,7 @@
 			RISCV_ACQUIRE_BARRIER				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
+			: "rJ" ((long)__old), "rJ" (__new)		\
 			: "memory");					\
 		break;							\
 	case 8:								\
@@ -270,7 +270,7 @@
 			"	bnez %1, 0b\n"				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
+			: "rJ" ((long)__old), "rJ" (__new)		\
 			: "memory");					\
 		break;							\
 	case 8:								\
@@ -316,7 +316,7 @@
 			"	fence rw, rw\n"				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
+			: "rJ" ((long)__old), "rJ" (__new)		\
 			: "memory");					\
 		break;							\
 	case 8:								\
-- 
2.27.0.278.ge193c7cf3a9-goog

