Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C93C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4260E2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMF976h4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgE2Pjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:39:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24001 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727926AbgE2Pjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590766787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j87hAUDq+YScmHL+QJ3UZ2kOk+T1wpoCPQwDzEm8eX0=;
        b=eMF976h4gXkOaostMO6SeC7utC3MxE2hjwf0ZbOiQ812q/DyZF+jnUGd6Z8xnJILBucwTN
        7sSF0tYritKiNfcTdgc/Vwv0PuqzHsRnO8APYaV7ws39124PL0HUQYMRJsnX3XLB0XojV3
        GG8Kx5FI5Dx8YaOGHWCaCTkQdrQ5J2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-3XzJ9W-wP1OBay2uFaXtgw-1; Fri, 29 May 2020 11:39:45 -0400
X-MC-Unique: 3XzJ9W-wP1OBay2uFaXtgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55ACD107ACF9;
        Fri, 29 May 2020 15:39:44 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFAE178366;
        Fri, 29 May 2020 15:39:43 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH 16/30] KVM: nSVM: restore clobbered INT_CTL fields after clearing VINTR
Date:   Fri, 29 May 2020 11:39:20 -0400
Message-Id: <20200529153934.11694-17-pbonzini@redhat.com>
In-Reply-To: <20200529153934.11694-1-pbonzini@redhat.com>
References: <20200529153934.11694-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore the INT_CTL value from the guest's VMCB once we've stopped using
it, so that virtual interrupts can be injected as requested by L1.
V_TPR is up-to-date however, and it can change if the guest writes to CR8,
so keep it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ec98c5979656..4122ba86bac2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1365,9 +1365,17 @@ static void svm_set_vintr(struct vcpu_svm *svm)
 
 static void svm_clear_vintr(struct vcpu_svm *svm)
 {
+	const u32 mask = V_TPR_MASK | V_GIF_ENABLE_MASK | V_GIF_MASK | V_INTR_MASKING_MASK;
 	clr_intercept(svm, INTERCEPT_VINTR);
 
-	svm->vmcb->control.int_ctl &= ~V_IRQ_MASK;
+	/* Drop int_ctl fields related to VINTR injection.  */
+	svm->vmcb->control.int_ctl &= mask;
+	if (is_guest_mode(&svm->vcpu)) {
+		WARN_ON((svm->vmcb->control.int_ctl & V_TPR_MASK) !=
+			(svm->nested.ctl.int_ctl & V_TPR_MASK));
+		svm->vmcb->control.int_ctl |= svm->nested.ctl.int_ctl & ~mask;
+	}
+
 	mark_dirty(svm->vmcb, VMCB_INTR);
 }
 
-- 
2.26.2


