Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E38C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337D222CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIrhVIPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgHGIkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727957AbgHGIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596789614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tapk5X882JkWKX+3cYAD+GMIrv4DCXAv+v7JG2RGp4=;
        b=QIrhVIPOLd+lx/ty7CFw+Idf+L8NEMZXRaX8GTUF10a9iURZv2uYkRAtlDM3bhgEJTLNKi
        pHsoamgPsZiu34GyrcW2oziszSa1a4pqIMS8POYVV/l1szgiKfRb0vc/lkwGaBkuUy9Zh5
        NqCot34GXLdeb77L8ZH+Au4itROe50Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-D_5NxhDnMcWUlNv0PozHow-1; Fri, 07 Aug 2020 04:40:11 -0400
X-MC-Unique: D_5NxhDnMcWUlNv0PozHow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C5B8017FB;
        Fri,  7 Aug 2020 08:40:09 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B3DF5C1D2;
        Fri,  7 Aug 2020 08:40:07 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Jon Doron <arilou@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] KVM: x86: hyper-v: always advertise HV_STIMER_DIRECT_MODE_AVAILABLE
Date:   Fri,  7 Aug 2020 10:39:43 +0200
Message-Id: <20200807083946.377654-5-vkuznets@redhat.com>
In-Reply-To: <20200807083946.377654-1-vkuznets@redhat.com>
References: <20200807083946.377654-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HV_STIMER_DIRECT_MODE_AVAILABLE is the last conditionally set feature bit
in KVM_GET_SUPPORTED_HV_CPUID but it doesn't have to be conditional: first,
this bit is only an indication to userspace VMM that direct mode stimers
are supported, it still requires manual enablement (enabling SynIC) to
work so no VMM should just blindly copy it to guest CPUIDs. Second,
lapic_in_kernel() is a must for SynIC. Expose the bit unconditionally.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5a6831799544..a8ebaa66a8e1 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2027,13 +2027,7 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->ebx |= HV_DEBUGGING;
 			ent->edx |= HV_X64_GUEST_DEBUGGING_AVAILABLE;
 			ent->edx |= HV_FEATURE_DEBUG_MSRS_AVAILABLE;
-
-			/*
-			 * Direct Synthetic timers only make sense with in-kernel
-			 * LAPIC
-			 */
-			if (lapic_in_kernel(vcpu))
-				ent->edx |= HV_STIMER_DIRECT_MODE_AVAILABLE;
+			ent->edx |= HV_STIMER_DIRECT_MODE_AVAILABLE;
 
 			break;
 
-- 
2.25.4

