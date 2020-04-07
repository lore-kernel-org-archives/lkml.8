Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD2DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F207520768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkEJ3mbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDGSVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:21:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21822 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726277AbgDGSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586283676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=IbMheVXmF0VacTTe2Hnfg/Xyo9y1cU/Y6NYWIzzzerg=;
        b=SkEJ3mbfIILtm+Xu6JDgBON0cQdguIZmsKGEEXMxK/R709hBhYcWaNGf+ft/HN3MnYRb6E
        9djHFZnfZ7FMmNpWcWk2+txYCZ2aBdiakYirTbmCnINjPUrKjJguCcClNbqPAuTVjCU4+q
        JK1LIm3xMyUiRudVMYlGQ7st8UdEj9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-1XmFQbKJOvOaa9FylQnhcw-1; Tue, 07 Apr 2020 14:21:13 -0400
X-MC-Unique: 1XmFQbKJOvOaa9FylQnhcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 333C08017FE;
        Tue,  7 Apr 2020 18:21:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DF2360BEC;
        Tue,  7 Apr 2020 18:21:11 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] Second batch of KVM changes for Linux 5.7
Date:   Tue,  7 Apr 2020 14:21:11 -0400
Message-Id: <20200407182111.23659-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 8c1b724ddb218f221612d4c649bc9c7819d8d7a6:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2020-04-02 15:13:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to dbef2808af6c594922fe32833b30f55f35e9da6d:

  KVM: VMX: fix crash cleanup when KVM wasn't used (2020-04-07 08:35:36 -0400)

----------------------------------------------------------------
s390:
* nested virtualization fixes

x86:
* split svm.c
* miscellaneous fixes

----------------------------------------------------------------
David Hildenbrand (3):
      KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks
      KVM: s390: vsie: Fix delivery of addressing exceptions
      KVM: s390: vsie: Fix possible race when shadowing region 3 tables

Joerg Roedel (4):
      kVM SVM: Move SVM related files to own sub-directory
      KVM: SVM: Move Nested SVM Implementation to nested.c
      KVM: SVM: Move AVIC code to separate file
      KVM: SVM: Move SEV code to separate file

Oliver Upton (1):
      KVM: nVMX: don't clear mtf_pending when nested events are blocked

Paolo Bonzini (1):
      Merge tag 'kvm-s390-master-5.7-1' of git://git.kernel.org/.../kvms390/linux into HEAD

Uros Bizjak (2):
      KVM: SVM: Split svm_vcpu_run inline assembly to separate file
      KVM: VMX: Remove unnecessary exception trampoline in vmx_vmenter

Vitaly Kuznetsov (1):
      KVM: VMX: fix crash cleanup when KVM wasn't used

Wanpeng Li (1):
      KVM: X86: Filter out the broadcast dest for IPI fastpath

 arch/s390/kvm/vsie.c                  |    1 +
 arch/s390/mm/gmap.c                   |    7 +-
 arch/x86/kvm/Makefile                 |    2 +-
 arch/x86/kvm/lapic.c                  |    3 -
 arch/x86/kvm/lapic.h                  |    3 +
 arch/x86/kvm/svm/avic.c               | 1027 ++++++
 arch/x86/kvm/svm/nested.c             |  823 +++++
 arch/x86/kvm/{pmu_amd.c => svm/pmu.c} |    0
 arch/x86/kvm/svm/sev.c                | 1187 ++++++
 arch/x86/kvm/{ => svm}/svm.c          | 6476 ++++++++-------------------------
 arch/x86/kvm/svm/svm.h                |  491 +++
 arch/x86/kvm/svm/vmenter.S            |  162 +
 arch/x86/kvm/vmx/nested.c             |    3 +-
 arch/x86/kvm/vmx/vmenter.S            |    8 +-
 arch/x86/kvm/vmx/vmx.c                |   12 +-
 arch/x86/kvm/x86.c                    |    3 +-
 16 files changed, 5219 insertions(+), 4989 deletions(-)
 create mode 100644 arch/x86/kvm/svm/avic.c
 create mode 100644 arch/x86/kvm/svm/nested.c
 rename arch/x86/kvm/{pmu_amd.c => svm/pmu.c} (100%)
 create mode 100644 arch/x86/kvm/svm/sev.c
 rename arch/x86/kvm/{ => svm}/svm.c (54%)
 create mode 100644 arch/x86/kvm/svm/svm.h
 create mode 100644 arch/x86/kvm/svm/vmenter.S

