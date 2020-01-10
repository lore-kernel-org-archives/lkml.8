Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ACFC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3C824685
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAJR7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59300 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgAJR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZC-0002At-D7; Fri, 10 Jan 2020 18:59:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D48741C2D6E;
        Fri, 10 Jan 2020 18:59:20 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:20 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Simplify the free_memtype() control flow
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867916069.30329.4589587679342870123.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     47553d42c55f7b85e72ce6f3a18030102f8f93a3
Gitweb:        https://git.kernel.org/tip/47553d42c55f7b85e72ce6f3a18030102f8f93a3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 19 Nov 2019 10:18:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Simplify the free_memtype() control flow

Simplify/streamline the quirky handling of the pat_pagerange_is_ram() logic,
and get rid of the 'err' local variable.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index ea7da7e..af04992 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -656,7 +656,6 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 
 int free_memtype(u64 start, u64 end)
 {
-	int err = -EINVAL;
 	int is_range_ram;
 	struct memtype *entry;
 
@@ -671,14 +670,10 @@ int free_memtype(u64 start, u64 end)
 		return 0;
 
 	is_range_ram = pat_pagerange_is_ram(start, end);
-	if (is_range_ram == 1) {
-
-		err = free_ram_pages_type(start, end);
-
-		return err;
-	} else if (is_range_ram < 0) {
+	if (is_range_ram == 1)
+		return free_ram_pages_type(start, end);
+	if (is_range_ram < 0)
 		return -EINVAL;
-	}
 
 	spin_lock(&memtype_lock);
 	entry = memtype_erase(start, end);
