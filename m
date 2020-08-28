Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297F7208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="COa8vwjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgH1HJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgH1HJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:09:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568EC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 00:09:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i10so36300pgk.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSKyECKPJv3nU8Dw0z78rbKPD6Ym+7wJ1BP9bvbD4E8=;
        b=COa8vwjHx2ZzN6nPPNKrxFxN1fyA0xYJ5MZm8IQjFG0daOd5bSUncn2eASIkGUSnYl
         17G1fa5Vz0MVNGq0T6LQZxSEHT0N55wxXo5g7mGBlPhlwYiM8ZA6FPRaB1eY8euSv7Rm
         ofjEK3EPVhaHH5u+LWWXyEUcgXlHUkMrkQ7bwDIhs12viVsvFVLmyJnEMQZLTv0R+aYX
         ED6ugS/WILDQ5IpAGj0usJwyth1Xl9UQIlCOh9JGJzA2VxJo++76eoX7/PIZDPBDNWtE
         D3vLdW6OwKHkHh3q2o4vxy1JKhgcjoRf/eUSCicm6uw3tfvz3HVP7YML1mQjxCGE5ZfY
         XCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSKyECKPJv3nU8Dw0z78rbKPD6Ym+7wJ1BP9bvbD4E8=;
        b=LQzGVMq82D0YYsZWZYKxIuvCcFlE6rPIRXgpfvzwUDWjbvX3v9TwH+hiVQfzEj1+Kt
         MKByca3F1FxjwuFlWMHWVFSJKHMoHqilVzrkBif0hZxUuUCXuo4Fd+/ELIs/CW6D95+m
         1sSDKY0peJ9jim0bgojrkl4pw0p/fueUXHJKp4x6NogX5eu87XrD2FjPiXZH+YcAjtki
         wIW5WGDQ4VzYTHLSGWx7tXI1esTSrCuho0Sz/UpcqlbCf/lQIopNwgcJ+Crw6LR+m9WB
         xap/5Cf+E72osQg3Q8Gt1oaMGnV0b84MacNzZyyPUQ5pmW91Gk8Ujimr0+VBIf4TyYyo
         C+UA==
X-Gm-Message-State: AOAM532kYN+D25vSqeMyHumRP+Z8YwFtOctXnPijiBSvqAUatguvansq
        Te6uluXLv93z5GgGB1mJai5rvA==
X-Google-Smtp-Source: ABdhPJzjb2TTq/xU0YJvZImSFFpQX7BbQ6hxsBVGAZSfnTtudzoH2x/NN+zAMvGVS9h3tdDUOF9aOw==
X-Received: by 2002:a63:fc5b:: with SMTP id r27mr252356pgk.142.1598598554762;
        Fri, 28 Aug 2020 00:09:14 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id b8sm434158pfp.48.2020.08.28.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 00:09:14 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v3 2/3] riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date:   Fri, 28 Aug 2020 15:09:06 +0800
Message-Id: <1591b508db1564adcb2179e310d9df2e79411c92.1598598459.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598598459.git.zong.li@sifive.com>
References: <cover.1598598459.git.zong.li@sifive.com>
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

