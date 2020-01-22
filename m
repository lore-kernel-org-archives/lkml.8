Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A05C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81F924686
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685593;
	bh=sj6N5pE2/82h7vfPvxKma1ckeCsu0WweTBH31NIC6AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hgzOG3mSIwOVgswP173pvCvVwr2poJpokFLyZleJYoO2bGY5zOL3lH7gCf/IA0QbW
	 xmgSMjVtRxc9qYbtPIIImi2bbvsoVligBg7mo9Dt5cebruAAhV5BeNxRCb1BuZIQiu
	 oi8eE3MrUik/gpVDc+5+AkdlmkwZ3Yfx4lKZQMGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgAVJdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbgAVJdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:33:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EE524673;
        Wed, 22 Jan 2020 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685589;
        bh=sj6N5pE2/82h7vfPvxKma1ckeCsu0WweTBH31NIC6AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wzi0C/WMJAzCQ2+0U7cZmU7NJMvSsVxv4cY+p5nT3yb96S8NpSW1OJyaObOUo0Xsc
         bjAclS+EbE17FOsHW4ArRH68gTbyi0J+la/SeYTfYTYrZbRO8URwfTm370X64ByZxO
         SV3a5m4u6fQ94E5v3ODeg2t+hxZt+WsSVMmHOg7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Sid Manning <sidneym@quicinc.com>,
        Brian Cain <bcain@codeaurora.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 38/76] hexagon: work around compiler crash
Date:   Wed, 22 Jan 2020 10:28:54 +0100
Message-Id: <20200122092756.130497147@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

[ Upstream commit 63e80314ab7cf4783526d2e44ee57a90514911c9 ]

Clang cannot translate the string "r30" into a valid register yet.

Link: https://github.com/ClangBuiltLinux/linux/issues/755
Link: http://lkml.kernel.org/r/20191028155722.23419-1-ndesaulniers@google.com
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Sid Manning <sidneym@quicinc.com>
Reviewed-by: Brian Cain <bcain@codeaurora.org>
Cc: Allison Randal <allison@lohutok.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/hexagon/kernel/stacktrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/stacktrace.c b/arch/hexagon/kernel/stacktrace.c
index f94918b449a8..03a0e10ecdcc 100644
--- a/arch/hexagon/kernel/stacktrace.c
+++ b/arch/hexagon/kernel/stacktrace.c
@@ -23,8 +23,6 @@
 #include <linux/thread_info.h>
 #include <linux/module.h>
 
-register unsigned long current_frame_pointer asm("r30");
-
 struct stackframe {
 	unsigned long fp;
 	unsigned long rets;
@@ -42,7 +40,7 @@ void save_stack_trace(struct stack_trace *trace)
 
 	low = (unsigned long)task_stack_page(current);
 	high = low + THREAD_SIZE;
-	fp = current_frame_pointer;
+	fp = (unsigned long)__builtin_frame_address(0);
 
 	while (fp >= low && fp <= (high - sizeof(*frame))) {
 		frame = (struct stackframe *)fp;
-- 
2.20.1



