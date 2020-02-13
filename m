Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B515C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B9624699
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607395;
	bh=i+yGrRs4yCH7reidTqlcHP58PGWiJO2laSighC9WHBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SkUGapUz2hdFKAzT8U8wa+KiiPZs1KsAcYCnycVkacXaIWEh3Q41YhqZb30WUkzm8
	 vFfWBNrDEoo08gbYrPvUpTlQzooAW1G2liRJB9tgmPRbkluNRlLDrNNSbETiFZ8gR6
	 kWB1FTO6gK/PSCW/BIdxyKp2qLsteSeIVaIn69Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgBMPXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgBMPWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:50 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2792469A;
        Thu, 13 Feb 2020 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607370;
        bh=i+yGrRs4yCH7reidTqlcHP58PGWiJO2laSighC9WHBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZjjEjVGgHnK+tBp5mZK50BkRgDWvDBu0vnBfDbiO1yPuoTUx4sMBiA6F9/KcqSQI
         7OpYP+9uG6s2UoEaNFy9nLEgkSDVxi6uYTkc1aUfu2nWg7Qez2rukUNEbqlN6MtEXp
         WdkhH92GewnhY1/iA+yNI9h0aHVWRuak6ZH+BszA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 44/91] KVM: PPC: Book3S HV: Uninit vCPU if vcore creation fails
Date:   Thu, 13 Feb 2020 07:20:01 -0800
Message-Id: <20200213151838.723680390@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
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
@@ -1669,7 +1669,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu
 	mutex_unlock(&kvm->lock);
 
 	if (!vcore)
-		goto free_vcpu;
+		goto uninit_vcpu;
 
 	spin_lock(&vcore->lock);
 	++vcore->num_threads;
@@ -1685,6 +1685,8 @@ static struct kvm_vcpu *kvmppc_core_vcpu
 
 	return vcpu;
 
+uninit_vcpu:
+	kvm_vcpu_uninit(vcpu);
 free_vcpu:
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 out:


