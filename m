Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159B3C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C802083E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlMM7ehH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bgCL+y7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgG1Iud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:50:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgG1Iud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:50:33 -0400
Date:   Tue, 28 Jul 2020 08:50:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595926230;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyMFGXbZ/EdigNqOkuZ7qYq2FIrdCInji0pyCT+MJxg=;
        b=KlMM7ehH5yv51XWtJ5301ed+kCz0LfGSoVdzOgGnTW6pBbhNDxhHzzr5EGhzLnDOOuejTm
        INsiHH+9JB6MNJMm6fCg+OtafopGNmCMzRDpUhkRHQmkTXAXIkQ51Aw49kOMnlwK3l2aUc
        Hye2SuMIRlhkh0Q+aDi7bj3odMx/OD896sJWXp+pYr7rZx67tB3hPg1r6UBDeDQZJ7qot5
        vLRQuxHiIS9zUvD6m7+lrUK444ElVh42B+iLwYpxD+2oYBkXIuJTZNemtkhVLAMuStpmAs
        u27xd7RDGIo1/huflacS1093+7Bx7a5kLIEduQP3MKSQ2uxzpqQFhmsbrizzZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595926230;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyMFGXbZ/EdigNqOkuZ7qYq2FIrdCInji0pyCT+MJxg=;
        b=bgCL+y7EQY4AmErzQk9kAjzw4W+EVwdwUPQR+kdA9grrRXTn8oL5HV5JO6uuzqOw4brf36
        /84bp9p9+6FSyGCQ==
From:   "tip-bot2 for Herbert Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/header] lockdep: Move list.h inclusion into lockdep.h
Cc:     Petr Mladek <pmladek@suse.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200716063649.GA23065@gondor.apana.org.au>
References: <20200716063649.GA23065@gondor.apana.org.au>
MIME-Version: 1.0
Message-ID: <159592622946.4006.7922093273246703940.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/header branch of tip:

Commit-ID:     e885d5d94793ef342e49d55672baabbc16e32bb1
Gitweb:        https://git.kernel.org/tip/e885d5d94793ef342e49d55672baabbc16e32bb1
Author:        Herbert Xu <herbert@gondor.apana.org.au>
AuthorDate:    Thu, 16 Jul 2020 16:36:50 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jul 2020 10:45:46 +02:00

lockdep: Move list.h inclusion into lockdep.h

Currently lockdep_types.h includes list.h without actually using any
of its macros or functions.  All it needs are the type definitions
which were moved into types.h long ago.  This potentially causes
inclusion loops because both are included by many core header
files.

This patch moves the list.h inclusion into lockdep.h.  Note that
we could probably remove it completely but that could potentially
result in compile failures should any end users not include list.h
directly and also be unlucky enough to not get list.h via some other
header file.

Reported-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Petr Mladek <pmladek@suse.com>
Link: https://lkml.kernel.org/r/20200716063649.GA23065@gondor.apana.org.au
---
 include/linux/lockdep.h       | 1 +
 include/linux/lockdep_types.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 3b73cf8..b1ad5c0 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -21,6 +21,7 @@ extern int lock_stat;
 #ifdef CONFIG_LOCKDEP
 
 #include <linux/linkage.h>
+#include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
 
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 7b93506..bb35b44 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -32,8 +32,6 @@ enum lockdep_wait_type {
 
 #ifdef CONFIG_LOCKDEP
 
-#include <linux/list.h>
-
 /*
  * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
  * the total number of states... :-(
