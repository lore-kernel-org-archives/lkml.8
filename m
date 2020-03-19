Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D33C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207BE214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624195;
	bh=9g2gIbbLljcopMLsa1wpkRfrnY5cLA9djOVfX6VbqYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DvA/59gT2Rff1s4Ora8KSpbNQ/ecrnt6DjVr1cJTBszu8ccEVC6OVuRGdML/tQK2+
	 jxXD7+Ti809ml6srqeGD4GlzpwvqOwPyD5Io4neGpNxQb7f/iDd6i1e+KZGkSFIYkb
	 +EWLQ5zFrBudAewF2UMb23qcYm/vbLKpyEhNnaFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgCSNXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbgCSNXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:23:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F13C20724;
        Thu, 19 Mar 2020 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624189;
        bh=9g2gIbbLljcopMLsa1wpkRfrnY5cLA9djOVfX6VbqYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FR2ctbiNrY3apd3xUcg9lW7/ZKMeB8vO1ze0a194ounXr2w1pB969Q8NCxZRA4awg
         r9KXj05k4/TGgqa5BtwrOBb/b8JSxE4E0Im+iW2jRdOO5/31ODTVuLTp8RyPsYlLU3
         hJ0OQFAgw/oFsKUoZIZsQH0zCfvcWMJzvRMhauTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 20/60] MIPS: vdso: Wrap -mexplicit-relocs in cc-option
Date:   Thu, 19 Mar 2020 14:03:58 +0100
Message-Id: <20200319123925.617729599@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123919.441695203@linuxfoundation.org>
References: <20200319123919.441695203@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 72cf3b3df423c1bbd8fa1056fed009d3a260f8a9 ]

Clang does not support this option and errors out:

clang-11: error: unknown argument: '-mexplicit-relocs'

Clang does not appear to need this flag like GCC does because the jalr
check that was added in commit 976c23af3ee5 ("mips: vdso: add build
time check that no 'jalr t9' calls left") passes just fine with

$ make ARCH=mips CC=clang CROSS_COMPILE=mipsel-linux-gnu- malta_defconfig arch/mips/vdso/

even before commit d3f703c4359f ("mips: vdso: fix 'jalr t9' crash in
vdso code").

-mrelax-pic-calls has been supported since clang 9, which is the
earliest version that could build a working MIPS kernel, and it is the
default for clang so just leave it be.

Fixes: d3f703c4359f ("mips: vdso: fix 'jalr t9' crash in vdso code")
Link: https://github.com/ClangBuiltLinux/linux/issues/890
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 08c835d48520b..3dcfdee678fb9 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -29,7 +29,7 @@ endif
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-O3 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
-	-mrelax-pic-calls -mexplicit-relocs \
+	-mrelax-pic-calls $(call cc-option, -mexplicit-relocs) \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
-- 
2.20.1



