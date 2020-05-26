Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51548C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2150320870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="myXzRI8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbgEZHDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731428AbgEZHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:03:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA610C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b190so9702247pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fC0RUJXoKmGwPm/9ciDiJFpYYSjjNjdLU/HcVXsBjW8=;
        b=myXzRI8vHTvuMn1skzPaxgHsAWGyE/YKC9onQaa3/nUUv0OantygxhQnmjREn4z41u
         gyqZUBWv646ooQYX+MUIGfHoE03hmS38E4f6yK3ht9Tgkmg2jZs8+QsWZ4G6ZbjGIgqs
         Jw9shadWDJDvbekhNoEQgrPxXzIBG5b9xH+R+A30aadarDPGgHY8rA7FiMmMQIsE9I04
         svK7h+B1eNycirHuzpnTaxILKe8uRP9PouC5DAECAjfvZM0ZAHNowK1WW5rNu1ixPvto
         NxtNLMPGuI5QezGB5iOg7Ly9xjnR8q67Gf7fjKnSKpZbMo+oOxCbajA37J33JlKPHK9i
         +8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fC0RUJXoKmGwPm/9ciDiJFpYYSjjNjdLU/HcVXsBjW8=;
        b=llSOLknPsj2pKEdb30GPQkOU1Kl29mEJ+j44UntVAwqHA5Qahg8cVDaKKYAxFwvJqL
         HE90yv3/L6eK+x1hM3ryxM7aMMeWUW0Ye9ugWHnAijJDPojSedgFd/6nPPFseW6RLUNW
         e4xJW2dSusI8TFxBdawt/+A2reyMSBam6j6XeJFO+kk32++HiijeW6DSFwp3GfILYEue
         wGr9zQf+spMAlpZkNjq9fYV0U+MIqFFf0jCAboHS7Dx1oyapn434L+Hmh6DYwpnS4KVp
         6yXr96v/9l/dg6JuJvBBeqgabgHiyYN7ZP4XdfGiqNK54Xc8zpW859XVlB8/o4yfG5nS
         CnSg==
X-Gm-Message-State: AOAM5335R9siVRcGwla2MpKku8JTqAcP2iKuziu//tFW4z5q7+A6Ub+q
        KAjm34jiDjJ4LkT2rL1zG1gmhw==
X-Google-Smtp-Source: ABdhPJxbLs8RJjoftufhwtlXW/MDHi61wqLYh5z4QBLCiJzyGQwGGz+patKM7N/4Ku5AJ4VPCCeFtw==
X-Received: by 2002:a63:3f8a:: with SMTP id m132mr5311368pga.225.1590476580339;
        Tue, 26 May 2020 00:03:00 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:02:59 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v4 05/13] riscv: Add new csr defines related to vector extension
Date:   Tue, 26 May 2020 15:02:34 +0800
Message-Id: <fe966314eae51a5089033f7186ac86c39719e0a0.1590474856.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590474856.git.greentime.hu@sifive.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
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

