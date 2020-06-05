Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1C5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D318207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360138;
	bh=At0/+C8mJmu58fFEoD3DVJfwfXlhXQeYSjcq2SXhuRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R6RmOrf/cko8ZyC/yFTTrfEUOguWDVQfhnTxN+ziastkmRqL7rn1BX8qBopBImQhb
	 FSlSu0uUVwEyk/6kxAUnr6yUXbfwuHmLOFQratBlZlgv2gSvjRMpCTdgfQkorLOSxV
	 pFn+Ay34za+v8eUQJVNPmvZjONCoZkt4QJrbTGjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgFEM25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgFEM0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:26:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE53208B6;
        Fri,  5 Jun 2020 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359960;
        bh=At0/+C8mJmu58fFEoD3DVJfwfXlhXQeYSjcq2SXhuRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdIrtGWbaYkjpaoUhRBK3OPTTpln9YFkRxjcLHxBp9osWt7W8ZbG90RkaBRef5ScQ
         qLJpFcdCXP0ynTcA0saekR89sx0CPI3QXIJ1GwlsP8rvLEYND2+0x9KVmyJ1ujDq0S
         yXCbUhnZpTpvj7MmSCDg3Sq5d/PRWjQjWEcr4a30=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fredrik Strupe <fredrik@strupe.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 2/9] ARM: 8977/1: ptrace: Fix mask for thumb breakpoint hook
Date:   Fri,  5 Jun 2020 08:25:50 -0400
Message-Id: <20200605122558.2882712-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122558.2882712-1-sashal@kernel.org>
References: <20200605122558.2882712-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fredrik Strupe <fredrik@strupe.net>

[ Upstream commit 3866f217aaa81bf7165c7f27362eee5d7919c496 ]

call_undef_hook() in traps.c applies the same instr_mask for both 16-bit
and 32-bit thumb instructions. If instr_mask then is only 16 bits wide
(0xffff as opposed to 0xffffffff), the first half-word of 32-bit thumb
instructions will be masked out. This makes the function match 32-bit
thumb instructions where the second half-word is equal to instr_val,
regardless of the first half-word.

The result in this case is that all undefined 32-bit thumb instructions
with the second half-word equal to 0xde01 (udf #1) work as breakpoints
and will raise a SIGTRAP instead of a SIGILL, instead of just the one
intended 16-bit instruction. An example of such an instruction is
0xeaa0de01, which is unallocated according to Arm ARM and should raise a
SIGILL, but instead raises a SIGTRAP.

This patch fixes the issue by setting all the bits in instr_mask, which
will still match the intended 16-bit thumb instruction (where the
upper half is always 0), but not any 32-bit thumb instructions.

Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 36718a424358..492ac74a63f4 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -229,8 +229,8 @@ static struct undef_hook arm_break_hook = {
 };
 
 static struct undef_hook thumb_break_hook = {
-	.instr_mask	= 0xffff,
-	.instr_val	= 0xde01,
+	.instr_mask	= 0xffffffff,
+	.instr_val	= 0x0000de01,
 	.cpsr_mask	= PSR_T_BIT,
 	.cpsr_val	= PSR_T_BIT,
 	.fn		= break_trap,
-- 
2.25.1

