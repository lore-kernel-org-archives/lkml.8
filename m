Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC40C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C852F2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyLNvjH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbgFXU61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389720AbgFXU6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:58:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A433CC061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:58:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f16so3609251ybp.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=MyLNvjH4BaSpMVt4m7OL8w8Kh4XLox5uMmU6/Z0ItdZP4yMrnH98CNwuV3QeifZL92
         3Y8tuGJwfcNuWZHxP1UkeqK/xJb1NRFlgtf+ZsZAZxk1HsrR1w7SdO7zb9wvBE1lihXo
         /gM/39u4cbejNpzreOPpLQs+1yfAKtUU1a9px0EyuTVEN0JzHssKb05XMKZvWoaTlB2G
         t5NtebZVftxPJvJkT4/iXrbXs6qVYFATI3eRi67iQDiHIAzrHfb/09cLTk76ga0CyglA
         oHFKXvdwJWazciq0ZtyNXvUR8S40GGOhq2T3LzC+e+3smItGPZh/hoBFWoC5eBtta1xc
         lXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=tuGFPgSXUq49ZiXF4adR9ofNamqslZXcML8MB4ACfb2EdGEvjmD7Wmd02G3PsT+Vnl
         IESaPWBB/jWHd50NtwakX//inzZF8PlplAxesKLOlUGR3JQ/KF+Kx23oSdWdb4zEz+7S
         +6v8XsZJVpl1VJXbBz5Rxo8hRzO83yfjBijyKyXHJ8kvGJFLlONctO28pdlKNPEWJZ/y
         gm6mwuszCtuw/vVkv/eJ6oTBC57sGokpZcyYJYVvRsjprPI+IVIY5TBUh/zMB3h5KaFX
         1iWv0UKeP9DySe2M6WYjcHeoC/Wal7FtGd/O+6PD35fl/MB2NNwtvYacz1EP+Ev7hF76
         HhRQ==
X-Gm-Message-State: AOAM533S005f/pF+G4WmcBDD5d55pSn/3Kp9kzDlnB9h/nZAkEZuKDZe
        52hdm9O7J06Wtu08AnErgS9N05KxnTQ14bPUKd5fcQ==
X-Google-Smtp-Source: ABdhPJzg+Au4umwjyLRblCRE3PuIJNmc8kxElVJsT/B0YDcGaL41JkWSqA7GJtKTxCWTEEXd8EUt+BFhsEEeVgNcGl0dpQ==
X-Received: by 2002:a25:73c3:: with SMTP id o186mr43621885ybc.230.1593032297774;
 Wed, 24 Jun 2020 13:58:17 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:44 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 05/11] arch: um: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
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
index eca6c452a41bd..9a9c97f45694c 100644
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
2.27.0.212.ge8ba1cc988-goog

