Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140BAC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E816420780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyZp3l7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDQQix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:38:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23036 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgDQQiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587141529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Z/pKVMMwxLbjeJ0zqc1nvp6FeDnWdM331HyKwioYf8M=;
        b=FyZp3l7hM6EYVN1Ry0vj4HP14HkXagzYaQXdthOFBbshrT+lQraOo8mbhByt8GLbZRtUCB
        xSapNOOBubYBR7X2wVGhAmU5KxTnZZ6mXSUZdEaKxAGouslT9/eLnuyaVBVybMjTT/yNDN
        pxQRuEBjoY9rtVBnXl24K6vLF4MYZEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Z7Q7GfjpPaOj1LKiOUnahg-1; Fri, 17 Apr 2020 12:38:46 -0400
X-MC-Unique: Z7Q7GfjpPaOj1LKiOUnahg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056F91083E85;
        Fri, 17 Apr 2020 16:38:45 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DB685DA84;
        Fri, 17 Apr 2020 16:38:44 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 2/2] selftests: kvm/set_memory_region_test: do not check RIP if the guest shuts down
Date:   Fri, 17 Apr 2020 12:38:43 -0400
Message-Id: <20200417163843.71624-3-pbonzini@redhat.com>
In-Reply-To: <20200417163843.71624-1-pbonzini@redhat.com>
References: <20200417163843.71624-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD, the state of the VMCB is undefined after a shutdown VMEXIT.  KVM
takes a very conservative approach to that and resets the guest altogether
when that happens.  This causes the set_memory_region_test to fail
because the RIP is 0xfff0 (the reset vector).  Restrict the RIP test
to KVM_EXIT_INTERNAL_ERROR in order to fix this.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../testing/selftests/kvm/set_memory_region_test.c  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 260e638826dc..b3ece55a2da6 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -287,10 +287,15 @@ static void test_delete_memory_region(void)
 
 	vcpu_regs_get(vm, VCPU_ID, &regs);
 
-	TEST_ASSERT(regs.rip >= final_rip_start &&
-		    regs.rip < final_rip_end,
-		    "Bad rip, expected 0x%lx - 0x%lx, got 0x%llx\n",
-		    final_rip_start, final_rip_end, regs.rip);
+	/*
+	 * On AMD, after KVM_EXIT_SHUTDOWN the VMCB has been reinitialized already,
+	 * so the instruction pointer would point to the reset vector.
+	 */
+	if (run->exit_reason == KVM_EXIT_INTERNAL_ERROR)
+		TEST_ASSERT(regs.rip >= final_rip_start &&
+			    regs.rip < final_rip_end,
+			    "Bad rip, expected 0x%lx - 0x%lx, got 0x%llx\n",
+			    final_rip_start, final_rip_end, regs.rip);
 
 	kvm_vm_free(vm);
 }
-- 
2.18.2

