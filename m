Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBEC20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947935;
	bh=4No8kJj82MoxCjfbp7pfjrtBJ3527AwcbSZTRVcL31s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wg30M95UjyTL4E0akkNpG8+7Ky1gL2tULKvGsMUxSmWYVibg8qul6ACfsGSdDalRh
	 4IA9GFZ623oRnRbHZ4+i3kyuMTefO4jgOCzycFJdy6q60vp+MzyaEOId3B8IVlrh3M
	 jt/t5xl3IkB3f8kGaMUAXYkJKuTFL8Kizxf0D+0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393303AbgFWVcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388557AbgFWUMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:12:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975D420EDD;
        Tue, 23 Jun 2020 20:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943162;
        bh=4No8kJj82MoxCjfbp7pfjrtBJ3527AwcbSZTRVcL31s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v05v46xo+evEGYTp2aXcHTimM+nGlYQnUM+lvitije6ztri0/M96E5Z44dLQq2xpl
         9TtbwrHoGI7O+JDxdTFOC7KztP0VrxOJem7XYv4Q6a0MIUCnHLc8WWnGa03TRfcVoF
         bHsXkjgy3WTUoqvEMOABXvPvV8Mnolivs8OZoiJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Dufour <ldufour@linux.ibm.com>,
        Greg Kurz <groug@kaod.org>, Ram Pai <linuxram@us.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 284/477] KVM: PPC: Book3S HV: Relax check on H_SVM_INIT_ABORT
Date:   Tue, 23 Jun 2020 21:54:41 +0200
Message-Id: <20200623195420.996711569@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Dufour <ldufour@linux.ibm.com>

[ Upstream commit e3326ae3d59e443a379367c6936941d6ab55d316 ]

The commit 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_*
Hcalls") added checks of secure bit of SRR1 to filter out the Hcall
reserved to the Ultravisor.

However, the Hcall H_SVM_INIT_ABORT is made by the Ultravisor passing the
context of the VM calling UV_ESM. This allows the Hypervisor to return to
the guest without going through the Ultravisor. Thus the Secure bit of SRR1
is not set in that particular case.

In the case a regular VM is calling H_SVM_INIT_ABORT, this hcall will be
filtered out in kvmppc_h_svm_init_abort() because kvm->arch.secure_guest is
not set in that case.

Fixes: 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_* Hcalls")
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 93493f0cbfe8e..ee581cde48788 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1099,9 +1099,14 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 			ret = kvmppc_h_svm_init_done(vcpu->kvm);
 		break;
 	case H_SVM_INIT_ABORT:
-		ret = H_UNSUPPORTED;
-		if (kvmppc_get_srr1(vcpu) & MSR_S)
-			ret = kvmppc_h_svm_init_abort(vcpu->kvm);
+		/*
+		 * Even if that call is made by the Ultravisor, the SSR1 value
+		 * is the guest context one, with the secure bit clear as it has
+		 * not yet been secured. So we can't check it here.
+		 * Instead the kvm->arch.secure_guest flag is checked inside
+		 * kvmppc_h_svm_init_abort().
+		 */
+		ret = kvmppc_h_svm_init_abort(vcpu->kvm);
 		break;
 
 	default:
-- 
2.25.1



