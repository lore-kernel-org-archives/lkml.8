Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31970C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C512068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPEtup4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgDUQHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:07:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbgDUQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587485222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=o5FOkANuc3nLYhQjPcsDscbLbZtxZk5DwaFRxRr4r+g=;
        b=DPEtup4T0UHRXsXgnRYBp9lqPZgySbAOIL+nSoo5gDGTcnYrfyufwnuWum42lh/53NlvS+
        PeW+yXFLLkBHwqRi5itxMSOxxX5GbDeXVW/wHN7YcGHR7plvO57Y07UmALnUEtSJT7Tdpr
        LqJUOL5k1WLtk8LLTSlNOkwaHXKtZAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-qIM84Du8Oc-OIl56oNYQQQ-1; Tue, 21 Apr 2020 12:06:53 -0400
X-MC-Unique: qIM84Du8Oc-OIl56oNYQQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E32361922021;
        Tue, 21 Apr 2020 16:06:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71B9676E74;
        Tue, 21 Apr 2020 16:06:52 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 5.7-rc3
Date:   Tue, 21 Apr 2020 12:06:51 -0400
Message-Id: <20200421160651.19274-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 00a6a5ef39e7db3648b35c86361058854db84c83:

  Merge tag 'kvm-ppc-fixes-5.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into kvm-master (2020-04-21 09:39:55 -0400)

----------------------------------------------------------------
Bugfixes, and a few cleanups to the newly-introduced assembly language
vmentry code for AMD.

----------------------------------------------------------------
Borislav Petkov (1):
      KVM: SVM: Fix build error due to missing release_pages() include

Claudio Imbrenda (1):
      MAINTAINERS: add a reviewer for KVM/s390

Eric Farman (1):
      KVM: s390: Fix PV check in deliverable_irqs()

Josh Poimboeuf (1):
      kvm: Disable objtool frame pointer checking for vmenter.S

Oliver Upton (2):
      kvm: nVMX: reflect MTF VM-exits if injected by L1
      kvm: nVMX: match comment with return type for nested_vmx_exit_reflected

Paolo Bonzini (4):
      KVM: SVM: fix compilation with modular PSP and non-modular KVM
      KVM: SVM: move more vmentry code to assembly
      Merge tag 'kvm-s390-master-5.7-2' of git://git.kernel.org/.../kvms390/linux into kvm-master
      Merge tag 'kvm-ppc-fixes-5.7-1' of git://git.kernel.org/.../paulus/powerpc into kvm-master

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Handle non-present PTEs in page fault functions

Sean Christopherson (2):
      KVM: Check validity of resolved slot when searching memslots
      KVM: s390: Return last valid slot if approx index is out-of-bounds

Steve Rutherford (1):
      KVM: Remove CREATE_IRQCHIP/SET_PIT2 race

Uros Bizjak (4):
      KVM: VMX: Enable machine check support for 32bit targets
      KVM: SVM: Do not mark svm_vcpu_run with STACK_FRAME_NON_STANDARD
      KVM: SVM: Do not setup frame pointer in __svm_vcpu_run
      KVM: SVM: Fix __svm_vcpu_run declaration.

Venkatesh Srinivas (1):
      kvm: Handle reads of SandyBridge RAPL PMU MSRs rather than injecting #GP

 MAINTAINERS                            |  1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  9 +++++----
 arch/powerpc/kvm/book3s_64_mmu_radix.c |  9 +++++----
 arch/s390/kvm/interrupt.c              |  2 +-
 arch/s390/kvm/kvm-s390.c               |  3 +++
 arch/x86/include/asm/nospec-branch.h   | 21 ---------------------
 arch/x86/kvm/Makefile                  |  4 ++++
 arch/x86/kvm/svm/sev.c                 |  6 +++++-
 arch/x86/kvm/svm/svm.c                 | 10 +---------
 arch/x86/kvm/svm/vmenter.S             | 10 +++++++++-
 arch/x86/kvm/vmx/nested.c              | 21 +++++++++++++++++++--
 arch/x86/kvm/vmx/vmx.c                 |  2 +-
 arch/x86/kvm/x86.c                     | 21 +++++++++++++++++++--
 include/linux/kvm_host.h               |  2 +-
 14 files changed, 74 insertions(+), 47 deletions(-)

