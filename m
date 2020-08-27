Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF46C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1512020786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wyBvHWxf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1yahYWhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgH0H4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgH0Hyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94081C061264;
        Thu, 27 Aug 2020 00:54:30 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yj6hitLGgH97TCU3MzZRcCuH/06F7hXMifwYh8hnFhA=;
        b=wyBvHWxfU6XjmQSYgdWgGYuc7br1bo9CIAWq3pOFL3Yyo0O1eep8rV9B70EfUG+Nw+5bEi
        x3V2ycCteIo6InpQR4iwIYhWgWmDxpsDuA7zZwJySKOKPxI9fFdCqFqZJ9x9sjipfKZW30
        qRYf6D4S4zvh37w0cfmbzYvNK+BQL8SKUriD/8A335FFRu39X7sBds1aLvzYwF09AH1Jsp
        69zDcw5INY4OTTDh84KJWFwqUV/0wgLSzTUiB9gtM6cg6YO1UPdF0bhq0j3nF/83LUksRr
        YoZrFx3k12h0stlMzqP/gwAFbyxvYzNSpwlBP0bm+45uHY+oTtwcvU0b/pvBXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yj6hitLGgH97TCU3MzZRcCuH/06F7hXMifwYh8hnFhA=;
        b=1yahYWhVDmg1dlaH33pbEtKjxVsEZKJBD1nu3JfWzdbPznuxj1uiuQ5wp7zm1NBg3uNwN+
        9bNrygnn1V1Wk3Bw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cpuidle: Fixup IRQ state
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.251340558@infradead.org>
References: <20200821085348.251340558@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486844.20229.10979787038687285429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     49d9c5936314e44d314c605c39cce0fd947f9c3a
Gitweb:        https://git.kernel.org/tip/49d9c5936314e44d314c605c39cce0fd947f9c3a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 20 Aug 2020 16:47:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:53 +02:00

cpuidle: Fixup IRQ state

Match the pattern elsewhere in this file.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.251340558@infradead.org
---
 drivers/cpuidle/cpuidle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8719731..2fe4f3c 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -153,7 +153,8 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	 */
 	stop_critical_timings();
 	drv->states[index].enter_s2idle(dev, drv, index);
-	WARN_ON(!irqs_disabled());
+	if (WARN_ON_ONCE(!irqs_disabled()))
+		local_irq_disable();
 	/*
 	 * timekeeping_resume() that will be called by tick_unfreeze() for the
 	 * first CPU executing it calls functions containing RCU read-side
