Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D1AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D542074D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+zIOwQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgFVQIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:08:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35248 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbgFVQIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592842123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oLt4zilRnLpSNkiF0C8oekFwW4sIceZdS9Lxg4NGfQA=;
        b=X+zIOwQ8lKRqow7O8kpUKjELqX+MtcdM3skTior4cv7zfv7AmK8lNqfc9Y7GoepUIC36+g
        Z+3bz4cwxpkNpPV7HAJO/L2DaKZTYdWY1IxH7YSIUge8b81A6bTn9p3cG6sgJBiAj6SuLA
        3i+Ka4CUFbXufcW0PKWhWbQaVErj9AQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-IPnes8dvMvar_MJTs1dysA-1; Mon, 22 Jun 2020 12:08:35 -0400
X-MC-Unique: IPnes8dvMvar_MJTs1dysA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 545F5A0BD9;
        Mon, 22 Jun 2020 16:08:33 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECEC45BACD;
        Mon, 22 Jun 2020 16:08:31 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, kvm@vger.kernel.org, wanpengli@tencent.com
Subject: [PATCH] kvm: lapic: fix broken vcpu hotplug
Date:   Mon, 22 Jun 2020 12:08:30 -0400
Message-Id: <20200622160830.426022-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest fails to online hotplugged CPU with error
  smpboot: do_boot_cpu failed(-1) to wakeup CPU#4

It's caused by the fact that kvm_apic_set_state(), which used to call
recalculate_apic_map() unconditionally and pulled hotplugged CPU into
apic map, is updating map conditionally [1] on state change which doesn't
happen in this case and apic map update is skipped.

Note:
new CPU during kvm_arch_vcpu_create() is not visible to
kvm_recalculate_apic_map(), so all related update calls endup
as NOP and only follow up kvm_apic_set_state() used to trigger map
update that counted in hotplugged CPU.
Fix issue by forcing unconditional update from kvm_apic_set_state(),
like it used to be.

1)
Fixes: (4abaffce4d25a KVM: LAPIC: Recalculate apic map in batch)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
PS:
it's alternative to full revert of [1], I've posted earlier
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2205600.html
so fii free to pick up whatever is better by now
---
 arch/x86/kvm/lapic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 34a7e0533dad..5696831d4005 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2556,6 +2556,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	int r;
 
+	apic->vcpu->kvm->arch.apic_map_dirty = true;
 	kvm_lapic_set_base(vcpu, vcpu->arch.apic_base);
 	/* set SPIV separately to get count of SW disabled APICs right */
 	apic_set_spiv(apic, *((u32 *)(s->regs + APIC_SPIV)));
-- 
2.26.2

