Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCA2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89AB2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaaSEpFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgFVWE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:04:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34180 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730934AbgFVWEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592863493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92xlo56NnQbKrNJm5mldzyMce3skYCA3gpK4Ws+GIX4=;
        b=HaaSEpFVYPjsqICjv2RQhacI1wO6GXV7A4y5TBzvlO8359EE52v+keaVMsYd+Ux6sIxhtR
        HLpwcK8QATcCF1XTftfR79weBBqqEGk8OlNoqpwkPF3/9TooVA9WSQg6RiR/7pBPnNSsE0
        FFo+C0sf2+EjjE7+UBEvG1+/OTNRcnM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-pyV9ZjN8No-qZfpOwdjVQA-1; Mon, 22 Jun 2020 18:04:52 -0400
X-MC-Unique: pyV9ZjN8No-qZfpOwdjVQA-1
Received: by mail-qk1-f199.google.com with SMTP id i82so13892369qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92xlo56NnQbKrNJm5mldzyMce3skYCA3gpK4Ws+GIX4=;
        b=eel+PPY7U0AEXCh0oEO9pMjC5sxolpbzJ5uzj+Z3br8h/htQObEN8JdNzhEFldXn11
         R+b/34fywIbloR0jNWXZst6vEr+2hBm7MCGknzB77m4HHEMB6nr218Pi43AzT+EEdHpq
         qRLArxtvKVa4jlPjktxBZif/7zZ63Vdh7MM3rYMthQXVmGQlOOl8BxLcmlUMjJV/zCx9
         65B1m4cvBPfeWzIA8YiS+0OPvuCC8WklDxt7YGO6UFTgz0kp3v6FAnyegHj9n9e5KW7d
         7Q87F9R6Csba7+8BzfQyyjY1oqZi9xA8OypktzgZBOQq3GLOs4+5/hw+sg9cz+Me1bLx
         ddww==
X-Gm-Message-State: AOAM532jd6/x2+IscjLdfUyksDHTOpAwHEMcPbLyRhqA6552ECnSHynO
        0JlOfNR1s0oQqIaU0Bfw8OzmNqKmoEsUA04wLfJ/cHoeMIm4OutUJYVhYpQIM477LHFheKz1U5A
        uUmIQgX6afbH1D8XzKHnZTjZU
X-Received: by 2002:a37:44d5:: with SMTP id r204mr7294738qka.113.1592863490936;
        Mon, 22 Jun 2020 15:04:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwpw9hXXzrRoZ7uBlSGesnncpPEpLsS//WL8KZ5yVPHkbD2TpWTGus3gca62CrS2n80xyqrg==
X-Received: by 2002:a37:44d5:: with SMTP id r204mr7294705qka.113.1592863490646;
        Mon, 22 Jun 2020 15:04:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id h6sm3506810qtu.2.2020.06.22.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:04:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 1/2] KVM: X86: Move ignore_msrs handling upper the stack
Date:   Mon, 22 Jun 2020 18:04:41 -0400
Message-Id: <20200622220442.21998-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622220442.21998-1-peterx@redhat.com>
References: <20200622220442.21998-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSR accesses can be one of:

  (1) KVM internal access,
  (2) userspace access (e.g., via KVM_SET_MSRS ioctl),
  (3) guest access.

The ignore_msrs was previously handled by kvm_get_msr_common() and
kvm_set_msr_common(), which is the bottom of the msr access stack.  It's
working in most cases, however it could dump unwanted warning messages to dmesg
even if kvm get/set the msrs internally when calling __kvm_set_msr() or
__kvm_get_msr() (e.g. kvm_cpuid()).  Ideally we only want to trap cases (2)
or (3), but not (1) above.

To achieve this, move the ignore_msrs handling upper until the callers of
__kvm_get_msr() and __kvm_set_msr().  To identify the "msr missing" event, a
new return value (KVM_MSR_RET_INVALID==2) is used for that.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/x86.c | 80 +++++++++++++++++++++++++++++++---------------
 arch/x86/kvm/x86.h |  2 ++
 2 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c17e6eb9ad43..b49eaf8a2ce5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -245,6 +245,29 @@ EXPORT_SYMBOL_GPL(x86_fpu_cache);
 
 static struct kmem_cache *x86_emulator_cache;
 
