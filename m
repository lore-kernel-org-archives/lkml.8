Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2841EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F71207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dXN1zXMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbgEZHDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731461AbgEZHDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:03:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6182C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so8276325plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q8iHAnjKh91djitETlf/VgG+9uuO5Xz5Jn9NWjplsUA=;
        b=dXN1zXMx/+49puOgrK+roK/nSE/IJAuj061+r7UMKKOc0JlZEfQoopeb7uwdGhPJPn
         euVPuilIqf8GcC1x2EFGdT7wVwgeNy+KBHSUE7k8EhNYaceeDoZ8b+N4uzxhncPNiE4/
         CQzyeS1K3yKWjKykMYL32JAHhEG+MP310uEQmTwIaxPG5pfo0OEAGW2WWDMoSMnvOf8n
         Tv+jQVOcZyvs+RGTeT70uhn+SznebOvx4bRxAvy7Vy5d33O4Mun9I5TKDyCAzhywhLzv
         1RozvzrbKgMOaD0BHm0rbs6WttdQEi6VDZ/CD+nJmEUwkm74oyUg7I65NGh3mnMM4DqQ
         vHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8iHAnjKh91djitETlf/VgG+9uuO5Xz5Jn9NWjplsUA=;
        b=CRwDZPGkuH3d8KhO8AaFpchbgtvNtdoBFwbNhdFuZXlP+PaUZ+WKAIMoaKXAYedqDB
         UBqGY7DtYMTqbFgB1S6jnsVKuRfeXO/nmQRwSNYCZPoybTh+cjjVs1MynbS1U2bWMGmO
         KMaVIaVM8EZ8sGhM4sBvaH1tDh4fQY8FD6UeN5TnEw3U8LGEJBeiSXFngq7B57MS6Yxy
         cIhUejgtBiLZym2mpkZP0D6tWmv5Qx4DDpvUeUpkp7B4PTYJk9LqN7IgSnd2kWexcDHp
         BUiZG5YEMWUe3T/+9mZT0iixC0ytgpBySNYf5mQa2VZUAX0awbOLoT3M8Z+8hPULlh6t
         g7hQ==
X-Gm-Message-State: AOAM5333GvH2VPNWs3c3Ln4SzN+VQNuDkNUbUAwfSu3vIb/3PgEx2GM4
        C/WEtuPvRlEjEiEfkrSjaZF8dA==
X-Google-Smtp-Source: ABdhPJx2qW4sRtTjN4ECPJKyZajPz8CgvGSiIMT0UcdKD02BLEP4n66DvuAwNXezHwLV2+9s5eof/w==
X-Received: by 2002:a17:90b:8d0:: with SMTP id ds16mr24740218pjb.174.1590476584352;
        Tue, 26 May 2020 00:03:04 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:03:03 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v4 07/13] riscv: Add has_vector/riscv_vsize to save vector features.
Date:   Tue, 26 May 2020 15:02:36 +0800
Message-Id: <e896db91e3303f64ac401021f848e536e9d42aaa.1590474856.git.greentime.hu@sifive.com>
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

This patch is used to detect vector support status of CPU and use
riscv_vsize to save the size of all the vector registers. It assumes
all harts has the same capabilities in SMP system.

[greentime.hu@sifive.com: add support for dynamic vlen]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/cpufeature.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c8527d770c98..5a68a926da68 100644
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
@@ -73,4 +77,11 @@ void riscv_fill_hwcap(void)
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
 		has_fpu = true;
 #endif
+
+#ifdef CONFIG_VECTOR
+	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
+		has_vector = true;
+		riscv_vsize = csr_read(CSR_VLENB) * 32;
+	}
+#endif
 }
-- 
2.26.2

