Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6323CC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D477206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcYx2KNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgCZUDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:03:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25818 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727446AbgCZUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585253000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=IKJXvHsw2viIBMjcPMcNthSEpAPOCGzoH1WTxzpDB7k=;
        b=FcYx2KNs1tT3NRjtXdPH+l7+1PQKleMS8X8RMUCjQnipORIMn043LOC+PW0bKbjRj0jRWx
        GgmsLHmZM3tWhgzyFof3H0NkzDJhY3PWNXzF3jZ/AsPNhsXLC7RPqBL4WFkUp0Mk2i20V8
        NOhyIzriba7sfjzzG4gvzOcOTuHjrGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-0uD2s0BPO4-KlYUbF5eL5A-1; Thu, 26 Mar 2020 16:03:13 -0400
X-MC-Unique: 0uD2s0BPO4-KlYUbF5eL5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3AE61007268;
        Thu, 26 Mar 2020 20:03:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F41B60BF3;
        Thu, 26 Mar 2020 20:03:12 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 5.6 final (or -rc8)
Date:   Thu, 26 Mar 2020 16:03:11 -0400
Message-Id: <20200326200311.28222-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 018cabb694e3923998fdc2908af5268f1d89f48f:

  Merge branch 'kvm-null-pointer-fix' into kvm-master (2020-03-14 12:49:37 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to e1be9ac8e6014a9b0a216aebae7250f9863e9fc3:

  KVM: X86: Narrow down the IPI fastpath to single target IPI (2020-03-26 05:44:21 -0400)

----------------------------------------------------------------
x86 bug fixes.

----------------------------------------------------------------
He Zhe (1):
      KVM: LAPIC: Mark hrtimer for period or oneshot mode to expire in hard interrupt context

Nick Desaulniers (1):
      KVM: VMX: don't allow memory operands for inline asm that modifies SP

Paolo Bonzini (2):
      KVM: x86: remove bogus user-triggerable WARN_ON
      KVM: SVM: document KVM_MEM_ENCRYPT_OP, let userspace detect if SEV is available

Tom Lendacky (1):
      KVM: SVM: Issue WBINVD after deactivating an SEV guest

Wanpeng Li (2):
      KVM: LAPIC: Also cancel preemption timer when disarm LAPIC timer
      KVM: X86: Narrow down the IPI fastpath to single target IPI

 Documentation/virt/kvm/amd-memory-encryption.rst | 25 ++++++++++++++++++++++++
 arch/x86/kvm/lapic.c                             |  8 +++++++-
 arch/x86/kvm/svm.c                               | 25 ++++++++++++++++--------
 arch/x86/kvm/vmx/vmx.c                           |  2 +-
 arch/x86/kvm/x86.c                               |  6 ++++--
 5 files changed, 54 insertions(+), 12 deletions(-)

