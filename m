Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B4DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 09:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC97F23AFC
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 09:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgFTJ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 05:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgFTJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 05:56:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F13C06174E;
        Sat, 20 Jun 2020 02:56:51 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmaEx-0001eb-My; Sat, 20 Jun 2020 11:56:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A620D1C0093;
        Sat, 20 Jun 2020 11:56:44 +0200 (CEST)
Date:   Sat, 20 Jun 2020 09:56:44 -0000
From:   "tip-bot2 for Jason Andryuk" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/idt: Make idt_descr static
Cc:     Jason Andryuk <jandryuk@gmail.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200619205103.30873-1-jandryuk@gmail.com>
References: <20200619205103.30873-1-jandryuk@gmail.com>
MIME-Version: 1.0
Message-ID: <159264700439.16989.3787803162777068826.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     286d966b21587b6303081b902f5c5e30b691baf5
Gitweb:        https://git.kernel.org/tip/286d966b21587b6303081b902f5c5e30b691baf5
Author:        Jason Andryuk <jandryuk@gmail.com>
AuthorDate:    Fri, 19 Jun 2020 16:51:02 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 20 Jun 2020 11:47:35 +02:00

x86/idt: Make idt_descr static

Commit

  3e77abda65b1 ("x86/idt: Consolidate idt functionality")

states that idt_descr could be made static, but it did not actually make
the change. Make it static now.

Fixes: 3e77abda65b1 ("x86/idt: Consolidate idt functionality")
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200619205103.30873-1-jandryuk@gmail.com
---
 arch/x86/kernel/idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 0db2120..7ecf9ba 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -160,7 +160,7 @@ static const __initconst struct idt_data apic_idts[] = {
 /* Must be page-aligned because the real IDT is used in the cpu entry area */
 static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
 
-struct desc_ptr idt_descr __ro_after_init = {
+static struct desc_ptr idt_descr __ro_after_init = {
 	.size		= IDT_TABLE_SIZE - 1,
 	.address	= (unsigned long) idt_table,
 };
