Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4EC42078C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Du2IZQVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgFWQmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbgFWQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:42:38 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2597DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:42:38 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z26so9882890qto.15
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zl+PzJjccgQ/z2IEdEeYMiws9NGR4cJmTEy3MFLmC3o=;
        b=Du2IZQVww527r+DkfvLwjzL1rLzDjXpQwn91wkmvUrKnk31COi3wf75uaCGRrhnnGT
         cZtT9QEs5+WAsDy2Ws+B4BBRNf8YRXN+wx28A81PgSW5nfRRKHGEunysMDByIjthTpU1
         EaG+wzyDLq6vv8QEQnsq9NFMy+Ermx4r6wlkGoIVUpdvXVYM35WHVewJAvwnDJayvvIJ
         LNC+uYqFb6WOk68KVwUZMOQ47eUWbRT7EAHJLRpH8tFbqnw9UwX9DGe3NzzMS8hv6L01
         SxMsXa5G4ntXvJFJlJn6ilR1MO/d8wM/CtsQIbsORt7+rG13EysINazUWFLS/0Y592H1
         hRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zl+PzJjccgQ/z2IEdEeYMiws9NGR4cJmTEy3MFLmC3o=;
        b=sXeD4NfzRnLAygcyg9j+UOD6g0JUvnLxltslfeR4XAxeET198gFsOpwfdXVvoNkKO+
         2sx52ftUGgvKzmd58GegZR/zw8BVAUfM1lW1pgZg7OGufUPBQlHVjQgz2jyQdTKRO675
         eMevJiCXO/kSKc2EEWsi+1t7RrkrRxwVH+kiFQR1BFJKOKRLtcqQ7WfAIi+WVYKjdwjd
         8D15mhlRY47JBf45m/jxrMwLJNAfF+t4fdEteILpErSRrlrXpT4ooN7+2/USqGa98CXS
         vOZPRs95251Qx8x+Tl+05Sk4+DZoivWD7Kzzpwshsad8C7dmFly3QkAuOPN7Dyh61z7H
         Ru/g==
X-Gm-Message-State: AOAM533ynRqfptepVblsVZ6+BKGLOD8ttjhldrTcV4PgvRwx8/+Kjf8b
        qE1PlLgZZoJ7C431cvszyfXERzf3cmK9
X-Google-Smtp-Source: ABdhPJwQGXprOfL8jqRrhCa93rf7sj1+uuw00sukDTOJcaV6twqdQ/5psZBymPf6HUwvw6+AZPA8V/mGl64c
X-Received: by 2002:a0c:bd12:: with SMTP id m18mr16597999qvg.178.1592930557012;
 Tue, 23 Jun 2020 09:42:37 -0700 (PDT)
Date:   Tue, 23 Jun 2020 09:42:31 -0700
Message-Id: <20200623164232.175846-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 net-next 1/2] indirect_call_wrapper: extend indirect
 wrapper to support up to 4 calls
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

