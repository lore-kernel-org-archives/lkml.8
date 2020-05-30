Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3893C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E865207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIBbFEvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgE3WLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgE3WLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A8C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:41 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q18so5953563ilm.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LXLtg2uPDVGwNw61GJ4ugRE8QvDMri3kJv2Q2gM5QA=;
        b=jIBbFEvN+n4/jkf7n820inTZcD1n72w15iUCJJdgAom6YfokaKEd5kaqlsLwyWRdTh
         Wk1gtWdLoT74+ZtcLOK5wZFZkEI7pVMdpcOyeinkoim1uqgJHGxKT8w/tKVBlG0j0KP0
         5Nyw5sLRgf9n+azlf10usDdtImsbGwNs+uT6hjXQ5yVPQGfEjenB54IMOk57julrEv8R
         DtsMcLZ/ykVJxB1iN/GBIEqThs/1HM5nG8M67rzNjzppnm4Yxvk1XOKQQeZIwskZeKi9
         oDYpU8Vqr4DdjLc16VvmPuviG34j2f/ZKvCoDJP1bugU0cPCmNX054LRJvmPZYRCCis9
         1NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LXLtg2uPDVGwNw61GJ4ugRE8QvDMri3kJv2Q2gM5QA=;
        b=aQbROfoabvtKrLqsCLK0bBG4mTuoOlW816OSjWbW8U3DNynhy8MCxve01NzT6zuOfL
         0IRDtm0udfjddj9fEGLZTHwSX28y6XzwybjOuWYbqq0snlng1lwx6nwjwpcoA3Ha/1l7
         mMeW+JxaNFd13k7F3Qb8qCfT+k6jx6ZFUx/kanF7MicFFEK8SK7ZT0C28v5FyK+oWuFv
         leCK6+vhnGY5K4nUY/qVr2DVyvH/wmQnxKUmLI6/4kGIv1DlMbUvPsf3jRum6suIrmwu
         d+IHxHOg0XPzSc91uq22T7SwenvpJZWdPkMkXLbsG0MtOg0BsU2b/aExHXxKDL/fh0aR
         cq1A==
X-Gm-Message-State: AOAM532UsXMmp5vMqZjO7ftRhJwGTgZk/s8rc7cNxddgDXidt8R1IFoP
        r4Vvxkz+MwO9UOuBAQdCv6ty4kg0tg==
X-Google-Smtp-Source: ABdhPJw8+EhF/R4PKISho+JZT/qFvxvPNaR4tB3BDIZPePED3MPWej1ixrbODHmud7DWkJw8L6bT7Q==
X-Received: by 2002:a05:6e02:68d:: with SMTP id o13mr14553675ils.230.1590876700756;
        Sat, 30 May 2020 15:11:40 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:40 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 01/10] x86/percpu: Introduce size abstraction macros
Date:   Sat, 30 May 2020 18:11:18 -0400
Message-Id: <20200530221127.459704-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200530221127.459704-1-brgerst@gmail.com>
References: <20200530221127.459704-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for cleaning up the percpu operations, define macros for
abstraction based on the width of the operation.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2278797c769d..19838e4f7a8f 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -87,6 +87,36 @@
  * don't give an lvalue though). */
 extern void __bad_percpu_size(void);
 
+#define __pcpu_type_1 u8
+#define __pcpu_type_2 u16
+#define __pcpu_type_4 u32
+#define __pcpu_type_8 u64
+
+#define __pcpu_cast_1(val) ((u8)(((unsigned long) val) & 0xff))
+#define __pcpu_cast_2(val) ((u16)(((unsigned long) val) & 0xffff))
+#define __pcpu_cast_4(val) ((u32)(((unsigned long) val) & 0xffffffff))
+#define __pcpu_cast_8(val) ((u64)(val))
+
+#define __pcpu_op1_1(op, dst) op "b " dst
+#define __pcpu_op1_2(op, dst) op "w " dst
+#define __pcpu_op1_4(op, dst) op "l " dst
+#define __pcpu_op1_8(op, dst) op "q " dst
+
+#define __pcpu_op2_1(op, src, dst) op "b " src ", " dst
+#define __pcpu_op2_2(op, src, dst) op "w " src ", " dst
+#define __pcpu_op2_4(op, src, dst) op "l " src ", " dst
+#define __pcpu_op2_8(op, src, dst) op "q " src ", " dst
+
+#define __pcpu_reg_1(mod, x) mod "q" (x)
+#define __pcpu_reg_2(mod, x) mod "r" (x)
+#define __pcpu_reg_4(mod, x) mod "r" (x)
+#define __pcpu_reg_8(mod, x) mod "r" (x)
+
+#define __pcpu_reg_imm_1(x) "qi" (x)
+#define __pcpu_reg_imm_2(x) "ri" (x)
+#define __pcpu_reg_imm_4(x) "ri" (x)
+#define __pcpu_reg_imm_8(x) "re" (x)
+
 #define percpu_to_op(qual, op, var, val)		\
 do {							\
 	typedef typeof(var) pto_T__;			\
-- 
2.25.4

