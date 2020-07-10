Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F61C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8375620725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZD56assv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGJPsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:48:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27826 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727863AbgGJPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594396101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qnq1BGapFhMZc1AmRLOzTnZddFrUvqx4x+MyFf6t4sA=;
        b=ZD56assv7V2R4GBOIyHVDdDJK2oUH4wM0QGQIM2NPzrZZcAK1MLH2fOvn9X35cwPCeh7IN
        wRmV6IPRkjgCTzkm1fWYW7eH8DVEOg29iZVd/QkdkVqUmPkROECIXKe7FzYZuHZwyuuQZo
        fnW8B/Lt/ws6mz8GKPuGxpxRX3ljuJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-kURzJpZRPQyy5obrA0h2yA-1; Fri, 10 Jul 2020 11:48:20 -0400
X-MC-Unique: kURzJpZRPQyy5obrA0h2yA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 516A68015F3;
        Fri, 10 Jul 2020 15:48:19 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-235.ams2.redhat.com [10.36.114.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFA8C7EFA3;
        Fri, 10 Jul 2020 15:48:13 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org,
        Mohammed Gamal <mgamal@redhat.com>
Subject: [PATCH v3 0/9] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
Date:   Fri, 10 Jul 2020 17:48:02 +0200
Message-Id: <20200710154811.418214-1-mgamal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EPT is enabled, KVM does not really look at guest physical
address size. Address bits above maximum physical memory size are reserved.
Because KVM does not look at these guest physical addresses, it currently
effectively supports guest physical address sizes equal to the host.

This can be problem when having a mixed setup of machines with 5-level page
tables and machines with 4-level page tables, as live migration can change
MAXPHYADDR while the guest runs, which can theoretically introduce bugs.

In this patch series we add checks on guest physical addresses in EPT
violation/misconfig and NPF vmexits and if needed inject the proper
page faults in the guest.

A more subtle issue is when the host MAXPHYADDR is larger than that of the
guest. Page faults caused by reserved bits on the guest won't cause an EPT
violation/NPF and hence we also check guest MAXPHYADDR and add PFERR_RSVD_MASK
error code to the page fault if needed.

----

Changes from v2:
- Drop support for this feature on AMD processors after discussion with AMD


Mohammed Gamal (5):
  KVM: x86: Add helper functions for illegal GPA checking and page fault
    injection
  KVM: x86: mmu: Move translate_gpa() to mmu.c
  KVM: x86: mmu: Add guest physical address check in translate_gpa()
  KVM: VMX: Add guest physical address check in EPT violation and
    misconfig
  KVM: x86: SVM: VMX: Make GUEST_MAXPHYADDR < HOST_MAXPHYADDR support
    configurable

Paolo Bonzini (4):
  KVM: x86: rename update_bp_intercept to update_exception_bitmap
  KVM: x86: update exception bitmap on CPUID changes
  KVM: VMX: introduce vmx_need_pf_intercept
  KVM: VMX: optimize #PF injection when MAXPHYADDR does not match

 arch/x86/include/asm/kvm_host.h | 10 ++------
 arch/x86/kvm/cpuid.c            |  2 ++
 arch/x86/kvm/mmu.h              |  6 +++++
 arch/x86/kvm/mmu/mmu.c          | 12 +++++++++
 arch/x86/kvm/svm/svm.c          | 22 +++++++++++++---
 arch/x86/kvm/vmx/nested.c       | 28 ++++++++++++--------
 arch/x86/kvm/vmx/vmx.c          | 45 +++++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/vmx.h          |  6 +++++
 arch/x86/kvm/x86.c              | 29 ++++++++++++++++++++-
 arch/x86/kvm/x86.h              |  1 +
 include/uapi/linux/kvm.h        |  1 +
 11 files changed, 133 insertions(+), 29 deletions(-)

-- 
2.26.2

