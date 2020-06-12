Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80138C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E11207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BdOZaJOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgFLHLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgFLHKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27AC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so3478103pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hbkAgC+PquBUrK8WyR9UJ24ePGDUqr+apyFl5WJvPs=;
        b=BdOZaJOGUOxHwgLXTREzQQgP8IdkkhhphjMQdSk4LAZItT68fp4I7T5uLiQmW5eB83
         Y0/HdgMcCcyAXQSt9i1JrgNLyRbXymJB+E+El2K57HK08ChYQreNSfO3lm7AHEx4yx51
         6RYoVnY2m1QhDzqT5X+mKTGBYfPn7negLN43JapDLw2h9AHt+YB50s/W2d5+CujebY7T
         jSqFMNWEg+nJZkPVyMSL7prSubRAa6GzZ0o0OQgu2aj/VNCQmRJPHxeqlx9Xbhq8+jut
         E5O2Z+TELL7sIdOWkJw8rgl8cRDatcdBo96GiF+6hdkEzqvAc80AGxXLHZtr3b1jZNay
         QVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hbkAgC+PquBUrK8WyR9UJ24ePGDUqr+apyFl5WJvPs=;
        b=ZSSmMBpsKxPsAK2IpXf/K1UIVVYk4OpdGP2SsqhXFHj+FPOLwNS8UpXQumqNovPXQN
         EuWpLg8WJVmtc8cth4tCp5+B+6kMrGCxiIFpajZKmJMU0qHwZ7intEHi9g0yULaVtLyh
         HtkMNgPlbW231wpnkKLEmLRIOQMQIP5AW8BUGMA4sr0BvvdyixTYYDl2Copwd4PIvSyy
         G4nayANpBSeLEHm7/p0TE3QW3P9R04RQsWz16dqgOyig/RWR7aN6a1ZnzUY+T0CJySIw
         u8549+KuXg/hpkjYAlyH7tq5UlMCjQnqafpdh5y2WAcQDh0Y8KOwZ7tX7A+fbXxayBKV
         K0LA==
X-Gm-Message-State: AOAM532MZztuBeki5U2SOEBmtFd2jOnQbODVeVBd4veSmLQ3XEY2jIF2
        iXm2l5On8l3eINHhQFXTM7c8sQ==
X-Google-Smtp-Source: ABdhPJx1ZHDZwPoaF4NxRGDU4vmr387qwe9VI25z+habDuxWepIlSNSsC2mvx4ylZT2lUrL0Vd9VPw==
X-Received: by 2002:a17:90a:e983:: with SMTP id v3mr11563272pjy.71.1591945821531;
        Fri, 12 Jun 2020 00:10:21 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:20 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Guo Ren <guoren@kernel.org>
Subject: [PATCH 05/13] riscv: Add new csr defines related to vector extension
Date:   Fri, 12 Jun 2020 15:09:54 +0800
Message-Id: <cdab13bac12143f171bc7cc98b1b511f3a536ccb.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
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
2.27.0

