Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49705C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBF520659
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG9m5Qhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgFEL7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:59:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46533 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgFEL7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591358355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKLxozwE9yOiueToAj/LCbZmtKtjyMDIjDUUZ06KkvY=;
        b=PG9m5QhprnO+Bi9N6cYxR956UJF/RAa0STaTOPnVd/ubgFe0kKj6GAT290dEbwsKAPjQY2
        zIi5S6JABXosoVb4cwSaS55Yq/8wwXa4fP+yil/qHh5T90/McTtu9Ulq9uoz9Ug4sNl2SS
        G68in4j01h2awQgPh6ePSyfvYoqutSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-MKba7rfnPkekL33pkDZqkw-1; Fri, 05 Jun 2020 07:59:13 -0400
X-MC-Unique: MKba7rfnPkekL33pkDZqkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8693E800688;
        Fri,  5 Jun 2020 11:59:12 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A83B35D9DA;
        Fri,  5 Jun 2020 11:59:10 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Revert "KVM: x86: work around leak of uninitialized stack contents"
Date:   Fri,  5 Jun 2020 13:59:06 +0200
Message-Id: <20200605115906.532682-2-vkuznets@redhat.com>
In-Reply-To: <20200605115906.532682-1-vkuznets@redhat.com>
References: <20200605115906.532682-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_vmptrst()/handle_vmread() stopped injecting #PF unconditionally
and switched to nested_vmx_handle_memory_failure() which just kills the
guest with KVM_EXIT_INTERNAL_ERROR in case of MMIO access, zeroing
'exception' in kvm_write_guest_virt_system() is not needed anymore.

This reverts commit 541ab2aeb28251bf7135c7961f3a6080eebcc705.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/x86.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9e41b5135340..0097a97d331f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5647,13 +5647,6 @@ int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu, gva_t addr, void *val,
 	/* kvm_write_guest_virt_system can pull in tons of pages. */
 	vcpu->arch.l1tf_flush_l1d = true;
 
-	/*
-	 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDED
-	 * is returned, but our callers are not ready for that and they blindly
-	 * call kvm_inject_page_fault.  Ensure that they at least do not leak
-	 * uninitialized kernel stack memory into cr2 and error code.
-	 */
-	memset(exception, 0, sizeof(*exception));
 	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
 					   PFERR_WRITE_MASK, exception);
 }
-- 
2.25.4

