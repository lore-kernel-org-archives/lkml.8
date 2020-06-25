Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9BAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8563D20706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="my1fX9ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405031AbgFYNPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404905AbgFYNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:14:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F404EC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so2805245wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=weWL7T+4egHpRvm0GYQ+v0Ui4aatvNKJI5SmqJIkJtU=;
        b=my1fX9kephaqvEBX9FIxuU9jSFcVLXtuFzR8EJXTKHAGTj7fLu6Ke5DENPonybea4V
         PBLUSWSvylaGW+EShdRwCSisN31LtAAQvUK+v/6gqv8mBVJ1AeTUpNtlVDPiOaClm/XB
         B6VJoXCqxfS2PNF1wy43kOtOAhMEB6m5gpKxVbZmNgH6/c/EoUxQvqJj2qdyXcBbu2bq
         BTzSiyss5XXgeL8JBFO3zRgUsv+0ufEUH4DA5+wrDD3dcS8DWRGd+VyANE10xSaGBDZB
         wNxnSbyFFAzJjqYCqVmN445ayuhhkLqksu1gWdfrsThf1TdGUSGBEWgc0w3wslq5X90j
         wopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weWL7T+4egHpRvm0GYQ+v0Ui4aatvNKJI5SmqJIkJtU=;
        b=QT5O54ZyiBM3Qkoerg8/EnKIEQhgdTDUkrxAZya4RNZeialJQ77uTKjpSnpa4GJ2tT
         z/S9AlAfOLT5qA7SsyzgqvphaYFS36jeL+qjIfxGiOCz3U8KGhSYmyXCQv9ALr/u7VLr
         BJocY86jjlUWqiv52NZa6DDz4PwajVI9IElnSh1/HujW1EdjMhaPY9A3G9JJ7HQJsWxO
         0evkCoDctZ7bYwpPmE9EFHhk7hBFkon72FwNKtLDyWhb+ToPv9HRiE+uFh3PqbskRtTV
         uYJiubcXfB08XlqEt5S1j47+AIcYq9f/oaFqne7/NyYxGtEtSn0I2FAGlHVuiocPE47j
         t6Zg==
X-Gm-Message-State: AOAM531Mb4P5Ic19E3xo6lemWJu4HAewQLOUwj22PfaPgX8Zezwt/enD
        qYlmp72OYLIWFVvkEw1vMs0HxA==
X-Google-Smtp-Source: ABdhPJyFCoPxAl/jVyIrJH4RBMwPWAai2+rrEY7HwqA9hMweZ6XP4r6wip4j7cg6rQQqnDEQLHWwXw==
X-Received: by 2002:adf:df03:: with SMTP id y3mr34915884wrl.376.1593090894481;
        Thu, 25 Jun 2020 06:14:54 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
        by smtp.gmail.com with ESMTPSA id z6sm8125973wmf.33.2020.06.25.06.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:14:53 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 15/15] arm64: kvm: Lift instrumentation restrictions on VHE
Date:   Thu, 25 Jun 2020 14:14:20 +0100
Message-Id: <20200625131420.71444-16-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/vhe/Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/vhe/Makefile b/arch/arm64/kvm/hyp/vhe/Makefile
index 090fd1e14be2..461e97c375cc 100644
--- a/arch/arm64/kvm/hyp/vhe/Makefile
+++ b/arch/arm64/kvm/hyp/vhe/Makefile
@@ -9,11 +9,3 @@ ccflags-y := -D__KVM_VHE_HYPERVISOR__
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
-
-# KVM code is run at a different exception code with a different map, so
-# compiler instrumentation that inserts callbacks or checks into the code may
-# cause crashes. Just disable it.
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCOV_INSTRUMENT	:= n
-- 
2.27.0

