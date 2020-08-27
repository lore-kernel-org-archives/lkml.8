Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EBCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA9D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFLlpokF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgH0Q1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbgH0Q1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598545665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYH0CxF6eLjWXF76ID4ItW4fWqoQltHt5Ilr7wVAd+g=;
        b=eFLlpokFallt2hubonk79rDQDI01oy21Xc5On6SiHBYj9YQKVhiZnNttnP7hn41OydIvyR
        uqaWw/a1UXP4+oByw0sQdAdCvWPkcP/Ogl/+HFi5V76aEsZNu/lR+9D/UszySIHToLg0Ii
        VMbDQmUseDCVKh8G3Up48qTWOaznbg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-0K9OV4_yNJ-ckBumD-XSUQ-1; Thu, 27 Aug 2020 12:27:40 -0400
X-MC-Unique: 0K9OV4_yNJ-ckBumD-XSUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22EBE802B73;
        Thu, 27 Aug 2020 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD3A95C1C2;
        Thu, 27 Aug 2020 16:27:35 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 2/3] SVM: nSVM: setup nested msr permission bitmap on nested state load
Date:   Thu, 27 Aug 2020 19:27:19 +0300
Message-Id: <20200827162720.278690-3-mlevitsk@redhat.com>
In-Reply-To: <20200827162720.278690-1-mlevitsk@redhat.com>
References: <20200827162720.278690-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was missing and was forcing the L2 run with L1's msr
permission bitmap

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 95fdf068fe4c1..e90bc436f5849 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1134,6 +1134,9 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	load_nested_vmcb_control(svm, &ctl);
 	nested_prepare_vmcb_control(svm);
 
+	if (!nested_svm_vmrun_msrpm(svm))
+		return -EINVAL;
+
 out_set_gif:
 	svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
 	return 0;
-- 
2.26.2

