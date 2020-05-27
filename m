Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C15C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A002A206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgE0LZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgE0LZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:25:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639E8C061A0F;
        Wed, 27 May 2020 04:25:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jduBc-000868-UH; Wed, 27 May 2020 13:25:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 46B231C00ED;
        Wed, 27 May 2020 13:25:28 +0200 (CEST)
Date:   Wed, 27 May 2020 11:25:28 -0000
From:   "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/apb_timer: Drop unused declaration and macro
Cc:     Johan Hovold <johan@kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200513100944.9171-2-johan@kernel.org>
References: <20200513100944.9171-2-johan@kernel.org>
MIME-Version: 1.0
Message-ID: <159057872810.17951.2200415241224950142.tip-bot2@tip-bot2>
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

Commit-ID:     e027a2bc934fd05d52ec5b77d159efdfc485b5b3
Gitweb:        https://git.kernel.org/tip/e027a2bc934fd05d52ec5b77d159efdfc485b5b3
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Wed, 13 May 2020 12:09:44 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 May 2020 13:12:49 +02:00

x86/apb_timer: Drop unused declaration and macro

Drop an extern declaration that has never been used and a no longer
needed macro.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200513100944.9171-2-johan@kernel.org
---
 arch/x86/include/asm/apb_timer.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/apb_timer.h b/arch/x86/include/asm/apb_timer.h
index 0a9bf8b..87ce8e9 100644
--- a/arch/x86/include/asm/apb_timer.h
+++ b/arch/x86/include/asm/apb_timer.h
@@ -25,10 +25,7 @@
 #define APBT_MIN_FREQ          1000000
 #define APBT_MMAP_SIZE         1024
 
-#define APBT_DEV_USED  1
-
 extern void apbt_time_init(void);
-extern int arch_setup_apbt_irqs(int irq, int trigger, int mask, int cpu);
 extern void apbt_setup_secondary_clock(void);
 
 extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint);
