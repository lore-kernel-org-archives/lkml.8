Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6650C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9109206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="rBOM5vGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgBLPmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:42:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36711 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgBLPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:42:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so2954976wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRco9JsmCdsskPKJMJX6LKetEjtGtQ7ZxpHTF2nQDdU=;
        b=rBOM5vGAEp7eYFE0Gflw+2hMyhFIG78V87Z7f3IBSobwMnUriX3HWpBH2zAVvUAnBV
         H1keqxl6PhrbT+RXAFk9aTBcaVIUqvaXWIhX8oCxsT/rK1GpBMY3p2hpo9vXD7ZyrMRn
         9QpKUmbcOYdA27PSd7aR/oAPnDXrQkmmLK06u8PjwajtCL6pclqyHgGo6h4jxLkmvpkl
         nxGZTEWZguphilCSWQtc/KTPtHLI+ERHG36YTJ2aMPY1ZAWDeB/H4nOak/jU8EsIclud
         J55Z/yfca4BZdcGKtifHkXiA4BYkHDwyxMyx/iixxdMrKeKt9Cms1E0IBIaSQpw4Mggx
         aT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BRco9JsmCdsskPKJMJX6LKetEjtGtQ7ZxpHTF2nQDdU=;
        b=RO7Jku+aXqZDI9B0yZ9KjsQHJVy3fvk8KS49wJf8vP2r2YlhYuf0n/l4URlyb8Ttxq
         6JnV1vG2uPTg+9tOTs03to808hePk9YC7rJPESQqY9/arfKIrF4e/U07SZzm4xpNX3Wd
         jN/MciYuCAC3jqSw/XQcW/HnYdW0BXlE1r2VboP+N7HFNQK8j9QhkfUSyXg6MwADQrf3
         UPFHTM5jaFLGg0zc8k5qrsz8JgNLHApHeNlT8eCEoaYfbyDvmYgpWjdtQnj6xf0ADDXZ
         SJQCOwjtA/jLgNbpb1AqoM3bYTxj2xv+FjlaOLEANiR0ZOcmqX0jwd75kbEwCwRCthUX
         1eVw==
X-Gm-Message-State: APjAAAW5+T79Ba7lBMZwa/JV33BEhMn6H3yt3oqw87KFWDys7Rfu+yp2
        RkT2qYqe2UreB0F4ardDl89ZQvRQNz2wS/Yn
X-Google-Smtp-Source: APXvYqyjzGz/67nrV8I1CpBMBG9Njv+UbZ6JgXPMgnK/ATFaasxB+ZHAObrBTay54qqDfbHpSQTOSA==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr15620215wrv.316.1581522159301;
        Wed, 12 Feb 2020 07:42:39 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q3sm1110916wmj.38.2020.02.12.07.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 07:42:38 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH 4/7] microblaze: Add SMP implementation of xchg and cmpxchg
Date:   Wed, 12 Feb 2020 16:42:26 +0100
Message-Id: <c841b4e94dbb6e2dedd30b6a4c1a47090b5c7d9f.1581522136.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581522136.git.michal.simek@xilinx.com>
References: <cover.1581522136.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Asserhall <stefan.asserhall@xilinx.com>

Microblaze support only 32bit loads and stores that's why only 4 byte
operations are supported by SMP.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/cmpxchg.h | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/microblaze/include/asm/cmpxchg.h b/arch/microblaze/include/asm/cmpxchg.h
index 3523b51aab36..0c24ac37df7f 100644
--- a/arch/microblaze/include/asm/cmpxchg.h
+++ b/arch/microblaze/include/asm/cmpxchg.h
@@ -4,6 +4,93 @@
 
 #ifndef CONFIG_SMP
 # include <asm-generic/cmpxchg.h>
+#else
+
+extern void __xchg_called_with_bad_pointer(void);
+
+static inline unsigned long __xchg_u32(volatile void *p, unsigned long val)
+{
+	unsigned long prev, temp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %3 to %0 */
+		"1:	lwx	%0, %3, r0;\n"
+		/* attempt store of new value */
+		"	swx	%4, %3, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%1, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%1, 1b;\n"
+		/* Outputs: result value */
+		: "=&r" (prev), "=&r" (temp), "+m" (*(volatile unsigned int *)p)
+		/* Inputs: counter address */
+		: "r"   (p), "r" (val)
+		: "cc", "memory"
+	);
+
+	return prev;
+}
+
+static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
+								int size)
+{
+	if (size == 4)
+		return __xchg_u32(ptr, x);
+
+	__xchg_called_with_bad_pointer();
+	return x;
+}
+
+#define xchg(ptr, x) ({							\
+	((__typeof__(*(ptr)))						\
+		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))));	\
+})
+
+static inline unsigned long __cmpxchg_u32(volatile unsigned int *p,
+					  unsigned long old, unsigned long new)
+{
+	int result, tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %3 to %0 */
+		"1:	lwx	%0, %3, r0;\n"
+		/* compare loaded value with old value */
+		"	cmp	%2, %0, %4;\n"
+		/* not equal to old value, write old value */
+		"	bnei	%2, 2f;\n"
+		/* attempt store of new value*/
+		"	swx	%5, %3, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%2, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%2, 1b;\n"
+		"2: "
+		/* Outputs : result value */
+		: "=&r" (result), "+m" (*p), "=&r" (tmp)
+		/* Inputs  : counter address, old, new */
+		: "r"   (p), "r" (old), "r" (new), "r" (&tmp)
+		: "cc", "memory"
+	);
+
+	return result;
+}
+
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+				      unsigned long new, unsigned int size)
+{
+	if (size == 4)
+		return __cmpxchg_u32(ptr, old, new);
+
+	__xchg_called_with_bad_pointer();
+	return old;
+}
+
+#define cmpxchg(ptr, o, n) ({						\
+	((__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o),	\
+			(unsigned long)(n), sizeof(*(ptr))));		\
+})
+
+
 #endif
 
 #endif /* _ASM_MICROBLAZE_CMPXCHG_H */
-- 
2.25.0

