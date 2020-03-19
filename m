Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC7C43332
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1DB20732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCSIsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:48:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59747 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgCSIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:47:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqH-0002zg-BS; Thu, 19 Mar 2020 09:47:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D82931C2297;
        Thu, 19 Mar 2020 09:47:49 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:49 -0000
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Convert to SPDX
 identifier
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200305082715.15861-2-lokeshvutla@ti.com>
References: <20200305082715.15861-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <158460766962.28353.14960534289903363482.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     341e8cba6c32bb7509eabb91619a233b7ae249b9
Gitweb:        https://git.kernel.org/tip/341e8cba6c32bb7509eabb91619a233b7ae249b9
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 05 Mar 2020 13:57:10 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 16 Mar 2020 12:40:14 +01:00

clocksource/drivers/timer-ti-dm: Convert to SPDX identifier

Use SPDX-License-Identifier instead of a verbose license text.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200305082715.15861-2-lokeshvutla@ti.com
---
 drivers/clocksource/timer-ti-dm.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 269a994..c0e9e99 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * linux/arch/arm/plat-omap/dmtimer.c
  *
@@ -15,24 +16,6 @@
  *
  * Copyright (C) 2009 Texas Instruments
  * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/clk.h>
