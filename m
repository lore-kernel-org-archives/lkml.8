Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28557C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FBD20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgCPMMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:12:25 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57033 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbgCPMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:12:25 -0400
X-Originating-IP: 84.210.220.251
Received: from [192.168.1.123] (cm-84.210.220.251.getinternet.no [84.210.220.251])
        (Authenticated sender: fredrik@strupe.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 97F0C2000F;
        Mon, 16 Mar 2020 12:12:21 +0000 (UTC)
To:     Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Fredrik Strupe <fredrik@strupe.net>
Subject: [PATCH] arm: ptrace: Fix mask for thumb breakpoint hook
Message-ID: <6ab2ce75-0763-75b1-0d72-ddfb2b9dec19@strupe.net>
Date:   Mon, 16 Mar 2020 13:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since instr_mask in struct undef_hook is 32 bits wide, a mask with value
0xffff will essentially be extended to 0x0000ffff. This makes undefined
thumb2 instructions with the second half-word as 0xde01 generate SIGTRAPs
instead of SIGILLs.

This happens in total for 3143 instructions on my system. An example
of such an instruction is e800de01.

This patch fixes the issue by extending the mask to the full 32 bits,
such that both half-words have to be matched. This will remove all of
the accidental matchings, as 0x0000 is not a valid thumb2 prefix, while
preserving the intended thumb hook.

Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
---
  arch/arm/kernel/ptrace.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 36718a424..f51bec0bc 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -228,9 +228,14 @@ static struct undef_hook arm_break_hook = {
  	.fn		= break_trap,
  };
  
+/*
+ * Set all bits in the instruction mask, even though the thumb
+ * instruction is only 16 bits. This is to prevent accidental
+ * matching of thumb2 instructions.
+ */
  static struct undef_hook thumb_break_hook = {
-	.instr_mask	= 0xffff,
-	.instr_val	= 0xde01,
+	.instr_mask	= 0xffffffff,
+	.instr_val	= 0x0000de01,
  	.cpsr_mask	= PSR_T_BIT,
  	.cpsr_val	= PSR_T_BIT,
  	.fn		= break_trap,
-- 
2.20.1

