Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C267C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643A8206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGZ1WI+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHSI5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgHSIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:55:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15795C061757;
        Wed, 19 Aug 2020 01:55:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so797400pjx.5;
        Wed, 19 Aug 2020 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5cHoUcJ2mD+T+5PMzFltfutrjmF1Y+qla8jlr3aC+f8=;
        b=aGZ1WI+PVdogKcUjr79CdQJmUFhpTH5cmhm81qkrRrBBnknAC+jhblXw9soOnapLs9
         xx37n0okEflehtYqzv0jX9ATsxAxva1eURsO22OoOLHlOGHa3gutGmFFVfzkj4DxB/7u
         YEo2SBHoDnpE44EZvmU1kVRWPf66utmG63q8n1F0scOIuOA1rN6TWv+QsFaK0gCx6w6R
         NDS7TVyLWC/uPznUMW+VAnlcaHSBNb3x5qHzuauqA0l4s6a4VqXfT74KoD8jJqJEwEkh
         I1op7n6GDYeMcKP/lJek7vBA3R8X9sdbJSxOjVP0fGvSExnxYq/5nxB9fNapC/BCh6cV
         Xy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5cHoUcJ2mD+T+5PMzFltfutrjmF1Y+qla8jlr3aC+f8=;
        b=rO4oZUUW76IpxSChb/EMinnfBEKazKFLLBfZaKnT2Khj+u2S58kM64usM3pd1E7S2Q
         dOz6cpyYurA5PRG6UiAZ2A1TzybUxLKl0GEwOpB63ysY5f+M2uTYdqikKAdDWKhd6LJ0
         Figiwe5aGjFwbECZQTRl1adIfF8oo0ytNjWna/u0VUYTemxTbjV1gStOJA4lt/vhHUkm
         EveNvD6/hCGlz2X1fP+Jpv4zEfRhsWudi4qvEUlgucNw147N7Arwg3Tg9TsdqmN+77iR
         RjvWiAxzdzDcJvz1KxiTyLcUo69zvHgoMhZk3tFF72NGEx8900cFALefDM8JzYWBmtMQ
         h5HQ==
X-Gm-Message-State: AOAM530gmNQ1Q70/KWA2D737krP24jsaNJRomJnoJ+8WtiOdrADQiKZA
        WEvlk7u2c9tHCahNy1mSk1b07H/kLo0=
X-Google-Smtp-Source: ABdhPJyVVIclDxsgDMCby3q0CXmR0QSx83JLxng3mShYm4bu4EMoaF+sRn9FgEEYOQRmKCQVjTLS4A==
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr3477334pjq.4.1597827343550;
        Wed, 19 Aug 2020 01:55:43 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.6])
        by smtp.googlemail.com with ESMTPSA id m15sm20209991pgr.2.2020.08.19.01.55.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 01:55:43 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] KVM: VMX: Don't freeze guest when event delivery causes an APIC-access exit
Date:   Wed, 19 Aug 2020 16:55:27 +0800
Message-Id: <1597827327-25055-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597827327-25055-1-git-send-email-wanpengli@tencent.com>
References: <1597827327-25055-1-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

According to SDM 27.2.4, Event delivery causes an APIC-access VM exit.
Don't report internal error and freeze guest when event delivery causes
an APIC-access exit, it is handleable and the event will be re-injected
during the next vmentry.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/vmx/vmx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 46ba2e0..80ba8d4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6054,6 +6054,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 			(exit_reason != EXIT_REASON_EXCEPTION_NMI &&
 			exit_reason != EXIT_REASON_EPT_VIOLATION &&
 			exit_reason != EXIT_REASON_PML_FULL &&
+			exit_reason != EXIT_REASON_APIC_ACCESS &&
 			exit_reason != EXIT_REASON_TASK_SWITCH)) {
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
-- 
2.7.4

