Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38933C18E5C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7D02084E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XVjAAwpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCIIXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:23:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35407 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCIIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:22:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id u68so3778586pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOiyM2uGzUc6zhWPwWC3bZJGaa62phcZiPuWR1LO/LM=;
        b=XVjAAwpw3TIfdPOsY5Hi9J6JcOtTWJAkDw9er4N1bmY9EtLRPbDrcMGvAuAN1JHlB8
         dvqJ/Id+necoQN/ItafyLCv12x3kRG6RRPocDa80UcowtkzhRoeyWwZoycO+Bt1Jb9qp
         HUpIX3GJRn2JzDI82wwL+0aPH1UbuekEvyEs/DMyolW4PH6WGXB1Gy7i9TLlmXtZUgAG
         jkC2Pq5L4tjZjokC/bwL+s2QhLWvMFvyyu16q6xQ3n23abW4DhRd7bkhBd0wUFafG4cG
         ZqvbxIyP/bpIUcqHbWkp6RsM/kdKT7m5GLx0ljSkH0K7ZFK5hXsyt5T5y7A2tiEYViee
         zWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOiyM2uGzUc6zhWPwWC3bZJGaa62phcZiPuWR1LO/LM=;
        b=BPYDKqYtHYyP2ekxrFAXfhNrgKkqGLSdC1dbA/k1W9r0W4qWjQQGjPTBeLvCKgZ3TE
         ZsX5WG4yr7BJSz3Wr13ED9FCicQoSZyBBrSW56jLMKT0TULs+Wb5qyOziXi/mS2cDZ0X
         TGdUTD1vHuaGLv2OZ87L+ufFtFwsaBrZCQ4eA/l6cUmq2T18Y38DXwwRJke4jILt8ZTT
         4h1iY9czK3KBMK3RSHSOtIrchEWWaV3Q6DPUkkVdsEOUJM5WEquHnMrw3HsacIXxMvMu
         AcscZN47BZ1O8DjO4kFAN0AOxEkaQG6eH+2Gji9xcnRilVmXHJjRtL7Rjmhj2jxQNbNS
         NNiQ==
X-Gm-Message-State: ANhLgQ3SjaBInWEriZ2JuQg2WPCRemN7KdnmIhLu6Jo3o0q68LOtVR4P
        YnTgA+GdN+WNHjBaGk+x8O4EZg==
X-Google-Smtp-Source: ADFU+vun+g27lkPxDCAAj467Dy8sCcdhE7EoSAKg4LPyr31qU0IxBeR2FOjubEoQClHB6p/eqbb+LA==
X-Received: by 2002:a63:715:: with SMTP id 21mr14981815pgh.234.1583742165744;
        Mon, 09 Mar 2020 01:22:45 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id v5sm18364779pfn.64.2020.03.09.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:22:45 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 4/9] riscv: move exception table immediately after RO_DATA
Date:   Mon,  9 Mar 2020 16:22:24 +0800
Message-Id: <96f4735f9845ddf7f778d4977c25d405ade92644.1583741997.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583741997.git.zong.li@sifive.com>
References: <cover.1583741997.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move EXCEPTION_TABLE immediately after RO_DATA. Make it easy to set the
attribution of the sections which should be read-only at a time.
Add _data to specify the start of data section with write permission.
This patch is prepared for STRICT_KERNEL_RWX support.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 1e0193ded420..02e948b620af 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -58,6 +58,10 @@ SECTIONS
 		*(.srodata*)
 	}
 
+	EXCEPTION_TABLE(0x10)
+
+	_data = .;
+
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	.sdata : {
 		__global_pointer$ = . + 0x800;
@@ -69,8 +73,6 @@ SECTIONS
 
 	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
 
-	EXCEPTION_TABLE(0x10)
-
 	.rel.dyn : {
 		*(.rel.dyn*)
 	}
-- 
2.25.1

