Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D19C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFB9207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAPnzH9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbgEZRXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:23:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41503 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389275AbgEZRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590513825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwYDsYOfWkvOXdIZq6xeSGLtmViex0XfUmWf4Uu92a0=;
        b=LAPnzH9dkB0Va/0cGdn3jQmmZD+tpD+JzWuiUc/O4Bss1zkhXsVjgG534lbEHwsLVZxqM5
        FeA45CBj7+quyWrFP6hu7yDRyyLTeLANYa93kEIls44fUFgqZpEewiTqIYGWnh+psZlAXw
        DoDjw/poWp3FtiwXPX9/bK0nKnI1dFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-dtvZkIV5MA2C4u-ABP01mA-1; Tue, 26 May 2020 13:23:43 -0400
X-MC-Unique: dtvZkIV5MA2C4u-ABP01mA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6617318A0778;
        Tue, 26 May 2020 17:23:42 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA6685C1BB;
        Tue, 26 May 2020 17:23:36 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 18/28] KVM: nSVM: remove unnecessary if
Date:   Tue, 26 May 2020 13:22:58 -0400
Message-Id: <20200526172308.111575-19-pbonzini@redhat.com>
In-Reply-To: <20200526172308.111575-1-pbonzini@redhat.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_vcpu_apicv_active must be false when nested virtualization is enabled,
so there is no need to check it in clgi_interception.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 97dbd6f65831..0654c5672b1a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2015,8 +2015,7 @@ static int clgi_interception(struct vcpu_svm *svm)
 	disable_gif(svm);
 
 	/* After a CLGI no interrupts should come */
-	if (!kvm_vcpu_apicv_active(&svm->vcpu))
-		svm_clear_vintr(svm);
+	svm_clear_vintr(svm);
 
 	return ret;
 }
-- 
2.26.2


