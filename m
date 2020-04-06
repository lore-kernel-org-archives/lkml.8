Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A8DC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0481238E4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgDFOQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:16:10 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40263 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgDFOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:16:10 -0400
X-Originating-IP: 84.210.220.251
Received: from [192.168.1.123] (cm-84.210.220.251.getinternet.no [84.210.220.251])
        (Authenticated sender: fredrik@strupe.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 114CC20005;
        Mon,  6 Apr 2020 14:16:07 +0000 (UTC)
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
From:   Fredrik Strupe <fredrik@strupe.net>
Subject: [PATCH] arm64: armv8_deprecated: Fix undef_hook mask for thumb setend
Message-ID: <911db2f1-e078-a460-32ee-154a0b4de5d4@strupe.net>
Date:   Mon, 6 Apr 2020 16:16:05 +0200
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

Use a full 32-bit mask to prevent accidental matchings of thumb32
instructions where the second half-word is equal to the thumb16 setend
encoding.

This fixes the same problem as the following patch:

     https://lkml.org/lkml/2020/3/16/341

but for setend emulation instead.

Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
---
  arch/arm64/kernel/armv8_deprecated.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 9d3442d62..8c06dfee0 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -609,7 +609,7 @@ static struct undef_hook setend_hooks[] = {
  	},
  	{
  		/* Thumb mode */
-		.instr_mask	= 0x0000fff7,
+		.instr_mask	= 0xfffffff7,
  		.instr_val	= 0x0000b650,
  		.pstate_mask	= (PSR_AA32_T_BIT | PSR_AA32_MODE_MASK),
  		.pstate_val	= (PSR_AA32_T_BIT | PSR_AA32_MODE_USR),
-- 
2.20.1

