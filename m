Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE22DC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CD4208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKtapjT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCIPw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:52:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59728 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbgCIPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583769147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3E4LIBi/eaTA+USlOTfstaQ+9ylrR99sJyL6v/S7Fzk=;
        b=fKtapjT8EGbaeMdtDDNv3HxuapRSH2RWSfl7zPvA04UjiadJdQOuh46yOS2oEikofv9Fb0
        tv43mgFxzY0mQgcYTp6+K8mMzVt3Sb0JSa5kegA6HUzh0A9N3IX1yngMc53Fl/zcy0DCfr
        oBMmsEok2P+ghKVzBZeQnZtIzPzQja4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-qVazAxTiO8ScCi1GI0Ptaw-1; Mon, 09 Mar 2020 11:52:23 -0400
X-MC-Unique: qVazAxTiO8ScCi1GI0Ptaw-1
Received: by mail-wr1-f70.google.com with SMTP id c6so5364900wrm.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3E4LIBi/eaTA+USlOTfstaQ+9ylrR99sJyL6v/S7Fzk=;
        b=O1XnJWhWOI1Gu4k1Je8bG91jV++5j4L/uS8Sni2zeXmYpA28HqVBkQsYpR9kF5tV9g
         iDFEFbAD/2p1ICrK1apBjGoReoJTwNyTREH4sypV75i4pJLsVZqdtvk+odnR/7y44Hlo
         BU8kTE0QtjMGvP86PGuG+0PW/okaHDkEazWvL/l4audTx3XAf1jQnMDPk/kpoIQqxtyI
         3OqHYJjqDnYRKIj+cBJ83IZCApxk2n26kK9lJ04P/bYTpGRyY5x/F4cyW1q+ebtrlqmI
         Co4zWod2fxqWB03iTFbw3AOnLLpu0A5EIgnse9ziggmS+DfCDhj6ojsTcyj4YeCWCKAi
         Ra2w==
X-Gm-Message-State: ANhLgQ3Qp5O1fWSYpV6IrCBfLmaCZGpZ2BHvhll7mvsDgfr5cQqHVxAY
        OVZhb/BtHD+t8r7MXN6Nmk1FjFGqaZulIH3duPv9q2MfJH+0RcAgceQRpVRf/jE4WpY/OSROcso
        QHNiYKWxsFZTyyx1/+Wc36cC9
X-Received: by 2002:a5d:5411:: with SMTP id g17mr20557074wrv.4.1583769142613;
        Mon, 09 Mar 2020 08:52:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs9pNoq6eROQLSMnQjOi+/bC2QHYG7NKgj7y/VTWqWWzCnhRUMXrJkC1KQDPqK4jhMpsxv/EA==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr20557054wrv.4.1583769142367;
        Mon, 09 Mar 2020 08:52:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q4sm17294521wro.56.2020.03.09.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:52:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH 1/6] KVM: nVMX: avoid NULL pointer dereference with incorrect EVMCS GPAs
Date:   Mon,  9 Mar 2020 16:52:11 +0100
Message-Id: <20200309155216.204752-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309155216.204752-1-vkuznets@redhat.com>
References: <20200309155216.204752-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an EVMCS enabled L1 guest on KVM will tries doing enlightened VMEnter
with EVMCS GPA = 0 the host crashes because the

evmcs_gpa != vmx->nested.hv_evmcs_vmptr

condition in nested_vmx_handle_enlightened_vmptrld() will evaluate to
false (as nested.hv_evmcs_vmptr is zeroed after init). The crash will
happen on vmx->nested.hv_evmcs pointer dereference.

Another problematic EVMCS ptr value is '-1' but it only causes host crash
after nested_release_evmcs() invocation. The problem is exactly the same as
with '0', we mistakenly think that the EVMCS pointer hasn't changed and
thus nested.hv_evmcs_vmptr is valid.

Resolve the issue by adding an additional !vmx->nested.hv_evmcs
check to nested_vmx_handle_enlightened_vmptrld(), this way we will
always be trying kvm_vcpu_map() when nested.hv_evmcs is NULL
and this is supposed to catch all invalid EVMCS GPAs.

Also, initialize hv_evmcs_vmptr to '0' in nested_release_evmcs()
to be consistent with initialization where we don't currently
set hv_evmcs_vmptr to '-1'.

Cc: stable@vger.kernel.org
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e920d7834d73..9750e590c89d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -224,7 +224,7 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 		return;
 
 	kvm_vcpu_unmap(vcpu, &vmx->nested.hv_evmcs_map, true);
-	vmx->nested.hv_evmcs_vmptr = -1ull;
+	vmx->nested.hv_evmcs_vmptr = 0;
 	vmx->nested.hv_evmcs = NULL;
 }
 
@@ -1923,7 +1923,8 @@ static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
 	if (!nested_enlightened_vmentry(vcpu, &evmcs_gpa))
 		return 1;
 
-	if (unlikely(evmcs_gpa != vmx->nested.hv_evmcs_vmptr)) {
+	if (unlikely(!vmx->nested.hv_evmcs ||
+		     evmcs_gpa != vmx->nested.hv_evmcs_vmptr)) {
 		if (!vmx->nested.hv_evmcs)
 			vmx->nested.current_vmptr = -1ull;
 
-- 
2.24.1

