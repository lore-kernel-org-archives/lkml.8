Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E79CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7025D23104
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVa4+Nls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbgFTDOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbgFTDOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:14:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2734C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:14:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c22so8630210qtp.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zl+PzJjccgQ/z2IEdEeYMiws9NGR4cJmTEy3MFLmC3o=;
        b=IVa4+NlsGbh2tuCONpmMignMX3tymio3t6JWrNzc5iXWlb7vOmjhAzN6NlhnjFhlfR
         SLJ2gRLA6EgVpy6YonZqFX54AkwoQvKBOlkFwCsmWTooE2Q423aBY278CNa0BX7Yzzi5
         lTmaofUZR7JB+xlA674HFVZ73jz5U7+ADJceLARAnFz+bA6LH/zrWy5QWqoeEotTqvOF
         UmYtSmZeHun0CDabkfnTMDnFWZTfWR7TUYD5al6woWbY0Ul7IMyeEFTFpl6EedRllncg
         SdzScVXpPGEAjKrWBCofUBL7hAbyMc2DncnGuAHznS6G6/EVpgXDGIDc1Q78yWZ0I/xm
         5QTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zl+PzJjccgQ/z2IEdEeYMiws9NGR4cJmTEy3MFLmC3o=;
        b=iOiYzHXCX4VUdPb4cwic3g6SOcn4t/1F49GeKBqcDrhBbl/A3BgD6twBWNBWrJEz2X
         d8MwTWTEz0nDllL2dgWJO4SW6mMu5d35Vsmt+XNZRoSjs6CG/YICqg1sDoihfNW11JOP
         GNAp6d/Ka/75enQ/T2GfBkobuhHPX8lyAc1TJi645DbUrcNsikioQrFRkUf6CSe0CKCU
         oK7rbm81Z8uEI7sQupLG6xJyDcOKJz/V3526IKFYaC79nFa5q5TFHRJNjl3CYcW+Ng38
         e4oVbgr9bjDly43UmsDEdKIDGPPHEwgvKZ5CbHivlykWqr45h5/r67ugH/XhKk2Sy1c5
         0knw==
X-Gm-Message-State: AOAM530iEfiT+MVTNg7W40X7bFu0APFJZXGStfm2hL6quUYjbiLl2utp
        Z16mFw3C9P5DcmimKj48/U1lr8UjerX0
X-Google-Smtp-Source: ABdhPJx7Zb5WZN9Kyj9M9t0YipMDGf9555Hb9vWxW3rsrq8ChDSsTnnDsP2VsrGgbZFEcrS6B5seAkyx5hxN
X-Received: by 2002:a05:6214:11b3:: with SMTP id u19mr11113254qvv.99.1592622875130;
 Fri, 19 Jun 2020 20:14:35 -0700 (PDT)
Date:   Fri, 19 Jun 2020 20:14:18 -0700
Message-Id: <20200620031419.219106-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH net-next 1/2] indirect_call_wrapper: extend indirect wrapper
 to support up to 4 calls
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many places where 2 annotations are not enough. This patch
adds INDIRECT_CALL_3 and INDIRECT_CALL_4 to cover such cases.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 include/linux/indirect_call_wrapper.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index 00d7e8e919c6..54c02c84906a 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -23,6 +23,16 @@
 		likely(f == f2) ? f2(__VA_ARGS__) :			\
 				  INDIRECT_CALL_1(f, f1, __VA_ARGS__);	\
 	})
+#define INDIRECT_CALL_3(f, f3, f2, f1, ...)					\
+	({									\
+		likely(f == f3) ? f3(__VA_ARGS__) :				\
+				  INDIRECT_CALL_2(f, f2, f1, __VA_ARGS__);	\
+	})
+#define INDIRECT_CALL_4(f, f4, f3, f2, f1, ...)					\
+	({									\
+		likely(f == f4) ? f4(__VA_ARGS__) :				\
+				  INDIRECT_CALL_3(f, f3, f2, f1, __VA_ARGS__);	\
+	})
 
 #define INDIRECT_CALLABLE_DECLARE(f)	f
 #define INDIRECT_CALLABLE_SCOPE
@@ -30,6 +40,8 @@
 #else
 #define INDIRECT_CALL_1(f, f1, ...) f(__VA_ARGS__)
 #define INDIRECT_CALL_2(f, f2, f1, ...) f(__VA_ARGS__)
+#define INDIRECT_CALL_3(f, f3, f2, f1, ...) f(__VA_ARGS__)
+#define INDIRECT_CALL_4(f, f4, f3, f2, f1, ...) f(__VA_ARGS__)
 #define INDIRECT_CALLABLE_DECLARE(f)
 #define INDIRECT_CALLABLE_SCOPE		static
 #endif
-- 
2.27.0.111.gc72c7da667-goog

