Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF16C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705E720BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758507;
	bh=r+e9qHmInOQJ47PfeFDi1mAZiHipiVuBXvckxLYW3bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f9m/BN6p+RlQqWJitz1+0Tx/41Erhl8rUYDZlVh0rGX+byeTt7m6Pu2mrTPvhMjja
	 oa+glqWl0UAAbGtDyKt69yUAQWreL8pKjwzE/22SXDq0E2cpRlwTGWhmfB152mn0Fd
	 uZ8jk6cWqtr2cRalMzw9Czc8UuELWLcwRc8b5/E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbgDAQ20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388104AbgDAQ2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:28:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7833B20857;
        Wed,  1 Apr 2020 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758502;
        bh=r+e9qHmInOQJ47PfeFDi1mAZiHipiVuBXvckxLYW3bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoQkWr49OAvTdcNGod+6SVFZ9hU4pwKpIgWu6EgFdRcLBcVUT2bLCWG1AeUDfKEuQ
         qlKKbPMs8apHT8rQxBCqA5QkUmaKtLp7rse6JAOKYRfusNiK6tkrFTiQNCfGv+PWEK
         nGDP+bxxCmq/US1NMEZmhqEkOiEEyFpOTdWdDwjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4.19 109/116] arm64: alternative: fix build with clang integrated assembler
Date:   Wed,  1 Apr 2020 18:18:05 +0200
Message-Id: <20200401161556.080817852@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
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
@@ -221,7 +221,7 @@ alternative_endif
 
 .macro user_alt, label, oldinstr, newinstr, cond
 9999:	alternative_insn "\oldinstr", "\newinstr", \cond
-	_ASM_EXTABLE 9999b, \label
+	_asm_extable 9999b, \label
 .endm
 
 /*


