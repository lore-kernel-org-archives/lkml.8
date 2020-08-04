Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1518C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E2C2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjkP8xIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHDGLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgHDGLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:11:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D566DC06174A;
        Mon,  3 Aug 2020 23:11:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so19602780pfm.4;
        Mon, 03 Aug 2020 23:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wLvICjqjYrd+Zh2vXjvJTYfRwMLWZImSkaARuz+JdB8=;
        b=FjkP8xIZDswm8+jRTrI5ZhoFdaZ6QvN44Ax01M1JKS9Hj7/uYxXG+Asd/FDBQIadYx
         AhYYpcW3ObeMCHOe+joGcwXzxpN7HUm5/KhVOMqd+IhNiYy2TDxlTb6h5wV64hPhOgZr
         qHCHzNth+o8khSBXs9la4GEMIz8cIqeWBqCu/ChJ6TSUfLUTTVzk1rB7xa29844EafWb
         pLJ0rl4LXp3DHE+HY4Qe0/otW4Ow7dmRjqWo3vkbTzrhV7CwIdOf5AfJa6X32s0oob3N
         gTwI153xeeN43agfAZ119zrZ81EQ5zavIwXrWB1cQ90ejpuWaq1PnZcfMMmh/zae0Yfu
         JnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wLvICjqjYrd+Zh2vXjvJTYfRwMLWZImSkaARuz+JdB8=;
        b=D6cBMDMEr9/xLZaPgFc0xsLfU2uTZyjkVqSlpGTK85J7+By8IE4d6RJlr+Oy3vNE8P
         AGD8a7rX7LkvGQxNnLJ5FWfyulOb7Tdt0OLLdP8qXk1aNagkgFEUvekI7SvwA88wD0VB
         WCYHorHAVWw24PEWy0C4d0x7B1CMKPmeS0oUPd8HKMSSccVXuew8Ft8vnsWzWd5IETGl
         1PZoYupCQ2Lbijpsd4Q+AGGLkhSVW5MfOPUKK8jIft7yruZX2QrG/KGmzgRtkUtxZHoN
         /bESWxgEP4qatLKaH2mr9UvEQ0tTRCVMDGJG3xT3BDCun3Kcx8t+LJP/q87IsU0M6t10
         mrDg==
X-Gm-Message-State: AOAM531lKfnNIfd97L+TU61Hx1sc7e1bVZnShCEDSbxCkncmEXnrLCBk
        VIQav61gjXJrwLefT41pC34cjFCO
X-Google-Smtp-Source: ABdhPJwrYtKdS8xuzfckXsojr3zeK6ZtLenz+rXKx9XMlQUa2Bdpi0VPPIt/W8r9nTDbLQ3t8zaFAg==
X-Received: by 2002:a05:6a00:90:: with SMTP id c16mr11083964pfj.200.1596521460237;
        Mon, 03 Aug 2020 23:11:00 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.6])
        by smtp.googlemail.com with ESMTPSA id s8sm22093069pfc.122.2020.08.03.23.10.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2020 23:10:59 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] KVM: LAPIC: Guarantee the timer is in tsc-deadline mode when setting
Date:   Tue,  4 Aug 2020 14:10:48 +0800
Message-Id: <1596521448-4010-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596521448-4010-1-git-send-email-wanpengli@tencent.com>
References: <1596521448-4010-1-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Check apic_lvtt_tscdeadline() mode directly instead of apic_lvtt_oneshot()
and apic_lvtt_period() to guarantee the timer is in tsc-deadline mode when
wrmsr MSR_IA32_TSCDEADLINE.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d89ab48..7b11fa8 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2193,8 +2193,8 @@ void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (!kvm_apic_present(vcpu) || apic_lvtt_oneshot(apic) ||
-			apic_lvtt_period(apic))
+	if (!kvm_apic_present(vcpu) ||
+		!apic_lvtt_tscdeadline(apic))
 		return;
 
 	hrtimer_cancel(&apic->lapic_timer.timer);
-- 
2.7.4

