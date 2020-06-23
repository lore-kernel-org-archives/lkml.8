Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546BFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5462078B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TuCRazjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbgFWICn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWICn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:02:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CD3C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:02:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e9so9492553pgo.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ru8jPTPnBePyvGJchZOluuKt4Npgi7HZT0olX4LUWXA=;
        b=TuCRazjmS40grkDqJhwcvAh8RwtyFqD92Ki4Rz3qIjFPjt58XSWg6p6In9ykDmJJXW
         D3wx0UiR2A2t/JmpXXWckro9KUZ2IiR3myo9lPlRAzg4gewNK3N94Awjn2EkVJCNCO9Z
         r5FiCzfabQxxs3j+1xsO5xTazRPMCoxqm0vB6VKJnpzF7cx+Tt049EbnFJqbF0BNcsi9
         ghT/EtvEJ4WBCErg8YDKPlIwDOb1uMhaz4R2GveUKeYxGwq7bdN3d38NGbV4qEJaj7r6
         jHg8Lu4FuJGVKC+P1s8KOBQKvGCJSW+R/CJKlSoKyRhKKrik1eA+N+aHIdkFVuNhpH6Y
         FBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ru8jPTPnBePyvGJchZOluuKt4Npgi7HZT0olX4LUWXA=;
        b=WpSjRUv3bpcOCFO6EvWGZvsnGogSuaguypPYUPVSg9zA3HQPGrvYbHxtTpQ9volEw4
         UR3GRhYP+Rc0Pks3k2bqVqvzErD8HFUorM8UfHOcPpPphqKTfaGUVBHkmxnkdgua9VHq
         EUcsgi/0CeyNnQUPv6ZJfC4IJVBGNIhJLP42FsglGpTubaTpYe2bKDaMfiH2hSJ9IgrT
         4Y524shLiQgyxE42UxeeV4Yf4bKFu7wLqae9fUxHiQ5IoahCWPto0ef5T05ipv5Jybdc
         w5Ng4fMnFrgVSF8kHE7He1+px3lIR3+i7lc+tgZdypkdUIHsO+8afbArnNrAsvERbQnu
         hTTw==
X-Gm-Message-State: AOAM530VJ0pB3cNwoB3M22S5hQJlJbRkOCqjfyg4SDY4aqsZa3fza4xg
        UoHia0GoujvCuNKXYZfqpT3KYA==
X-Google-Smtp-Source: ABdhPJwNKGpmftqGSnIuinlv7FoUHRvottguTJgzZ8vYl3davjP/NHkvSa9jOZ1OJXxz90aZkipbfg==
X-Received: by 2002:a05:6a00:7c8:: with SMTP id n8mr23161403pfu.116.1592899362851;
        Tue, 23 Jun 2020 01:02:42 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id x4sm15499868pfx.87.2020.06.23.01.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 01:02:42 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date:   Tue, 23 Jun 2020 16:02:38 +0800
Message-Id: <20200623080238.122973-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
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
2.27.0

