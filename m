Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF1C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CAD21739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgA1LND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:13:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48670 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgA1LNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:13:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwOng-0002YR-RT; Tue, 28 Jan 2020 12:12:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3B3751C1A10;
        Tue, 28 Jan 2020 12:12:56 +0100 (CET)
Date:   Tue, 28 Jan 2020 11:12:55 -0000
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] MAINTAINERS: Correct path to time namespace source file
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200127143748.268515-1-dima@arista.com>
References: <20200127143748.268515-1-dima@arista.com>
MIME-Version: 1.0
Message-ID: <158020997595.396.4728433356571662875.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     fcfd7345209210ab309f4422a308bad3e1fa6b8c
Gitweb:        https://git.kernel.org/tip/fcfd7345209210ab309f4422a308bad3e1fa6b8c
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Mon, 27 Jan 2020 14:37:48 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 28 Jan 2020 12:08:42 +01:00

MAINTAINERS: Correct path to time namespace source file

According to reviews, Time Namespace source was moved from
kernel/time_namespace.c to kernel/time/namespace.c between patchset
versions, while the path in MAINTERNERS file wasn't adjusted properly.

Correct it, so get_maintainer.pl produces a correct emails list again.

Fixes: 769071ac9f20 ("ns: Introduce Time Namespace")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200127143748.268515-1-dima@arista.com
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 141b8d3..3a4163b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13267,7 +13267,7 @@ S:	Maintained
 F:	fs/timerfd.c
 F:	include/linux/timer*
 F:	include/linux/time_namespace.h
-F:	kernel/time_namespace.c
+F:	kernel/time/namespace.c
 F:	kernel/time/*timer*
 
 POWER MANAGEMENT CORE
