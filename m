Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6BEC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4B4206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgBQPwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:52:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60080 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBQPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:52:41 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3ihI-0000Y4-Em; Mon, 17 Feb 2020 16:52:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E2E281C20B0;
        Mon, 17 Feb 2020 16:52:35 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:52:35 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/iopl: Include prototype header for ksys_ioperm()
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200123133051.5974-1-b.thiel@posteo.de>
References: <20200123133051.5974-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <158195475557.13786.12758785543744091411.tip-bot2@tip-bot2>
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

Commit-ID:     cdcb58cc05ed9a7f74509a023762488c111cdfb3
Gitweb:        https://git.kernel.org/tip/cdcb58cc05ed9a7f74509a023762488c111cdfb3
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Thu, 23 Jan 2020 14:30:51 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 17 Feb 2020 16:36:53 +01:00

x86/iopl: Include prototype header for ksys_ioperm()

.. in order to fix a -Wmissing-prototype warning.

No functional change.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200123133051.5974-1-b.thiel@posteo.de
---
 arch/x86/kernel/ioport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 8abeee0..a53e7b4 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -13,6 +13,7 @@
 
 #include <asm/io_bitmap.h>
 #include <asm/desc.h>
+#include <asm/syscalls.h>
 
 #ifdef CONFIG_X86_IOPL_IOPERM
 
