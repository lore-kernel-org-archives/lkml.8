Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBC8C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74CC206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbJkzKEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgEEUuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:50:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51132 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbgEEUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588711807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lqz8ABTk7mmZmr2SRgNolx/ynB8Uv1cG2IVS55AzIlU=;
        b=JbJkzKECUrTXasp7/5Wv876iJV1/lM2sGOUV2MKmOFb4F4lmLyf4aya3/hupOEgH9qQnzu
        YFPB07ZqBXMqdVl6y7efxNAxiCxrb6oxd+RkE49/fNiuXuEnwgX69olHczrQQ9rvW7wWMk
        fqXNcq6HnP8kAL7iCv+xBXf7cq3b7Rc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-NnBL6p3POKiezogHv2gdWQ-1; Tue, 05 May 2020 16:50:06 -0400
X-MC-Unique: NnBL6p3POKiezogHv2gdWQ-1
Received: by mail-qk1-f199.google.com with SMTP id p126so10998qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lqz8ABTk7mmZmr2SRgNolx/ynB8Uv1cG2IVS55AzIlU=;
        b=VqRxyYdLA9GCcafiTiKtrsBpiNK7aINXrv3J0KUcyJadJHXHqGtaD90hs5LAJItDyg
         DmyKGd8UdrdUlSmHDHZ/cs1/kIj1OepLamHKJy40Y+IoHKWa9kvv1lwpCdmUfzblJyyx
         66UbYuRNFvj+zGDG9ir5YwGEK8COF+iAKNAJ3JsTbY0tC78PavFPzRGvbKtdzBpY8k1K
         0kV+sHpKi452kJkPcsm25I8avQ6boH5+gJuxJalPfp6ikmhwTi1xWa7kkZzMOSAh2scQ
         CUB7zbBmB2b+JAOJU3qfXMiK8Di/UF4neivi/mSPmq2Vncwz0zJHqDjnF8f+lOX6u8tz
         RF8A==
X-Gm-Message-State: AGi0PuYqSKjbf+9FhsdJezqFPtSVsKmPBtqUBzwo8tAoOi5j2E5leBWR
        WaiTL3qSQVCQsknIKKBo/Cy5RuRK0oLgHg1RyBg3IPl/iJKKAxJbH8rGPMgE8OetiFi2JvJqhuG
        zmvSmTFPkkyLel6STEiF7t3fP
X-Received: by 2002:aed:30ad:: with SMTP id 42mr4804537qtf.88.1588711805890;
        Tue, 05 May 2020 13:50:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypJS3vgYB6ujLFNjvYBh4/YtNUpRO0CUlvOlkw6CWWBl6k97CeaB10WRCG6L5GhKHA/wqD12AA==
X-Received: by 2002:aed:30ad:: with SMTP id 42mr4804520qtf.88.1588711805673;
        Tue, 05 May 2020 13:50:05 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 193sm19380qkl.42.2020.05.05.13.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:50:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] KVM: X86: Fix single-step with KVM_SET_GUEST_DEBUG
Date:   Tue,  5 May 2020 16:49:59 -0400
Message-Id: <20200505205000.188252-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505205000.188252-1-peterx@redhat.com>
References: <20200505205000.188252-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When single-step triggered with KVM_SET_GUEST_DEBUG, we should fill in the pc
value with current linear RIP rather than the cached singlestep address.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac7b0e6f4000..7190188b2ac8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6672,7 +6672,7 @@ static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu)
 
 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
 		kvm_run->debug.arch.dr6 = DR6_BS | DR6_FIXED_1 | DR6_RTM;
-		kvm_run->debug.arch.pc = vcpu->arch.singlestep_rip;
+		kvm_run->debug.arch.pc = kvm_get_linear_rip(vcpu);
 		kvm_run->debug.arch.exception = DB_VECTOR;
 		kvm_run->exit_reason = KVM_EXIT_DEBUG;
 		return 0;
-- 
2.26.2

