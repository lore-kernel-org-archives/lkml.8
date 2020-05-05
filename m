Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411FDC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209DD206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gubbskT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgEEUuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:50:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27150 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729060AbgEEUuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588711806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5fyKyck3cIU7DcvHTGzyMWNl4dUwB0H2Ul/b+bN2co=;
        b=gubbskT1+3s1VSDSXQw2eKvfS1m8UuNKtK29GIQknx2HT1AIkSo86aX/Oj5uBv4iX+RFTx
        xbN8jFWRIAIJQbt7NuzpyBNwn37PgOTixsk0b8iabJZDrLWFzv6TKBm3MCpxKEBDyHXRsf
        zlLLVe3UFSpQmmnYe9rwFgeHIvFb9Ps=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-Udo735DQOBG8jEaYBiKjYg-1; Tue, 05 May 2020 16:50:05 -0400
X-MC-Unique: Udo735DQOBG8jEaYBiKjYg-1
Received: by mail-qk1-f197.google.com with SMTP id l19so3354310qki.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5fyKyck3cIU7DcvHTGzyMWNl4dUwB0H2Ul/b+bN2co=;
        b=Z5ebk/SMtnKn4xWGuOjkV55nBLnbvhPePCqnPEEPYxsgpt7rQW7G8HNXGs1oJWHycb
         YNFMn/r3ZysREQeh+UGjMguCkC139wFQYuSfEW5wU3iAlL1OFy4CLzM+UPUxGm+vXdht
         SaWQx84l2/j44rK+bGOe4vqOefn/tVefRRCJAEqn4S/9ztRcfXs8TTsDCUUfrnznv8HM
         kA5ZWCewqg7Pwv4FnGd/rnMoJR51tc4umFbyTF7S4lHJxDIefDK4A5j4hVhATy01U3+T
         oDv2ZOrtnqFjvGDwIXfcFrGDzR5kjlRb5FWRW3BHVzPnldkpicYGJzw6ziKUNBXEF3VH
         3ikA==
X-Gm-Message-State: AGi0Pub8X3/XRoJG7L3hIHjKy9rR7NOT8UycT9ZpDoT6ZZZUDpdSbyop
        oBbD5/xcJR7AAYho54nriMff3WMqEj4LIX4qTStrcz/vQUgzft3CbEF5Jb1oYbXKSI2Bk1cdhrJ
        UQqHAwVfk+qVd3JgyQNJCzuWv
X-Received: by 2002:ac8:3f6d:: with SMTP id w42mr4732567qtk.171.1588711804400;
        Tue, 05 May 2020 13:50:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypLOTQWzwWYM8fE/nDb/teAnnAv0eA3zDhbPGnwIcj7jk9BsG2W3T+3JWJxBw9ko1tMQ6r44Lw==
X-Received: by 2002:ac8:3f6d:: with SMTP id w42mr4732555qtk.171.1588711804173;
        Tue, 05 May 2020 13:50:04 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 193sm19380qkl.42.2020.05.05.13.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:50:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] KVM: X86: Set RTM for DB_VECTOR too for KVM_EXIT_DEBUG
Date:   Tue,  5 May 2020 16:49:58 -0400
Message-Id: <20200505205000.188252-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505205000.188252-1-peterx@redhat.com>
References: <20200505205000.188252-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTM should always been set even with KVM_EXIT_DEBUG on #DB.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c2c6335a998c..05ed3e707ec6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4685,7 +4685,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 			kvm_queue_exception(vcpu, DB_VECTOR);
 			return 1;
 		}
-		kvm_run->debug.arch.dr6 = dr6 | DR6_FIXED_1;
+		kvm_run->debug.arch.dr6 = dr6 | DR6_FIXED_1 | DR6_RTM;
 		kvm_run->debug.arch.dr7 = vmcs_readl(GUEST_DR7);
 		/* fall through */
 	case BP_VECTOR:
-- 
2.26.2

