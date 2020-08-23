Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0399DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F0720767
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YkSCx8wG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jsWQqu8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHWI1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgHWI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:27:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5F2C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 01:27:00 -0700 (PDT)
Date:   Sun, 23 Aug 2020 08:25:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598171211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0UxICh7o8szFFCOGz8X0Us9wb7698vkr7QSsXV3dhC8=;
        b=YkSCx8wGp+7/GS5DEe66V9JNVI25EeTb35G86fo3y8XIH0W1PeVt+0vDgA4ehXSRS2evTg
        FeK16A1y2OYvZeGU52v1JqNPw6Jh06a/oH9K/eXcSn8mqpGAafngRyxr6nEy8CjiZOsDmX
        ODEx8twoRJlawy+WFVYX4NTeOaA8vXyPJd//Lu0MQHUeqFeMnL9iG/FpU2lJCpoLovxIxh
        Di9m0dOPm6KqfZUvX752jO6i+Esl0cMwA6gTyJLMQu+YQJzgPDH1USWiuNomztKtOmknCR
        2p64Dy3LxVTc3VF54DXbMCZPIAs6gzbrx8jlytC1UXUDGlBIjh1W4ajLms03gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598171211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0UxICh7o8szFFCOGz8X0Us9wb7698vkr7QSsXV3dhC8=;
        b=jsWQqu8lVDa87KJUfaAOXPv8a60PmUsFTewehf2jb/zkOT8KGhcdgTn7odfWUXxD/Dhze5
        08lBN5RUeodjf9Cg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for v5.9-rc2
Message-ID: <159817113401.5783.14776307451257171431.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-08-23

up to:  d88d59b64ca3: core/entry: Respect syscall number rewrites


A single bug fix for the common entry code. The transcript of the x86
version messed up the reload of the syscall number from pt_regs after
ptrace and seccomp which breaks syscall number rewriting.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      core/entry: Respect syscall number rewrites


 kernel/entry/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 9852e0d62d95..fcae019158ca 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -65,7 +65,8 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 
 	syscall_enter_audit(regs, syscall);
 
-	return ret ? : syscall;
+	/* The above might have changed the syscall number */
+	return ret ? : syscall_get_nr(current, regs);
 }
 
 noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)

