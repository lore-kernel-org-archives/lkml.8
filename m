Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C34C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF81208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDAG44KP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgCIPwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:52:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40863 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727071AbgCIPw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583769148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUjMf0pru97NKPn88I5joi0BdJ++OODXbfomnXreXCg=;
        b=eDAG44KP78M/zxqNDhx4NNYJFKpEXQvkUIPHAmhlkABR0wuUO18ZcUePqX6W0/EyHlKMe/
        M1w5katVatyVVH8HRo1t6DIwI5wjRCabALP+tggD9dtaUCUA/6KoHEBoAk3Xw6GeD6rA0F
        berXOs5eOhYdfucHa2kpqAxqwQCFDTk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-xf7zL3YXNHK9TDYLXywS8A-1; Mon, 09 Mar 2020 11:52:26 -0400
X-MC-Unique: xf7zL3YXNHK9TDYLXywS8A-1
Received: by mail-wm1-f70.google.com with SMTP id n188so14842wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUjMf0pru97NKPn88I5joi0BdJ++OODXbfomnXreXCg=;
        b=uirdux5yTThgLCB+duFxgzBa/tMlpNGNxefDNMO7Bf3KpBOaCHH9eTeYLOZlJXfxTi
         WNopSg8gY2bXtjICYTBgTgEwXKsX/9rHg3XYX6bc69r8xPJVeRMHokQgwL1w5VVmu8fi
         CakBX/Xh8Nw5dRQz6xCIzsPEy7azQMnfi1szgP+qYdIrX6dj+z9ONoY8UN75AJZaA/Ht
         HCamql0HtqUTJNtTm7C5+N+ukCc0EaAa0ZQidRYkpefzBSPY7Tk9/vyOEH3uFbgRULBc
         rclIFkZ4PjfhgOwaPO8giCjL07oKKTy0UTNUcHMUj7EOoUNNBR79b71vbc/bj07xwIAi
         CRPA==
X-Gm-Message-State: ANhLgQ3otUBDkBCxOM8iQDrt3X383rUJL7ErRlhihBeDiLVrIl3G+yxz
        rOtUyuE93h4Z9r7guz+AK+PLztP1GX3DuYCWZNudNsvl6jMz0NBGWsLYxx0WiPEF0feRRZ8bNZW
        uG/Hmg0I1iW4/xwq2Si8smlsB
X-Received: by 2002:adf:fa50:: with SMTP id y16mr22546598wrr.41.1583769145414;
        Mon, 09 Mar 2020 08:52:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs+HzLTtazNgJbQdyRhXHpsKnoISFChWiFU93ZCJ5xdplETQI692if7cVEAxyLXeEoO6fSXXg==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr22546578wrr.41.1583769145152;
        Mon, 09 Mar 2020 08:52:25 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q4sm17294521wro.56.2020.03.09.08.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:52:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH 2/6] KVM: nVMX: stop abusing need_vmcs12_to_shadow_sync for eVMCS mapping
Date:   Mon,  9 Mar 2020 16:52:12 +0100
Message-Id: <20200309155216.204752-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309155216.204752-1-vkuznets@redhat.com>
References: <20200309155216.204752-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When vmx_set_nested_state() happens, we may not have all the required
data to map enlightened VMCS: e.g. HV_X64_MSR_VP_ASSIST_PAGE MSR may not
yet be restored so we need a postponed action. Currently, we (ab)use
need_vmcs12_to_shadow_sync/nested_sync_vmcs12_to_shadow() for that but
this is not ideal:
- We may not need to sync anything if L2 is running
- It is hard to propagate errors from nested_sync_vmcs12_to_shadow()
 as we call it from vmx_prepare_switch_to_guest() which happens just
 before we do VMLAUNCH, the code is not ready to handle errors there.

Move eVMCS mapping to nested_get_vmcs12_pages() and request
KVM_REQ_GET_VMCS12_PAGES, it seems to be is less abusive in nature.
It would probably be possible to introduce a specialized KVM_REQ_EVMCS_MAP
but it is undesirable to propagate eVMCS specifics all the way up to x86.c

Note, we don't need to request KVM_REQ_GET_VMCS12_PAGES from
vmx_set_nested_state() directly as nested_vmx_enter_non_root_mode() already
does that. Requesting KVM_REQ_GET_VMCS12_PAGES is done to document the
(non-obvious) side-effect and to be future proof.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9750e590c89d..72398e3bc92b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1997,14 +1997,6 @@ void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	/*
-	 * hv_evmcs may end up being not mapped after migration (when
-	 * L2 was running), map it here to make sure vmcs12 changes are
-	 * properly reflected.
-	 */
-	if (vmx->nested.enlightened_vmcs_enabled && !vmx->nested.hv_evmcs)
-		nested_vmx_handle_enlightened_vmptrld(vcpu, false);
-
 	if (vmx->nested.hv_evmcs) {
 		copy_vmcs12_to_enlightened(vmx);
 		/* All fields are clean */
@@ -3053,6 +3045,14 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	struct page *page;
 	u64 hpa;
 
+	/*
+	 * hv_evmcs may end up being not mapped after migration (when
+	 * L2 was running), map it here to make sure vmcs12 changes are
+	 * properly reflected.
+	 */
+	if (vmx->nested.enlightened_vmcs_enabled && !vmx->nested.hv_evmcs)
+		nested_vmx_handle_enlightened_vmptrld(vcpu, false);
+
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
 		/*
 		 * Translate L1 physical address to host physical
@@ -5905,10 +5905,12 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 		set_current_vmptr(vmx, kvm_state->hdr.vmx.vmcs12_pa);
 	} else if (kvm_state->flags & KVM_STATE_NESTED_EVMCS) {
 		/*
-		 * Sync eVMCS upon entry as we may not have
-		 * HV_X64_MSR_VP_ASSIST_PAGE set up yet.
+		 * nested_vmx_handle_enlightened_vmptrld() cannot be called
+		 * directly from here as HV_X64_MSR_VP_ASSIST_PAGE may not be
+		 * restored yet. EVMCS will be mapped from
+		 * nested_get_vmcs12_pages().
 		 */
-		vmx->nested.need_vmcs12_to_shadow_sync = true;
+		kvm_make_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
 	} else {
 		return -EINVAL;
 	}
-- 
2.24.1

