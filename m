Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6BFC43446
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6DB620717
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281219;
	bh=1DC36zulnrTR4UQVCUR7JDdTyotCWqbHbyfSEQjISsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dkuR9QKNf/iKl1FRs7qb7fjLC8M1lsDvMtn2+o69pU3Bp1zdVrhIQlqfAg69MvXOt
	 SBWJB4+gsvWMeXJfWjIRGOb6F8bYOOSE2dAX3QWDfB/z1r+A0F+oxDP4lQuMWEFogG
	 qqOnFGbZD5BfKJDw3291vouzAE8oM8Y6GqwPmeqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgGTVkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbgGTVjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:39:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6B522CAF;
        Mon, 20 Jul 2020 21:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281182;
        bh=1DC36zulnrTR4UQVCUR7JDdTyotCWqbHbyfSEQjISsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyiL24pVHO9n0/PEHifUZIeK2pZo3hqUXPegL9J/yuP0m6WaXv1oeUwiY1wsbpRnW
         0epA1JBYWTk3c4o4wt2PGePJ8eMRi4zSvTj5zK93YyVzTPXeZ76+xFMlcjF72KYO7c
         A//91WKvTfgsfeeNm/+pSO7D6GRRGCeBEKynBgD4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.9 8/9] x86: math-emu: Fix up 'cmp' insn for clang ias
Date:   Mon, 20 Jul 2020 17:39:31 -0400
Message-Id: <20200720213932.408089-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213932.408089-1-sashal@kernel.org>
References: <20200720213932.408089-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 81e96851ea32deb2c921c870eecabf335f598aeb ]

The clang integrated assembler requires the 'cmp' instruction to
have a length prefix here:

arch/x86/math-emu/wm_sqrt.S:212:2: error: ambiguous instructions require an explicit suffix (could be 'cmpb', 'cmpw', or 'cmpl')
 cmp $0xffffffff,-24(%ebp)
 ^

Make this a 32-bit comparison, which it was clearly meant to be.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20200527135352.1198078-1-arnd@arndb.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/math-emu/wm_sqrt.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/math-emu/wm_sqrt.S b/arch/x86/math-emu/wm_sqrt.S
index d258f59564e11..3b40c98bbbd40 100644
--- a/arch/x86/math-emu/wm_sqrt.S
+++ b/arch/x86/math-emu/wm_sqrt.S
@@ -208,7 +208,7 @@ sqrt_stage_2_finish:
 
 #ifdef PARANOID
 /* It should be possible to get here only if the arg is ffff....ffff */
-	cmp	$0xffffffff,FPU_fsqrt_arg_1
+	cmpl	$0xffffffff,FPU_fsqrt_arg_1
 	jnz	sqrt_stage_2_error
 #endif /* PARANOID */
 
-- 
2.25.1

