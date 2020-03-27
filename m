Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8528C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F302072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgC0Oyh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:54:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53606 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgC0Oyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:54:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHqNT-00005h-Qi; Fri, 27 Mar 2020 15:54:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5D96A1C0470;
        Fri, 27 Mar 2020 15:54:31 +0100 (CET)
Date:   Fri, 27 Mar 2020 14:54:31 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/platform/uv: Add a missing prototype for
 uv_bau_message_interrupt()
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200327072621.2255-1-b.thiel@posteo.de>
References: <20200327072621.2255-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <158532087103.28353.1381973254942714459.tip-bot2@tip-bot2>
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

Commit-ID:     01bd18624d91cfe82e7df4bfe2f22814a20b993a
Gitweb:        https://git.kernel.org/tip/01bd18624d91cfe82e7df4bfe2f22814a20b993a
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Fri, 27 Mar 2020 08:26:21 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 27 Mar 2020 10:54:52 +01:00

x86/platform/uv: Add a missing prototype for uv_bau_message_interrupt()

... in order to fix a -Wmissing-prototypes warning:

  arch/x86/platform/uv/tlb_uv.c:1275:6: warning:
  no previous prototype for ‘uv_bau_message_interrupt’ [-Wmissing-prototypes] \
	  void uv_bau_message_interrupt(struct pt_regs *regs)

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200327072621.2255-1-b.thiel@posteo.de
---
 arch/x86/include/asm/uv/uv_bau.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/uv/uv_bau.h b/arch/x86/include/asm/uv/uv_bau.h
index 7803114..13687bf 100644
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -858,4 +858,6 @@ static inline int atomic_inc_unless_ge(spinlock_t *lock, atomic_t *v, int u)
 	return 1;
 }
 
+void uv_bau_message_interrupt(struct pt_regs *regs);
+
 #endif /* _ASM_X86_UV_UV_BAU_H */
