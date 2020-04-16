Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87769C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5313B21D91
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051626;
	bh=bFWDlqP9USn3c5lqfAuj6t5+gOROS4BcTG8X8ED4KOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LEsN1QrBiSv/lNEfkKbhDSkub5hl9VNvhDhfTGGX0tSI6JHBabdkEz6Cf2cNcTI71
	 yVKDiMWkzuFpagIwEVL6ZlTnlXjvk/EU5vgap/eeJwlh3Fg5jL9lP5jwKheHu8dDkg
	 pgU0xVGFFKHcnVYMy+bPAQ+ZA56SOwcExIA1emZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbgDPPkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897538AbgDPNhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:37:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FA1C221F4;
        Thu, 16 Apr 2020 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044269;
        bh=bFWDlqP9USn3c5lqfAuj6t5+gOROS4BcTG8X8ED4KOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNLzNi46Usq1Lpo/GxVgCp1U9k2sAJSNRR+1XeeECZe7djOnr4Ywj5RFkpEHtnm9c
         pwqtNpKB12++AZmU9SI3TQf4SlqwEa5w/+FKzszgvlxm3SEUPz1ZLOgm0q1YUeqMGo
         6ovcdcss8EBvND7bIpMkCQqcocSLeWsJxHrMjTj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 148/257] KVM: x86: Gracefully handle __vmalloc() failure during VM allocation
Date:   Thu, 16 Apr 2020 15:23:19 +0200
Message-Id: <20200416131344.971663792@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit d18b2f43b9147c8005ae0844fb445d8cc6a87e31 upstream.

Check the result of __vmalloc() to avoid dereferencing a NULL pointer in
the event that allocation failres.

Fixes: d1e5b0e98ea27 ("kvm: Make VM ioctl do valloc for some archs")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c     |    4 ++++
 arch/x86/kvm/vmx/vmx.c |    4 ++++
 2 files changed, 8 insertions(+)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1930,6 +1930,10 @@ static struct kvm *svm_vm_alloc(void)
 	struct kvm_svm *kvm_svm = __vmalloc(sizeof(struct kvm_svm),
 					    GFP_KERNEL_ACCOUNT | __GFP_ZERO,
 					    PAGE_KERNEL);
+
+	if (!kvm_svm)
+		return NULL;
+
 	return &kvm_svm->kvm;
 }
 
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6633,6 +6633,10 @@ static struct kvm *vmx_vm_alloc(void)
 	struct kvm_vmx *kvm_vmx = __vmalloc(sizeof(struct kvm_vmx),
 					    GFP_KERNEL_ACCOUNT | __GFP_ZERO,
 					    PAGE_KERNEL);
+
+	if (!kvm_vmx)
+		return NULL;
+
 	return &kvm_vmx->kvm;
 }
 


