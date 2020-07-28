Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED6BC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC19206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaG1BR6O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aei4F2kD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgG1M31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:29:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgG1M3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:29:16 -0400
Date:   Tue, 28 Jul 2020 12:29:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595939355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiX8FF++DrdJ7/RxhyDj5URL8ZYx7pcohzaiY9bEL+0=;
        b=YaG1BR6OB4OXNZdWlemxVz7vxd9Sq+Fv1lOWaNReCL+FYpl3o/In9aNi8GdzqPY+v71Xob
        guD2NH7LVYqhjQIyV2VhXeWC0375TP/EdmWnRIS+FzK7vwSKjp6buB/7MZEdU/4wGWifAC
        fwtVHbXnUNlG1x16xm/CXNgvNJLw9Y3l+Yryp21oNi4GAoo+vSvK7TR2EU7dRBujkafauF
        KgXXEjZMnFFmTQGRScbSsWSVjOHo5B0hy3jkwW2OMcaa+YpxbMWSnSv20/ayXHtlVzBuZA
        HJpTNti9ZvslkiHLBAcnBOEyHtCYi3CQi8z0tVJ0cMO47XNiaI1XvAhtPcMW6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595939355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiX8FF++DrdJ7/RxhyDj5URL8ZYx7pcohzaiY9bEL+0=;
        b=aei4F2kDtuo26bNBAq2cV/ptf9eHJZwT6xS7TmxUKwqDsFRKczO0eMDz5Kmr7VPk2V/mNe
        zS7vCwWo9aGnicBg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Fix process_efi_entries comment
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727230801.3468620-4-nivedita@alum.mit.edu>
References: <20200727230801.3468620-4-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159593935441.4006.4834681494121268317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     a68bcea591a040cce5e08615c829a316beb3e4b4
Gitweb:        https://git.kernel.org/tip/a68bcea591a040cce5e08615c829a316beb3e4b4
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 27 Jul 2020 19:07:56 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jul 2020 12:54:43 +02:00

x86/kaslr: Fix process_efi_entries comment

Since commit:

  0982adc74673 ("x86/boot/KASLR: Work around firmware bugs by excluding EFI_BOOT_SERVICES_* and EFI_LOADER_* from KASLR's choice")

process_efi_entries() will return true if we have an EFI memmap, not just
if it contained EFI_MEMORY_MORE_RELIABLE regions.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200727230801.3468620-4-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 21cd9e0..207fcb7 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -741,8 +741,8 @@ static bool process_mem_region(struct mem_vector *region,
 
 #ifdef CONFIG_EFI
 /*
- * Returns true if mirror region found (and must have been processed
- * for slots adding)
+ * Returns true if we processed the EFI memmap, which we prefer over the E820
+ * table if it is available.
  */
 static bool
 process_efi_entries(unsigned long minimum, unsigned long image_size)
