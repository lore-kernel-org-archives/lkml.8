Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42E0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768F12070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adTr7fq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgATPLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:11:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20339 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729159AbgATPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579533106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jl75FyV2eKAuNVkPFCRLduCG2Tj/ztsoq3xLT8s1OKA=;
        b=adTr7fq/ZB9Dz3LrmAl+bzWj6GOKvI/uIGvBMLr2ZoSmaFW6nALcQDZrqa8vNR6PU2qG12
        ssv6rf7PiUIPW4M6c+AuYV/VVqh778VTkpYpdm02HPoyK9x2E8c2+DQfiQL7WEajesIxFs
        JqWKDkbXToT83UFJ/JaexBsIJGQq5NA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-dzzo49kQOry5Um8UtxP5Sg-1; Mon, 20 Jan 2020 10:11:45 -0500
X-MC-Unique: dzzo49kQOry5Um8UtxP5Sg-1
Received: by mail-wr1-f69.google.com with SMTP id y7so14298386wrm.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jl75FyV2eKAuNVkPFCRLduCG2Tj/ztsoq3xLT8s1OKA=;
        b=hQCpQhFkGT6i7e8c7oyJ8YJm0oysKMWrtMCoQeGOXJ7PbxNTKat0Znixv0oZv6UsQ3
         S0P3Oz0iU9ftPuiVAawsNAQNMcnFSyceC1/2Vdrfj/IZKmsYeDn/GZr8jeCt3YcraUah
         HSUqLvn9JvIcqs9nRnabfzOEZbnAENq8cHDJ7IR1TSzN7hMLl2wwJf0caLLFZCBOkegk
         N4Z9WBY78LhixCh2efy9w5cJrEqwSkdEq9LVu/XPAfoo3LCqlU2Yyd9AlmaX1W1Nw9oo
         t/MWa5VcKnXv12Ho1fk61KWSZ6phwqsHiVF67fUhf2I0dio7Sx7NzKXhoI4ge1TOO7PA
         rc0Q==
X-Gm-Message-State: APjAAAU+VptJs3RnLcA1+pBn4ybyhul6BCtkxCOBvYXdMA52hkhUT475
        RLCVlOU6ClJ5FwymbhuexTU65qEOYJk7/sQkfXdc/aKWB5FoisAnfRdSa7OaiJa0wVKaTFsVss+
        u3EKvnH9BOibZPaeiMnXlmDPe
X-Received: by 2002:a5d:6144:: with SMTP id y4mr18472332wrt.15.1579533103594;
        Mon, 20 Jan 2020 07:11:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwozBAXQphYzllCmalCwNBWOVy6u0dZCaSjZL8FjTnS+D47H1/1MzPh9W3DbIpfjfStE25Mbw==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr18472310wrt.15.1579533103369;
        Mon, 20 Jan 2020 07:11:43 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y20sm833707wmi.25.2020.01.20.07.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 07:11:42 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>
Subject: [RFC] Revert "kvm: nVMX: Restrict VMX capability MSR changes"
Date:   Mon, 20 Jan 2020 16:11:41 +0100
Message-Id: <20200120151141.227254-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a943ac50d10aac96dca63d0460365a699d41fdd0.

Fine-grained VMX feature enablement in QEMU broke live migration with
nested guest:

 (qemu) qemu-kvm: error: failed to set MSR 0x48e to 0xfff9fffe04006172

The problem is that QEMU does KVM_SET_NESTED_STATE before KVM_SET_MSRS,
although it can probably be changed.

RFC. I think the check for vmx->nested.vmxon is legitimate for everything
but restore so removing it (what I do with the revert) is likely a no-go.
I'd like to gather opinions on the proper fix: should we somehow check
that the vCPU is in 'restore' start (has never being run) and make
KVM_SET_MSRS pass or should we actually mandate that KVM_SET_NESTED_STATE
is run after KVM_SET_MSRS by userspace?

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4aea7d304beb..bb8afe0c5e7f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1321,13 +1321,6 @@ int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	/*
-	 * Don't allow changes to the VMX capability MSRs while the vCPU
-	 * is in VMX operation.
-	 */
-	if (vmx->nested.vmxon)
-		return -EBUSY;
-
 	switch (msr_index) {
 	case MSR_IA32_VMX_BASIC:
 		return vmx_restore_vmx_basic(vmx, data);
-- 
2.24.1

