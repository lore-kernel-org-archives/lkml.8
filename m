Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B956C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D042073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588861763;
	bh=vvdSzbEpBcmS5iWnBqJ8Fdmt3xvKYr6xWdUdjkVYuFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJr3APu1eF1sZDBxG/D9Rqjc9zJBGM9F9w5YsYKefUgMjbF39b3f2iT11AMaLlB23
	 ujcHhRvULoFsJt2ti0ls67Dte8kFfEWXeBMNSsr95q9m3dednsiwecejtVpWHr7i5g
	 PrcHbx5Fmd6qskkhmyphNjHw+Wnb0aNrNHoQZvWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgEGO3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgEGO3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:29:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E651724956;
        Thu,  7 May 2020 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861752;
        bh=vvdSzbEpBcmS5iWnBqJ8Fdmt3xvKYr6xWdUdjkVYuFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jijZ92rDQsmBZgQF74Ndc0eQ0F+5LPh8xwnD7afsmNLh+KODtB8PzYu0zCFMMBMPO
         XeNOLcnaKQmew07EJKcCwJzgXkk++eezbUOvOkGlONaPnTZl9YiL+Nx4S4bwhbyruy
         O7GMQNJYLwBdJYWv7UNiV6x3UseFJdP9d+biCw0c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 33/35] arm64: vdso: Add -fasynchronous-unwind-tables to cflags
Date:   Thu,  7 May 2020 10:28:27 -0400
Message-Id: <20200507142830.26239-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142830.26239-1-sashal@kernel.org>
References: <20200507142830.26239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

[ Upstream commit 1578e5d03112e3e9d37e1c4d95b6dfb734c73955 ]

On arm64 linux gcc uses -fasynchronous-unwind-tables -funwind-tables
by default since gcc-8, so now the de facto platform ABI is to allow
unwinding from async signal handlers.

However on bare metal targets (aarch64-none-elf), and on old gcc,
async and sync unwind tables are not enabled by default to avoid
runtime memory costs.

This means if linux is built with a baremetal toolchain the vdso.so
may not have unwind tables which breaks the gcc platform ABI guarantee
in userspace.

Add -fasynchronous-unwind-tables explicitly to the vgettimeofday.o
cflags to address the ABI change.

Fixes: 28b1a824a4f4 ("arm64: vdso: Substitute gettimeofday() with C implementation")
Cc: Will Deacon <will@kernel.org>
Reported-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index dd2514bb1511f..3862cad2410cf 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -32,7 +32,7 @@ UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
 
-CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny
+CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
-- 
2.20.1

