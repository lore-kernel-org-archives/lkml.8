Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883EDC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561472073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mz03cmNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgCZShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:37:16 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:47927 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:37:15 -0400
Received: by mail-pl1-f202.google.com with SMTP id l1so4932140pld.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1VavJ5Z7gke3ZjScCRX+571R0N4qJ3UtZHz2ejGsmPM=;
        b=Mz03cmNX3lc1A2QqylFfXvNRdrX0DjBFn1gcQjK0ks/DKwgYbSDKtGOipgxIVNOspV
         U3rWXJoXvESa/9DEAvWGE5+CPpTyseyH3B1GxBx7GzcIyrRQpCPuKedxRzPO0ehLzwBD
         PtoSBWMoIoilWe4sILCDjsEduSFQiCGXeHjuw8Ac4zX24FoXMyztCutVfu+JMtlFGrkd
         SUQSfU0uGngVqyJywlytT9J0ZOEs3HRFwKa8lrn8ndFP2D1dBTVw5pO/1D3GH28m/pQr
         JzHDh5wQCWyxzpoh6rGfgaxRXiFet/J25b44lepf/kHEqrYX1qMe/j/9GBCaB5lOK9Qp
         pJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1VavJ5Z7gke3ZjScCRX+571R0N4qJ3UtZHz2ejGsmPM=;
        b=OfH6i8so+KBP/jg56NSfoopvkgqOYmOPaGxxOgEZZuMjFfAuBzj8MvzCe4Vnl0pl4R
         5qqKfq/TPPfb1jR7Np97FrCcQlrX5h7V0LkhgHwlB2KwZKPCznhf6PTJ+NADnnu1HLCR
         1rZ2oNC1ZcN22zQx+nafS2F7yGwyXebVBuzHW0/XrYMrwB4OxJBfkr8zif7V8DWhP4/8
         hhjlCy8KEmhhmVJHXHkGk9MnvA4cBfTnhqTCrJMyBhqGYpCnsK9DHT0Zf6dQ632tGCLT
         nRFaMRVaEZ48RAKVPSJzvHYjBYN//QCXgGI465MKhCbYDqv9yRI7MHT0vCNp/MZuUdDk
         nkVQ==
X-Gm-Message-State: ANhLgQ3m+se+oJfPdH96EKKR4gryYeuvLio792aByhzueL6M29ybSItB
        jCI1CJQ+DskJbBJ3ZquwBAG96rXnVqOfjrzjLNE=
X-Google-Smtp-Source: ADFU+vsrbsuXUjM8oF56gchzwHrNRIHzOy5PvHjLhEMUTUivfXfP6nPlmkBsYGF6WxrvP1I4JhalU8UiTYP+I0YUOsk=
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr1469403pjb.109.1585247834008;
 Thu, 26 Mar 2020 11:37:14 -0700 (PDT)
Date:   Thu, 26 Mar 2020 11:37:06 -0700
In-Reply-To: <20200326134701.GA118458@rlwimi.vmware.com>
Message-Id: <20200326183707.238474-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200326134701.GA118458@rlwimi.vmware.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2] objtool: Documentation: document UACCESS warnings
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     jpoimboe@redhat.com, peterz@infradead.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with Clang and CONFIG_KASAN=y was exposing a few warnings:
  call to memset() with UACCESS enabled

Document how to fix these for future travelers.

Link: https://github.com/ClangBuiltLinux/linux/issues/876
Suggested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Suggested-by: Matt Helsley <mhelsley@vmware.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* fix typo of listing uaccess_enable() twice rather than
  uaccess_disable() as per Matt and Kamalesh.
* fix type of "should called" to "should be called" as per Randy.
* Mention non-obvious compiler instrumentation ie. -pg/mcount
  -mfentry/fentry via tracing as per Peter.
* Add sentence "It also helps verify..."
* Add potential fix "1) remove explicit..."


 .../Documentation/stack-validation.txt        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index de094670050b..faa47c3aafae 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -289,6 +289,32 @@ they mean, and suggestions for how to fix them.
       might be corrupt due to a gcc bug.  For more details, see:
       https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
 
+9. file.o: warning: objtool: funcA() call to funcB() with UACCESS enabled
+
+   This means that an unexpected call to a non-whitelisted function exists
+   outside of arch-specific guards.
+   X86: SMAP (stac/clac): __uaccess_begin()/__uaccess_end()
+   ARM: PAN: uaccess_enable()/uaccess_disable()
+
+   These functions should be called to denote a minimal critical section around
+   access to __user variables. See also: https://lwn.net/Articles/517475/
+
+   The intention of the warning is to prevent calls to funcB() from eventually
+   calling schedule(), potentially leaking the AC flags state, and not
+   restoring them correctly.
+
+   It also helps verify that there are no unexpected calls to funcB() which may
+   access user space pages with protections against doing so disabled.
+
+   To fix, either:
+   1) remove explicit calls to funcB() from funcA().
+   2) add the correct guards before and after calls to low level functions like
+      __get_user_size()/__put_user_size().
+   3) add funcB to uaccess_safe_builtin whitelist in tools/objtool/check.c, if
+      funcB obviously does not call schedule(), and is marked notrace (since
+      function tracing inserts additional calls, which is not obvious from the
+      sources).
+
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
-- 
2.26.0.rc2.310.g2932bb562d-goog

