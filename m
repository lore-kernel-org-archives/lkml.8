Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D9C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EAF9206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBRkPDZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgEEPr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:47:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52487 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729569AbgEEPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588693675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EQ23tM5kMyn811fS97lNvm/DAC1rh32RC7gp61B/0ws=;
        b=QBRkPDZZ+owFkGi2+xP/wa1o/3GMmZWkxf4drmH9KQTuhIEBFvu2sb5ZC/uEGgAaQg5Tlk
        HO/9yj5nH84dReaP0JYm0IiNhVpEJB9/OAz9/HuA66PD+w5uoUzRDVnh4btjMyrrqEgdLU
        WnrRMgegYep2/fp4ODNC1QKSLFtMBcg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-w8o9HSUHPAygHf6BAPDKMA-1; Tue, 05 May 2020 11:47:53 -0400
X-MC-Unique: w8o9HSUHPAygHf6BAPDKMA-1
Received: by mail-qt1-f197.google.com with SMTP id f56so2071697qte.18
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EQ23tM5kMyn811fS97lNvm/DAC1rh32RC7gp61B/0ws=;
        b=GP3l+ihcO7vz56Retb9cZ/zsdHhBnnntN1l/hawU4J/aF4cud03RygiZP5KBhu7Vk6
         3Fufex7jzooc4lQp58SpWidv2QBIoIA9jHCVzHpno80Ufkt8djrOHefuaZZ/ibbAyXFH
         qw/nQphfcHqRfR60R3ovDsHfveRD1csDI5RPKfMTdriTrwQgt5Zq2KY9D6YjRovjq+tI
         7/Ugy3MB/PHMAtrV2NJhLAwrSw99rju7MR/94hnuZscdOHqSMeXjiH5JQpQRPjSdj/ms
         WwkWw+DWdHrHIjfiwSVCZ6wO1UfujckNbcQrepIu86ddKIkR/xdO1Od3do6kH/9ubsOk
         M/Tw==
X-Gm-Message-State: AGi0PuaKLiBs7GE9PUvKO9AzUAxTMvluY+sbTdFNG7O0Ey6OVN5xUMVw
        iMuCB6TOWKeJVOWI6ePF9yEHNJSSFeLHohbGqnlGUY0kbf5wkCGGH3thd+6TsqEbL1EVf587t7d
        uwlqx4b55v/9FOj2/lGyv+IBE
X-Received: by 2002:a37:af05:: with SMTP id y5mr4261812qke.471.1588693673001;
        Tue, 05 May 2020 08:47:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypLoIwGDPk77az/a2DrITfutNeyY8xsNdsMX2fUvJgFNvtmn7qg0F/iELQj44ngrT8/uGNZ7sg==
X-Received: by 2002:a37:af05:: with SMTP id y5mr4261783qke.471.1588693672668;
        Tue, 05 May 2020 08:47:52 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id u5sm2081443qkm.116.2020.05.05.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:47:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH] KVM: X86: Declare KVM_CAP_SET_GUEST_DEBUG properly
Date:   Tue,  5 May 2020 11:47:50 -0400
Message-Id: <20200505154750.126300-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM_CAP_SET_GUEST_DEBUG should be supported for x86 however it's not declared
as supported.  My wild guess is that userspaces like QEMU are using "#ifdef
KVM_CAP_SET_GUEST_DEBUG" to check for the capability instead, but that could be
wrong because the compilation host may not be the runtime host.

The userspace might still want to keep the old "#ifdef" though to not break the
guest debug on old kernels.

Signed-off-by: Peter Xu <peterx@redhat.com>
---

I also think both ppc and s390 may need similar thing, but I didn't touch them
yet because of not confident enough to cover all cases.
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c5835f9cb9ad..ac7b0e6f4000 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3385,6 +3385,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_GET_MSR_FEATURES:
 	case KVM_CAP_MSR_PLATFORM_INFO:
 	case KVM_CAP_EXCEPTION_PAYLOAD:
+	case KVM_CAP_SET_GUEST_DEBUG:
 		r = 1;
 		break;
 	case KVM_CAP_SYNC_REGS:
-- 
2.26.2

