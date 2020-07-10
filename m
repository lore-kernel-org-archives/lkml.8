Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D48C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A7820836
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtoQ3/RD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgGJOMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:12:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48681 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728315AbgGJOMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594390351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOceSolOcCnL8nnokzwJbOsFELxGoSPw4yCTbFrccdo=;
        b=ZtoQ3/RDbk5wHOsAs++BNJ07CzUsOucQbYMniUd8mg+l+Leu073he+xbnHhq0ocgEdnXo8
        jbEfRcgIvQ7aCKG0xWfrhuCfP8EhemmRYHh2jK9inhFlabY+K4wmAOaE2TwMb989yPbBmo
        fTG03GX+++cVUpeLvUb8sy1wDQ8dRto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-Ur86T0lJPLSe1nDsqltjyA-1; Fri, 10 Jul 2020 10:12:27 -0400
X-MC-Unique: Ur86T0lJPLSe1nDsqltjyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 569CB1083;
        Fri, 10 Jul 2020 14:12:26 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2992374F52;
        Fri, 10 Jul 2020 14:12:23 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] KVM: x86: drop superfluous mmu_check_root() from fast_pgd_switch()
Date:   Fri, 10 Jul 2020 16:11:57 +0200
Message-Id: <20200710141157.1640173-10-vkuznets@redhat.com>
In-Reply-To: <20200710141157.1640173-1-vkuznets@redhat.com>
References: <20200710141157.1640173-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmu_check_root() check in fast_pgd_switch() seems to be
superfluous: when GPA is outside of the visible range
cached_root_available() will fail for non-direct roots
(as we can't have a matching one on the list) and we don't
seem to care for direct ones.

Also, raising #TF immediately when a non-existent GFN is written to CR3
doesn't seem to mach architectural behavior. Drop the check.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 13ec3c30eda2..50a923696bf1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4277,8 +4277,7 @@ static bool fast_pgd_switch(struct kvm_vcpu *vcpu, gpa_t new_pgd,
 	 */
 	if (mmu->shadow_root_level >= PT64_ROOT_4LEVEL &&
 	    mmu->root_level >= PT64_ROOT_4LEVEL)
-		return !mmu_check_root(vcpu, new_pgd >> PAGE_SHIFT) &&
-		       cached_root_available(vcpu, new_pgd, new_role);
+		return cached_root_available(vcpu, new_pgd, new_role);
 
 	return false;
 }
-- 
2.25.4

