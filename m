Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E107421744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+Qg19D2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3aR/53vW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHFXjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgHFXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:59 -0400
Date:   Thu, 06 Aug 2020 23:38:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXjoTKFCZ+Y/MWw/mqSyAJJ5aTDFDN/BMU0AUdWPDUk=;
        b=k+Qg19D2vX5oaDEgRrOSK9NMYreIk6OVDc8NeaUEf5DiBpLL0D3/XcbPQPrOD91URIVQit
        mrwJwwDkb69/Rk//43DnjEY/UhZk+4yL3n3QDBkBdrkB7OzZZxkmM1uXWce+TG2w0WigEn
        EM7qdA028b+1f5QucJj9Jz42gd+gBOA0vxxjzmVtbnQiqcEjjJeZ1WzBMtFiIOth67jEyh
        EBYSlIVYBdHlIsIvG5rOV9ogGyC7082wsjbaHOpEeHt7+Yfc6cK881wiS4Bd3no8uPtX0f
        VDgohjJ36GVPuroLTFsB8ZYxVexZi4vmV1FSYxSkgEFO4asnTDUECoqz7V3bnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXjoTKFCZ+Y/MWw/mqSyAJJ5aTDFDN/BMU0AUdWPDUk=;
        b=3aR/53vW0DM1zbIj0V74y4mbzn17eC144fQQ0+OiE/6qmo5RVTjBfyYjmP/bzyiHroQ8+Z
        egSYxKbqCwTtJHAg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Short-circuit gb_huge_pages on x86-32
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-12-nivedita@alum.mit.edu>
References: <20200728225722.67457-12-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713698.3192.5462555690750286629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     50def2693a900dfb1d91872056dc8164245820fc
Gitweb:        https://git.kernel.org/tip/50def2693a900dfb1d91872056dc8164245820fc
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:12 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Short-circuit gb_huge_pages on x86-32

32-bit does not have GB pages, so don't bother checking for them. Using
the IS_ENABLED() macro allows the compiler to completely remove the
gb_huge_pages code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-12-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 0df513e..3727e97 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -303,7 +303,7 @@ static void handle_mem_options(void)
 
 		if (!strcmp(param, "memmap")) {
 			mem_avoid_memmap(PARSE_MEMMAP, val);
-		} else if (strstr(param, "hugepages")) {
+		} else if (IS_ENABLED(CONFIG_X86_64) && strstr(param, "hugepages")) {
 			parse_gb_huge_pages(param, val);
 		} else if (!strcmp(param, "mem")) {
 			char *p = val;
@@ -551,7 +551,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 	struct mem_vector tmp;
 	int i = 0;
 
-	if (!max_gb_huge_pages) {
+	if (!IS_ENABLED(CONFIG_X86_64) || !max_gb_huge_pages) {
 		store_slot_info(region, image_size);
 		return;
 	}
