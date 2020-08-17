Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA82C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A90204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692215;
	bh=7/jSenEQJI1USPtTKR+KueXBZvlK+SmNfaZd+djxXj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hOusseZbJuM4Vyi99W0b/RRV34Dpwk9sWvHSQdNqJfwTm9JV5ZNhXhXOLRhiIA0Q5
	 VY8HcolZwkCQv6/RVn6q+VEuNFlN3B7GHdxlSySRZt3I17d/lHc2auqD6Rw4zuTrdy
	 KR3Fhg4YA8ngdTRcoeoUKP8Ucz57YPXzG8dVJoys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgHQTXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbgHQPfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:35:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9424322B40;
        Mon, 17 Aug 2020 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678506;
        bh=7/jSenEQJI1USPtTKR+KueXBZvlK+SmNfaZd+djxXj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQesun9jV72RTfLVbHuhItNmHyGFYaMSfSzzujY4POJLnZbL0ZjDIN+6brYP9y7iN
         zH2QaTPOcZaRZPrIOezkIXzfH1hkSAfx6DQE11g+vkx8V76GGRq8vnQMTan0EEI/4K
         ZbvUKUo/5CMT1I9yjh7S+wnLhTsfELnrj87UR+uY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 316/464] powerpc/32s: Fix CONFIG_BOOK3S_601 uses
Date:   Mon, 17 Aug 2020 17:14:29 +0200
Message-Id: <20200817143848.932971143@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit df4d4ef22446b3a789a4efd74d34f2ec1e24deb2 ]

We have two uses of CONFIG_BOOK3S_601, which doesn't exist. Fix them
to use CONFIG_PPC_BOOK3S_601 which is the correct symbol.

Fixes: 12c3f1fd87bf ("powerpc/32s: get rid of CPU_FTR_601 feature")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200724131728.1643966-5-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/ptrace.h | 2 +-
 arch/powerpc/include/asm/timex.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index ac3970fff0d5d..8b5814a36b76e 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -238,7 +238,7 @@ static inline void set_trap_norestart(struct pt_regs *regs)
 }
 
 #define arch_has_single_step()	(1)
-#ifndef CONFIG_BOOK3S_601
+#ifndef CONFIG_PPC_BOOK3S_601
 #define arch_has_block_step()	(true)
 #else
 #define arch_has_block_step()	(false)
diff --git a/arch/powerpc/include/asm/timex.h b/arch/powerpc/include/asm/timex.h
index d2d2c4bd84358..6047402b0a4db 100644
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -17,7 +17,7 @@ typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
 {
-	if (IS_ENABLED(CONFIG_BOOK3S_601))
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_601))
 		return 0;
 
 	return mftb();
-- 
2.25.1



