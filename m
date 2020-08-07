Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A52C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F17A22CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Anx/nToC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHGIj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:39:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31531 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726382AbgHGIj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596789597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OlUdNVLkFbE86ANY/tbMVg0aRxa7c4aH/HL6yZUmDFI=;
        b=Anx/nToC93GeclaJg0o9ZmqKTpCK0i2n68pPiZdkDInfitUH0dkGG7ztzseEuZFu+b51X6
        dq3AtWM2Yu9aJQQQqoc0trY8RvpMOZgxQAlx4ZrN/363JSkIyh1lkeJ0nsXdwO+YfI8fFo
        UqBonBnU5jrHgLhsJExeptaYEBJ+QvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-eRSuRYPAOOacnDWMSEeuCw-1; Fri, 07 Aug 2020 04:39:53 -0400
X-MC-Unique: eRSuRYPAOOacnDWMSEeuCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E24928005B0;
        Fri,  7 Aug 2020 08:39:51 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 950025C1D2;
        Fri,  7 Aug 2020 08:39:48 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Jon Doron <arilou@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] KVM: x86: hyper-v: make KVM_GET_SUPPORTED_HV_CPUID more useful
Date:   Fri,  7 Aug 2020 10:39:39 +0200
Message-Id: <20200807083946.377654-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM_GET_SUPPORTED_HV_CPUID was initially implemented as a vCPU ioctl but
this is not very useful when VMM is just trying to query which Hyper-V
features are supported by the host prior to creating VM/vCPUs. The data
in KVM_GET_SUPPORTED_HV_CPUID is mostly static with a few exceptions but
it seems we can change this. Add support for KVM_GET_SUPPORTED_HV_CPUID as
a system ioctl as well.

QEMU specific description:
In some cases QEMU needs to collect the information about which Hyper-V
features are supported by KVM and pass it up the stack. For non-hyper-v
features this is done with system-wide KVM_GET_SUPPORTED_CPUID/
KVM_GET_MSRS ioctls but Hyper-V specific features don't get in the output
(as Hyper-V CPUIDs intersect with KVM's). In QEMU, CPU feature expansion
happens before any KVM vcpus are created so KVM_GET_SUPPORTED_HV_CPUID
can't be used in its current shape.

Vitaly Kuznetsov (7):
  KVM: x86: hyper-v: Mention SynDBG CPUID leaves in api.rst
  KVM: x86: hyper-v: disallow configuring SynIC timers with no SynIC
  KVM: x86: hyper-v: make KVM_GET_SUPPORTED_HV_CPUID output independent
    of eVMCS enablement
  KVM: x86: hyper-v: always advertise HV_STIMER_DIRECT_MODE_AVAILABLE
  KVM: x86: hyper-v: drop now unneeded vcpu parameter from
    kvm_vcpu_ioctl_get_hv_cpuid()
  KVM: x86: hyper-v: allow KVM_GET_SUPPORTED_HV_CPUID as a system ioctl
  KVM: selftests: test KVM_GET_SUPPORTED_HV_CPUID as a system ioctl

 Documentation/virt/kvm/api.rst                | 12 +--
 arch/x86/include/asm/kvm_host.h               |  2 +-
 arch/x86/kvm/hyperv.c                         | 30 ++++----
 arch/x86/kvm/hyperv.h                         |  3 +-
 arch/x86/kvm/vmx/evmcs.c                      |  8 +-
 arch/x86/kvm/vmx/evmcs.h                      |  2 +-
 arch/x86/kvm/x86.c                            | 44 ++++++-----
 include/uapi/linux/kvm.h                      |  4 +-
 .../testing/selftests/kvm/include/kvm_util.h  |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 26 +++++++
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 77 +++++++++----------
 11 files changed, 120 insertions(+), 90 deletions(-)

-- 
2.25.4

