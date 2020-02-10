Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F51BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCF820708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339755;
	bh=UAEqW0YFarAHJboLLeth1SnmcmHoqxKMJ03r4H2ztfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NUpBiYeGS8n6skIfzlVaqGid9ldyGjcDLNmKfa/Q5q5VtWi6hSXGFhYW6kQr2RDF4
	 MpIru5hi6Vsj0w8aK8d95FmjrFL2bxk4k/hERrUSJ+jZOS+fjPv5V3eCkSPNRqSZPr
	 niMWIWttb3ohVium2J/CZfqfChR4x7+Q+1I27yXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgBJMkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgBJMiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:21 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BCFA2467D;
        Mon, 10 Feb 2020 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338301;
        bh=UAEqW0YFarAHJboLLeth1SnmcmHoqxKMJ03r4H2ztfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsaR4kHeveDRXFPN9W1Ydf5DYKmlRbnwj40VIj3NWwjwgo0lgSIo+/VSV7HiSOCel
         256jO2zxZNipppAXkZH+kXWwjeBr7gdjuMm5gpczK9eZwH3qjVsYUKKyLhvWGpGZcP
         GrJXIirDjMtY+fYF3uURzvxXO9JC7R0y48P7bWCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.4 212/309] KVM: PPC: Book3S PR: Free shared page if mmu initialization fails
Date:   Mon, 10 Feb 2020 04:32:48 -0800
Message-Id: <20200210122426.906613197@linuxfoundation.org>
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

commit cb10bf9194f4d2c5d830eddca861f7ca0fecdbb4 upstream.

Explicitly free the shared page if kvmppc_mmu_init() fails during
kvmppc_core_vcpu_create(), as the page is freed only in
kvmppc_core_vcpu_free(), which is not reached via kvm_vcpu_uninit().

Fixes: 96bc451a15329 ("KVM: PPC: Introduce shared page")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_pr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1769,10 +1769,12 @@ static struct kvm_vcpu *kvmppc_core_vcpu
 
 	err = kvmppc_mmu_init(vcpu);
 	if (err < 0)
-		goto uninit_vcpu;
+		goto free_shared_page;
 
 	return vcpu;
 
+free_shared_page:
+	free_page((unsigned long)vcpu->arch.shared);
 uninit_vcpu:
 	kvm_vcpu_uninit(vcpu);
 free_shadow_vcpu:


