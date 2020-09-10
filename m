Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025BDC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E362067C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QMmGQYeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgIJIPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgIJIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:12:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E09C061786
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n3so961584pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBZg38YV3F0UBIikGh/iifz81s+4k+D3Kp7Tc68TLZI=;
        b=QMmGQYeC6WHteUVor0MkG/umERsoUyehK2V8+a5Xgv0HC+1W/5a/3SgTR1co9SZdzr
         b0TxGgynak/YrX59cQrA2aDjs+g1TnA4h28P1AoV4tqxL63aD4nfD9B3TmCMskjuaaL0
         ED7eIL2mKHpTHcOvzwn2ud/ORFKZDbShWyGUO1y4bKo2Ez1uY0bFyEpRziFilumZSLv/
         7ZuzbGVSFp6BPE8UmMIgcRfIUlyxsSeeN4XCD2hILXiWjD/pn+uUb/um1ehh4K1BPWcT
         mwT/t1FlGLgKRToL3dEkcJDNNNOGUvmkvROg7n5fOJK1NEEf+Ar/OI9LbaMmXQut80ou
         b+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBZg38YV3F0UBIikGh/iifz81s+4k+D3Kp7Tc68TLZI=;
        b=g02nkgZy5PX6KLVuO7S67Tdt6y729W4YMJdf5py0QKOnnNsJAIw6NHESZhNpTmZzlW
         g1XVOg/GZJLhRNpuYfGDvFUwPsyyZySaF3r3k1hh68+YDLWdIMQLOrcG3K669lOq0NQv
         gyXwo0xwsZBWAiQMtGvdkJrlA3cALBDXvkrEGlOfk8JWHL8xJbVbgTVql1/fRXg0Kvaw
         Urd3V/NA1RTM1WUY7T++zRCLSZu3ifBHUoDN6LS9m7N0QvhnlCGygQcfJedOIhgjxWtc
         68YJMungJzsOY5Rw021wrDesJ2Yfc+ygoMXwomYzT91LHmkc1TdSiWcTCLUaqKfJsS5C
         T1IQ==
X-Gm-Message-State: AOAM5316abl52AB/QO2li5b9MSOF+pe6SKZaaKzNA7ZH7aez0dt0yDQ/
        em74EquIx+DC+XvsjcOaqxLffg==
X-Google-Smtp-Source: ABdhPJx5AqEGmcn4ZmggG6tMGtXj1OMr4k67KXCra2/D96tG0n9Nv2iG9jor2KACZRPMEfu9BZEzBQ==
X-Received: by 2002:a17:90b:815:: with SMTP id bk21mr1154992pjb.57.1599725565272;
        Thu, 10 Sep 2020 01:12:45 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:44 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH v7 04/21] riscv: Add new csr defines related to vector extension
Date:   Thu, 10 Sep 2020 16:11:59 +0800
Message-Id: <c75e35c53ad8eb24a3f21f17f383d1f0177138a8.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the riscv vector spec to add new csr numbers.

[guoren@linux.alibaba.com: first porting for new vector related csr]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Acked-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index cec462e198ce..0d4c89fb97b5 100644
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
@@ -111,6 +117,12 @@
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
2.28.0

