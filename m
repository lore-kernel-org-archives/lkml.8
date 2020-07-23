Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF31C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C479020737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S70VTYJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgGWUx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGWUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:53:57 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5ABC0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:53:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v16so4780399qka.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jAHIqv7D3hXB60XxP9GMGsxVao6b4A29Qsn40xA3zUE=;
        b=S70VTYJEbr1kzIoy7Yuf5LoVsfgbYkUu6JPa1/T5IQjjnF7P0uY/wcBJ4VMlGHLiq7
         rh2Zvyeu7TO3rYxWNsR48gwgbXQ36bTiWiYTpH9qt+r87rOJGXTJzdtVaU2gC2BDS8TN
         kMJvXf9v0pn0nVz0IY96x5Bw/up5TKO7kVANtjnpUfw3HjaxHXbV2vfrTF75MgsnKwJK
         liloKVkjPfoWk4ikiOw9zpEl6PUB8tlQ818X0SF/LkW8cJjwciLyqXQsmhHv8oLj4lDs
         FV7ZyMGkKEyevpnBUuIUqPw+SakFmgWVTlJFUsKDaN6r+cg2uBHd8KI9vmRuMGN1tF1b
         01Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jAHIqv7D3hXB60XxP9GMGsxVao6b4A29Qsn40xA3zUE=;
        b=c6MDbVgHb1nQmT0aS7tMqe5wIPS/Jugav+7h0jeLNGuFKiSPi5Na2i4WgLD/v5MH4U
         gk7Cjfb4g7pFHPuwd/+Q3UBDNCn/jEWwngQrZA9KMGk7wn/LuvWw1tfQsJq7P4GuA1QL
         6qKFosVof0D665PVtyqOWLvQY2x6cGA7tf5zThNa9Ox9LsssLBzipeMwEOouoSmM7naU
         mdAiux8gD4wfjpOO1oENWR1HMmtPGp/dlxYLUgEnMNUJDe5bq/19NhgQaPU+FWunzZjV
         Zf2S+rElBYHsbl9A99mmgtLlBDZsxdMn++Yyt5uJKrqKWsWKrh3AJLBdnISRZIisdCks
         vQlw==
X-Gm-Message-State: AOAM533T+/oswbzjyV78o3c1IzLCLt+nBIyBJqDi5MdKPFsrpu4Dna92
        WGznOzFWeJlMro5aapLbMlNPLGu8kuIXQzY66Fw=
X-Google-Smtp-Source: ABdhPJzfU4XLHeS13NfuwAFsURxlpXzmukj3ghhC6pSPJjcr1W6XdbEzIwbpSEG+oINpMlrHNVyteGTmg+E8KQE/eOQ=
X-Received: by 2002:a0c:e554:: with SMTP id n20mr6610346qvm.14.1595537636287;
 Thu, 23 Jul 2020 13:53:56 -0700 (PDT)
Date:   Thu, 23 Jul 2020 13:53:40 -0700
In-Reply-To: <20200723205341.1099742-1-ndesaulniers@google.com>
Message-Id: <20200723205341.1099742-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200723205341.1099742-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 1/2] tracepoint: mark __tracepoint_string's __used
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org, Tim Murray <timmurray@google.com>,
        Simon MacMullen <simonmacm@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__tracepoint_string's have their string data stored in .rodata, and an
address to that data stored in the "__tracepoint_str" section. Functions
that refer to those strings refer to the symbol of the address. Compiler
optimization can replace those address references with references
directly to the string data. If the address doesn't appear to have other
uses, then it appears dead to the compiler and is removed. This can
break the /tracing/printk_formats sysfs node which iterates the
addresses stored in the "__tracepoint_str" section.

Like other strings stored in custom sections in this header, mark these
__used to inform the compiler that there are other non-obvious users of
the address, so they should still be emitted.

Cc: stable@vger.kernel.org
Reported-by: Tim Murray <timmurray@google.com>
Reported-by: Simon MacMullen <simonmacm@google.com>
Suggested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
We observe this in Clang; it seems that GCC doesn't do the "cleanup" of
the dead address.

Specifically, the Clang passes "Interprocedural Sparse Conditional
Constant Propagation" (IPSCCP) and GlobalOpt both try to removed the
address if no other uses exist after inlining the reference directly to
the string data.

We don't want to change the linkage of these variables, but we kind of
want optimization behavior to treat these function static strings as if
they had `extern` linkage, at least by not removing the address of the
string data from the custom section.

 include/linux/tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index a1fecf311621..3a5b717d92e8 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -361,7 +361,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		static const char *___tp_str __tracepoint_string = str; \
 		___tp_str;						\
 	})
-#define __tracepoint_string	__attribute__((section("__tracepoint_str")))
+#define __tracepoint_string	__attribute__((section("__tracepoint_str"), used))
 #else
 /*
  * tracepoint_string() is used to save the string address for userspace
-- 
2.28.0.rc0.105.gf9edc3c819-goog

