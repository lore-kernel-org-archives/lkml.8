Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB31C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7765B20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KeQRs5P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgG3WqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730270AbgG3WqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:46:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C26C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:46:16 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w8so19369504plq.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nxP2fPsBjuLaGOnJV2PoctyTt9HEnsA8L8JDsWYdkGs=;
        b=KeQRs5P9ew2DCJuY+M3CRlFIQjO3m8TNGL7YPT1yXAaZfGSylk6BIYxBtdGhvil/Ss
         ljoeXefdtoexVULGZzypQj5Oz/JmHBezN/UqXxhjkRIGoFNI7XVHetAcIQdgyVI32dg3
         7BTDhMS8RJnf46s+eHaoJV71PDCq0JNiTUXnaOz+no7SCf4yheXzYEuCslAFJ0odgXka
         DsGUBo79d4p/i9/cMudzqJwCWvCocHR6GF+Xe8jtr4c4LXUm+BYEf000ml26uyDXo3vm
         +lEivQeCo/PwMLZO3UWaMCfDudWt47LTXtis9ovz7vclBQW5EgOyaJxK0JppgnceeyFf
         MtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nxP2fPsBjuLaGOnJV2PoctyTt9HEnsA8L8JDsWYdkGs=;
        b=kd3VNF/CVIcmwK8KfAx3PyTcbZjK7h0BUflvo/x2EY3dr5uGe2/KNYQuOWGI9cgkSk
         GiaOU+51hV57a15SytOpixZJBVLAcAjFCsKzQ9u1PjTcouMRax1qwe3l+g8H6SML5y3Z
         a3w5/TqCcGPUtzTvXHZpRAXKoanz0nmKSCQZPWhKQ5ANXwhEIYH5wi7VBGNOM1OBCX4q
         ciykx+1AXOSNL/cOPsor5oeIbO7ASaUoqc1w4hONZsnlkT2PC5XiCYmdzgY3p4y5N+19
         t6Evsw6ubBrE791yPDnDXlRTdkNHcxuETldd/6JIwg70Tau1dSBW/MN8nUaIl+8C/BZz
         P0TQ==
X-Gm-Message-State: AOAM530M8VbJPGkveDmAjhYhRPsU2mKjIk+U9LidJkHVrw5k9hoZlB2u
        xCPacf8LVxCH56/k+VH6Uekk8fvtZ2APhAUsFbc=
X-Google-Smtp-Source: ABdhPJyxLPs7XttU9ug/fEo70OLgEg1uxpiUznOI71yyHWeiiaIucGy64+/wfZyIf6mQtLMUzZh8SZkifKavPrl6d9Y=
X-Received: by 2002:a17:90a:d42:: with SMTP id 2mr1254368pju.15.1596149175923;
 Thu, 30 Jul 2020 15:46:15 -0700 (PDT)
Date:   Thu, 30 Jul 2020 15:45:54 -0700
In-Reply-To: <20200730224555.2142154-1-ndesaulniers@google.com>
Message-Id: <20200730224555.2142154-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200730224555.2142154-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 1/2] tracepoint: mark __tracepoint_string's __used
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org, Tim Murray <timmurray@google.com>,
        Simon MacMullen <simonmacm@google.com>,
        Greg Hackmann <ghackmann@google.com>
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
No change V1 -> V2.

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
2.28.0.163.g6104cc2f0b6-goog

