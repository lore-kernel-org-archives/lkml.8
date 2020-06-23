Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F62C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF32206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZk02rCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbgFWRLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:11:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46333 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732565AbgFWRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592932281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tgpqv+Z4YzvIf/4SqnrwWUNPhSAJzQTNmQO1fWEnu4g=;
        b=AZk02rCAYz9FmShJrHLK/213qOgbmJRA0fQvN4CAdiR9hbgHLY6qLIlp57p+qsjV72qm7d
        FZGHL+J5Hj22VmoFLPZLXzIeFkydt7/HL/gfzgGP2sl1kw6JvXThUxbfRmUeXIYqNQouc5
        zT452za7dMG39a39mwssx7e0IGOONn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-fa8R2lz4PIqGlC1xadbvrQ-1; Tue, 23 Jun 2020 13:11:19 -0400
X-MC-Unique: fa8R2lz4PIqGlC1xadbvrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E71B8C4BA1;
        Tue, 23 Jun 2020 17:11:18 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F2AF5D9D3;
        Tue, 23 Jun 2020 17:11:18 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 5.8-rc3
Date:   Tue, 23 Jun 2020 13:11:17 -0400
Message-Id: <20200623171117.326222-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to e4553b4976d1178c13da295cb5c7b21f55baf8f9:

  KVM: VMX: Remove vcpu_vmx's defunct copy of host_pkru (2020-06-23 06:01:29 -0400)

----------------------------------------------------------------
All bugfixes except for a couple cleanup patches.

----------------------------------------------------------------
Huacai Chen (1):
      KVM: MIPS: Fix a build error for !CPU_LOONGSON64

Igor Mammedov (1):
      kvm: lapic: fix broken vcpu hotplug

Marcelo Tosatti (1):
      KVM: x86: allow TSC to differ by NTP correction bounds without TSC scaling

Paolo Bonzini (1):
      KVM: LAPIC: ensure APIC map is up to date on concurrent update requests

Qian Cai (1):
      kvm/svm: disable KCSAN for svm_vcpu_run()

Sean Christopherson (4):
      KVM: VMX: Add helpers to identify interrupt type from intr_info
      KVM: nVMX: Plumb L2 GPA through to PML emulation
      KVM: VMX: Stop context switching MSR_IA32_UMWAIT_CONTROL
      KVM: VMX: Remove vcpu_vmx's defunct copy of host_pkru

Vitaly Kuznetsov (2):
      Revert "KVM: VMX: Micro-optimize vmexit time when not exposing PMU"
      KVM: x86/mmu: Avoid mixing gpa_t with gfn_t in walk_addr_generic()

Xiaoyao Li (1):
      KVM: X86: Fix MSR range of APIC registers in X2APIC mode

 arch/mips/kvm/mips.c            |  2 ++
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/include/asm/mwait.h    |  2 --
 arch/x86/kernel/cpu/umwait.c    |  6 -----
 arch/x86/kvm/lapic.c            | 50 +++++++++++++++++++++++++----------------
 arch/x86/kvm/mmu.h              |  2 +-
 arch/x86/kvm/mmu/mmu.c          |  4 ++--
 arch/x86/kvm/mmu/paging_tmpl.h  | 16 ++++++-------
 arch/x86/kvm/svm/svm.c          |  2 +-
 arch/x86/kvm/vmx/vmcs.h         | 32 ++++++++++++++++----------
 arch/x86/kvm/vmx/vmx.c          | 27 ++++------------------
 arch/x86/kvm/vmx/vmx.h          |  2 --
 arch/x86/kvm/x86.c              |  7 +++---
 13 files changed, 74 insertions(+), 82 deletions(-)

