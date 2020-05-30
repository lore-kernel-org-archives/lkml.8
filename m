Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E27C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88297208FE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgE3J5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgE3J5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5756DC03E969;
        Sat, 30 May 2020 02:57:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyF4-0002sH-0m; Sat, 30 May 2020 11:57:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9537E1C0489;
        Sat, 30 May 2020 11:57:22 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:22 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/hw_breakpoint: Prevent data breakpoints on
 per_cpu cpu_tss_rw
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526014221.2119-4-laijs@linux.alibaba.com>
References: <20200526014221.2119-4-laijs@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <159083264246.17951.4135007103117136248.tip-bot2@tip-bot2>
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

Commit-ID:     9a06f99a03a0f961047bbae4ee80ce9265757bfe
Gitweb:        https://git.kernel.org/tip/9a06f99a03a0f961047bbae4ee80ce9265757bfe
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 29 May 2020 23:27:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:06 +02:00

x86/hw_breakpoint: Prevent data breakpoints on per_cpu cpu_tss_rw

cpu_tss_rw is not directly referenced by hardware, but cpu_tss_rw is
accessed in CPU entry code, especially when #DB shifts its stacks.

If a data breakpoint would be set on cpu_tss_rw.x86_tss.ist[IST_INDEX_DB],
it would cause recursive #DB ending up in a double fault.

Add it to the list of protected items.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200526014221.2119-4-laijs@linux.alibaba.com
Link: https://lkml.kernel.org/r/20200529213320.897976479@infradead.org

---
 arch/x86/kernel/hw_breakpoint.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index f859095..f311bbf 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -255,6 +255,15 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 		if (within_area(addr, end, (unsigned long)get_cpu_gdt_rw(cpu),
 				GDT_SIZE))
 			return true;
+
+		/*
+		 * cpu_tss_rw is not directly referenced by hardware, but
+		 * cpu_tss_rw is also used in CPU entry code,
+		 */
+		if (within_area(addr, end,
+				(unsigned long)&per_cpu(cpu_tss_rw, cpu),
+				sizeof(struct tss_struct)))
+			return true;
 	}
 
 	return false;
