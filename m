Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99531C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E6E207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSbRjJiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGJUvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:51:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35594 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726832AbgGJUvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594414270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nYaxZ7g1kLsIpQ2YHr1Z0FbzS/d7X/Lb2qWm2o336oM=;
        b=XSbRjJiZ19WXfpf+1JO7wsUP2JXy+KYMqKYIrqE3RWu2jiQjqvYSQ5cUpln6aUd02ALAwa
        XXwLjJZ7MHKZf2UQ/tYTo7rGTQLRkHf/EYVxY3F7mp2jvvqfJaa6TFNfCFawGx54KCpS0p
        XjiDsZt3tdmS4i+UkGuhRoRy8EBv6+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-n35QQoVkMbqzxCc70t8gaA-1; Fri, 10 Jul 2020 16:51:08 -0400
X-MC-Unique: n35QQoVkMbqzxCc70t8gaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B56280183C;
        Fri, 10 Jul 2020 20:51:07 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5C7B10013C4;
        Fri, 10 Jul 2020 20:51:06 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>
Subject: [PATCH] KVM: nSVM: remove nonsensical EXITINFO1 adjustment on nested NPF
Date:   Fri, 10 Jul 2020 16:51:06 -0400
Message-Id: <20200710205106.941151-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "if" that drops the present bit from the page structure fauls makes no sense.
It was added by yours truly in order to be bug-compatible with pre-existing code
and in order to make the tests pass; however, the tests are wrong.  The behavior
after this patch matches bare metal.

Reported-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7b331e3da3eb..61378a3c2ce4 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -48,13 +48,6 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 	svm->vmcb->control.exit_info_1 &= ~0xffffffffULL;
 	svm->vmcb->control.exit_info_1 |= fault->error_code;
 
-	/*
-	 * The present bit is always zero for page structure faults on real
-	 * hardware.
-	 */
-	if (svm->vmcb->control.exit_info_1 & (2ULL << 32))
-		svm->vmcb->control.exit_info_1 &= ~1;
-
 	nested_svm_vmexit(svm);
 }
 
-- 
2.26.2

