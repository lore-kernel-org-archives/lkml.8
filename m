Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37450C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1331C20899
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aQFJByr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgE1GlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgE1GlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933DC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so11102400plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fC0RUJXoKmGwPm/9ciDiJFpYYSjjNjdLU/HcVXsBjW8=;
        b=aQFJByr24EianeyilXbBPU5NMEkCsXaIesfejM69/UAdXLxk9743E0K01CU2/XDoeu
         5SMSUvyjqAqyiTO/T7Wkb7nZ4C+fut5RZpHs4OV8MW1W5c2wJo7R9tVWP+Zj5Cu85kDl
         ShoLpRGSQGzRH5qNV0cVYzhJ+dAHxL/R8F6P8DSG5N5lRuRNRCbaoDE2lNU2I7PQ4K4c
         zxJt0B59DrVdGdaP02PEGBFwRjmyKwHv4u25rZKnApaPEdaS3qcVxjA2djSQV1BasDiO
         73MPFdhZDV/yxCeG9n3Wa3uv0It7fhEpDBmgDqzTU5gmBtmcQc/HN2RxS9awgin+Tszp
         m7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fC0RUJXoKmGwPm/9ciDiJFpYYSjjNjdLU/HcVXsBjW8=;
        b=KjodackgfJUK1gy+5NFYLSyYYb7SykX8OhIXp+oulf0Og4ImwFDrRpltqv6hiGYhVs
         7eiBvbz1+5nkgGGpQRtnKHnxW7oBHbrryGf1Vd0KZnFJ5X6shu/mRkzHRRGJMXARnaax
         LrTzmUc54Y1aPnkUnW01WKJzg6+vxo97sYsd3AwAltwWQxnp+AloKAoEgsIg7LHP3KiO
         ldH5td3ZJqQ7ci3SZ0yTkRhLV8FvVxGPtqT9C+HA+jMPb/4B3NBXTtUizNZg3j3b5IIF
         fUQxyaJbP4KwTQzeSNWrUTLpr2ipBdD6WBZrB2XKukm1086oXhOizlSLFDkWNNQ6pC4N
         lk3g==
X-Gm-Message-State: AOAM5301IMpfF2tplt8VaTxoRQTtMI7YvznSzluvg19EGgPWDrz0uMO+
        zHJIYIixbkH/P1y6a9zksRynuw==
X-Google-Smtp-Source: ABdhPJwW/P4SJ4LYsKoqp0IU6dhl4nw3h0gsjDhLvHZ7slAFYi6AV9hjFG6GqKsuCmL5LcSeL/BanQ==
X-Received: by 2002:a17:90a:d191:: with SMTP id fu17mr2258020pjb.228.1590648077687;
        Wed, 27 May 2020 23:41:17 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:17 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v5 05/13] riscv: Add new csr defines related to vector extension
Date:   Thu, 28 May 2020 14:40:53 +0800
Message-Id: <d17991701f346749eda2ad3d295ac5788ac89af7.1590646208.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590646208.git.greentime.hu@sifive.com>
References: <cover.1590646208.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Follow the riscv vector spec to add new csr number.

[greentime.hu@sifive.com: update the defined value based on new spec and
remove unused ones]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 8e18d2c64399..cc13626c4bbe 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -24,6 +24,12 @@
 #define SR_FS_CLEAN	_AC(0x00004000, UL)
 #define SR_FS_DIRTY	_AC(0x00006000, UL)
 
+#define SR_VS           _AC(0x00000600, UL) /* Vector Status */
+#define SR_VS_OFF       _AC(0x00000000, UL)
+#define SR_VS_INITIAL   _AC(0x00000200, UL)
+#define SR_VS_CLEAN     _AC(0x00000400, UL)
+#define SR_VS_DIRTY     _AC(0x00000600, UL)
+
 #define SR_XS		_AC(0x00018000, UL) /* Extension Status */
 #define SR_XS_OFF	_AC(0x00000000, UL)
 #define SR_XS_INITIAL	_AC(0x00008000, UL)
@@ -31,9 +37,9 @@
 #define SR_XS_DIRTY	_AC(0x00018000, UL)
 
 #ifndef CONFIG_64BIT
-#define SR_SD		_AC(0x80000000, UL) /* FS/XS dirty */
+#define SR_SD		_AC(0x80000000, UL) /* FS/VS/XS dirty */
 #else
-#define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
+#define SR_SD		_AC(0x8000000000000000, UL) /* FS/VS/XS dirty */
 #endif
 
 /* SATP flags */
@@ -114,6 +120,12 @@
 #define CSR_PMPADDR0		0x3b0
 #define CSR_MHARTID		0xf14
 
+#define CSR_VSTART		0x8
+#define CSR_VCSR		0xf
+#define CSR_VL			0xc20
+#define CSR_VTYPE		0xc21
+#define CSR_VLENB		0xc22
+
 #ifdef CONFIG_RISCV_M_MODE
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
-- 
2.26.2

