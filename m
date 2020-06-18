Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F21C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4B5207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2fnvJZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgFRM0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgFRMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:25:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815A6C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r15so5433780wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djiFW55yS1Rp4YNDz8isiFDt/Jj9YD2Q3nFMXytrXY8=;
        b=v2fnvJZkLqF0i9ErTBWcqsVxtNWg/3wdSutfObc9AIk4DR/IavDByhXEtlOYekhmdf
         R2CgLoEuJAbgHIWE/vPnL5o/HpKTPnr77VMTfNap2Jdz0WW+qcGIUEwuTapaFS1tKF1p
         ZLLoqMNDzEdm8u5aMtSPYg4A04ypHted9caH6mhehwNz3HStqSoG2BT/EHLQuOauISpr
         IDWxdnQNL5hLTPOnquHTBZ5v3Y/zX4wzZRzveuQ2xKU4K4qfn3raKqsYUtZTiuJ+T2rF
         8RLx+Nk8YRIHIp1ihTyjcJvrrloifKjS1iJbF6NSUB52yi2G+564oLebdH39X7+ZWhVQ
         IuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djiFW55yS1Rp4YNDz8isiFDt/Jj9YD2Q3nFMXytrXY8=;
        b=Q9hFYAXqDXRvf3/TCUzWD3WamC6dyiwT5bLNtK17ujmR6a6vmxFuyxmNhbcWFpzf9s
         PGIHpgS9fvlYajQuO6GnbgLXWAtuDEF7hZuK7gAzroqHcyC12I2pY3IFnu6AOabUpAiK
         R9azrujEo3reBoKTkgq8fl++uCHSMVN1GTquO28HBhvvtashBLiStit5c4ol6flcLo9+
         2Ns8xS32PXF3rN2iHwnAYygHQPP5qUuV9OTVYQdhk6WXJwT8cjgyu0loQqtPgsx0aoqF
         pG2uUrHW4yiFCvMQ2VxAKIPg4HS0DGJiwk7KR/G5qnu7jJyUaII23NsPDHxH4iu7nkrI
         GWjg==
X-Gm-Message-State: AOAM531ErsZW21PlA2NmFAK9qPspOaeljyozmos2TNqcyD/qSl4Sm/0S
        DpnbdBCa0wyQ8rkjuARBSU16sA==
X-Google-Smtp-Source: ABdhPJy9A8Zbppj9s06HLgvsvKt+NXsCtHpKYpFtYCSZa2fG9j2ycaFqUHQSP17r/EIg0sOzuQL+lg==
X-Received: by 2002:a1c:5411:: with SMTP id i17mr3942342wmb.137.1592483151024;
        Thu, 18 Jun 2020 05:25:51 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
        by smtp.gmail.com with ESMTPSA id 89sm3423962wrg.56.2020.06.18.05.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:25:50 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 01/15] arm64: kvm: Fix symbol dependency in __hyp_call_panic_nvhe
Date:   Thu, 18 Jun 2020 13:25:23 +0100
Message-Id: <20200618122537.9625-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618122537.9625-1-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__hyp_call_panic_nvhe contains inline assembly which did not declare
its dependency on the __hyp_panic_string symbol.

The static-declared string has previously been kept alive because of a use in
__hyp_call_panic_vhe. Fix this in preparation for separating the source files
between VHE and nVHE when the two users land in two different compilation
units. The static variable otherwise gets dropped when compiling the nVHE
source file, causing an undefined symbol linker error later.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index db1c4487d95d..9270b14157b5 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -897,7 +897,7 @@ static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par,
 	 * making sure it is a kernel address and not a PC-relative
 	 * reference.
 	 */
-	asm volatile("ldr %0, =__hyp_panic_string" : "=r" (str_va));
+	asm volatile("ldr %0, =%1" : "=r" (str_va) : "S" (__hyp_panic_string));
 
 	__hyp_do_panic(str_va,
 		       spsr, elr,
-- 
2.27.0

