Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9A1C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C88208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEGPRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727849AbgEGPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:17:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2FFC05BD43;
        Thu,  7 May 2020 08:17:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWiGb-0004pa-NU; Thu, 07 May 2020 17:16:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 587C51C03AB;
        Thu,  7 May 2020 17:16:53 +0200 (CEST)
Date:   Thu, 07 May 2020 15:16:53 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Remove unneeded kernel CR3 switching
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200419144049.1906-2-laijs@linux.alibaba.com>
References: <20200419144049.1906-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <158886461331.8414.12415962471907072377.tip-bot2@tip-bot2>
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

Commit-ID:     f642aebc9d2a51775d86eaa79da9d90aa5dff0f7
Gitweb:        https://git.kernel.org/tip/f642aebc9d2a51775d86eaa79da9d90aa5dff0f7
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Sun, 19 Apr 2020 14:40:47 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 17:12:39 +02:00

x86/entry/64: Remove unneeded kernel CR3 switching

When native_load_gs_index() fails on .Lgs_change, CR3 must be kernel
CR3. No need to switch it.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200419144049.1906-2-laijs@linux.alibaba.com

---
 arch/x86/entry/entry_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3d747da..7d40d10 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1338,7 +1338,6 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 	SWAPGS
 	FENCE_SWAPGS_USER_ENTRY
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	jmp .Lerror_entry_done
 
 .Lbstep_iret:
