Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A80C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF0B206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxKH4Rx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgETQHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:07:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40039 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726775AbgETQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589990870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cf3WukEsfySNhoecA6qrczHdfhodkstmNrTwpvxGHuU=;
        b=VxKH4Rx4o3Y99ZH48wRWYyQD2eSMf0ZWmrZXoNSXuzh9n87eza/27Ez8XXXfKXJ67sr0US
        KrcaO3ZtoGELqGa8KdXU2GcHBC/lCtARAtrhgSStp09JnO/cIUS+a6vInCXHkuzD2YAKoy
        G8laCcPLK7bfs1oM9kIytsMEKgysx2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-cTF6r1KZPZueAKuP9-4BHw-1; Wed, 20 May 2020 12:07:48 -0400
X-MC-Unique: cTF6r1KZPZueAKuP9-4BHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E9F8800053;
        Wed, 20 May 2020 16:07:47 +0000 (UTC)
Received: from starship.fedora32vm (unknown [10.35.207.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E1BA341FD;
        Wed, 20 May 2020 16:07:46 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 2/2] kvm/x86: don't expose MSR_IA32_UMWAIT_CONTROL unconditionally
Date:   Wed, 20 May 2020 19:07:40 +0300
Message-Id: <20200520160740.6144-3-mlevitsk@redhat.com>
In-Reply-To: <20200520160740.6144-1-mlevitsk@redhat.com>
References: <20200520160740.6144-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This msr is only available when the host supports WAITPKG feature.

This breaks a nested guest, if the L1 hypervisor is set to ignore
unknown msrs, because the only other safety check that the
kernel does is that it attempts to read the msr and
rejects it if it gets an exception.

Fixes: 6e3ba4abce KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fe3a24fd6b263..9c507b32b1b77 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5314,6 +5314,10 @@ static void kvm_init_msr_list(void)
 			if (msrs_to_save_all[i] - MSR_ARCH_PERFMON_EVENTSEL0 >=
 			    min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
 				continue;
+			break;
+		case MSR_IA32_UMWAIT_CONTROL:
+			if (!kvm_cpu_cap_has(X86_FEATURE_WAITPKG))
+				continue;
 		default:
 			break;
 		}
-- 
2.26.2

