Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56239C433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3275920714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cT3KOa4g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HiIRxt+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgGYKNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 06:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgGYKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 06:13:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3DAC0619D3;
        Sat, 25 Jul 2020 03:13:42 -0700 (PDT)
Date:   Sat, 25 Jul 2020 10:13:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595672020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qwu/iZaf7EOvYkm7ogUMnahRsySRRaJFOiD0v/N0Q4o=;
        b=cT3KOa4gdJ/pJvw9ILHq5nHj2Qs0ojmumBHqcvFkNESytfd/48FQAJAZhneGnEZ7O8yozt
        Jazs4fGI2FFH62HRF4unksTTr7ZIUZ1r01NbdN4C9+vGQcFHmXC5Sg6mL7zDx+JzMhV3YC
        mSkxll4jRiA7Q9ndEustpKK4/rCSzjAwkanmZ3QbGhUZPQyHDwQpv03fJwX/SpctowwN/S
        xFbiOKNMJ/9ugg2xtAjCCSXViXuzgo54L34rS1m0ravwXNFSYQxUsalVwBQRqfpW9GdSmS
        BcrXGSXXw3RgfvHer/2ksR0Oe7xDWcwNhgSPPNdtz8z5bACAiSIDmQLFqwhzjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595672020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qwu/iZaf7EOvYkm7ogUMnahRsySRRaJFOiD0v/N0Q4o=;
        b=HiIRxt+T5brj7graxC8ETkYFdTnox1Mff/RyBwywMEfiOe6V5nMu+4jZ3oltzVwuKbHkaR
        qYXFZrZ7naj8e1BQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/tsc: Remove unused "US_SCALE" and "NS_SCALE"
 leftover macros
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200724114418.629021-3-mingo@kernel.org>
References: <20200724114418.629021-3-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <159567202032.4006.6639431900725796846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     161449bad5053d66f2310744ba8498158ab12c89
Gitweb:        https://git.kernel.org/tip/161449bad5053d66f2310744ba8498158ab12c89
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 24 Jul 2020 13:44:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Jul 2020 12:00:57 +02:00

x86/tsc: Remove unused "US_SCALE" and "NS_SCALE" leftover macros

Last use of them was removed 13 years ago, when the code was converted
to use CYC2NS_SCALE_FACTOR:

  53d517cdbaac: ("x86: scale cyc_2_nsec according to CPU frequency")

The current TSC code uses the 'struct cyc2ns_data' scaling abstraction,
the old fixed scaling approach is long gone.

This cleanup also removes the 'arbitralrily' typo from the comment,
so win-win. ;-)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200724114418.629021-3-mingo@kernel.org
---
 arch/x86/include/asm/tsc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 8a0c25c..b7b2624 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -7,9 +7,6 @@
 
 #include <asm/processor.h>
 
-#define NS_SCALE	10 /* 2^10, carefully chosen */
-#define US_SCALE	32 /* 2^32, arbitralrily chosen */
-
 /*
  * Standard way to access the cycle counter.
  */
