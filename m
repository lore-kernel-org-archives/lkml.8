Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFEFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB71620738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j8c/SjYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgH0IWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgH0IWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:22:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC06C06121A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p11so2918116pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSKyECKPJv3nU8Dw0z78rbKPD6Ym+7wJ1BP9bvbD4E8=;
        b=j8c/SjYZEaoP7zhOS5rATU7Hbq5B89gNnCBQQwgj5uyPgChWzW8s0/U/DJBwmChybQ
         J2cTBCa+9z+RT19XRaIcp2db+JQlBlgzvDHur8GGCVqRrSd3xptZn16LsVAQJ+LmpKIp
         r5qGd9bDL87qMsY5u6SuExOU9j+Vg0xFyx2gs8BkjXfnNxwgdRdIhAuq8IvDFtwcsEAX
         xdg9wWmdNANi3h1Dg1fYVG1m8PIbCqkdbG0N6ehkzEsLDpoWjKceiL6Io476EB8Sx3hV
         t93KgFL5wWuSvZRajz3af8lo4VmVjD9ep0Zu7tXsUW2OkGLJfWb1kbGfzraLC2yMKPln
         2u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSKyECKPJv3nU8Dw0z78rbKPD6Ym+7wJ1BP9bvbD4E8=;
        b=nNjspXptx4LO0rcOpfVc3UYiHrFqeo0E6XsYA2VmQ6Lt5Irl4teV7WQXDFU+x2JGsY
         GGqiNOi9lIq0Tsxb4IXIE58o/z0YXRuKEO6gF+/CkEpM1Lw4c9RQo/Y8Z09Y2+Oc/VrZ
         yP8rGLlAu9FFn/jgs3rZSf/meR4mXPH3gneHy0WjcqU7lniKmbugi5IrV85K9eywPcKa
         giTrIaipo9p6p+GL3i69Te0IikYetxWytZXFv5i6mPinqwvSpE3or1FYDqqQKy7fCgZw
         Ft8gFiyfdtOJCjNWQSV3rV/Z3sJXzGgtdZMrGwCbdeFCzGF4yjZoXjsXouh5xaGvI3Ec
         y3/Q==
X-Gm-Message-State: AOAM533awDHG1pliJNkw5dSs9KIqZd8RHalpTdeuJA5WdEtxtIaS9AEL
        ipbd08PZ5BObiAdhSGEt12B5Zg==
X-Google-Smtp-Source: ABdhPJzkF7i7qpJvM+h8ORtoArVh4alXGnJMZV02SIWConIcos1OiM32m8VKq0zhaKQR/l3q0g05OA==
X-Received: by 2002:a63:7b54:: with SMTP id k20mr13013755pgn.75.1598516556721;
        Thu, 27 Aug 2020 01:22:36 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 124sm1828351pfb.19.2020.08.27.01.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 01:22:36 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v2 2/3] riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date:   Thu, 27 Aug 2020 16:22:27 +0800
Message-Id: <1591b508db1564adcb2179e310d9df2e79411c92.1598515355.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598515355.git.zong.li@sifive.com>
References: <cover.1598515355.git.zong.li@sifive.com>
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

