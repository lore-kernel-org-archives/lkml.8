Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64175C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4406920720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aR3924TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404872AbgFYNOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404710AbgFYNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:14:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFB9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so5798871wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djiFW55yS1Rp4YNDz8isiFDt/Jj9YD2Q3nFMXytrXY8=;
        b=aR3924TG/GhiA+e7cSIyaJXA4Y+WubHOl2DXaNi1c0reM2jrYsW9uqw6yFadKgakVd
         XP/Ylg3kWsXPqPO0Ppu8rrrHbJPhaXOVHRa+esGXU6xwqh85CssuLdYju0YgANwUpFLQ
         es5wVqJK+4N3Ef7qF0XOda0fdxFiosUz/4tRhGvAA+oww2CasCmo0yBcKTETiOp1Ljiv
         YpNbGFi5F3sjN3M0z2JxhAflHCvzASzCC0A4VwKKideeVL33accPM86TTKg2K+mBsLtL
         /DZ3oFEbTF082pksDvRp/4Aukeo3/MT+qjhPr2+PRjoWyZyfJYoikkmbznirPdvyZ8hD
         0xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djiFW55yS1Rp4YNDz8isiFDt/Jj9YD2Q3nFMXytrXY8=;
        b=k3Z1GqeUKpbttOplHOGurksPZkcfYIUa8EhaJ3IbIIjlhyFpRUCm/q5lXgD+Njx7z4
         qaf/noUctsxGAf3i9SraEcVm6DtQpbk4fteZ9f+Ahjbh8bMS27CXEi+v3nyq4Ihhy2jp
         YsYyV+jWuuUXJ3LW8gjgz/jWA/pEwQ2FwsZFUyDWehP2eLIXqrJO9HAnN56w/wK6KLn/
         7wyja8cdJqGT4+D6dl7/gABLenbIIHWDiVCdIHfdzVloBhD2cUyQAGUUtCoPB6PUNn7P
         DayNifr1d3y8DdLAM+13St1Z4Ql+ZONGVorYhsNqlja9sv01Kp/C/ocNfQskLSdwSQ+V
         KaGQ==
X-Gm-Message-State: AOAM5319MLjMXKY7bYX9RhSl8tMcj6GKjrgf4rounKvAdsGKYsiPcg4K
        fq+gVDXpMcSjHN1JMMSiLS/DPg==
X-Google-Smtp-Source: ABdhPJwznHV4hv6Fj3Er6LKY8SIiHuc2Snez1YpadUkoPjJ25Jk5PeHh1uhQrUEuukHkOvjncxyEfA==
X-Received: by 2002:adf:e647:: with SMTP id b7mr37709680wrn.170.1593090866123;
        Thu, 25 Jun 2020 06:14:26 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
        by smtp.gmail.com with ESMTPSA id d13sm16942574wrn.61.2020.06.25.06.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:14:25 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 01/15] arm64: kvm: Fix symbol dependency in __hyp_call_panic_nvhe
Date:   Thu, 25 Jun 2020 14:14:06 +0100
Message-Id: <20200625131420.71444-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
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

