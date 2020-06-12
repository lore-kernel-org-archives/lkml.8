Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36468C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7D320801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="doTShxH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFLHLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgFLHKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C48C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so3287184pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qon66DpP/9C+tl7pgvKjepLx67Alsh8Vu/kEKeYzw5s=;
        b=doTShxH7Y/dsPbNJ+cLPM0V+vYloqDfRvNPzA9RkizxyoybW7ndmznNSSY+wG1kDqm
         Ng+Eel87SwVZG83rOIZadRsSt3gxAR7jpYOX2FZ+aSDonbP5BgLDL9Pv325SEpwng3zr
         w+fgz2zljiaSQJmyjD/FhBu/apLQfKrqkwC4woE4TkgM4xjLq/JnzouAN3b30HOUFFUq
         +OMlTPdI6Dd6ZD9Ai/V7Lk7hnrJ/taVd8hS3a4cJ3DTtV/4eTt8VuXGsKw90DlX7CIdA
         DDYzPhr/m3TDfkbCMK1PRnMVDq436bX1UGTNY4/lsHiPOywNL9Z2r7AkZSQTb0np1pfc
         QLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qon66DpP/9C+tl7pgvKjepLx67Alsh8Vu/kEKeYzw5s=;
        b=BZKtb5QYA3jIkUqbXJ5ACz4jDKLxDM9jyHH8mSMX3BLLx6SrcaXrD91wpNxvcWknSx
         oRR4YSSPf8Kkhn9M7fXx+y+Qpms/4n1waJm4fAhIzsrYnMjj0ZnxHYEKpu8wudQlYKhR
         P7Um0VLlQWT+vPKSbJWXsXoTotVFOj6keTn/WRbsXCNuGzdzPkP+nbeGm5NYrPJfBDWx
         SONySmeSsNJuZMD6GSla2anz6/vPDOj7DS4om3DwzGUeM5FJvYee014nHdXrFQ53l0Bk
         qt3ebtVEIFztaAMiLF8KDHFV/BMIDxDA2kKZolri1x97XWZWsPoTdHJ6Wrf3Z93UQIja
         vPsw==
X-Gm-Message-State: AOAM531sUg8KBuFeyCehn5yFIJzyer62y+4WQCAxH22u25438cksjYnm
        SJtBCq2Y2ciIsN+4ydciBdDguA==
X-Google-Smtp-Source: ABdhPJxdL3oZhAFHxU1Uft6EO9Gm7i++9n8ABoOq3s6toXlmfYm7sY3HquRLodQM9zQo9yUiedVebQ==
X-Received: by 2002:a17:90b:882:: with SMTP id bj2mr12458129pjb.122.1591945819238;
        Fri, 12 Jun 2020 00:10:19 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:18 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>
Subject: [PATCH 04/13] riscv: Extending cpufeature.c to detect V-extension
Date:   Fri, 12 Jun 2020 15:09:53 +0800
Message-Id: <a5568f4547da37b48852f4bce08a646fb9aef903.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
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
2.27.0

