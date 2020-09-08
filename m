Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E251EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27FD2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V6h7jQlf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mzZH0W5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgIHRmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731660AbgIHQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4AC061383;
        Tue,  8 Sep 2020 05:18:13 -0700 (PDT)
Date:   Tue, 08 Sep 2020 12:13:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599567190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DB6ES7hSkk/mpQh9A6SXST0ZjAghkapEmOy8PiLFuHE=;
        b=V6h7jQlf39pcKu8jw6Joj5JY5PmKEt3fWRyCr2ghOoRtF1uFd50CjolCpSyhl1svf2as47
        PuCktBLbLh7+OXiUMd83Tt5rU9ewRaizm5FEsqAMx+XnwtF/YgJetbwdmFWLrouCyzjqvW
        MAvJMgibo5NlAvkF3iFJREuEzWzaG5OUYLLXw8gWTIElizNv8gzbPn7mHFXXunBoOefeDe
        Uvm3od6RRkq/vaAqpI+n+/8UvCjV9Zn9GH8t+RFRN1xKLlyGGMSvttSPack4xKBl9Zbdpr
        RfUIJhchoDhSWGJJRV7OTkg7du8A9akLNYSTXxHVCiKrUnKuPa+xsxxaleYoAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599567190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DB6ES7hSkk/mpQh9A6SXST0ZjAghkapEmOy8PiLFuHE=;
        b=mzZH0W5XRcqSaj8BChN8h4rA25qus3hcHLB3tmgOYRXST/687NLLzFeFXHZHGHAq/0NZP/
        8yY8o2s6MbNnzCBA==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] tracepoint: Fix overly long tracepoint names
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200908105743.GW2674@hirez.programming.kicks-ass.net>
References: <20200908105743.GW2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159956718882.20229.3629672356074809317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     de394e7568ce2cdb4643ed230169f484f25f9442
Gitweb:        https://git.kernel.org/tip/de394e7568ce2cdb4643ed230169f484f25f9442
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Tue, 08 Sep 2020 12:57:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 14:10:59 +02:00

tracepoint: Fix overly long tracepoint names

Stephen Rothwell reported:

> Exported symbols need to be <= (64 - sizeof(Elf_Addr)) long.  This is
> presumably 56 on 64 bit arches and the above symbol (including the '.')
> is 56 characters long.

Shorten the tracepoint symbol name.

Fixes: d25e37d89dd2 ("tracepoint: Optimize using static_call()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200908105743.GW2674@hirez.programming.kicks-ass.net
---
 include/linux/tracepoint.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 3722a10..81fa0b2 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -154,7 +154,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #ifdef CONFIG_HAVE_STATIC_CALL
 #define __DO_TRACE_CALL(name)	static_call(tp_func_##name)
 #else
-#define __DO_TRACE_CALL(name)	__tracepoint_iter_##name
+#define __DO_TRACE_CALL(name)	__traceiter_##name
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
 /*
@@ -232,8 +232,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * poking RCU a bit.
  */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
-	extern int __tracepoint_iter_##name(data_proto);		\
-	DECLARE_STATIC_CALL(tp_func_##name, __tracepoint_iter_##name); \
+	extern int __traceiter_##name(data_proto);			\
+	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
@@ -288,19 +288,19 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static const char __tpstrtab_##_name[]				\
 	__section(__tracepoints_strings) = #_name;			\
 	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
-	int __tracepoint_iter_##_name(void *__data, proto);		\
+	int __traceiter_##_name(void *__data, proto);			\
 	struct tracepoint __tracepoint_##_name	__used			\
 	__section(__tracepoints) = {					\
 		.name = __tpstrtab_##_name,				\
 		.key = STATIC_KEY_INIT_FALSE,				\
 		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
 		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
-		.iterator = &__tracepoint_iter_##_name,			\
+		.iterator = &__traceiter_##_name,			\
 		.regfunc = _reg,					\
 		.unregfunc = _unreg,					\
 		.funcs = NULL };					\
 	__TRACEPOINT_ENTRY(_name);					\
-	int __tracepoint_iter_##_name(void *__data, proto)		\
+	int __traceiter_##_name(void *__data, proto)			\
 	{								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
@@ -314,18 +314,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		} while ((++it_func_ptr)->func);			\
 		return 0;						\
 	}								\
-	DEFINE_STATIC_CALL(tp_func_##_name, __tracepoint_iter_##_name);
+	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
 
 #define DEFINE_TRACE(name, proto, args)		\
 	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
-	EXPORT_SYMBOL_GPL(__tracepoint_iter_##name);			\
+	EXPORT_SYMBOL_GPL(__traceiter_##name);				\
 	EXPORT_STATIC_CALL_GPL(tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
 	EXPORT_SYMBOL(__tracepoint_##name);				\
-	EXPORT_SYMBOL(__tracepoint_iter_##name);			\
+	EXPORT_SYMBOL(__traceiter_##name);				\
 	EXPORT_STATIC_CALL(tp_func_##name)
 
 
