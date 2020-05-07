Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79817C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57792207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgEGPQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgEGPQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:16:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC1C05BD43;
        Thu,  7 May 2020 08:16:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWiGc-0004pd-3Q; Thu, 07 May 2020 17:16:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A764F1C001A;
        Thu,  7 May 2020 17:16:53 +0200 (CEST)
Date:   Thu, 07 May 2020 15:16:53 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Remove an unused label
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200419144049.1906-4-laijs@linux.alibaba.com>
References: <20200419144049.1906-4-laijs@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <158886461364.8414.3100271154858505569.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     4446d96d7ba7eaac54f9ef968bbe858097441d50
Gitweb:        https://git.kernel.org/tip/4446d96d7ba7eaac54f9ef968bbe858097441d50
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Sun, 19 Apr 2020 14:40:49 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 17:12:39 +02:00

x86/entry/64: Remove an unused label

The label .Lcommon_\sym was introduced by 39e9543344fa.
(x86-64: Reduce amount of redundant code generated for invalidate_interruptNN)
And all the other relevant information was removed by 52aec3308db8
(x86/tlb: replace INVALIDATE_TLB_VECTOR by CALL_FUNCTION_VECTOR)

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200419144049.1906-4-laijs@linux.alibaba.com

---
 arch/x86/entry/entry_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0e9504f..3d747da 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -798,7 +798,6 @@ _ASM_NOKPROBE(common_interrupt)
 SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS
 	pushq	$~(\num)
-.Lcommon_\sym:
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
 	call	\do_sym	/* rdi points to pt_regs */
