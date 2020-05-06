Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555ADC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A66A206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhZZGMMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgEFLKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:10:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47671 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728139AbgEFLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588763443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=h2l3KOMDutolAkEtGy6K6Owvl6fNHONxFxSaO2J+VP4=;
        b=RhZZGMMvxB7a/AGEmWk4o5cSsfwn46lxZRCMZ5ZnrgrML9SSDf3/UKvtbv67N1MlwxWkpm
        gfIpFcEbBSVzwr0OFLqtcTRmY+vr2j0F6wRJJ0es/Aw4xnAK09z2BRjH5CSJxDEZYVcYyJ
        R5gCcZnGARi0KbLlrRjxdCE85WRBR3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-Q1s40J2yNQGl_e7U6ioYcQ-1; Wed, 06 May 2020 07:10:41 -0400
X-MC-Unique: Q1s40J2yNQGl_e7U6ioYcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 962AC107ACCA;
        Wed,  6 May 2020 11:10:40 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E107C5C1D4;
        Wed,  6 May 2020 11:10:37 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 1/9] KVM: X86: Declare KVM_CAP_SET_GUEST_DEBUG properly
Date:   Wed,  6 May 2020 07:10:26 -0400
Message-Id: <20200506111034.11756-2-pbonzini@redhat.com>
In-Reply-To: <20200506111034.11756-1-pbonzini@redhat.com>
References: <20200506111034.11756-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

KVM_CAP_SET_GUEST_DEBUG should be supported for x86 however it's not declared
as supported.  My wild guess is that userspaces like QEMU are using "#ifdef
KVM_CAP_SET_GUEST_DEBUG" to check for the capability instead, but that could be
wrong because the compilation host may not be the runtime host.

The userspace might still want to keep the old "#ifdef" though to not break the
guest debug on old kernels.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200505154750.126300-1-peterx@redhat.com>
[Do the same for PPC and s390. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/powerpc/kvm/powerpc.c | 1 +
 arch/s390/kvm/kvm-s390.c   | 1 +
 arch/x86/kvm/x86.c         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index e15166b0a16d..ad2f172c26a6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -521,6 +521,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_DEVICE_CTRL:
 	case KVM_CAP_IMMEDIATE_EXIT:
+	case KVM_CAP_SET_GUEST_DEBUG:
 		r = 1;
 		break;
 	case KVM_CAP_PPC_GUEST_DEBUG_SSTEP:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5dcf9ff12828..d05bb040fd42 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -545,6 +545,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_AIS:
 	case KVM_CAP_S390_AIS_MIGRATION:
 	case KVM_CAP_S390_VCPU_RESETS:
+	case KVM_CAP_SET_GUEST_DEBUG:
 		r = 1;
 		break;
 	case KVM_CAP_S390_HPAGE_1M:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8d296e3d0d56..d786c7d27ce5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3372,6 +3372,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_GET_MSR_FEATURES:
 	case KVM_CAP_MSR_PLATFORM_INFO:
 	case KVM_CAP_EXCEPTION_PAYLOAD:
+	case KVM_CAP_SET_GUEST_DEBUG:
 		r = 1;
 		break;
 	case KVM_CAP_SYNC_REGS:
-- 
2.18.2


