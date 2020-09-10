Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FBEC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864A820855
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XT+/rTXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIJIOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgIJIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:12:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCA5C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 67so3816706pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmKbThgzqbDY+/UyIBOV/py9QNKCn3663FFj9Ytmh4w=;
        b=XT+/rTXy4+F81PxarhjGF4uZjYapLuWQd7pvXQYmt0dFRKgz0jAaAAo8AkP53a54V2
         Wlnv1zFNX7gl5wDv7pgEfrci3gbD4rAkY3HblD0WOtWyIzhDEFF15qnD7mdiGdX8Zw3S
         sdb9N+limI2q5Tg+UhrteMuL004SrtOYOVsbm0U1lbmIcWAWX4ES3nGjoqhOUqp5rGv0
         c5WUBYxTwz9CDBpc/u+OwtZfYDLx/o8770/xub8IlKHNT2KlG6JZgrFLyzb/vwv+7Nto
         n+dnubYCDHuazzcS4CBTYNApXnT28fBVu+ACwgpXu7e1Slw7aMMMwQBBEZ4dqKFbo8s2
         6a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmKbThgzqbDY+/UyIBOV/py9QNKCn3663FFj9Ytmh4w=;
        b=rL+6/YA1l28v9ImsUQGNUGjKH/13HIkYMgqdcWLRUfGQaBDXx4wB6FJXpYSraViMPi
         9R3JdKWWo8+wfJpvE2+hQrcf5xc0P3Ok8M+5iIoPSUxEyhFPK9j8315rtn93tNYnydN9
         jrbr8gfPf+WaHbXSRKPbjeIYUVLnTIZkoS6LVbmQz/LaduVOHcgFkQUR1MOoHzzyLno1
         yf/JQ331cvQUnSqwAV2hZnMoUTQsR7IAzGQrTVPGYW9JpNFQ/nGdwyA6hrjpqvnGga3B
         dI0Fahqo3NmzJjeUK0E8N5n1w2D1nV7ZHpUXqrrDLvtBqcddHUerhENB9yzbvuhK4X+P
         fhYQ==
X-Gm-Message-State: AOAM530ShnYbsMpAZkT5wzCsds64pvKtfNBXMEf1Xj5XepHzrZVrSEfg
        tEdZ8eGLjFq5hl22TwZ0n4neng==
X-Google-Smtp-Source: ABdhPJyM5pqCEbrW/ZjKyxLXcqHXTZyqjPKUFbYo6PArPLcEjQtDn9LMKK3iD2Z8Nw9stnH9fQOWfw==
X-Received: by 2002:aa7:9dd2:0:b029:13e:d13d:a109 with SMTP id g18-20020aa79dd20000b029013ed13da109mr4276909pfq.37.1599725561077;
        Thu, 10 Sep 2020 01:12:41 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:40 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>
Subject: [RFC PATCH v7 02/21] riscv: Rename __switch_to_aux -> fpu
Date:   Thu, 10 Sep 2020 16:11:57 +0800
Message-Id: <cc97813e4b83f66b1b069114bdba54c07592490c.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

From: Guo Ren <ren_guo@c-sky.com>

The name of __switch_to_aux is not clear and rename it with the
determine function: __switch_to_fpu. Next we could add other regs'
switch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/switch_to.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 407bcc96a710..b9234e7178d0 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -44,7 +44,7 @@ static inline void fstate_restore(struct task_struct *task,
 	}
 }
 
-static inline void __switch_to_aux(struct task_struct *prev,
+static inline void __switch_to_fpu(struct task_struct *prev,
 				   struct task_struct *next)
 {
 	struct pt_regs *regs;
@@ -60,7 +60,7 @@ extern bool has_fpu;
 #define has_fpu false
 #define fstate_save(task, regs) do { } while (0)
 #define fstate_restore(task, regs) do { } while (0)
-#define __switch_to_aux(__prev, __next) do { } while (0)
+#define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
 extern struct task_struct *__switch_to(struct task_struct *,
@@ -71,7 +71,7 @@ do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
 	if (has_fpu)					\
-		__switch_to_aux(__prev, __next);	\
+		__switch_to_fpu(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
-- 
2.28.0

