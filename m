Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D27C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12D620714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340527;
	bh=UIpegJNULyKBWEMumoWwrG2B15Jat15T2/qa3UZL1g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KLKOf4I1plO7pQb6+VYG6EE4TpEPx340mpDHeqGUQZKnCO2BR4caBD0sXbveD77Qi
	 CpvvKKaMYdP1DJjWuOkAY9g6pv5V597r4ycIVQOMP6m0awB0GCqOWqd3lPXS4UMiw3
	 ePRWDdGbUkow1DiH3JYz01H4ceimpwJWeZDI6r9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgBJNP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgBJMiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:21 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83282168B;
        Mon, 10 Feb 2020 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338300;
        bh=UIpegJNULyKBWEMumoWwrG2B15Jat15T2/qa3UZL1g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x+CgYguWmsfS/hq9J7FX+5qH1W00DZC3NfTi/HayRp4BZYNaUiz3OJ1FfjwNO+1gM
         ddb2lkmt1/rMflw9vWn66LpHIOWDxaobB9ZilQUpxYK26sExG1B2o6jsPVJxVDZ6/n
         h9aWJN8y2dj7ccCEoqFQSnCu9mdheG5BNL6+AeYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.4 211/309] KVM: PPC: Book3S HV: Uninit vCPU if vcore creation fails
Date:   Mon, 10 Feb 2020 04:32:47 -0800
Message-Id: <20200210122426.803087822@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 1a978d9d3e72ddfa40ac60d26301b154247ee0bc upstream.

Call kvm_vcpu_uninit() if vcore creation fails to avoid leaking any
resources allocated by kvm_vcpu_init(), i.e. the vcpu->run page.

Fixes: 371fefd6f2dc4 ("KVM: PPC: Allow book3s_hv guests to use SMT processor modes")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2354,7 +2354,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu
 	mutex_unlock(&kvm->lock);
 
 	if (!vcore)
-		goto free_vcpu;
+		goto uninit_vcpu;
 
 	spin_lock(&vcore->lock);
 	++vcore->num_threads;
@@ -2371,6 +2371,8 @@ static struct kvm_vcpu *kvmppc_core_vcpu
 
 	return vcpu;
 
+uninit_vcpu:
+	kvm_vcpu_uninit(vcpu);
 free_vcpu:
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 out:


