Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D112C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DD020720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tMLLk6gk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0BCZ5+Hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgGHJwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47986 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgGHJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:52 -0400
Date:   Wed, 08 Jul 2020 09:51:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A36WFf54t/lOmWjcos+3kIorCDngAcHvXNxtMZHDhfM=;
        b=tMLLk6gkPCUfWxP6yGQSfeauTkRR1RQVEaGu/+BlBAHRdtGyD1buS+chy7bbQXAh7uujNP
        ClhvQmlOBBt+IFWjoG+CMFA1QrlRMaC51y+ikEYeQrzaxoYMrXwxJ19/b1J7vC+6W8n8Lx
        GeTSwzEX7BBqb3FwJg05tRS3cKvXOiBIBXTtrmJmGDsnQeVfMbKqi9zl8L2XeeY133E/u3
        mduUnT7Vq1apmI5bEqlgqb7L7FEc5MecgBb/+HHmFbyvEFbgQkLN046LAvw1eyRJF099ZU
        EbgTBT0UjVlRWnd/tyWWtmKrpOBt/ef9QGY70TK1FyYftX5kR4oph0dmkEy5XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A36WFf54t/lOmWjcos+3kIorCDngAcHvXNxtMZHDhfM=;
        b=0BCZ5+Hqr3MuIr4ygw4P2ewNA5M9GiEJN/yJE6lXIyVjtilBpXqCxSoiT9ILdz1nNonwoP
        DUZE2eAozkWrODCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Mark the {rd,wr}lbr_{to,from}
 wrappers __always_inline
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-12-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-12-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191008.4006.4909876213341116387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     020d91e5f32da4f4b929b3a6e680135fd526107c
Gitweb:        https://git.kernel.org/tip/020d91e5f32da4f4b929b3a6e680135fd526107c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:53 +02:00

perf/x86/intel/lbr: Mark the {rd,wr}lbr_{to,from} wrappers __always_inline

The {rd,wr}lbr_{to,from} wrappers are invoked in hot paths, e.g. context
switch and NMI handler. They should be always inline to achieve better
performance. However, the CONFIG_OPTIMIZE_INLINING allows the compiler
to uninline functions marked 'inline'.

Mark the {rd,wr}lbr_{to,from} wrappers as __always_inline to force
inline the wrappers.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-12-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/lbr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b8baaf1..21f4f07 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -332,18 +332,18 @@ static u64 lbr_from_signext_quirk_rd(u64 val)
 	return val;
 }
 
-static inline void wrlbr_from(unsigned int idx, u64 val)
+static __always_inline void wrlbr_from(unsigned int idx, u64 val)
 {
 	val = lbr_from_signext_quirk_wr(val);
 	wrmsrl(x86_pmu.lbr_from + idx, val);
 }
 
-static inline void wrlbr_to(unsigned int idx, u64 val)
+static __always_inline void wrlbr_to(unsigned int idx, u64 val)
 {
 	wrmsrl(x86_pmu.lbr_to + idx, val);
 }
 
-static inline u64 rdlbr_from(unsigned int idx)
+static __always_inline u64 rdlbr_from(unsigned int idx)
 {
 	u64 val;
 
@@ -352,7 +352,7 @@ static inline u64 rdlbr_from(unsigned int idx)
 	return lbr_from_signext_quirk_rd(val);
 }
 
-static inline u64 rdlbr_to(unsigned int idx)
+static __always_inline u64 rdlbr_to(unsigned int idx)
 {
 	u64 val;
 
