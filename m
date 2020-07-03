Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413BB2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UOKz7YMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgGCI6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:58:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B2AC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:58:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c1so6472973pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ru8jPTPnBePyvGJchZOluuKt4Npgi7HZT0olX4LUWXA=;
        b=UOKz7YMBAA7xCoh6IUPLnINGs19MzIg/FeTTNL9SyQ3krPdSHHWxE9imlLWxdVCnj6
         SMLoMv5sAXFQe5U3/eLs0J0yhfELchfSq2eAnkx9ubF/dY1msRjhnXHxXD6XRme4U8BT
         4U5Q9dyTUB5yPXrEnU0W0tCgO+nlb5o5A10VPkQFJDwSGk5x1JCFlGA29+x0QvYNIsqN
         WKYkzcRIfMb8Iyu5kYkEyc6/+s39WrbltcztHTYXXqmwtbtBQs4Ymtvsm6/1hDs0lXTx
         7WA2GZUxjsJZqVMPrZou7uFHOyd4ro2irxp3OUeDtWEcaCy6zfx/szcaBAf2QapPsCDE
         8DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ru8jPTPnBePyvGJchZOluuKt4Npgi7HZT0olX4LUWXA=;
        b=sew7Qy4TdyMMF8bsS9FKhRnkne45Djoj3tO+yzqoym0Ie2nU//mBX8ucxno7yIFQkz
         7FBJZPtSh1TIspuD5ia1+R1BJtDUxDMirdQB1AJ5eXeB9ycsmfQHQbhO4T9l2zYlZGfT
         wjQdNm7J9SbNlr4UsexndKvdKgoZ6wANnD/oYqMxJy7HcJ9sBA0HZJYzaVZkewChsXCv
         rRj0aoOPc4AJMpyQgEPEpPTMQG9AuBwVPehYf3f1I7+Xl2wsk/tQDF2bmScf1XX13yk0
         iP6clm2cFkRyEbwIx7z0Rs1kvtSBhRdWpYYI9HVWfXxPx9E4xndRN+qvYCVCUnO4xTPR
         aKvA==
X-Gm-Message-State: AOAM5331RKDXFZ6X/n8vreSk0/QE2DMgJi12kHoC+DgmnQyz7CE/Qo5F
        7GkmUewpBDqhc0xcUTb5w3libw==
X-Google-Smtp-Source: ABdhPJzFsePizfLV1p2UZMgva9HWjdbpZ0ufsa2hiTQZfkyspRzfC1m6tnO6H1gH/ILSFkoaUKdfHw==
X-Received: by 2002:a17:902:fe04:: with SMTP id g4mr19644353plj.66.1593766682799;
        Fri, 03 Jul 2020 01:58:02 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id l23sm2126287pjy.45.2020.07.03.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:58:02 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/3] riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date:   Fri,  3 Jul 2020 16:57:54 +0800
Message-Id: <25223adbad5badb3cd0000df078b407bafc129fd.1593766028.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593766028.git.zong.li@sifive.com>
References: <cover.1593766028.git.zong.li@sifive.com>
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

