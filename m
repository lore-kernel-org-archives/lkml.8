Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CC4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846716;
	bh=Ijmq/i5PFf8y/H7vXVaSKWPVJgkUToA6JgRLsQDTu7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yLllWMzo9b3kz8VH82eA6EFImAN9RcM7hnuhgAKxVkYSjbaR+BlVO4Ra04EDcpK+8
	 dptjRmMwUY0oTZTJBIpy2hRVcYU3JoNcyJDEvibEuCEweAbFwRMVtYSsC36Jf+Vo9a
	 E4BMyG5OA+1qDvzpPK8GkrLaLso2Kk4gHAWrp8Ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgCJM5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbgCJM5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:57:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24CBB20674;
        Tue, 10 Mar 2020 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845062;
        bh=Ijmq/i5PFf8y/H7vXVaSKWPVJgkUToA6JgRLsQDTu7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHBDt/Is9XhIs5F+ywYIOLZ7yGeHmANu6GD02HqgpOVISkZUbNU/HY15YWc9TiiYb
         aMaMHxlk4gZqbc3QaUYDosNgqpKiXWQfJtUWajfwtJQ+uRh5gEd8hE0sVepxlvqnLt
         XzkHgIKrIWqgJotPv1ssXxkEO1n64+w4ongeQ6ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 049/189] x86/xen: Distribute switch variables for initialization
Date:   Tue, 10 Mar 2020 13:38:06 +0100
Message-Id: <20200310123644.460773649@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 9038ec99ceb94fb8d93ade5e236b2928f0792c7c ]

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

arch/x86/xen/enlighten_pv.c: In function ‘xen_write_msr_safe’:
arch/x86/xen/enlighten_pv.c:904:12: warning: statement will never be executed [-Wswitch-unreachable]
  904 |   unsigned which;
      |            ^~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200220062318.69299-1-keescook@chromium.org
Reviewed-by: Juergen Gross <jgross@suse.com>
[boris: made @which an 'unsigned int']
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/enlighten_pv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 1f756ffffe8b3..79409120a6036 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -896,14 +896,15 @@ static u64 xen_read_msr_safe(unsigned int msr, int *err)
 static int xen_write_msr_safe(unsigned int msr, unsigned low, unsigned high)
 {
 	int ret;
+#ifdef CONFIG_X86_64
+	unsigned int which;
+	u64 base;
+#endif
 
 	ret = 0;
 
 	switch (msr) {
 #ifdef CONFIG_X86_64
-		unsigned which;
-		u64 base;
-
 	case MSR_FS_BASE:		which = SEGBASE_FS; goto set;
 	case MSR_KERNEL_GS_BASE:	which = SEGBASE_GS_USER; goto set;
 	case MSR_GS_BASE:		which = SEGBASE_GS_KERNEL; goto set;
-- 
2.20.1



