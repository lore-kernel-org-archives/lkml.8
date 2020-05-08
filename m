Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9E4C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4CD21582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F0LIwmWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEHP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgEHP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:28:14 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ijaFvPasWKUsbhA2kdV/wZu4/wcIgDcX0/4aV7FEpOw=; b=F0LIwmWPAQRoQkL1B1fUf81p9A
        hgaeHxDtDWrclHPEJfJT81bgNKVDvPOjGOvIPCcj7ICL9wlu+VKeSDDn4X0u3j5+edgEiGj0zsQgL
        vlxphxIm3dOzu/8Uy7tGi2W+IyDdon1ML2ArhLVDi0PrHfDhs3/TP8ApM6ybHKAhxy5Non+6qY0Lj
        Kkd9rV3vnF85kaXFx7oZYaUJ54J0M4hZzM7Ngj/ZetnPCo5kyq4tYbhQuZcQ2uSpWH+aLPJJhbQ2k
        7rnL76QqiLnnt0V4kyHOYNIuop+hRJpXzhJqE9jxcadMShtMzdJ2MG14xE1inBt8b74HsDSAYK858
        6kxJ4U+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX4uU-000786-HI; Fri, 08 May 2020 15:27:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 112CE3010C8;
        Fri,  8 May 2020 17:27:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E48F1286E8FF5; Fri,  8 May 2020 17:27:30 +0200 (CEST)
Date:   Fri, 8 May 2020 17:27:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200508152730.GB3344@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <20200506172455.ho5em2mtzn7qqfjl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506172455.ho5em2mtzn7qqfjl@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:24:55PM -0500, Josh Poimboeuf wrote:

> On that note, what do you think about tweaking the naming from
> 
>   DEFINE_STATIC_COND_CALL(name, typename);
>   static_cond_call(name)(args...);
> 
> to
> 
>   DEFINE_STATIC_CALL_NO_FUNC(name, typename);
>   static_call_if_func(name)(args...);
> 
> ?
> 
> Seems clearer to me.  They're still STATIC_CALLs, so it seems logical to
> keep those two words together.  And NO_FUNC clarifies the initialized
> value.
> 
> Similarly RETTRAMP could be ARCH_DEFINE_STATIC_CALL_NO_FUNC.

So I dislike static_call_if_func(), that's so much typing. Also, I
prefer ARCH_*_RETTRAMP as it clearly describes what the thing is.

How is something like this? 

---
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -16,7 +16,7 @@
  *
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
- *   DEFINE_STATIC_COND_CALL(name, typename);
+ *   DEFINE_STATIC_CALL_NULL(name, typename);
  *   static_call(name)(args...);
  *   static_cond_call(name)(args...);
  *   static_call_update(name, func);
@@ -54,6 +54,43 @@
  *   rather than calling through the trampoline.  This requires objtool or a
  *   compiler plugin to detect all the static_call() sites and annotate them
  *   in the .static_call_sites section.
+ *
+ *
+ * Notes on NULL function pointers:
+ *
+ *   Static_call()s support NULL functions, with many of the caveats that
+ *   regular function pointers have.
+ *
+ *   Clearly calling a NULL function pointer is 'BAD', so too for
+ *   static_call()s (although when HAVE_STATIC_CALL it might not be immediately
+ *   fatal). A NULL static_call can be the result of:
+ *
+ *     DECLARE_STATIC_CALL_NULL(my_static_call, void (*)(int));
+ *
+ *   which is equivalent to declaring a NULL function pointer with just a
+ *   typename:
+ *
+ *     void (*my_func_ptr)(int arg1) = NULL;
+ *
+ *   or using static_call_update() with a NULL function. In both cases the
+ *   HAVE_STATIC_CALL implementation will patch the trampoline with a RET
+ *   instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
+ *   architectures can patch the trampoline call to a NOP.
+ *
+ *   In all cases, any argument evaluation is unconditional. Unlike a regular
+ *   conditional function pointer call:
+ *
+ *     if (my_func_ptr)
+ *         my_func_ptr(arg1)
+ *
+ *   where the argument evaludation also depends on the pointer value.
+ *
+ *   When calling a static_call that can be NULL, use:
+ *
+ *     static_cond_call(name)(arg1);
+ *
+ *   which will include the required value tests to avoid NULL-pointer
+ *   dereferences.
  */
 
 #include <linux/types.h>
@@ -122,7 +159,7 @@ extern int static_call_text_reserved(voi
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
-#define DEFINE_STATIC_COND_CALL(name, _func)				\
+#define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = NULL,						\
@@ -154,7 +191,7 @@ struct static_call_key {
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
-#define DEFINE_STATIC_COND_CALL(name, _func)				\
+#define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = NULL,						\
@@ -198,7 +235,7 @@ struct static_call_key {
 		.func = _func,						\
 	}
 
-#define DEFINE_STATIC_COND_CALL(name, _func)				\
+#define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = NULL,						\
