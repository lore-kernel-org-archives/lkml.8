Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B42C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022D6221FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444475;
	bh=L7krQWvQ/BaFmjdN656B/vQz1kmE70ALqk8CeDzjA+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gnhJgBa+sxBYa131JtN+E6YUDAF71CADIImnwJIuHBFfwF8s+JxUl8cchG7XMdIs9
	 XSW6H+Gd9QIcv/+Zgbmj6xsVwYSDVjCOs0aSodcoBbNRltMiC4G1whkfdOxDI3dOku
	 aTMHCgfE3Cl2z5Ty4veTFgbIotq4SgdqFgAIWtEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbgFRBlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbgFRB3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:29:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE8922229;
        Thu, 18 Jun 2020 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443789;
        bh=L7krQWvQ/BaFmjdN656B/vQz1kmE70ALqk8CeDzjA+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIAFLCWM2DdlphUvSjW26HQHkvKC/98E8nrgPgy8Y05aSFqd2JR9Wh1cFsY8tcwsN
         j3m5xWALFlqxL1Ks6w5ktMXoJg6xAKXUi+BIgnH3gYxU0a+ic8G1jWvS+gHyhFPdIY
         nKiGJ4DiATH6EoY1ePw4xTUQ52Bb3o4p5pxp/tV8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>, Sasha Levin <sashal@kernel.org>,
        openrisc@lists.librecores.org
Subject: [PATCH AUTOSEL 4.9 70/80] openrisc: Fix issue with argument clobbering for clone/fork
Date:   Wed, 17 Jun 2020 21:28:09 -0400
Message-Id: <20200618012819.609778-70-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index c17e8451d997..3fbe420f49c4 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1092,13 +1092,13 @@ ENTRY(__sys_clone)
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
 	l.j	_sys_rt_sigreturn
-- 
2.25.1

