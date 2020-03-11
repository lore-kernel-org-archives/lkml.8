Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD799C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C213206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avmx2t1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgCKSex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:34:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37261 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730641AbgCKSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583951692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=ck66yOynV6oFFHDYrIkPfdq+bgw9rigHmyCYwCoQaaQ=;
        b=avmx2t1IC9dvDiqjd9CQrDoDkb0Uwsh2MGMTMbASMc8fe3iWN3ysabN+s80PiM0m0+/FD5
        AAZil4VHNfzm8s/zjiQsU+dUwz8ujDgghjdEB457i6e/z4o8GAW8DySWg+xE+bamwN+JEX
        hXXWGFdrhKQNEG6ZDN3vde//E5f0r54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-Yf2UNswrNKGu9r_EIxvw3w-1; Wed, 11 Mar 2020 14:34:48 -0400
X-MC-Unique: Yf2UNswrNKGu9r_EIxvw3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 092A8107ACCC;
        Wed, 11 Mar 2020 18:34:47 +0000 (UTC)
Received: from virtlab512.virt.lab.eng.bos.redhat.com (virtlab512.virt.lab.eng.bos.redhat.com [10.19.152.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB6B884779;
        Wed, 11 Mar 2020 18:34:45 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, pbonzini@redhat.com
Subject: [Patch v1] KVM: x86: Initializing all kvm_lapic_irq fields
Date:   Wed, 11 Mar 2020 14:34:45 -0400
Message-Id: <1583951685-202743-1-git-send-email-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously all fields of structure kvm_lapic_irq were not initialized
before it was passed to kvm_bitmap_or_dest_vcpus(). Which will cause
an issue when any of those fields are used for processing a request.
This patch initializes all the fields of kvm_lapic_irq based on the
values which are passed through the ioapic redirect_entry object.

Fixes: 7ee30bc132c6("KVM: x86: deliver KVM IOAPIC scan request to target vCPUs")
Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 arch/x86/kvm/ioapic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 7668fed..3a8467d 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -378,12 +378,15 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
 		if (e->fields.delivery_mode == APIC_DM_FIXED) {
 			struct kvm_lapic_irq irq;
 
-			irq.shorthand = APIC_DEST_NOSHORT;
 			irq.vector = e->fields.vector;
 			irq.delivery_mode = e->fields.delivery_mode << 8;
-			irq.dest_id = e->fields.dest_id;
 			irq.dest_mode =
 			    kvm_lapic_irq_dest_mode(!!e->fields.dest_mode);
+			irq.level = 1;
+			irq.trig_mode = e->fields.trig_mode;
+			irq.shorthand = APIC_DEST_NOSHORT;
+			irq.dest_id = e->fields.dest_id;
+			irq.msi_redir_hint = false;
 			bitmap_zero(&vcpu_bitmap, 16);
 			kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
 						 &vcpu_bitmap);
-- 
1.8.3.1

