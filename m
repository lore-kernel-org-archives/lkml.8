Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A05C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF572087D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wk2qKfa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgEZHDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbgEZHC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:02:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742FC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n18so9713830pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gvp2INvx+B9ss8TpUTp5IqU5aDse0eaPMYxEsTSV+gk=;
        b=Wk2qKfa30EWw+z9TkYF6hLLr/si2a5wR2YMqoap59kX9XvLPewWzOjzI5wn4Bi/Nnv
         fk3LGDOEzmXPFk4nQsjIkhYjzJ2Q5Oe/lXELWSYEIPhtVhjaJTLjOVqSgtP+qtdBAyBQ
         Q5BAGzV8Mtx/Qd5rc6oa2i7xd4biugKXhVN2wpOUVInELgw8WdQyoxcy9LO8NJoN+szY
         nlo90zNTthvChmUfjK8HZX4LpN7nRYRDr8IiVwWGHU+ljZMPWabfKbhrJSXSIfni+zS3
         dhEM5dympOAcs6lVpQoTvGjwfrkBkp+EWVdKbPM0kg4T3Mqcq3fht+jD7T824iDW4gPU
         2eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gvp2INvx+B9ss8TpUTp5IqU5aDse0eaPMYxEsTSV+gk=;
        b=YXn5Yr7zYB8K65K4WqeczE5PfgGIPsadGvO00Mpd+VmkE570BHI5vYyr+P9Ov+CHnx
         6qznoTbdHIFqWoTk5bo6mXqWGATydnh2N8TYyw+nNHYH7sPXDv0iyPjUmzJGBGNENxu8
         FGvT9mepucF+lTRZYU8y7QtatigMOHkN7eOkibnUIRajT9vdr9AGBH3LQDu8eKmWYCV5
         J502rLyCbcfvXKIzQLJhvWI0LEvlfFqJzG1mI2kleY2Q/JPU/BOJrfw2Vm7hXi+HAKCx
         4jj4FxNFA2xU8kEV7tPLKB04NziCswypEYj3T2u8mTlTh6MXfxMgVKkG2gtt10vTgx5L
         a/OQ==
X-Gm-Message-State: AOAM531lCcjpKliFqwAqImPQRyaXzZIlO0wKeIMV0i6T5kJNc6HUHU4N
        rjNYVr+put0pAM5d/UI/402QHg==
X-Google-Smtp-Source: ABdhPJxsFmvhNXhCO0KIlX/3Vpid91Ou7337I9p9atlNuHf+zW0JTlqnmoPDaxPAabSqMdGx/dh6KA==
X-Received: by 2002:a63:1a42:: with SMTP id a2mr925889pgm.269.1590476578281;
        Tue, 26 May 2020 00:02:58 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:02:57 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     Anup Patel <anup@brainfault.org>
Subject: [RFC PATCH v4 04/13] riscv: Extending cpufeature.c to detect V-extension
Date:   Tue, 26 May 2020 15:02:33 +0800
Message-Id: <eff3bcd51d9125f1d01150e9ea634668695f1b76.1590474856.git.greentime.hu@sifive.com>
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

From: Guo Ren <ren_guo@c-sky.com>

Current cpufeature.c doesn't support detecting V-extension, because
"rv64" also contain a 'v' letter and we need to skip it.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/uapi/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c      | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
index dee98ee28318..a913e9a38819 100644
--- a/arch/riscv/include/uapi/asm/hwcap.h
+++ b/arch/riscv/include/uapi/asm/hwcap.h
@@ -21,5 +21,6 @@
 #define COMPAT_HWCAP_ISA_F	(1 << ('F' - 'A'))
 #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
 #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
+#define COMPAT_HWCAP_ISA_V	(1 << ('V' - 'A'))
 
 #endif /* _UAPI_ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index a5ad00043104..c8527d770c98 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -30,6 +30,7 @@ void riscv_fill_hwcap(void)
 	isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
 	isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
 	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
+	isa2hwcap['v'] = isa2hwcap['V'] = COMPAT_HWCAP_ISA_V;
 
 	elf_hwcap = 0;
 
@@ -44,7 +45,8 @@ void riscv_fill_hwcap(void)
 			continue;
 		}
 
-		for (i = 0; i < strlen(isa); ++i)
+		/* Skip rv64/rv32 to support v/V:vector */
+		for (i = 4; i < strlen(isa); ++i)
 			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
 
 		/*
-- 
2.26.2

