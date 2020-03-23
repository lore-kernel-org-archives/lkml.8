Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C447C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AAF20781
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgCWLJE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:09:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40985 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgCWLJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:09:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGKx1-0005AM-46; Mon, 23 Mar 2020 12:08:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6BFB91C0470;
        Mon, 23 Mar 2020 12:08:58 +0100 (CET)
Date:   Mon, 23 Mar 2020 11:08:58 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpu: Fix a -Wmissing-prototypes warning for
 init_ia32_feat_ctl()
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323105934.26597-1-b.thiel@posteo.de>
References: <20200323105934.26597-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <158496173800.28353.4422989867880905481.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0e79ad863df43b01090ae18c97de5c3787f069c6
Gitweb:        https://git.kernel.org/tip/0e79ad863df43b01090ae18c97de5c3787f069c6
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Mon, 23 Mar 2020 11:59:34 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 23 Mar 2020 12:01:59 +01:00

x86/cpu: Fix a -Wmissing-prototypes warning for init_ia32_feat_ctl()

Add a missing include in order to fix -Wmissing-prototypes warning:

  arch/x86/kernel/cpu/feat_ctl.c:95:6: warning: no previous prototype for ‘init_ia32_feat_ctl’ [-Wmissing-prototypes]
     95 | void init_ia32_feat_ctl(struct cpuinfo_x86 *c)

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200323105934.26597-1-b.thiel@posteo.de
---
 arch/x86/kernel/cpu/feat_ctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 0268185..29a3bed 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -5,6 +5,7 @@
 #include <asm/msr-index.h>
 #include <asm/processor.h>
 #include <asm/vmx.h>
+#include "cpu.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"x86/cpu: " fmt
