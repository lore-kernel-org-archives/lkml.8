Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B29C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AE12065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4elTZsJh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+k18nHk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGZR6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:58:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50196 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGZR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:58:48 -0400
Date:   Sun, 26 Jul 2020 17:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595786326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhCDp1OdajCS7pW/CKgwrZGQtmI83gENbkTinXvtEHY=;
        b=4elTZsJhe0bWPVvkeRNLm56naMdhBYACSJRSBqbngQptdrARJP/rsLPRrkDeMi0KAd1HWm
        ypFF3L9wkyPmyupNdUpd31mWMu3e2ck7eTB27wBjn6I6hjiEcVvRlx55sLtooLk1H8eVla
        zqByIIuNdk+1YsT7PuDSbotY9tLTcynf8X4KHPF/yEsYALMFNMZ1VMHpIk41HJiwr3oH+c
        b2yJjBSKGxpq4OQVEq6h5THbqUKzypszgM1L+Z/rXep9O3T0TpSw+5RzCzjj1whzHiU/AE
        Sm4XJLft5JOZQsBGPaZEhayqRL1cVl0Vfuea8rTuwNjnj1alQvGbA11PRiRzXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595786326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhCDp1OdajCS7pW/CKgwrZGQtmI83gENbkTinXvtEHY=;
        b=+k18nHk+mMAlRT7OYurYVT2KyYmzMXi3cFtb1la7zWBzY4C6diToWsROo1p6KRcZKvQCVs
        fFYIn/vPWF4ArbAQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/ioperm: Initialize pointer bitmap with NULL
 rather than 0
Cc:     Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juergen Gross <jgross@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200721100217.407975-1-colin.king@canonical.com>
References: <20200721100217.407975-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <159578632503.4006.1661941536167538433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     90fc73928fec2f62bbee1476781754c7392a7b61
Gitweb:        https://git.kernel.org/tip/90fc73928fec2f62bbee1476781754c7392a7b61
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Tue, 21 Jul 2020 11:02:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 26 Jul 2020 19:52:55 +02:00

x86/ioperm: Initialize pointer bitmap with NULL rather than 0

The pointer bitmap is being initialized with a plain integer 0,
fix this by initializing it with a NULL instead.

Cleans up sparse warning:
arch/x86/xen/enlighten_pv.c:876:27: warning: Using plain integer
as NULL pointer

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20200721100217.407975-1-colin.king@canonical.com
---
 arch/x86/xen/enlighten_pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c46b9f2..2aab43a 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -873,7 +873,7 @@ static void xen_load_sp0(unsigned long sp0)
 static void xen_invalidate_io_bitmap(void)
 {
 	struct physdev_set_iobitmap iobitmap = {
-		.bitmap = 0,
+		.bitmap = NULL,
 		.nr_ports = 0,
 	};
 
