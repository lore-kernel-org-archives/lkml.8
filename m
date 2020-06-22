Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A335C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CBA20716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkT3SGEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgFVWFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:05:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730951AbgFVWE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592863496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxNoiIotuSOUgYrJS6aM7fTSWzfHgwqTuPAKOewitTU=;
        b=UkT3SGEJuUdVEAmXbiSsYeOWbiMHQ6F7vSjAfG0PZGZtdR0nNLs7Z+NEMP80B/8+KPfWdc
        NhNL6ygT8Ig2R1EEj22GTXWc9P4qamqOPNP8mlLxEsssfB9WthbTNA6tae86L93iMfIjOT
        iW4QLyz49mqAlcsSqX/CnSiQ0q6Qv58=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-IHxP7bM-MsaVpdKV-JLgYw-1; Mon, 22 Jun 2020 18:04:55 -0400
X-MC-Unique: IHxP7bM-MsaVpdKV-JLgYw-1
Received: by mail-qt1-f200.google.com with SMTP id x6so12323910qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxNoiIotuSOUgYrJS6aM7fTSWzfHgwqTuPAKOewitTU=;
        b=KPi4KGXEfAddpzKa9W2ZyBiHKzCVA/ArcN1B45Sy9X7BvPlF6azLHDU5eKBCTuf/SI
         qYqT7nmCRRiSK+nJRmNWMOdSSuw4BVV7aUwypDNUpMC1S5bXkRwQ9vkKcpDT8VyK4YCO
         s8qpzPza6pYKCup7YHCEUpmQtFV3bvAJNNaNr1Z9nTDdyNIAIf+eb5DEhNp3spLuwTjy
         ju+zniV4ds3iSTlysktunjlmtW8KZzpRMW+bXuk+EFsFveEeGmmAMFPukyOshOAktgbK
         X8t/IFGbNWv2fiQiF2DrH5tTz3PFJoEmHgUDt+ppWurNxpqpHDCDAqCojvCqHD6DgQjT
         Vpig==
X-Gm-Message-State: AOAM532BSb+ubT4tgJ1DxObDZyYFw/W6bpY6QoZAaONtgw2mJYfkPWVM
        FuDYGqYsOJLZcYw7XEo4mxeahtAZPI1lpx1HUdDGFYPfAiIcnDVLE7nXxPe5Ow8Jz9Nb7/gpKkw
        9XVzteeuq1HHYl4NzAc1FdMj1
X-Received: by 2002:a37:5c7:: with SMTP id 190mr5161778qkf.479.1592863494606;
        Mon, 22 Jun 2020 15:04:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/+HmfLMWSdX8VJlG/0qF7L1Bbp0eFUoOqz+i/oWxlSly1ie82Fn50R5C+EgZSYNrMiebaGQ==
X-Received: by 2002:a37:5c7:: with SMTP id 190mr5161745qkf.479.1592863494278;
        Mon, 22 Jun 2020 15:04:54 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id h6sm3506810qtu.2.2020.06.22.15.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:04:53 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 2/2] KVM: X86: Do the same ignore_msrs check for feature msrs
Date:   Mon, 22 Jun 2020 18:04:42 -0400
Message-Id: <20200622220442.21998-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622220442.21998-1-peterx@redhat.com>
References: <20200622220442.21998-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logically the ignore_msrs and report_ignored_msrs should also apply to feature
MSRs.  Add them in.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/svm/svm.c |  2 +-
 arch/x86/kvm/vmx/vmx.c |  2 +-
 arch/x86/kvm/x86.c     | 10 ++++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a862c768fd54..8fae61d71d6b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2346,7 +2346,7 @@ static int svm_get_msr_feature(struct kvm_msr_entry *msr)
 			msr->data |= MSR_F10H_DECFG_LFENCE_SERIALIZE;
 		break;
 	default:
-		return 1;
+		return KVM_MSR_RET_INVALID;
 	}
 
 	return 0;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 89c766fad889..42dbb3d0a2bd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1772,7 +1772,7 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 			return 1;
 		return vmx_get_vmx_msr(&vmcs_config.nested, msr->index, &msr->data);
 	default:
-		return 1;
+		return KVM_MSR_RET_INVALID;
 	}
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b49eaf8a2ce5..1af37794377e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1392,8 +1392,7 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
 	default:
-		if (kvm_x86_ops.get_msr_feature(msr))
-			return 1;
+		return kvm_x86_ops.get_msr_feature(msr);
 	}
 	return 0;
 }
@@ -1405,6 +1404,13 @@ static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 
 	msr.index = index;
 	r = kvm_get_msr_feature(&msr);
+
+	if (r == KVM_MSR_RET_INVALID) {
+		/* Unconditionally clear the output for simplicity */
+		*data = 0;
+		r = kvm_msr_ignored_check(vcpu, index, 0, false);
+	}
+
 	if (r)
 		return r;
 
-- 
2.26.2

