Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C0C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E023D20735
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dEevPmr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgCXHbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:31:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35817 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXHbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:31:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id g6so7073182plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rI7k74kFCx75JJFZ6P5OAIxYXRc1E3R4Ch5Nvkd/PLg=;
        b=dEevPmr87gMs/zwZYhDr7kBAchZIIxA4j5XE/SWfIF4tf1bkYVtCjmF3HsMceLOm/f
         yMUMX1CJJOm8dr2xxEoJWUbfGXvxESvk3D0nxnwpGXEjuBCmUsgS16u0WGb8owp6HQw4
         IEug9xf/t27S0CWLebeXEEqDTvoaWjbkL720nZutV1M8l8cdL588L5zelE+ZOKxiTCS+
         vbMGHNscXpKxbnk87V5VOYQz2ImoBQUmms6OABHlwE0fY7e3BGB4yTliJXWw0s0KJMwR
         34bOJFpvs9St2+5ZOCOEN7S9LcoDAIhATu3a1S1NGHc8lMXQbEUh2u2WKje+RTRJjySE
         088Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rI7k74kFCx75JJFZ6P5OAIxYXRc1E3R4Ch5Nvkd/PLg=;
        b=TQ3pQ6qWLMid2yiz0BoRuN7W/Hi/hv94eQ8w360fcf7Z49JMhXayMwjdl/nN6wy80Q
         x+GW1zlXwbQsw9Uje83+zdtcu+6YkVDTQ2U1FC92QLrryMvTxN+erBSox8xeDSv/hdjX
         V8HQgkzEtcjSLDFfQsiPDkc9FbVWASFyjQjOLzhQ1AB+4N6gyQDsJWEiyJmbZpgVw9X6
         obAJIn0qVW8o+qrTMysACDK6h7oiHAV287xHauBlFu5Fzk+avy9aadd3kSwlslWBxaEJ
         5Y087iMO8zaPE6agpLv/ZuCsNOOIP4ck4Zs96c+Hcd9e0qkroqTvHn9r3Sb5FsEf5n7M
         D67A==
X-Gm-Message-State: ANhLgQ0Yca20gPdZixr7hJxUK299ZnZQN+XwnLTdNNsK3pywbmRA5rvT
        fL6ngD0iJtYCqYKJaXUkBc/qsT92Z0M=
X-Google-Smtp-Source: ADFU+vslTkhtG9uiit3rXTJkBTjyUlQnzV2opL3cYdGTfGD2f0Xo7eaCNuOpvpfefHtqiXeUtLDX/Q==
X-Received: by 2002:a17:90a:3606:: with SMTP id s6mr3821002pjb.195.1585035058819;
        Tue, 24 Mar 2020 00:30:58 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i187sm15124648pfg.33.2020.03.24.00.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:30:58 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC 1/8] riscv/kaslr: add interface to get kaslr offset
Date:   Tue, 24 Mar 2020 15:30:46 +0800
Message-Id: <cf8585177e6798095b1af02f28dad5a3271a761e.1584352425.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1584352425.git.zong.li@sifive.com>
References: <cover.1584352425.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interface to get the random offset.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/page.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 92848e172a40..e2c2020f0a8d 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -101,6 +101,11 @@ extern unsigned long kernel_virt_addr;
 extern unsigned long max_low_pfn;
 extern unsigned long min_low_pfn;
 
+static inline unsigned long get_kaslr_offset(void)
+{
+	return kernel_virt_addr - PAGE_OFFSET;
+}
+
 #define __pa_to_va_nodebug(x)	((void *)((unsigned long) (x) + va_pa_offset))
 #define __va_to_pa_nodebug(x)	((unsigned long)(x) - va_pa_offset)
 
-- 
2.25.1

