Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B3DC2BA12
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4042078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759647;
	bh=O8o1VsBoFBKPmE2ac8EKDiK2TUahPmQesISu0qFsf1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FsXfPorp3vfHY1itfYRML1k0KKxnmZo95Iuety/CvT6xG+NXhf5gqptLF5njnhA6G
	 N7wa/RQyPFwQ5MAo+SYQmOdr3/WdXezbNOxq5lwpSlsVIQJ9dK59z89ah5IAmQ+Evj
	 UluAK7yolfKoS0wgHmBJnaH+xqLVf/0Fu2dTUPTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389761AbgDAQr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389834AbgDAQrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:47:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C38212CC;
        Wed,  1 Apr 2020 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759637;
        bh=O8o1VsBoFBKPmE2ac8EKDiK2TUahPmQesISu0qFsf1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoXY4At9H+IM91F/X0Z/WTqri++zd3l8AgI4K+CLRAVkFulMpG6U7JY/uUq3zDoQf
         kCEaxTTn8oJhlp5fO1Sg1/5xIPGYrGR1RMTty2dG2p7bD5viqyb7ONnIfE7Lh1aIjb
         Htz7OY9qJSxIJJmrykq/8bcBesuA8EeT8LKtwzXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4.14 143/148] arm64: alternative: fix build with clang integrated assembler
Date:   Wed,  1 Apr 2020 18:18:55 +0200
Message-Id: <20200401161605.836956481@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilie Halip <ilie.halip@gmail.com>

commit 6f5459da2b8736720afdbd67c4bd2d1edba7d0e3 upstream.

Building an arm64 defconfig with clang's integrated assembler, this error
occurs:
    <instantiation>:2:2: error: unrecognized instruction mnemonic
     _ASM_EXTABLE 9999b, 9f
     ^
    arch/arm64/mm/cache.S:50:1: note: while in macro instantiation
    user_alt 9f, "dc cvau, x4", "dc civac, x4", 0
    ^

While GNU as seems fine with case-sensitive macro instantiations, clang
doesn't, so use the actual macro name (_asm_extable) as in the rest of
the file.

Also checked that the generated assembly matches the GCC output.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Fixes: 290622efc76e ("arm64: fix "dc cvau" cache operation on errata-affected core")
Link: https://github.com/ClangBuiltLinux/linux/issues/924
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/alternative.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -216,7 +216,7 @@ alternative_endif
 
 .macro user_alt, label, oldinstr, newinstr, cond
 9999:	alternative_insn "\oldinstr", "\newinstr", \cond
-	_ASM_EXTABLE 9999b, \label
+	_asm_extable 9999b, \label
 .endm
 
 /*


