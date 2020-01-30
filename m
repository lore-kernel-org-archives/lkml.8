Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A84C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06244215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SK7qbAbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgA3XIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:08:39 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56976 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgA3XIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:08:35 -0500
Received: by mail-pg1-f201.google.com with SMTP id a4so142081pgm.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 15:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GWHGFk+tfCHvu/qeG8h3yhiMIdqay1deL3woZTxVWJc=;
        b=SK7qbAbMVIMUgyE42nQVDPyGZ3xVFHv0chQcoZWlALn4b+uUTa/V5PsexsEkn4W2Kb
         bZ7asnJNgDPXfOBetYqJnB9J2XcNvSCZ2/XQ46hFJbZuHTPb4tjLrji35a2EH5gEYQHX
         Vkr9rAsWvphKeh+EesgLzV0XxJ8zZnKFtmATHJ3yzTibY5hSi70Lnx1UCkTYJAuNwZlh
         OicLwo5w9sN3kYYpjEk4VGqXocphh9jYWtcIwf1NuOdGOcvYH5uehNSugKLXxfxcIe4+
         5dUSUaen9Esm8+Jozb1twYu1kudX5eI+ybO5b2ahw9UpOS7dJqKDb5rKEe1YFZwBGUag
         JZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GWHGFk+tfCHvu/qeG8h3yhiMIdqay1deL3woZTxVWJc=;
        b=e6dJzR+9Zsu09HlTEmJ/JwrF/dDjin/R0q9BaKxn1Y+mTB+RSqwTCt8ORYD5dIlhQ+
         RUWjdLnADApVpj+z6ejJI/F3LI8IxPZcmJYCvlb4d1D6udqHAxkEBzumlbDEq9Yh7wne
         3SfC16co4GB6D9MrgICQDsiwaVKQIdrd+f6hFgWhlSQouf5j6HMV+X3PdiS+E67deesX
         dkwowst7PMtibRr2wA96pcS5oB4B7tIEjBjLvCcxHXLX69x5sp4QBF/RBJjrnT1nPPJ+
         0F3UQw07RPwmY4+gSWNObQ8QClXZq39hPaeHkYGunGxt7MmyMk1yAk5Eb2dtX4hmO+SJ
         bmuA==
X-Gm-Message-State: APjAAAXTYpYM7Ro3KvToJc9G9ZZ48KwU1Rw/FjkLC/Y+oGhQF7VqJWfT
        LmURbCtz4zaqa++Qp7w9f5XSWwWCq8r5yUXV8WVhxw==
X-Google-Smtp-Source: APXvYqzh84slKzyUU7Hf8lA5m17FvOWJKZUYYrXcCEAGxMB3WhDFDTTWmSv14cUPAQuwHTR0/deMhklQVof4n1fVyRG7sw==
X-Received: by 2002:a65:4142:: with SMTP id x2mr7048130pgp.393.1580425714304;
 Thu, 30 Jan 2020 15:08:34 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:08:07 -0800
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Message-Id: <20200130230812.142642-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 2/7] arch: um: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a linker section to UML where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/include/asm/common.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 7145ce6999822..eab9ceb450efd 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -52,6 +52,10 @@
 	CON_INITCALL
   }
 
+  .kunit_test_suites : {
+	KUNIT_TEST_SUITES
+  }
+
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
-- 
2.25.0.341.g760bfbb309-goog