+/*
+ * When called, it means the previous get/set msr reached an invalid msr.
+ * Return 0 if we want to ignore/silent this failed msr access, or 1 if we want
+ * to fail the caller.
+ */
+static int kvm_msr_ignored_check(struct kvm_vcpu *vcpu, u32 msr,
+				 u64 data, bool write)
+{
+	const char *op = write ? "wrmsr" : "rdmsr";
+
+	if (ignore_msrs) {
+		if (report_ignored_msrs)
+			vcpu_unimpl(vcpu, "ignored %s: 0x%x data 0x%llx\n",
+				    op, msr, data);
+		/* Mask the error */
+		return 0;
+	} else {
+		vcpu_debug_ratelimited(vcpu, "unhandled %s: 0x%x data 0x%llx\n",
+				       op, msr, data);
+		return 1;
+	}
+}
+
 static struct kmem_cache *kvm_alloc_emulator_cache(void)
 {
 	unsigned int useroffset = offsetof(struct x86_emulate_ctxt, src);
@@ -1496,6 +1519,17 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 	return kvm_x86_ops.set_msr(vcpu, &msr);
 }
 
+static int kvm_set_msr_ignored_check(struct kvm_vcpu *vcpu,
+				     u32 index, u64 data, bool host_initiated)
+{
+	int ret = __kvm_set_msr(vcpu, index, data, host_initiated);
+
+	if (ret == KVM_MSR_RET_INVALID)
+		ret = kvm_msr_ignored_check(vcpu, index, data, true);
+
+	return ret;
+}
+
 /*
  * Read the MSR specified by @index into @data.  Select MSR specific fault
  * checks are bypassed if @host_initiated is %true.
@@ -1517,15 +1551,29 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 	return ret;
 }
 
+static int kvm_get_msr_ignored_check(struct kvm_vcpu *vcpu,
+				     u32 index, u64 *data, bool host_initiated)
+{
+	int ret = __kvm_get_msr(vcpu, index, data, host_initiated);
+
+	if (ret == KVM_MSR_RET_INVALID) {
+		/* Unconditionally clear *data for simplicity */
+		*data = 0;
+		ret = kvm_msr_ignored_check(vcpu, index, 0, false);
+	}
+
+	return ret;
+}
+
 int kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data)
 {
-	return __kvm_get_msr(vcpu, index, data, false);
+	return kvm_get_msr_ignored_check(vcpu, index, data, false);
 }
 EXPORT_SYMBOL_GPL(kvm_get_msr);
 
 int kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data)
 {
-	return __kvm_set_msr(vcpu, index, data, false);
+	return kvm_set_msr_ignored_check(vcpu, index, data, false);
 }
 EXPORT_SYMBOL_GPL(kvm_set_msr);
 
@@ -1621,12 +1669,12 @@ EXPORT_SYMBOL_GPL(handle_fastpath_set_msr_irqoff);
  */
 static int do_get_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 {
-	return __kvm_get_msr(vcpu, index, data, true);
+	return kvm_get_msr_ignored_check(vcpu, index, data, true);
 }
 
 static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 {
-	return __kvm_set_msr(vcpu, index, *data, true);
+	return kvm_set_msr_ignored_check(vcpu, index, *data, true);
 }
 
 #ifdef CONFIG_X86_64
@@ -2977,17 +3025,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return xen_hvm_config(vcpu, data);
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
-		if (!ignore_msrs) {
-			vcpu_debug_ratelimited(vcpu, "unhandled wrmsr: 0x%x data 0x%llx\n",
-				    msr, data);
-			return 1;
-		} else {
-			if (report_ignored_msrs)
-				vcpu_unimpl(vcpu,
-					"ignored wrmsr: 0x%x data 0x%llx\n",
-					msr, data);
-			break;
-		}
+		return KVM_MSR_RET_INVALID;
 	}
 	return 0;
 }
@@ -3234,17 +3272,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info->index, &msr_info->data);
-		if (!ignore_msrs) {
-			vcpu_debug_ratelimited(vcpu, "unhandled rdmsr: 0x%x\n",
-					       msr_info->index);
-			return 1;
-		} else {
-			if (report_ignored_msrs)
-				vcpu_unimpl(vcpu, "ignored rdmsr: 0x%x\n",
-					msr_info->index);
-			msr_info->data = 0;
-		}
-		break;
+		return KVM_MSR_RET_INVALID;
 	}
 	return 0;
 }
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index b968acc0516f..62e3e896d059 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -359,4 +359,6 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu);
 void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu);
 u64 kvm_spec_ctrl_valid_bits(struct kvm_vcpu *vcpu);
 
+#define  KVM_MSR_RET_INVALID  2
+
 #endif
-- 
2.26.2

