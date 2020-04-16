Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66B7C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925A3206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFPLLGPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbgDPSnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgDPSnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:43:16 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D216AC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:43:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w7so3536021ply.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mC/qr0j7HUgGt77fxIftKjS5qqz0qPQen02hUmh1Dh8=;
        b=CFPLLGPX4ctg78piDhgn3JbQBZ4NUQ5XOGuQiN/7vBRQR685triRRUALfmerg6W9xb
         j17+dKXQTA3N2V71skyu4zTFuVB/4OZSOXSyyskfOa5GZcQt4xpXMOQ5n5GE5MlQPCkQ
         1ZT3ut6wPZWf8D1dz63sAtr4+ZZSe1wtluo7mS5hgEVFNheTwFlMBnRW1WwxEpYbZ7ua
         XDKaJoHGbdm/AHYIKimMrLcSP6KvyLTT43OvDxyfMe60DGjgycAsTONaibnbQmuRB/82
         56FsiaOolzNptFQmMpl3CS8QBl6GBmGxjoAOyseLH1OgPbkueAOjEA0utBJPCWW3wD5F
         nYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mC/qr0j7HUgGt77fxIftKjS5qqz0qPQen02hUmh1Dh8=;
        b=tBCGUtTCctleQ6OGKbMTywY0+UBrRyL2AYmf0l7a3rWMh/gYO6cDrOT82IB/bhAYoD
         +RLfSQUe3MH0Epdr/vgY5+qqYuRa7qPum26EHlQ/jz76Gptbww7vZLiBSoFJunNFxwhB
         NXMeNFj8zC2Uh+CO9ZsxFhQotoCXEImmHqvfIYfRVHeyGfgaGcpkGOBJrHc8V8LJEWFg
         a3sSKrwE018sBnpUWYXbb4g1Yg+gpa6cUBwaKR79mPFXHDfM11nibnPdTo+Q+z2xVfVy
         eqbKAX0MXtKEgYVFUdP8innmZwUe/Qhq5xuv7SSwYxRtXOHIdSt93IvdY+GpHHKc9IU1
         bTDg==
X-Gm-Message-State: AGi0PubsWdhxiZfqbMHt/88dOHq44FN8Z93lz1HtCtaC0kfVcatjpOY9
        qgE594Td2RSJYh6GwQSzSjZrNAWvY4JK8g==
X-Google-Smtp-Source: APiQypKhTjvNBou9iWL+ZmFqhZSk6QlvKSXplfrNIv5dwwZO5la9jHmS99O/mXPKRy/qIQIJHfkgNvE17bDG8Q==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr6679174pjs.156.1587062596155;
 Thu, 16 Apr 2020 11:43:16 -0700 (PDT)
Date:   Thu, 16 Apr 2020 11:42:54 -0700
Message-Id: <20200416184254.248374-1-jcargill@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] kvm: Handle reads of SandyBridge RAPL PMU MSRs rather than
 injecting #GP
From:   Jon Cargille <jcargill@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Venkatesh Srinivas <venkateshs@google.com>,
        Jon Cargille <jcargill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkatesh Srinivas <venkateshs@google.com>

Linux 3.14 unconditionally reads the RAPL PMU MSRs on boot, without handling
General Protection Faults on reading those MSRs. Rather than injecting a #GP,
which prevents boot, handle the MSRs by returning 0 for their data. Zero was
checked to be safe by code review of the RAPL PMU driver and in discussion
with the original driver author (eranian@google.com).

Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>
Signed-off-by: Jon Cargille <jcargill@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/x86.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3cc3f673785c8..4f9b7dd687e3c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3060,6 +3060,17 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
 	case MSR_F15H_EX_CFG:
+	/*
+	 * Intel Sandy Bridge CPUs must support the RAPL (running average power
+	 * limit) MSRs. Just return 0, as we do not want to expose the host
+	 * data here. Do not conditionalize this on CPUID, as KVM does not do
+	 * so for existing CPU-specific MSRs.
+	 */
+	case MSR_RAPL_POWER_UNIT:
+	case MSR_PP0_ENERGY_STATUS:	/* Power plane 0 (core) */
+	case MSR_PP1_ENERGY_STATUS:	/* Power plane 1 (graphics uncore) */
+	case MSR_PKG_ENERGY_STATUS:	/* Total package */
+	case MSR_DRAM_ENERGY_STATUS:	/* DRAM controller */
 		msr_info->data = 0;
 		break;
 	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
-- 
2.26.0.110.g2183baf09c-goog

