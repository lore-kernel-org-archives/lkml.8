Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8929D207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OFiDcEYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFLHKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgFLHK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713DDC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so3706242pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pbP82gUL18C1Fla9shgiQQ97uS+492J9jEgfpwVcbPY=;
        b=OFiDcEYWxQE3WkBK3dTvh348Jh2eoGWIzY5+cfmABqwb4g9kCFVGZIM9AlCnv/9Q4w
         b1QHy35qJGWGkZzFRlEo3wz1VFv3YEkzl4ypBsfEEpldy7BHJoozzE9WyJcWaKMuD+CB
         1kt+dzz2ZiLJt2ntDrB7ezZdqkR0kec032PVhQljIxRVHF89Ah+Uerk5E9XeNAYUU+Lh
         D9VNWWwbZdAmy4VGcNiMbAaYcqwlKCCjfVQR9ZTXm93aAg4gSkK/hFWdC/+TcA33ViGi
         4PeliW1MnMFo2qlbw3xTD3UUSmjEibBSBbaGbMQ3+/0QcRVTDsgPKpHq4dhrLRPezY5q
         LczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbP82gUL18C1Fla9shgiQQ97uS+492J9jEgfpwVcbPY=;
        b=pcCjOFOqxcxqJiwAJeFxyQpJ4XrwDIObj58XexGif/I4MyRmmFdkDMflckvSseQ25/
         GDH0Zwb76qSFmkEwvxCV0JqLOTucO5fzOzuvV58L98Dhvs6q6AoTf6hz1OWqMd8Sw5mP
         5EBtbRcThx5YSvySLv/08lhPoebTDZHthaQX1jYxuQjlB7MbLB6vtXVCKENWEXh8UsDm
         6NonIiAbj7UQ6lnpvvZyu9lECKeGiq7sbbmjPMNlKp0TsT59exFS3uQK/WVnvaRXyMjM
         a2bCIK8XWWfyFO/OHV/NT7EMiZARRbO2pjebpFIFoD/GoRq9B9XyKHSTrxFjGXmrHimk
         JlRA==
X-Gm-Message-State: AOAM533puplJDjwfxmePKTAaE0aSkiOqhKbOjGL37E84SZZfpFsFGSB2
        XSTMXbZvcJsTpdUiMqFTc6UcNg==
X-Google-Smtp-Source: ABdhPJzYsgrvRY/e0uV567qf3OJr/AS7IFAJducWNceLl4M2iwG28zBHaJD4Zo9jtBYytldPZjj34A==
X-Received: by 2002:aa7:9a9c:: with SMTP id w28mr9821650pfi.295.1591945825946;
        Fri, 12 Jun 2020 00:10:25 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:25 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] riscv: Add has_vector/riscv_vsize to save vector features.
Date:   Fri, 12 Jun 2020 15:09:56 +0800
Message-Id: <02932e625077902209ab9967735607f6054cd4d6.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to detect vector support status of CPU and use
riscv_vsize to save the size of all the vector registers. It assumes
all harts has the same capabilities in SMP system.

[guoren@linux.alibaba.com: add has_vector checking]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/cpufeature.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c8527d770c98..9b02d8b069e3 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -16,6 +16,10 @@ unsigned long elf_hwcap __read_mostly;
 #ifdef CONFIG_FPU
 bool has_fpu __read_mostly;
 #endif
+#ifdef CONFIG_VECTOR
+bool has_vector __read_mostly;
+unsigned long riscv_vsize __read_mostly;
+#endif
 
 void riscv_fill_hwcap(void)
 {
@@ -73,4 +77,12 @@ void riscv_fill_hwcap(void)
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
 		has_fpu = true;
 #endif
+
+#ifdef CONFIG_VECTOR
+	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
+		has_vector = true;
+		/* There are 32 vector registers with vlenb length. */
+		riscv_vsize = csr_read(CSR_VLENB) * 32;
+	}
+#endif
 }
-- 
2.27.0

