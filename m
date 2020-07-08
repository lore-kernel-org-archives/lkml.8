Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F0EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035F2206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYTpSPuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgGHJgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:36:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55031 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726973AbgGHJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594200978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EXLv6hsZ/QhTdQkzMIaq3BPH71+im/fXOsDOYnL4M9A=;
        b=NYTpSPuZNOHy5/IdoAEL+IymiW4MC1Tm7p/WOA4MKm2tD8FBDdZJe9aE+ydCXExny6IlDR
        LIgH4UX52QOFXREreN8mZsONpQk2HjQxLupMukOLE1EzSlBJHzh4pGSRUWFmB4sh/eRuCV
        y/f0NUy53Et4Y7e4ruayL3k9MMUEEzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Z9U-hLTZOPGhlVyBIK_szg-1; Wed, 08 Jul 2020 05:36:17 -0400
X-MC-Unique: Z9U-hLTZOPGhlVyBIK_szg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32429461;
        Wed,  8 Jul 2020 09:36:15 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EF215C221;
        Wed,  8 Jul 2020 09:36:12 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] KVM: nSVM: fix #TF from CR3 switch when entering guest
Date:   Wed,  8 Jul 2020 11:36:08 +0200
Message-Id: <20200708093611.1453618-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a succesor of "[PATCH] KVM: x86: drop erroneous mmu_check_root()
from fast_pgd_switch()".

Undesired triple fault gets injected to L1 guest on SVM when L2 is
launched with certain CR3 values. #TF is raised by mmu_check_root()
check in fast_pgd_switch() and the root cause is that when
kvm_set_cr3() is called from nested_prepare_vmcb_save() with NPT
enabled CR3 points to a nGPA so we can't check it with
kvm_is_visible_gfn().

Fix the issue by moving kvm_mmu_new_pgd() to the right place when switching
to nested guest and drop the unneeded mmu_check_root() check from
fast_pgd_switch().

Vitaly Kuznetsov (3):
  KVM: nSVM: split kvm_init_shadow_npt_mmu() from kvm_init_shadow_mmu()
  KVM: nSVM: properly call kvm_mmu_new_pgd() upon switching to guest
  KVM: x86: drop superfluous mmu_check_root() from fast_pgd_switch()

 arch/x86/include/asm/kvm_host.h |  7 ++++++-
 arch/x86/kvm/mmu.h              |  3 ++-
 arch/x86/kvm/mmu/mmu.c          | 36 ++++++++++++++++++++++++---------
 arch/x86/kvm/svm/nested.c       |  5 +++--
 arch/x86/kvm/x86.c              |  8 +++++---
 5 files changed, 43 insertions(+), 16 deletions(-)

-- 
2.25.4

