Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A104C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480D820663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860106;
	bh=p7kbBdidlvQ7bLIBBd8hhQHTZoQliGldBUR16LYjEP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VZdMu8lQdTgQeuqjAwIqDmRXRWyjiYOgCg+vNXkbRmF1Aj/n0gqUSm57/ieXFLrUj
	 TNdnBIwF6IB/JByWd/+UA5HEnDtNOY6Fr3SV0lKLIncxmRGWDQZBfE5KNM5+nDWNo0
	 GSG9FUJ08LeIpmEAMA+JNw7L/I9XFVSuVRhEuJfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbgG0O2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732257AbgG0OYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:24:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA682173E;
        Mon, 27 Jul 2020 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859861;
        bh=p7kbBdidlvQ7bLIBBd8hhQHTZoQliGldBUR16LYjEP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arSpuOjiW10ZrAnsrK8ShmzshalgQTWUBdxpkKA7hALhFl4Cz/kUrt7YGJu9VXrzF
         sBduNVayFzEuOxipFDHrdrPyMVq6PLESUsPaOoDmV3BjL5lo0iBwRjcPpul4u1GSUd
         fSRKc2GVV6VE01zeMrqxbXEsyJEpOCUMQeAqSbLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 134/179] x86: math-emu: Fix up cmp insn for clang ias
Date:   Mon, 27 Jul 2020 16:05:09 +0200
Message-Id: <20200727134939.177146438@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 3b2b58164ec18..40526dd85137b 100644
--- a/arch/x86/math-emu/wm_sqrt.S
+++ b/arch/x86/math-emu/wm_sqrt.S
@@ -209,7 +209,7 @@ sqrt_stage_2_finish:
 
 #ifdef PARANOID
 /* It should be possible to get here only if the arg is ffff....ffff */
-	cmp	$0xffffffff,FPU_fsqrt_arg_1
+	cmpl	$0xffffffff,FPU_fsqrt_arg_1
 	jnz	sqrt_stage_2_error
 #endif /* PARANOID */
 
-- 
2.25.1



