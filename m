Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F5C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C3D20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fdfr63X/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IotAVYy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGQLWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgGQLWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:22:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828DC061755;
        Fri, 17 Jul 2020 04:22:08 -0700 (PDT)
Date:   Fri, 17 Jul 2020 11:22:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594984926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vq55nEQay6RR9IZtBQHQbQIygvyxIzE9HauBDImIhvc=;
        b=fdfr63X/M1GbfJ2s2Uhe0rH14CvX1/SnhWAwKNll6acxqw9RIxuwRfUIIRkF2Es8ZJQaTL
        N7Pc5lba2pykyWr0lenJrfGeK6YnNeNSR5zJtluoF7KP24xJdSwQqltrA9OQ6H5eRXAjoM
        qbL0C3UR+VPPi/9M+SVjU4oxao2A3YE3ElM7YLlT9VBfXtwdJ9fIITNJ1tbuBWiL1rcR6d
        5WOlPOw46/wCCtLny9aWdRyESl0nnL/n+swFizOi6N9o3cWS6RG0miSrllneE7dn3u5/CZ
        3zpxx70DeEz7mwwPloAxx0BGSK1+WIPVX+71NZF1C2ew6krwq1qqhdCH4YABOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594984926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vq55nEQay6RR9IZtBQHQbQIygvyxIzE9HauBDImIhvc=;
        b=IotAVYy/csXyJJtaHrPd/tXqWZGHLp0RpjSQYq5ePpv6wMs9Sjxo5QrnzbQ0eZXDGyh1ag
        BJgbigVfBGGjpeAg==
From:   "tip-bot2 for Herbert Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Move list.h inclusion into lockdep.h
Cc:     Petr Mladek <pmladek@suse.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200716063649.GA23065@gondor.apana.org.au>
References: <20200716063649.GA23065@gondor.apana.org.au>
MIME-Version: 1.0
Message-ID: <159498492623.4006.16207982024495976101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5be542e945cb39a2457aa2cfe8b84aac95ef0f2d
Gitweb:        https://git.kernel.org/tip/5be542e945cb39a2457aa2cfe8b84aac95ef0f2d
Author:        Herbert Xu <herbert@gondor.apana.org.au>
AuthorDate:    Thu, 16 Jul 2020 16:36:50 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Jul 2020 23:19:51 +02:00

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
index fd04b9e..7aafba0 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -22,6 +22,7 @@ extern int lock_stat;
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
