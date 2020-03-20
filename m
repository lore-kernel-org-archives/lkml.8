Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486EAC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AE620776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgCTM7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:59:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35648 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgCTM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHE2-0003jO-LW; Fri, 20 Mar 2020 13:58:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4B3E51C22C1;
        Fri, 20 Mar 2020 13:58:05 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:04 -0000
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] MAINTAINERS: Add maintenance information for psi
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200316191333.115523-4-hannes@cmpxchg.org>
References: <20200316191333.115523-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <158470908499.28353.9637225580351813709.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a0fe6ba69059266ba70ed5d3c4ac80713f6ffde7
Gitweb:        https://git.kernel.org/tip/a0fe6ba69059266ba70ed5d3c4ac80713f6ffde7
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Mon, 16 Mar 2020 15:13:33 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:19 +01:00

MAINTAINERS: Add maintenance information for psi

Add a maintainer section for psi, as it's a user-visible, configurable
kernel feature.

The patches are still routed through the scheduler tree due to the
close integration with that code, but get_maintainers.pl does the
right thing and makes sure everybody gets CCd:

$ ./scripts/get_maintainer.pl -f kernel/sched/psi.c
Johannes Weiner <hannes@cmpxchg.org> (maintainer:PRESSURE STALL INFORMATION (PSI))
Ingo Molnar <mingo@redhat.com> (maintainer:SCHEDULER)
Peter Zijlstra <peterz@infradead.org> (maintainer:SCHEDULER)
...

Reported-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200316191333.115523-4-hannes@cmpxchg.org
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a14..5f82a70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13518,6 +13518,12 @@ F:	net/psample
 F:	include/net/psample.h
 F:	include/uapi/linux/psample.h
 
+PRESSURE STALL INFORMATION (PSI)
+M:	Johannes Weiner <hannes@cmpxchg.org>
+S:	Maintained
+F:	kernel/sched/psi.c
+F:	include/linux/psi*
+
 PSTORE FILESYSTEM
 M:	Kees Cook <keescook@chromium.org>
 M:	Anton Vorontsov <anton@enomsg.org>
