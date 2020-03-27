Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59009C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2472220663
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="o32vt/1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgC0H03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 03:26:29 -0400
Received: from mout02.posteo.de ([185.67.36.66]:52047 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgC0H03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 03:26:29 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 73AAE240102
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1585293987; bh=t1GU0A4ERuo48VbarfAigSfwM6d3JheC2ki78GUYLOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=o32vt/1pC3H2tm1ebD192pnmWDDZ8CxZKK7cjGHqHWTtf25HAQun5K74BUxaVV2+C
         9UrfNslYv7tq7cvdrbomOd+ikvI44fHeBxFlqghXeI8C0/aslknic3caqax3x6XCGI
         qnPnwbG6+yCJbYdsaQ/H87jET4heQUZ7PXhiUj/pOaemfAB5jhLs9W6slezgTLEpGw
         uYtBdgcoNcA+sjT8CzLhk6uKAvmd+dPjXY7bYHW4R/KQCLBzLpwHtgxJIfgVg/KsrU
         eGwz0iYATqiEgcLvMOu2R6DO4R/9OqMVTGpgfWLfhR9H7p3cD/4x7XPpb70oNu6fND
         SID0Yd6S8SSxA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48pYLp61CHz9rxX;
        Fri, 27 Mar 2020 08:26:26 +0100 (CET)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/platform/uv: Add a missing prototype for uv_bau_message_interrupt()
Date:   Fri, 27 Mar 2020 08:26:21 +0100
Message-Id: <20200327072621.2255-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... in order to fix a -Wmissing-prototypes warning.

arch/x86/platform/uv/tlb_uv.c:1275:6: warning:
no previous prototype for ‘uv_bau_message_interrupt’ [-Wmissing-prototypes]
void uv_bau_message_interrupt(struct pt_regs *regs)

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/include/asm/uv/uv_bau.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/uv/uv_bau.h b/arch/x86/include/asm/uv/uv_bau.h
index 7803114aa140..13687bf0e0a9 100644
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -858,4 +858,6 @@ static inline int atomic_inc_unless_ge(spinlock_t *lock, atomic_t *v, int u)
 	return 1;
 }
 
+void uv_bau_message_interrupt(struct pt_regs *regs);
+
 #endif /* _ASM_X86_UV_UV_BAU_H */
-- 
2.17.1

