Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C92C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA5C20771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7S9t2tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgGUJpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:45:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:45:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so20574255wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCTmXoCDoueHGgkSs0dR8Q0gxBgF8BRtzs8whbeoPBY=;
        b=i7S9t2tE6o1ZpRYbBoPLh0mSIFrwHpF9lRxApXBd0SVtfEaMYvKF999IuDfaCE0DdV
         wFP+lVdRe3oBxP2XXvkxkBId3a9rt+6LPKWVsl+ePCY53KV/eftUkC17hvcyirlr+CGK
         x7ecwNpbckzsh0wui6eblLsfMr8GEq9ZrWF10CjkBxj2vMY7btc6zTVBhf2gFaf+aYKQ
         Z9o0w00u6PzL/RWmFmEzV0p9EKWUu+yEx7/TbdTY8Td8Japa4BSiSwPQ6XbmtKjsTrTi
         vXBWkcRXULUnuwkT7FCat/ZEFHAvwe0oSFvoHGLxUv4FYZhSJU1tk0eMqjkihc349oCz
         jYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCTmXoCDoueHGgkSs0dR8Q0gxBgF8BRtzs8whbeoPBY=;
        b=gpmFJ4ffkpeG+HEZybcOsGJfIDzW09VBp5B+EmyGJ93jZDlICJ/fIPz47IquqL9HVc
         98HuBmJM/t8XMNiiuYY0hJrYkFus85lNgtFm4bI9YzauAy2XhViy4uEBZ0DDzCQy1uOb
         teq5pgU/p+Uhyd762c8QvFConZofstZ69wBjR/xD16RVWomVxS739cMOr4gGZBhNhmWY
         EihvNOY8G8SKkVmYubfs8ZOXFAY/bdG6qiVpJk7ig3LkuCSjyVMC+3JNS7cw3siV8mvI
         5/6pLK0Ha6Ko8yx4M/VgP1kmdjpO26D8UIZ4lSYZ3C6iWbI0fRKbwtSkAK8YdJOy0cYJ
         NQ6w==
X-Gm-Message-State: AOAM530GUyX5SFykr7mfGEwtj2Uqd9E428u6MSvIDosNmlxkW6673jHC
        R3t3qEBk2pB6koLySUizFwWNyQ==
X-Google-Smtp-Source: ABdhPJwsEeqkTbsLPEJadyPaueujiKzL/IxGYymb0jshDg7vVUsqj2qjWEo9k1RSpX4pHM494OqVlA==
X-Received: by 2002:adf:f542:: with SMTP id j2mr25975490wrp.61.1595324699596;
        Tue, 21 Jul 2020 02:44:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:cd93:4ca4:af31:19e5])
        by smtp.gmail.com with ESMTPSA id l1sm39195773wrb.12.2020.07.21.02.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 02:44:58 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 1/2] KVM: arm64: Make nVHE ASLR conditional on RANDOMIZE_BASE
Date:   Tue, 21 Jul 2020 10:44:44 +0100
Message-Id: <20200721094445.82184-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721094445.82184-1-dbrazdil@google.com>
References: <20200721094445.82184-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are spare bits in non-VHE hyp VA, KVM unconditionally replaces them
with a random tag chosen at init. Disable this if the kernel is built without
RANDOMIZE_BASE to align with kernel behavior.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/va_layout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index a4f48c1ac28c..e0404bcab019 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -48,7 +48,7 @@ __init void kvm_compute_layout(void)
 	va_mask = GENMASK_ULL(tag_lsb - 1, 0);
 	tag_val = hyp_va_msb;
 
-	if (tag_lsb != (vabits_actual - 1)) {
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && tag_lsb != (vabits_actual - 1)) {
 		/* We have some free bits to insert a random tag. */
 		tag_val |= get_random_long() & GENMASK_ULL(vabits_actual - 2, tag_lsb);
 	}
-- 
2.27.0

