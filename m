Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA424C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FEB2137B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943313;
	bh=Z4g01D/Ys5Kk7CGpGOkwVsmgrOaLnGIqNdtXtrjgml0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r9J9dJC17bI3IZbOURVfdt4yZkLWhODOz6nrWu6UwgmWDtxtJ6EIq/hBrdEzwMfDO
	 rQEuuZ1aeNKPhsT1KKW84ECu0XOZlkFftzRvV2t5p2f+WfNWDZI31Osb7/TiuoahV7
	 uLbbhXgcMgWA+RCCxmqYKMoLWHLmpqdJhz6vmEKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbgFWUPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389261AbgFWUO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:14:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDFAC2073E;
        Tue, 23 Jun 2020 20:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943298;
        bh=Z4g01D/Ys5Kk7CGpGOkwVsmgrOaLnGIqNdtXtrjgml0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9ul5V5RWAyLJcUnI8hVxeD8KVRvixAbGmkYY3Lm1DMWQYyJ5fM5MEMJzWwt6LO39
         FdS2QB7MGS93ukq6Mi5Z/RfjKAzKn8KmpGRWzTfpr9ICJu9OuAoe6rUXcJVYs5i/om
         XgtdWL0zyY0EXjj6mpUXloqRPg0ai/gP1QAEDMcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 306/477] openrisc: Fix issue with argument clobbering for clone/fork
Date:   Tue, 23 Jun 2020 21:55:03 +0200
Message-Id: <20200623195422.012376785@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stafford Horne <shorne@gmail.com>

[ Upstream commit 6bd140e14d9aaa734ec37985b8b20a96c0ece948 ]

Working on the OpenRISC glibc port I found that sometimes clone was
working strange.  That the tls data argument sent in r7 was always
wrong.  Further investigation revealed that the arguments were getting
clobbered in the entry code.  This patch removes the code that writes to
the argument registers.  This was likely due to some old code hanging
around.

This patch fixes this up for clone and fork.  This fork clobber is
harmless but also useless so remove.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index e4a78571f8833..c6481cfc5220f 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1166,13 +1166,13 @@ ENTRY(__sys_clone)
 	l.movhi	r29,hi(sys_clone)
 	l.ori	r29,r29,lo(sys_clone)
 	l.j	_fork_save_extra_regs_and_call
-	 l.addi	r7,r1,0
+	 l.nop
 
 ENTRY(__sys_fork)
 	l.movhi	r29,hi(sys_fork)
 	l.ori	r29,r29,lo(sys_fork)
 	l.j	_fork_save_extra_regs_and_call
-	 l.addi	r3,r1,0
+	 l.nop
 
 ENTRY(sys_rt_sigreturn)
 	l.jal	_sys_rt_sigreturn
-- 
2.25.1



