Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D3BC35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B1220838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBGUk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:40:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41560 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:40:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j0AQo-0002F4-Qb; Fri, 07 Feb 2020 21:40:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 040321C1EEE;
        Fri,  7 Feb 2020 21:40:54 +0100 (CET)
Date:   Fri, 07 Feb 2020 20:40:53 -0000
From:   "tip-bot2 for Stephen Boyd" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Clarify that irq wake state is orthogonal
 to enable/disable
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206191521.94559-1-swboyd@chromium.org>
References: <20200206191521.94559-1-swboyd@chromium.org>
MIME-Version: 1.0
Message-ID: <158110805373.411.379070256193790267.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f9f21cea311340f38074ff93a8d89b4a9cae6bcc
Gitweb:        https://git.kernel.org/tip/f9f21cea311340f38074ff93a8d89b4a9cae6bcc
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Thu, 06 Feb 2020 11:15:21 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 07 Feb 2020 21:37:08 +01:00

genirq: Clarify that irq wake state is orthogonal to enable/disable

There's some confusion around if an irq that's disabled with disable_irq()
can still wake the system from sleep states such as "suspend to RAM".

Clarify this in the kernel documentation for irq_set_irq_wake() so that
it's clear that an irq can be disabled and still wake the system if it has
been marked for wakeup.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lkml.kernel.org/r/20200206191521.94559-1-swboyd@chromium.org

---
 kernel/irq/manage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 818b280..3089a60 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -731,6 +731,13 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
  *
  *	Wakeup mode lets this IRQ wake the system from sleep
  *	states like "suspend to RAM".
+ *
+ *	Note: irq enable/disable state is completely orthogonal
+ *	to the enable/disable state of irq wake. An irq can be
+ *	disabled with disable_irq() and still wake the system as
+ *	long as the irq has wake enabled. If this does not hold,
+ *	then the underlying irq chip and the related driver need
+ *	to be investigated.
  */
 int irq_set_irq_wake(unsigned int irq, unsigned int on)
 {
