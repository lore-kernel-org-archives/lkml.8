Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04008C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D825C2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OA5l7aPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgD3OtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728333AbgD3OtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:49:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D5CC035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:49:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so7668919wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7eYSMAp+jVN9aeMCPrBnn3TIBRQFFZukfwsZjZglmQ=;
        b=OA5l7aPTjb+/faLVms3XE72y8w1jxluq6N84GtC94alO2aDBpgsSDm1VINExf6U31K
         9tqr3waTe0vuItea2ZK+4FQY33rrwYVdlFm66/zz3Cbebio6W/zJw+cuzPwy6n+iuVO1
         Qv5Txcaf0FBe7wgFuL7AbtE7IOV5EsWHhF+AbyMKfvo6KM8oDXgrOneyRlflh3kUpYDW
         E4uoX+Djh2ULGNXS229plrMBCBOviGp/3ySosN9wHOowtX6bdb+p566EJDb6/lYWICXS
         WRk4yWH7ivHkDHxhIfzZpbxIlPohMJP1LV+ksBsadHK0LHqwXShd8qhbrbm5BovWgXrw
         ++DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7eYSMAp+jVN9aeMCPrBnn3TIBRQFFZukfwsZjZglmQ=;
        b=lKDSJP04ojkJMS9N+0jPK5p6s6CIYp1jd2O68Kk5pDC5braKqTvt4n+fRct/SL/QDD
         MJgGA+9wzw/ghAvSJHmto7yLLjx8tNyXwY0IQ08o0KFHLNu6Bxm/Unp0XH4Yh+Au/E+d
         ufElwtZBRDbkUHwUQiEwVm1H1uKVyDpBHDrTklD4EqjyQ59neuOrKITHFi5/5tAg22SO
         I+YsbvdnWNXwQHiy2UKidJKmQi0SOIb+hI5Cn6cWWHHQNnJBh3mP9/Sj4zczMcKb13QD
         1bfqAMS/OX1XdgHe5Hap7S3b6QBKY3h/CserAUdJx/ED1jdfLC/4rOWgydzR2DlLisy7
         LIsQ==
X-Gm-Message-State: AGi0PuYmO/wneTdbV+3Hqro9tn+I7ARtT3sd3JKdb1ZsuH0D/A7Xxx2s
        ZWSknzbZcS7qqHzZymeE31OCnQ==
X-Google-Smtp-Source: APiQypITD1jhHlRSJgCpCChsFN8ZYowBb0ctI7WS8xvFw5N4p+kZxrBFEWIMXyQBlBl3+nKP5Z4Cvw==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr3287632wmj.40.1588258152859;
        Thu, 30 Apr 2020 07:49:12 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id f2sm4557427wro.59.2020.04.30.07.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:49:12 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 15/15] arm64: kvm: Lift instrumentation restrictions on VHE
Date:   Thu, 30 Apr 2020 15:48:31 +0100
Message-Id: <20200430144831.59194-16-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
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
index a6883f4fed9e..f877ac404b46 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -10,11 +10,3 @@ obj-$(CONFIG_KVM) += vhe.o nvhe/
 
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
2.26.1

