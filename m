Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0424AC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0E5207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XukddvFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgHaHeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgHaHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:33:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E080C061755
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:33:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so2675472pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSKyECKPJv3nU8Dw0z78rbKPD6Ym+7wJ1BP9bvbD4E8=;
        b=XukddvFFFD1zAqDQHGH5BD5WQG16TAuPURkye7d9HyU9CWM3MMW5mrphYWciBvYjMQ
         ecqKx0HQGHRcoGhUVJKkt/cLJ5wgWBhz1ZXAvIzdbkd4QJ8i+ROEfIVWdxmax2urbTXT
         T6e2+SYopesFrk/+3Eql9NHSDJp9I82Uu0sSGx/V+kCeAym9SqNTO9XiAldBZkAYU0Lc
         nowzSN7fw1BHMVU98cPBf/5Z4GohXRJsIznsmL2zx40WRttsWBMTcWKodLpyIwXTXVLE
         V/IMWj11DNxBbiLyAsdJ97l0bzNTy2UmMZGAX5k1whgU5pJDBN874H+SR8tkrZiTKYff
         EL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSKyECKPJv3nU8Dw0z78rbKPD6Ym+7wJ1BP9bvbD4E8=;
        b=EsZntSWeSzcS1PMUAELy7j9YdGo+v+FjnAok6O+2bDFOmtd38i1tU39FvKzYn07Vb5
         w9R9F8fw66mcJff1WPNi1P8r0sGAfJQ9z0mdlW0Ypd9B5r/o+OHoK3hQnJ+qyWzddkJz
         Cpuyg4/imV30xfqylftpCl+QG8SP+CoDv9/DYLnypsfAhJkQem8HzqoFh4r3ymly/SFD
         ZT/0Ov4NXkJ6DuN5/+RlfUEv33Tc8A8H1Ei/4xDrjxs3j+o0kv+8Z+7YsDdpxCMykEpK
         zef5FVWsQRULlOCijJmMciDfeg2C0mGElz0Gv5JgL0/WzxzH0N1zrjJB1Z6zczHt7aHk
         779Q==
X-Gm-Message-State: AOAM531RueIAcuIolxgVsH6KsyzRuC1qEFCrR62FlOeyCeFxq45ElzCw
        4kmHFaA5+hb8CyDmYFFARyl2PQ==
X-Google-Smtp-Source: ABdhPJwjI1t2LrvO3ZA+rS9glLYEGRF+dDpUkHFg1fj5pzT7aca/4buH72JoatmkLSk5LD1aIQ24dA==
X-Received: by 2002:a17:90b:1093:: with SMTP id gj19mr221573pjb.149.1598859237012;
        Mon, 31 Aug 2020 00:33:57 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id m3sm6065979pjn.28.2020.08.31.00.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 00:33:56 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v4 2/3] riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date:   Mon, 31 Aug 2020 15:33:49 +0800
Message-Id: <c822805d45654074bb392126ed68915f7284b74a.1598859038.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598859038.git.zong.li@sifive.com>
References: <cover.1598859038.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
for RISC-V at all even though ARCH_DLINFO will contain one NEW_AUX_ENT
for the VDSO address.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/uapi/asm/auxvec.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index d86cb17bbabe..22e0ae888406 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -10,4 +10,7 @@
 /* vDSO location */
 #define AT_SYSINFO_EHDR 33
 
+/* entries in ARCH_DLINFO */
+#define AT_VECTOR_SIZE_ARCH	1
+
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
-- 
2.28.0

