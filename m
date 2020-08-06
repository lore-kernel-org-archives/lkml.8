Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C0CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3FF2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PbNSAidf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AWsyZ/PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgHFXkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgHFXiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83DC061756;
        Thu,  6 Aug 2020 16:38:55 -0700 (PDT)
Date:   Thu, 06 Aug 2020 23:38:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/PbUOdFNvLbRCjWWev6nnC+DBak5mXQz8gymsqcFpQ=;
        b=PbNSAidfc9AWzSg5G+jYvavC4dqg4LtLLTyEFLYDP3gGssPcxfgeEtjPZK3Fj6NeQid1SK
        xKOFSz0WI9muYrmy+ugLQ3b1QE8MO0VGj2Qf8/4ItxE3kt4KM2WFZcAJBa+RwxkBpbPt83
        P9cGLHvpP9WWRn6LMhNkVaVB6gStqo/ZQDahh9NneCmjt5UKpDQ/XhPNa6HbdOMqoTQGO+
        9zCGYDIpF+qknY3tQmAlz/b3cnRwubNvn2wPEeBkhkOe4tx8BzlQ2scBR8v5/7rY211m8g
        /UYNIFVgObJm6ETqpfbgszaz4vS/Gb0sr4yoehlCgscESSD1EJ1flBqTJZ8zoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/PbUOdFNvLbRCjWWev6nnC+DBak5mXQz8gymsqcFpQ=;
        b=AWsyZ/POUp413RqGwZsM5k7Bhc9z6wIU+xBUUzU7/oCqVPdx10huICL/A0bGQix/CKMG0A
        lkVJNFXk8qd2NZAg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Small cleanup of find_random_phys_addr()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-18-nivedita@alum.mit.edu>
References: <20200728225722.67457-18-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713306.3192.18348861057543480095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     4268b4da572f8bde8bc2f3243927ff5795687a6f
Gitweb:        https://git.kernel.org/tip/4268b4da572f8bde8bc2f3243927ff5795687a6f
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:18 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Small cleanup of find_random_phys_addr()

Just a trivial rearrangement to do all the processing together, and only
have one call to slots_fetch_random() in the source.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-18-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index ce34a05..ecdf33d 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -813,10 +813,9 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 		return 0;
 	}
 
-	if (process_efi_entries(minimum, image_size))
-		return slots_fetch_random();
+	if (!process_efi_entries(minimum, image_size))
+		process_e820_entries(minimum, image_size);
 
-	process_e820_entries(minimum, image_size);
 	return slots_fetch_random();
 }
 
