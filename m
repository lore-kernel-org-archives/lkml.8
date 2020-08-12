Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE19C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 06:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD48420781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 06:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la9ApehZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgHLGa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLGa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 02:30:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F93C06174A;
        Tue, 11 Aug 2020 23:30:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x15so633159plr.11;
        Tue, 11 Aug 2020 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RZ3wedaw2pbYbDAfBKRfeJcZf90FJkT5dw1w3ok5Pjo=;
        b=la9ApehZUj8QpjB8DNp2LZ8oh/Ftor/yarN8eTh/oOZLMZGVTMtuTthMVo3Wq+H6kV
         GJwpfLM1Vkmq0aUotJn3WdTP/a1oocJa6Y4ZqhjFCETAYwEWVc1q3en+nFmt3IwZVXn1
         Qy6ACeGO+IROY1zslFKC0RkqvV6BgxeP3CEx4b5oAwVhhg+C3TVV+lCSVTSR0A70/QQI
         Sda7aq9f7nKARLqf/LiUDj84R2Iegn0y9ahFDNsobKl9So76il083ycfaaw/bPkyeiQy
         U8xuOSHHa+VkT7msSVPYIS/+Pql3hKFm+/HaIUKAW/mCakfAQqIH0JOXO+jdtYypB+Zp
         hQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RZ3wedaw2pbYbDAfBKRfeJcZf90FJkT5dw1w3ok5Pjo=;
        b=iLI84nKrFvjTiaRyuz9xtFkqYAF96fDmugdF6ITtctZE7tdx8HgTL0zbbAA9Na2pjP
         jJAMcWqHijhRCQPErQ6OmQvN7nu3KodcPwPBn5mWdYhkN5XU0icY2qq47T1oLQu/iZnO
         SNb7VRPCYvVcOIlaWxx5wmH6S4fl96V4uRD8QfY8lGZykeflpyz/V5xY8UjetM+fJlpd
         sWhtpyjZGxkBj4qFY/q7/Z1NbXIUiy/u1fD+ISL5pQ49t0otY4mvqGaYWcfGTGSybkqZ
         VkpY5mMDsCu6FP4Pd+dnwB7ICAMJJB7Fl3e2CYtYy7GlHSTz8CMkP/2gYAjTeC4Z/Uve
         G7Tw==
X-Gm-Message-State: AOAM533MQPFIJlq+g6quLCqVWEDa3Rf9KYWPMfKMA7mtr9FqKt+6S4P8
        YMJYKmGf+UBkxLaOf9OZyp+0ie4r
X-Google-Smtp-Source: ABdhPJz2GTHROF746HCvaeRI/8TLGO0W+B7VK9k45cU+invz7Ps5RNo40/3liUZ3jGZWrViTACDiVg==
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr4034745pls.115.1597213854302;
        Tue, 11 Aug 2020 23:30:54 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.6])
        by smtp.googlemail.com with ESMTPSA id x20sm11117344pjp.3.2020.08.11.23.30.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 23:30:53 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/2] KVM: LAPIC: Return 0 when getting the tscdeadline timer if the lapic is hw disabled
Date:   Wed, 12 Aug 2020 14:30:37 +0800
Message-Id: <1597213838-8847-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Return 0 when getting the tscdeadline timer if the lapic is hw disabled.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v1 -> v2:
 * fix indentation

 arch/x86/kvm/lapic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 5ccbee7..79599af 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2183,8 +2183,7 @@ u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (!lapic_in_kernel(vcpu) ||
-		!apic_lvtt_tscdeadline(apic))
+	if (!kvm_apic_present(vcpu) || !apic_lvtt_tscdeadline(apic))
 		return 0;
 
 	return apic->lapic_timer.tscdeadline;
-- 
2.7.4 
