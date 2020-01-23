Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648D0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DF320718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/C8CMtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgAWSFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:05:22 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51332 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgAWSEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:55 -0500
Received: by mail-pf1-f202.google.com with SMTP id z19so2070623pfn.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fRJtGzU1nWtZCwyyEdBQOQV0uriURdFY4YOkq57xKFA=;
        b=I/C8CMtDyMwkAyRWTigJSrx8ByPwzQxVcP2Y+qJ4lGvA2rQUQ+UnnLo7HnBLIstBBI
         Se+PwmLQHN+LOVGuJqJzd/H7Bcbp05STGoP3ij0oUhXZqXYtjMxODspqKQ+r0Qf/48bi
         XXhUwajJPI3kaI+9Ok0tfbC6HBRjJ6XiYJGcpudGe+aY+EvqIUsCZEGShQlf86XZaWzo
         Q2P/+Y2eTaAm8vFcIPTkCe/0dFigQC6wmq42DqOwPkIRwZyXrBrWJGdFPD1QSYjfNjYL
         rV8Z0D6oaAwGzyN0FI4d4McSMqWxeax+btspKH6/+JWKqHjpJ9le7DXX1SDGH0LLCwJn
         jHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fRJtGzU1nWtZCwyyEdBQOQV0uriURdFY4YOkq57xKFA=;
        b=RwUfpoFjqzlmZ6uVF1EIbrFkPQGR8ELsT9Xp0o54PlwvACNf0k6kbb7PZJ9iZKyhk0
         qoKyCIx6GTePWa7GEVik++2h3z14zGyKBQ5e7qd0hrTDY3JgNTzcoZRvJr1n89aQ7KzI
         G2pb2cw3GT3UzPmRWhRHFxfB1YE0iDIozKyMTKGKLqd5Nc4I0aa9nM3xEqPuVGYe13i0
         bt4ivUcETSWPJsBTs7OuuCb4s7fVof1g2svLawqj8BMzKXCEN8dTAtmQyIThxg7ltO6+
         qqoxyX440K9I8VmNLZaD35lcHl/XQ1hzTng4dAOHQuutsNfltVl/bSu5oAVgS8Oc+Xd9
         uADg==
X-Gm-Message-State: APjAAAXFD47a5l2gGaqPUw2ZZBM5U1XNH+yv9a1KbW64ArMiu0spvuw9
        SrTnrILZfhvCHyuLBmDTPAejpu93cJ6w/GN1t16gu3ruJ/0BIKYOUCQAVuyg05tvHKjzEPF4bD6
        XQOzHuo3Ox59sZ4uCbr41fyH85i4mZ9RhjMUuv451fERh2w6TMWWxLfWX+6A5rylNqS+rehPR
X-Google-Smtp-Source: APXvYqx0aHZM1DcqSFTVtQf5JBTmVMs5XjbKOT9oAFEQnjFFCQcfL2/KGMJmFYibuxRpdeVN5YZ1pdPKWiZd
X-Received: by 2002:a63:6c86:: with SMTP id h128mr14829pgc.200.1579802694008;
 Thu, 23 Jan 2020 10:04:54 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:32 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-7-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 06/10] KVM: selftests: Add support for vcpu_args_set to
 aarch64 and s390x
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently vcpu_args_set is only implemented for x86. This makes writing
tests with multiple vCPUs difficult as each guest vCPU must either a.)
do the same thing or b.) derive some kind of unique token from it's
registers or the architecture. To simplify the process of writing tests
with multiple vCPUs for s390 and aarch64, add set args functions for
those architectures.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/lib/aarch64/processor.c     | 33 +++++++++++++++++
 .../selftests/kvm/lib/s390x/processor.c       | 35 +++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 86036a59a668e..a2ff90a75f326 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -333,3 +333,36 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 {
 	aarch64_vcpu_add_default(vm, vcpuid, NULL, guest_code);
 }
+
+/* VM VCPU Args Set
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   num - number of arguments
+ *   ... - arguments, each of type uint64_t
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Sets the first num function input arguments to the values
+ * given as variable args.  Each of the variable args is expected to
+ * be of type uint64_t. The registers set by this function are r0-r7.
+ */
+void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
+{
+	va_list ap;
+
+	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
+		    "  num: %u\n",
+		    num);
+
+	va_start(ap, num);
+
+	for (i = 0; i < num; i++)
+		set_reg(vm, vcpuid, ARM64_CORE_REG(regs.regs[num]),
+			va_arg(ap, uint64_t));
+
+	va_end(ap);
+}
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 32a02360b1eb0..680f37be9dbc9 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -269,6 +269,41 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 	run->psw_addr = (uintptr_t)guest_code;
 }
 
+/* VM VCPU Args Set
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   num - number of arguments
+ *   ... - arguments, each of type uint64_t
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Sets the first num function input arguments to the values
+ * given as variable args.  Each of the variable args is expected to
+ * be of type uint64_t. The registers set by this function are r2-r6.
+ */
+void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
+{
+	va_list ap;
+	struct kvm_regs regs;
+
+	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
+		    "  num: %u\n",
+		    num);
+
+	va_start(ap, num);
+	vcpu_regs_get(vm, vcpuid, &regs);
+
+	for (i = 0; i < num; i++)
+		regs.gprs[i + 2] = va_arg(ap, uint64_t);
+
+	vcpu_regs_set(vm, vcpuid, &regs);
+	va_end(ap);
+}
+
 void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
 {
 	struct vcpu *vcpu = vm->vcpu_head;
-- 
2.25.0.341.g760bfbb309-goog

