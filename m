Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4519C204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gojtw9TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgEQP31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgEQP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:29:27 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D91C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c24so6106914qtw.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFjHLY4WC58pfJwCBl5HkDZy6g0P3bNgInuOdM0yT6k=;
        b=gojtw9TNaV866cFCKtepYpIEDCV7OHhjOIUPv3qX/JP4zJauL20oxcRVS/rurJo7GD
         8t5PxyQpy7v7lP2xT7Qn+EFkHSjeUFhBDB3dTdnSmnCfEbfyamAocNulymLB2D94X39y
         QpnNn7BmwYg1gCjxKgi1v+vzGSXWHP6JcQxc0LWrc18G63u4ax8mdi9S7mBZPh7ClWmH
         VxlCWJ6AfOtppzjdjT7b/dhFjOHfPrgXDJ2vjA81b+A2py0RQ+LRMIvybqLtfrbw70Zf
         SEZW7AvhTpTVzhZ9q6yPHTHnLBvfESj99JhiWzJ9MgQ6fEy18Pcxfc7hgb/qRIC6O46N
         jAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFjHLY4WC58pfJwCBl5HkDZy6g0P3bNgInuOdM0yT6k=;
        b=FV4HCigtA5dVpiuHc4/anMeo1TYKdDvGjY7dW1h+q8uhFHQWqu9dFIjgv2G6AYO79L
         G7+UbNNBYYJ+qvFZCOx8oFqksIK7RUexyCG+HOVy+cTbULRoIVClbwXXRSjHDnETCit5
         6Ov8q3OqShya2X1iBAXCcaZ+2ubuNmpZq0dZwNBl4Z/M6+M7VMxJF2LiB7HD5MhjAiYe
         I3RalQZSD1U3MGvWdbx+lid2Igs80IohtJ0rL2RHD0rAMiwB8yjJqtQ4PJU7SlgPBgjV
         7MUuF45lCQ87y4J0m7qvVtoFQa9DzxzmPwIXOf9URrf1dDOfSTq5G23dBP31b+m5h2tg
         Kl2g==
X-Gm-Message-State: AOAM531vWZWhf1J2jt+7OAwgrd6p7NZ8c0+iCq6B2cuiAnHRRObDrHXI
        EzrzpzdKOXNPxZuOCbilJSbaGeqxOg==
X-Google-Smtp-Source: ABdhPJx35Y/W9fjL/roOifq3l+14KSHNMTdUeGzxATbZn3/2bv75EvQIM8XOlS7oF0u8ybHDFm34/A==
X-Received: by 2002:ac8:66d2:: with SMTP id m18mr12307464qtp.302.1589729365816;
        Sun, 17 May 2020 08:29:25 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 63sm6234335qkh.120.2020.05.17.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 08:29:25 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/7] x86/percpu: Introduce size abstraction macros
Date:   Sun, 17 May 2020 11:29:10 -0400
Message-Id: <20200517152916.3146539-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200517152916.3146539-1-brgerst@gmail.com>
References: <20200517152916.3146539-1-brgerst@gmail.com>
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
index 2278797c769d..89f918a3e99b 100644
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
+#define __pcpu_cast_1(val) ((u8)((unsigned long) val))
+#define __pcpu_cast_2(val) ((u16)((unsigned long) val))
+#define __pcpu_cast_4(val) ((u32)((unsigned long) val))
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
+#define __pcpu_reg_1(out, x) out "q" (x)
+#define __pcpu_reg_2(out, x) out "r" (x)
+#define __pcpu_reg_4(out, x) out "r" (x)
+#define __pcpu_reg_8(out, x) out "r" (x)
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

