Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BA4C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148C02166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lv5XmrPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgCDTD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:03:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41732 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDTD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:03:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id z65so923446pfz.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5TjbY4GEQcUBSuOZ3RlaB1Ghuf3vDqDXE20DOsWONH0=;
        b=lv5XmrPOoGKdCPO/GpdsKXBp9iLUqDpmu2DPMA3TlPDemcOpuemqp5eieDPfz+t7Il
         LNN69mMJ6aaxOZzYEsGXWs02yKsHy8OpSdhH6uwUy1G+IWb89y+qhOoqkvef8uvOWjSg
         MCDJE1HLXFcecJXaIleOmpvfLPnhqgj4y0+xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5TjbY4GEQcUBSuOZ3RlaB1Ghuf3vDqDXE20DOsWONH0=;
        b=Am4X7EUU1iy1PU/67q2LYP0akqds4yXsjgSdWVa2eTEqoG4fy4F8YzVjHiIehZhaCy
         S4Yex13mHJYrU8UyCfO9gQem6oRcjMj5uK9B1RD6rJhLT2s+TG5D9GdNr2ecKula0vRn
         he8pwlT879ppihtYMrnb3QWq1yjYoP7+LB4Z4ZugrMQQixUQJDWEgVkCYszfFGkc/24w
         o9T2kM2ErGkBytcetJJjXBe0p0ScLwHJVqZSmcCJXvKrGIuQ+JdV3BDmhHChbMQh0Ha7
         X0NAtvrgvy82n/3+fdQ3gnmNjZVB3QxAGsrFGcyvsVuUQjcergJjjA0Fdv9gtH0jZ7Zl
         E+4Q==
X-Gm-Message-State: ANhLgQ34HXg/wFi7Q7Z4+EYv0NOT8hBILnAA6JdHUL2N5dK1hlU35YfJ
        Zv49TCq2aT8YD7vBVpiyEvDFXw==
X-Google-Smtp-Source: ADFU+vsVcBfZ2QwQDf3QDE8S0SgijoH1lmHzLI+CblXB0MxvcDpeHgHCnUP0kbb+4jz5YRecrQczFQ==
X-Received: by 2002:a63:ce42:: with SMTP id r2mr4075199pgi.106.1583348606353;
        Wed, 04 Mar 2020 11:03:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x65sm16783249pfd.34.2020.03.04.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:03:25 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:03:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Joe Perches <joe@perches.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: deprecated.rst: Clean up fall-through details
Message-ID: <202003041102.47A4E4B62@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add example of fall-through, list-ify the case ending statements, and
adjust the markup for links and readability. While here, adjust
strscpy() details to mention strscpy_pad().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst | 48 +++++++++++++++++-----------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 179f2a5625a0..f9f196d3a69b 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -94,8 +94,8 @@ and other misbehavior due to the missing termination. It also NUL-pads the
 destination buffer if the source contents are shorter than the destination
 buffer size, which may be a needless performance penalty for callers using
 only NUL-terminated strings. The safe replacement is :c:func:`strscpy`.
-(Users of :c:func:`strscpy` still needing NUL-padding will need an
-explicit :c:func:`memset` added.)
+(Users of :c:func:`strscpy` still needing NUL-padding should instead
+use strscpy_pad().)
 
 If a caller is using non-NUL-terminated strings, :c:func:`strncpy()` can
 still be used, but destinations should be marked with the `__nonstring
@@ -122,27 +122,37 @@ memory adjacent to the stack (when built without `CONFIG_VMAP_STACK=y`)
 
 Implicit switch case fall-through
 ---------------------------------
-The C language allows switch cases to "fall-through" when a "break" statement
-is missing at the end of a case. This, however, introduces ambiguity in the
-code, as it's not always clear if the missing break is intentional or a bug.
+The C language allows switch cases to fall through to the next case
+when a "break" statement is missing at the end of a case. This, however,
+introduces ambiguity in the code, as it's not always clear if the missing
+break is intentional or a bug. For example, it's not obvious just from
+looking at the code if `STATE_ONE` is intentionally designed to fall
+through into `STATE_TWO`::
+
+	switch (value) {
+	case STATE_ONE:
+		do_something();
+	case STATE_TWO:
+		do_other();
+		break;
+	default:
+		WARN("unknown state");
+	}
 
 As there have been a long list of flaws `due to missing "break" statements
 <https://cwe.mitre.org/data/definitions/484.html>`_, we no longer allow
-"implicit fall-through".
-
-In order to identify intentional fall-through cases, we have adopted a
-pseudo-keyword macro 'fallthrough' which expands to gcc's extension
-__attribute__((__fallthrough__)).  `Statement Attributes
-<https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html>`_
-
-When the C17/C18  [[fallthrough]] syntax is more commonly supported by
+implicit fall-through. In order to identify intentional fall-through
+cases, we have adopted a pseudo-keyword macro "fallthrough" which
+expands to gcc's extension `__attribute__((__fallthrough__))
+<https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html>`_.
+(When the C17/C18  `[[fallthrough]]` syntax is more commonly supported by
 C compilers, static analyzers, and IDEs, we can switch to using that syntax
-for the macro pseudo-keyword.
+for the macro pseudo-keyword.)
 
 All switch/case blocks must end in one of:
 
-	break;
-	fallthrough;
-	continue;
-	goto <label>;
-	return [expression];
+* break;
+* fallthrough;
+* continue;
+* goto <label>;
+* return [expression];
-- 
2.20.1


-- 
Kees Cook
