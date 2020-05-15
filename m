Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73928C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5253020758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLHC5KfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgEOPZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726241AbgEOPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:25:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97ACC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:25:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u188so3118619wmu.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YHxui3Yo0vMHsmaXOJkEoFjwBV06P7bv7E8zziz5hQ=;
        b=WLHC5KfExF6hPKo7XxaA64czaJ7BpoHLU2zJICyp3N6zf6g0Vz7Ph3aIbdNXAiCrOP
         tCbYqwUu4plPR/NdJdRZvUjxei0rh8/YA/1+lG34HUVqWq+9tW7M1/9WoNIlK1ChRmRt
         FtiWhlL+mdGntWnLltUD93FSVO6Q5VQCVMEaissAi0MSH3OWJmd8fovGarXXhoHPA7Cc
         h/zjCz6NPCujmxrfEKJ5IUQzqUhdXa6zLo7R2i4rDhTiUFozm0g/1c4+tZkBvy31sEvf
         unYFk2EIKZ4XRkziKU6DzIwHGm2BA/B5Pw6A4MI3p+wf8Vwq3765fAuEnv3dimZiyAx7
         F03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YHxui3Yo0vMHsmaXOJkEoFjwBV06P7bv7E8zziz5hQ=;
        b=NqNGD+dTWO9r4TkVuYaKat04rlVcncialuF8lGD9pfQZsljRCu4Q2rCp+wqZptxWxF
         ViGX77gBugln/Lph3wkU+L0ublA6JcvfBYgfVC2F4fYe6Y/jWHuuZ2FXC0yl0TWExEUH
         K9+OsuO7KKADlK9v7D1LWJhZ1Hl7HY5ZtOVE2c6RYB43l9OwqJO48VmcyzRxdrgKlhsG
         t7J8ADn8JlXs9tboRG1KM9/4E0dnIrof4wE2vkVJeYzCoQgVhINTySOpNOx4JK7Rj38h
         T2Lv38jx5k75TxZy066WPiwEDOOKFeFpQ0bVgNPVf6ZH9RyZnw1RuBxPKywOAjSEOIdy
         51Hw==
X-Gm-Message-State: AOAM531FBtJkx/++BX7XlEfSVjISMdPkVIlE4lN10nDpeVi92stlRzsj
        K7TCPFhKzQwjI8i8I+Zl3ZdrCA==
X-Google-Smtp-Source: ABdhPJw3mKWVBSJfaO5wBBJqm/u5qU4h/LdI+37noVfSRuxmHsjjAxJo3FbZwUFQLSDIbvqJipPA8A==
X-Received: by 2002:a1c:6042:: with SMTP id u63mr4545603wmb.65.1589556356308;
        Fri, 15 May 2020 08:25:56 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id y185sm4005761wmy.11.2020.05.15.08.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:25:55 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH] arm64: kvm: Fix incorrect comment on kvm_get_hyp_vector()
Date:   Fri, 15 May 2020 16:25:50 +0100
Message-Id: <20200515152550.83810-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment used to say that kvm_get_hyp_vector is only called on VHE systems.
In fact, it is also called from the nVHE init function cpu_init_hyp_mode().
Fix the comment to stop confusing devs.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 30b0e8d6b895..796f6a2e794a 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -473,7 +473,7 @@ static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
 extern void *__kvm_bp_vect_base;
 extern int __kvm_harden_el2_vector_slot;
 
-/*  This is only called on a VHE system */
+/*  This is called on both VHE and !VHE systems */
 static inline void *kvm_get_hyp_vector(void)
 {
 	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
-- 
2.26.2

