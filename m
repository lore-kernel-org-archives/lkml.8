Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A61C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F139221741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goR36onb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBEMap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:30:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36837 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727500AbgBEMan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580905842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHRLTiRDFk91fNbjqjjK4sS7PVxxMVDiLVR/Xqc6yrU=;
        b=goR36onbq+Wde7g29GPe+37/YO28USNho5tQ4RptrwrJppehTu/jABbxjkHGDyw11Ic7ay
        c/1h02HxUDC2ZtGPwVM8qo0ry9+xUj5zdsVBE6WnIKjbOlQFMjJf4QtIlA7tJOby3QvdlF
        7i4Hn2l/UeCNWw0FBn3LcSMcjjrRU0k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-8NZPR-KdNVG9czlLnUi0QQ-1; Wed, 05 Feb 2020 07:30:39 -0500
X-MC-Unique: 8NZPR-KdNVG9czlLnUi0QQ-1
Received: by mail-wr1-f72.google.com with SMTP id l1so1126660wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 04:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHRLTiRDFk91fNbjqjjK4sS7PVxxMVDiLVR/Xqc6yrU=;
        b=ogx/z9UuVqtu0rEx9HxyOhmVBUE2QpzSnYcsnWRp0MSE/3INcCwHGck2Tlkl7Yb0b2
         D90NwjNx6tXeYNeqjIvLs7JqbiVC5/FSe1QVV7jx9zjRWWGSBN+6gMHjOQWInCcZIdqh
         cNZ29yv6+7SMXmSkQ+POWKddGQF4r1jce+pcRRXuQAz7ZmTYHg40VaKDs1mjJSq7lMMK
         i3ub/47smEZdq5PNKEpiKlEM5Fkp58lRCPkv4t0jITfkOYxw2F1tGTZlxbNsXRBjdy2t
         +CBHkAycKou/zfP9xvcnhkH29eTyo7ioUvhcHrEAiXGAK8aidZk2FhuTTPQg4qwS8lWB
         Mqpw==
X-Gm-Message-State: APjAAAWKe6qIBalatXsxA4M+WB/3NxXhjWGAF2HVg7OfGg52/g5Rb1nY
        hdaWXQ4KX1czjmkbNTrbbBFWvedLp+OcEPbfEUgr1IFXlnj49XI9j6Zej57u7+nI6AaZj5oVtrO
        y4EeVUzjbg+zUTXiunOhe207G
X-Received: by 2002:a5d:5263:: with SMTP id l3mr27754230wrc.405.1580905838388;
        Wed, 05 Feb 2020 04:30:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxd5Bz9WYMUVNFZyA/vAWEUrG6f9LLsByb0bUcfyGjRUNIQyI+6xv9t7EQ2SbgTUNWO2yOMw==
X-Received: by 2002:a5d:5263:: with SMTP id l3mr27754211wrc.405.1580905838179;
        Wed, 05 Feb 2020 04:30:38 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g7sm34227251wrq.21.2020.02.05.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 04:30:37 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 1/3] x86/kvm/hyper-v: remove stale evmcs_already_enabled check from nested_enable_evmcs()
Date:   Wed,  5 Feb 2020 13:30:32 +0100
Message-Id: <20200205123034.630229-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205123034.630229-1-vkuznets@redhat.com>
References: <20200205123034.630229-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nested_enable_evmcs() evmcs_already_enabled check doesn't really do
anything: controls are already sanitized and we return '0' regardless.
Just drop the check.

Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 72359709cdc1..89c3e0caf39f 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -350,17 +350,12 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	bool evmcs_already_enabled = vmx->nested.enlightened_vmcs_enabled;
 
 	vmx->nested.enlightened_vmcs_enabled = true;
 
 	if (vmcs_version)
 		*vmcs_version = nested_get_evmcs_version(vcpu);
 
-	/* We don't support disabling the feature for simplicity. */
-	if (evmcs_already_enabled)
-		return 0;
-
 	vmx->nested.msrs.pinbased_ctls_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
 	vmx->nested.msrs.entry_ctls_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
 	vmx->nested.msrs.exit_ctls_high &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
-- 
2.24.1

