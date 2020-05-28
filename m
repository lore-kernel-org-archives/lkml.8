Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527ACC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304CF2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZMjx8+9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgE1GlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgE1GlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2DDC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z64so8472155pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gvp2INvx+B9ss8TpUTp5IqU5aDse0eaPMYxEsTSV+gk=;
        b=ZMjx8+9k1qlKADWoYFMr1t2to6kbxg7plETGIOt3xM45sBIHxWuegyLkn4B7CpKpnG
         VJIkjRmBNAb896IRqlZ4eibnkzID+q3nu7XThatd8qGEZSKMcjYiJb4F5cnGLQv/n3G6
         5k97qBEAh+1o9FN7KP74qpU3VlxCFIFMX0fn89pFCNSldqS1Yq0s+LEYJlas+NKE95Ez
         nQFN7K1bmnStT3VKkK8fnnf95wyF3rmHegDn7a1J9sSM9buzRVt7rldtEfdz4hhiIkzI
         r/7tTNfaugYr9dtVc9buZh90zWu0Mg23fulWV2oVfkvBQXF6EqppfSK5oLDj8sOUVd+z
         Ozxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gvp2INvx+B9ss8TpUTp5IqU5aDse0eaPMYxEsTSV+gk=;
        b=lESdDrIybp4cnjQYnb10ZvUdtrd8STzeg5YXugYouujNbY/b95efdj/xBcyWrzs4Bo
         dqM53CylZmyeE2nEnPcLIoZbhNGPl64btDj+ZME4UHTbJOEAVm5S35avwCn1GZwJxUtr
         iS2AJDmy+8W1nGFmuzeTvzOWd3QymOidX46wJ0tgHHgioNSloFAu6JcdxeqFN4abUe4A
         KMSmK79aGhh/0PnE3fNgK7kTPC0cHOmxzeG0SsRtqLyC+EmJ0xk5T0ARHS7W3UM64m9s
         TJfufqclxjAobIu/yDVsFDMc4v8B0AANNuphx07qk5KW0Fajh4pS5eouPKfCWv/SWagB
         PkhA==
X-Gm-Message-State: AOAM533XwESYOrZsEawUZ00Ua26wUJetKPwPkthSP9oQQGrZQJO95SV5
        NhbDMzQzWzP8CHB20okJynqSRA==
X-Google-Smtp-Source: ABdhPJxrQtY0V5qN9YCUcZBCzMhw0xLetgJwr2kAdy3xYpSMNC6eHCcgX5en7iP8ooEjnC0FvbOTew==
X-Received: by 2002:aa7:8ec6:: with SMTP id b6mr1588810pfr.272.1590648075534;
        Wed, 27 May 2020 23:41:15 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:14 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     Anup Patel <anup@brainfault.org>
Subject: [RFC PATCH v5 04/13] riscv: Extending cpufeature.c to detect V-extension
Date:   Thu, 28 May 2020 14:40:52 +0800
Message-Id: <4b2a5ec77dd0eee02818abb036518930fed8b105.1590646208.git.greentime.hu@sifive.com>
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

