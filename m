Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C43C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A981A20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqre/qi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgEOK7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgEOK7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:59:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC3C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so2979030wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sW/5ZwfUkcrq8MNsWbZB8lRN7UAKxOnejMG35fACcpU=;
        b=tqre/qi7LotrlOupGSzYt/UzPtBy6RKj8xVepwDzpdtgmD2j1I7oQ4kcPPdkV2ZGOJ
         hkb6qLAW45uzBZeohJSLIXIGRY/7SVGY1leLVFJVuP4CMq9xSsZjxdeS5vfPPIJEl/y4
         MHUYKk1DPQdCyvYh7bT9gvsdjIWCHy1cgZBKcG/RbceKT+P2dXPlyzEVONehZKyuPUXL
         388pp6M15+gpipCoh7DAoq00mt0q5cZfUMfLfunZYQv4+z9cvbDoEj4JB4JSpO7k2DxO
         V5ckh4Ftfrl4+RmZy2SzVWEqFvC/U1b7tjmCt7qIYEAU6yVfSEpjBRvfcTtbYrhOj0xo
         KVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sW/5ZwfUkcrq8MNsWbZB8lRN7UAKxOnejMG35fACcpU=;
        b=N5pI410ffnDik0Zdrpn5MBESd4MXt12biQXp8lJS/jyfLMj0K4BvbXUKNMihhpAKZP
         SRfH7C8KDM+OcKUXMaBhIxPaUuoyTqtL/9IF9cD1GveBTxNfdQS+HBjDp875Zr6Nf0JF
         KxB8k4axWYnD6BlJ9FOgMwyf8/5ArQoAIWEUutMPk28YWnrGyND/YxW6skjYAxzW1R0/
         brgBAURzm0JBdmgKWMmYLsUBvNSVd8sC/56PUZTQezmDHfPsA4zFvwMVVM/BBVTQjUGT
         hhvWmCezqM3Y98H8e4FMwcaqlqfXLF2aACzYlMD+PonyyDutkG4dldDqc0pFLwKj+gAN
         4v5g==
X-Gm-Message-State: AOAM533YGQjjY45NQFOVaGsUlZYTqo6qJUYKwAxI6IclIvz17jF745nO
        TscFafsEPjZ7AiKsnH77bRmw0g==
X-Google-Smtp-Source: ABdhPJypINRB1vch83S8A4T3nKixjdrHNtaJjymSWdrumgmpTeVVmG20s6/LdGZ7yzPGLe/h25kr3w==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr3816250wrk.92.1589540360508;
        Fri, 15 May 2020 03:59:20 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id f128sm3300011wme.1.2020.05.15.03.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:59:19 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 14/14] arm64: kvm: Lift instrumentation restrictions on VHE
Date:   Fri, 15 May 2020 11:58:41 +0100
Message-Id: <20200515105841.73532-15-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515105841.73532-1-dbrazdil@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With VHE and nVHE executable code completely separated, remove build config
that disabled GCOV/KASAN/UBSAN/KCOV instrumentation for VHE as these now
execute under the same memory mappings as the rest of the kernel.

No violations are currently being reported by either KASAN or UBSAN.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index c9fd8618980d..69113bf193de 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -11,11 +11,3 @@ obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
 vhe-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
 	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
-
-# KVM code is run at a different exception code with a different map, so
-# compiler instrumentation that inserts callbacks or checks into the code may
-# cause crashes. Just disable it.
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCOV_INSTRUMENT	:= n
-- 
2.26.2

