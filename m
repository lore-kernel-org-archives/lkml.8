Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0857AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3303206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHLBnS1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgFJQli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:41:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52715 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726095AbgFJQlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591807295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JjmEXwM2z+xW1VlWIW84dTFtD9mhLZeCe5kD1Da0GoU=;
        b=EHLBnS1VjZq7UlyZ5X/fvBWr78t/n0+dNMztw3rGiKpqJgHrCEZ3Et4IttccCQqAW/Md1J
        o8hjBR69SHPefOIM46rav4aOGWE6rq5zvpJ9tGQkPyJXrhjD8CXkIwBdXAIhmN4405aBx2
        ROfC/y5IvNyzjN4TqH9NMYwtV3SsBEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-ShVyT7k7OSCrrFC0vmj9gw-1; Wed, 10 Jun 2020 12:41:32 -0400
X-MC-Unique: ShVyT7k7OSCrrFC0vmj9gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D24791B2C980;
        Wed, 10 Jun 2020 16:41:30 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC5017C3B9;
        Wed, 10 Jun 2020 16:41:17 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Marcelo Bandeira Condotta <mcondotta@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: fix sync_with_host() in smm_test
Date:   Wed, 10 Jun 2020 18:41:16 +0200
Message-Id: <20200610164116.770811-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that older GCCs compile smm_test in a way that breaks
it completely:

  kvm_exit:             reason EXIT_CPUID rip 0x4014db info 0 0
  func 7ffffffd idx 830 rax 0 rbx 0 rcx 0 rdx 0, cpuid entry not found
  ...
  kvm_exit:             reason EXIT_MSR rip 0x40abd9 info 0 0
  kvm_msr:              msr_read 487 = 0x0 (#GP)
  ...

Note, '7ffffffd' was supposed to be '80000001' as we're checking for
SVM. Dropping '-O2' from compiler flags help. Turns out, asm block in
sync_with_host() is wrong. We us 'in 0xe, %%al' instruction to sync
with the host and in 'AL' register we actually pass the parameter
(stage) but after sync 'AL' gets written to but GCC thinks the value
is still there and uses it to compute 'EAX' for 'cpuid'.

smm_test can't fully use standard ucall() framework as we need to
write a very simple SMI handler there. Fix the immediate issue by
making RAX input/output operand. While on it, make sync_with_host()
static inline.

Reported-by: Marcelo Bandeira Condotta <mcondotta@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/x86_64/smm_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index 36314152943d..ae39a220609f 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -47,10 +47,10 @@ uint8_t smi_handler[] = {
 	0x0f, 0xaa,           /* rsm */
 };
 
-void sync_with_host(uint64_t phase)
+static inline void sync_with_host(uint64_t phase)
 {
 	asm volatile("in $" XSTR(SYNC_PORT)", %%al \n"
-		     : : "a" (phase));
+		     : "+a" (phase));
 }
 
 void self_smi(void)
-- 
2.25.4

