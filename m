Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ABAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D5520786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TfbrukHR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OGW95xQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgH0Hzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgH0Hyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D5C061236;
        Thu, 27 Aug 2020 00:54:36 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECyvMDbs1VNX+l7QtCYIDcO9pJJ9+CjzvFCuz5jGHrw=;
        b=TfbrukHR4Vyp8jaKjTvKpxiO4BwaQbFK6LyjFViDWnIu8KjWAeSwCx/DYhvpwMFPfG8jrp
        OARoXeUJIiJ1DvMe1Nm0UFxpOlS59PwCzlLHoGiRST+EsTK8eJrhO3tAIuaN/GvlwhxMUJ
        /6PKfsefMMjJ4PXP111j4QKiY/B8d71SkY6TqHQE1Viki/zN87iHaURJgeWWU0OQrvSF0k
        QwZR29o1iA0t+oNNzQHKmtF3LU+8V1H4MbCpOZCFaspjirFGS1PMZa7hlS/a2yowN3SYk3
        shAG1y2aoIUM2Iyrf3bpak/9vMiIiusx5WrQaLY1C42vkLn0cbnnjzSMz5wvMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECyvMDbs1VNX+l7QtCYIDcO9pJJ9+CjzvFCuz5jGHrw=;
        b=OGW95xQyiTZ/fFRQbv5B+vi6q9Do/BCzkp1IdIRqo1DZn4apXPSkWZG8Y4SS/ceGGakUgx
        Jmf7OMLMFUIzrgDQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Use __always_inline on is_idle_task()
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200820172046.GA177701@elver.google.com>
References: <20200820172046.GA177701@elver.google.com>
MIME-Version: 1.0
Message-ID: <159851487420.20229.1106109799847028466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c94a88f341c9b8f05d8639f62bb5d95936f881cd
Gitweb:        https://git.kernel.org/tip/c94a88f341c9b8f05d8639f62bb5d95936f881cd
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 20 Aug 2020 19:20:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:51 +02:00

sched: Use __always_inline on is_idle_task()

is_idle_task() may be used from noinstr functions such as
irqentry_enter(). Since the compiler is free to not inline regular
inline functions, switch to using __always_inline.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200820172046.GA177701@elver.google.com
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd93..afe01e2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1666,7 +1666,7 @@ extern struct task_struct *idle_task(int cpu);
  *
  * Return: 1 if @p is an idle task. 0 otherwise.
  */
-static inline bool is_idle_task(const struct task_struct *p)
+static __always_inline bool is_idle_task(const struct task_struct *p)
 {
 	return !!(p->flags & PF_IDLE);
 }
