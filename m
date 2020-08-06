Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CF9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17B623119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFDFMb7b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AJew4jIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgHFRLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730226AbgHFRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3072C061575;
        Thu,  6 Aug 2020 10:10:09 -0700 (PDT)
Date:   Thu, 06 Aug 2020 17:10:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pr7bCYviArGye3y9QgU0GHmrTGpo9Vah1SuVzRiY8yw=;
        b=NFDFMb7bdBN1MF9KEVW9mwdqpxvgbJeTizEVXT0tj8/aWG5UIna4mm0XHc3EG0tFMBwEjW
        faDhp4PXab1QW/Lfu9jkciXtgyYHrK3ySkw0rr6P2UlaqqemNk8OblwZMMf0hz2O9bn3zL
        E2nQf1UKqjflFMXH0bYoAsNSGg3T3Wtcof1nMqh7TVsKWdhQ9tfDnhRAUROfv6g68s695h
        O54u1N9wDwDo9yTc5K/ywmRLO0hhxsNFmVB5GW2KWjdnQjMimBND7sUdTPeY4dq+hHD6T3
        LAEjw45JPZlmKmGnBIqhtxIgdA4lsTg7HZpg27tLjx9OP7j+o0j5FE4kYp60TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pr7bCYviArGye3y9QgU0GHmrTGpo9Vah1SuVzRiY8yw=;
        b=AJew4jIodX6sk108XoAufHRU3njO22T4AOMfqdPXi0S4yuOgsoW21fOn7pklrwl+yEay2X
        ffysnGhro43OGIAg==
From:   "tip-bot2 for Lianbo Jiang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/crash: Correct the address boundary of function
 parameters
Cc:     Lianbo Jiang <lijiang@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Young <dyoung@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200804044933.1973-2-lijiang@redhat.com>
References: <20200804044933.1973-2-lijiang@redhat.com>
MIME-Version: 1.0
Message-ID: <159673380758.3192.12299066068844130724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5b89a35f8c11a7846b06ac729d7de72044f7fc60
Gitweb:        https://git.kernel.org/tip/5b89a35f8c11a7846b06ac729d7de72044f7fc60
Author:        Lianbo Jiang <lijiang@redhat.com>
AuthorDate:    Tue, 04 Aug 2020 12:49:31 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 15:25:58 +02:00

x86/crash: Correct the address boundary of function parameters

Let's carefully handle the boundary of the function parameter to make
sure that the arguments passed doesn't exceed the address range.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Young <dyoung@redhat.com>
Link: https://lore.kernel.org/r/20200804044933.1973-2-lijiang@redhat.com
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index fd87b59..a8f3af2 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -230,7 +230,7 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	int ret = 0;
 
 	/* Exclude the low 1M because it is always reserved */
-	ret = crash_exclude_mem_range(cmem, 0, 1<<20);
+	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
 	if (ret)
 		return ret;
 
