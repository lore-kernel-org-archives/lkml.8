Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13BAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D692065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159316;
	bh=gMXF4fl4Dkfvmlk//jveDXjQXmPi/EG1P1zpQCrRKb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yug3UBt6wjrRTHpCUacYdh98lMoYfflk2qg+U15IzikvJ/oOjtV27LVyC8uWMldaz
	 ZvN3N1IUEeAHWb8Er26lTv0pg99gBftdeyjxjcROKyoHqvg4KxTGhzAMIoCXEOC3ho
	 8fmkBM9XWqaFr4QR6nkQpHIS8FUIsFX4cjA93ZKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgEVOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730945AbgEVOvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:51:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13C522256;
        Fri, 22 May 2020 14:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159074;
        bh=gMXF4fl4Dkfvmlk//jveDXjQXmPi/EG1P1zpQCrRKb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19x/WWTcQGJh4jECwIu34iInK/W6jAqa1962cZGMq0xAGbx62PR1yA47yNdDHVskQ
         EAZDdG4iB3z3GGgKwEMh/mbo9KaD8CmxmnVSf3OXMAs4pRz/gW23cF2m9i67RiKiLb
         oEK65UiJZ2T9uXatZxO4q4iXS94DfX0A2BR4l5Qs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liu Yibin <jiulong@linux.alibaba.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 27/32] csky: Fixup remove duplicate irq_disable
Date:   Fri, 22 May 2020 10:50:39 -0400
Message-Id: <20200522145044.434677-27-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145044.434677-1-sashal@kernel.org>
References: <20200522145044.434677-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yibin <jiulong@linux.alibaba.com>

[ Upstream commit 6633a5aa8eb6bda70eb3a9837efd28a67ccc6e0a ]

Interrupt has been disabled in __schedule() with local_irq_disable()
and enabled in finish_task_switch->finish_lock_switch() with
local_irq_enabled(), So needn't to disable irq here.

Signed-off-by: Liu Yibin <jiulong@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/entry.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index a7a5b67df898..65c55f22532a 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -318,8 +318,6 @@ ENTRY(__switch_to)
 
 	mfcr	a2, psr			/* Save PSR value */
 	stw	a2, (a3, THREAD_SR)	/* Save PSR in task struct */
-	bclri	a2, 6			/* Disable interrupts */
-	mtcr	a2, psr
 
 	SAVE_SWITCH_STACK
 
-- 
2.25.1

