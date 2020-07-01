Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E946C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6FB20702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bby2Ud9K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9c36ESwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgGANdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbgGANdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:33:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93092C08C5C1;
        Wed,  1 Jul 2020 06:33:18 -0700 (PDT)
Date:   Wed, 01 Jul 2020 13:33:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593610396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DxhjgNjWsMKOHdwoTjOoAQfYytoVvlcHku9/QV+ij98=;
        b=Bby2Ud9KvnOb6QFiRZ86bNcWu4rxbOHV634POtLDtsaBvBpjf/5pZ3P3stxO9cvAqxZilO
        acdrY1yFOv2v+k7swbJPPoRRV1kaPKpQtdBpgcUyb/kqsCiwgJgcKgzdOi3TLymu1Uj2wY
        l+1qh+eEowunDJfiAJFoD82z+zhOF2DfieR6mPH2b5xBENjuC9P98miuHllJ2sTDO4eP0x
        IZvQ+gzFZCiJErlWVxEUuoXVofP2X8MpJWPyOzM+1AMbzqMos2UyUeobEKrR1cfqaZWWNl
        2NE8AXBdYnaUA3uNJNBjph1kt+iy9Bcv0uoiJ+DhIfRfSNbdx5x3A6v5na86sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593610396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DxhjgNjWsMKOHdwoTjOoAQfYytoVvlcHku9/QV+ij98=;
        b=9c36ESwTLSiCxDhIFhwG82IvmKQcK4r887viCO7zGYPxzqnJF8StmATqbL2pNwXOeuk4ZV
        IBwI3OBvCNeUm4CA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] selftests/x86/fsgsbase: Add a missing memory constraint
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <432968af67259ca92d68b774a731aff468eae610.1593192140.git.luto@kernel.org>
References: <432968af67259ca92d68b774a731aff468eae610.1593192140.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159361039618.4006.2322389302819926132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     8e259031c67a5ea0666428edb64c89e8c6ebd18e
Gitweb:        https://git.kernel.org/tip/8e259031c67a5ea0666428edb64c89e8c6ebd18e
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:24:28 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 15:27:20 +02:00

selftests/x86/fsgsbase: Add a missing memory constraint

The manual call to set_thread_area() via int $0x80 was missing any
indication that the descriptor was a pointer, causing gcc to
occasionally generate wrong code.  Add the missing constraint.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/432968af67259ca92d68b774a731aff468eae610.1593192140.git.luto@kernel.org

---
 tools/testing/selftests/x86/fsgsbase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index f47495d..9983195 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -285,7 +285,8 @@ static unsigned short load_gs(void)
 		/* 32-bit set_thread_area */
 		long ret;
 		asm volatile ("int $0x80"
-			      : "=a" (ret) : "a" (243), "b" (low_desc)
+			      : "=a" (ret), "+m" (*low_desc)
+			      : "a" (243), "b" (low_desc)
 			      : "r8", "r9", "r10", "r11");
 		memcpy(&desc, low_desc, sizeof(desc));
 		munmap(low_desc, sizeof(desc));
