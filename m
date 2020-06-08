Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA772C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CD5206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpzAfCEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgFHLYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:24:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28696 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729713AbgFHLYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591615443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9HAlVWdZdxfSRbyxxgqN4SVRwTe1Y0Wh7Ky+n2UDhmY=;
        b=ZpzAfCEBlGl2nx92AtQQbbVKyLxOjwSovnp8WaF4IV0buvD/dpu7sEsVJ7LTilvF7f0XMI
        pwaLyZ51Go2xYZjfzspViQIFoojuJDI4ppBsGvy/GELbNK0XRmmvXHhW6lO5N/YYjIYy7N
        BQ9cSMetcK5F3hcLwZzSDtdgX7dZo/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-L7NeeYuyPMenKOW9qcFraw-1; Mon, 08 Jun 2020 07:24:01 -0400
X-MC-Unique: L7NeeYuyPMenKOW9qcFraw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF48D8064DF;
        Mon,  8 Jun 2020 11:23:59 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51AD05D9C9;
        Mon,  8 Jun 2020 11:23:57 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Marcelo Bandeira Condotta <mcondotta@redhat.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: fix vmx_preemption_timer_test build with GCC10
Date:   Mon,  8 Jun 2020 13:23:46 +0200
Message-Id: <20200608112346.593513-2-vkuznets@redhat.com>
In-Reply-To: <20200608112346.593513-1-vkuznets@redhat.com>
References: <20200608112346.593513-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC10 fails to build vmx_preemption_timer_test:

gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99
-fno-stack-protector -fno-PIE -I../../../../tools/include
 -I../../../../tools/arch/x86/include -I../../../../usr/include/
 -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  -no-pie
 x86_64/evmcs_test.c ./linux/tools/testing/selftests/kselftest_harness.h
 ./linux/tools/testing/selftests/kselftest.h
 ./linux/tools/testing/selftests/kvm/libkvm.a
 -o ./linux/tools/testing/selftests/kvm/x86_64/evmcs_test
/usr/bin/ld: ./linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):
 ./linux/tools/testing/selftests/kvm/include/x86_64/vmx.h:603:
 multiple definition of `ctrl_exit_rev'; /tmp/ccMQpvNt.o:
 ./linux/tools/testing/selftests/kvm/include/x86_64/vmx.h:603:
 first defined here
/usr/bin/ld: ./linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):
 ./linux/tools/testing/selftests/kvm/include/x86_64/vmx.h:602:
 multiple definition of `ctrl_pin_rev'; /tmp/ccMQpvNt.o:
 ./linux/tools/testing/selftests/kvm/include/x86_64/vmx.h:602:
 first defined here
 ...

ctrl_exit_rev/ctrl_pin_rev/basic variables are only used in
vmx_preemption_timer_test.c, just move them there.

Fixes: 8d7fbf01f9af ("KVM: selftests: VMX preemption timer migration test")
Reported-by: Marcelo Bandeira Condotta <mcondotta@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86_64/vmx.h              | 4 ----
 .../testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c  | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index ccff3e6e2704..766af9944294 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -598,10 +598,6 @@ union vmx_ctrl_msr {
 	};
 };
 
-union vmx_basic basic;
-union vmx_ctrl_msr ctrl_pin_rev;
-union vmx_ctrl_msr ctrl_exit_rev;
-
 struct vmx_pages *vcpu_alloc_vmx(struct kvm_vm *vm, vm_vaddr_t *p_vmx_gva);
 bool prepare_for_vmx_operation(struct vmx_pages *vmx);
 void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
index cc72b6188ca7..a7737af1224f 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
@@ -31,6 +31,10 @@ bool l2_save_restore_done;
 static u64 l2_vmx_pt_start;
 volatile u64 l2_vmx_pt_finish;
 
+union vmx_basic basic;
+union vmx_ctrl_msr ctrl_pin_rev;
+union vmx_ctrl_msr ctrl_exit_rev;
+
 void l2_guest_code(void)
 {
 	u64 vmx_pt_delta;
-- 
2.25.4

