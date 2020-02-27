Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825FEC35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0C1246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AItJTnih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgB0RXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:23:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45417 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729948AbgB0RXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582824217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHtHSwWIA/g7mfRIh25WqYXlQpnkyDs1uqDNi5kqsKE=;
        b=AItJTnih9pXuWGjHsGyTv7xfEOpAwEZIOZ6KnNQoZcucGcn3UK7AsTR6sygavyG6Pe/1lK
        fbiUL2z5lSH8JKNxELAZ88ztCIQMJ4m8f8KlJNl7ceyrM8hhY85TM+TmgBGMOP3fRfyodC
        P3zmSgC24JLU3AwCKO31jNVDO+1wHfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-Uu0QOX68O_eAddw1YEHCeQ-1; Thu, 27 Feb 2020 12:23:36 -0500
X-MC-Unique: Uu0QOX68O_eAddw1YEHCeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D221A13E5;
        Thu, 27 Feb 2020 17:23:33 +0000 (UTC)
Received: from millenium-falcon.redhat.com (unknown [10.36.118.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECCB11001B2C;
        Thu, 27 Feb 2020 17:23:30 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>
Subject: [PATCH 1/5] KVM: x86: Add function to inject guest page fault with reserved bits set
Date:   Thu, 27 Feb 2020 19:23:02 +0200
Message-Id: <20200227172306.21426-2-mgamal@redhat.com>
In-Reply-To: <20200227172306.21426-1-mgamal@redhat.com>
References: <20200227172306.21426-1-mgamal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 arch/x86/kvm/x86.c | 14 ++++++++++++++
 arch/x86/kvm/x86.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 359fcd395132..434c55a8b719 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10494,6 +10494,20 @@ u64 kvm_spec_ctrl_valid_bits(struct kvm_vcpu *vc=
pu)
 }
 EXPORT_SYMBOL_GPL(kvm_spec_ctrl_valid_bits);
=20
+void kvm_inject_rsvd_bits_pf(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+	struct x86_exception fault;
+
+	fault.vector =3D PF_VECTOR;
+	fault.error_code_valid =3D true;
+	fault.error_code =3D PFERR_RSVD_MASK;
+	fault.nested_page_fault =3D false;
+	fault.address =3D gpa;
+
+	kvm_inject_page_fault(vcpu, &fault);
+}
+EXPORT_SYMBOL_GPL(kvm_inject_rsvd_bits_pf);
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_fast_mmio);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 3624665acee4..7d8ab28a6983 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -276,6 +276,7 @@ int kvm_mtrr_get_msr(struct kvm_vcpu *vcpu, u32 msr, =
u64 *pdata);
 bool kvm_mtrr_check_gfn_range_consistency(struct kvm_vcpu *vcpu, gfn_t g=
fn,
 					  int page_num);
 bool kvm_vector_hashing_enabled(void);
+void kvm_inject_rsvd_bits_pf(struct kvm_vcpu *vcpu, gpa_t gpa);
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    int emulation_type, void *insn, int insn_len);
 enum exit_fastpath_completion handle_fastpath_set_msr_irqoff(struct kvm_=
vcpu *vcpu);
--=20
2.21.1

