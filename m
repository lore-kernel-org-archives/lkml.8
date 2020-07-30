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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C9520838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EcGh2gJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgG3WqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbgG3WqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:46:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0263C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:46:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a5so19249290ybh.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ghSDhe2c5Xvw5KrRhzzBcUm252rPp0PZQtHeMauHrcs=;
        b=EcGh2gJYLAcOANdcprjVDiok8hh3zd4C37VjDhpR0GFD1OKSxjfaqrQ473JfmXKXXW
         Ckg0nXOI6Wu4PVLSElQjLalh9gldwYSv/6XNFig7Pi/BJItdY7hOR6qr0P3TBDcPSr/k
         lXAoKEKoNir3T0jGT7fFMQbCOBie5VX51QL3yojx0YHs9JeGaVVrIxvO7hnFNQhcLSAv
         jD8bQt2vCXVIEmNF1dfgtXKQ14kDUef4hOwtsBUSVJe+OxR/fCHAmUbrkxlhbVcIRxsg
         YbDXGnPBTEUAEQ1xwlCGR476INXgl4kF/DSY0AJ4N8fWlFXRoKq5k8wl6gZJO61kXnth
         GMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ghSDhe2c5Xvw5KrRhzzBcUm252rPp0PZQtHeMauHrcs=;
        b=AbI5FJk+0mW/BGnyv2mqxRjh0YSE2GjG7s2brVT56ZHuOLxq+oyUqvArXLwWiAoMI7
         VA9mPRe1E0hQmvxf4fNNAJbwxeAVmvRWMP7ebCGipoWgCdIu0vTmZJCK1nFmtPKxl7jm
         DABouGsck5MqwsScsy5EjzdBmZhh09A7mvLmiFGt8tWMZS0t+QTMQUjeRTeM2hUq8EFZ
         yink9eo5p83O2jkHbLukvJa0sy53q6tpYZ+h6uYAQti0fASB12WL398IvLt4JSLN4/9P
         QIvosn3oaZcmi/UHuNIt92z/Hk5bcFgtBOmRijtvOo1twCbl3B1w4DYetB6YZf6JQLfQ
         5B2w==
X-Gm-Message-State: AOAM531GiIKbGDSWIfIAxL2uMxxXw8UiusrcnZ309UtmXVfCyMUW3Tj3
        RyBo4yWDlnWNhatL14+G7YwlrBj1IBjpNntBLNU=
X-Google-Smtp-Source: ABdhPJyHaKU4xc8Q37dEZT57pxAVTPaVzeSsELYAssbhsKk1MtKB3DAYGuEgnAG24fPi3bOlZAXyS4a47OtUz5h82AU=
X-Received: by 2002:a05:6902:1002:: with SMTP id w2mr1897535ybt.321.1596149178898;
 Thu, 30 Jul 2020 15:46:18 -0700 (PDT)
Date:   Thu, 30 Jul 2020 15:45:55 -0700
In-Reply-To: <20200730224555.2142154-1-ndesaulniers@google.com>
Message-Id: <20200730224555.2142154-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200730224555.2142154-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 2/2] tracepoint: used attribute definitions from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a small cleanup while I was touching this header.
compiler_attributes.h does feature detection of these __attributes__(())
and provides more concise ways to invoke them.

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* Add Miguel's Ack.


 include/linux/tracepoint.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 3a5b717d92e8..598fec9f9dbf 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -116,8 +116,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __TRACEPOINT_ENTRY(name)					 \
 	static tracepoint_ptr_t __tracepoint_ptr_##name __used		 \
-	__attribute__((section("__tracepoints_ptrs"))) =		 \
-		&__tracepoint_##name
+	__section(__tracepoints_ptrs) = &__tracepoint_##name
 #endif
 
 #endif /* _LINUX_TRACEPOINT_H */
@@ -280,9 +279,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  */
 #define DEFINE_TRACE_FN(name, reg, unreg)				 \
 	static const char __tpstrtab_##name[]				 \
-	__attribute__((section("__tracepoints_strings"))) = #name;	 \
-	struct tracepoint __tracepoint_##name				 \
-	__attribute__((section("__tracepoints"), used)) =		 \
+	__section(__tracepoints_strings) = #name;			 \
+	struct tracepoint __tracepoint_##name __used			 \
+	__section(__tracepoints) =					 \
 		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
 	__TRACEPOINT_ENTRY(name);
 
@@ -361,7 +360,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		static const char *___tp_str __tracepoint_string = str; \
 		___tp_str;						\
 	})
-#define __tracepoint_string	__attribute__((section("__tracepoint_str"), used))
+#define __tracepoint_string	__used __section(__tracepoint_str)
 #else
 /*
  * tracepoint_string() is used to save the string address for userspace
-- 
2.28.0.163.g6104cc2f0b6-goog

