Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CCCC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECCA206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648665;
	bh=thnLnMquqfXBw2CaUvUTvh3sLjdeFfrsERODMyLxxqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VcRkuHpa26FuztbS4b+NumvGcCrTwp5dRhnKyhhjKG6q9wShX+ifoxk9xLNmbMIxf
	 6UO/RUKlfR8+2lRW2AYLGWSxbpZimZofnOfNkM8974xtSB7GfmhOuWcgPVr8Y3/bFJ
	 Hg4NKM9qMFjtBZXnjd16naWjWHcpWVsoBMNK6gXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgDKXoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgDKXGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:06:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70FA721D6C;
        Sat, 11 Apr 2020 23:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646363;
        bh=thnLnMquqfXBw2CaUvUTvh3sLjdeFfrsERODMyLxxqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JWTgCAWYiXxzzBqVgtctHNraL87WpEBSMm0WcC6ZOCTSrnVhx4kqaGPl/KidNl7t
         cEdSbn1NQIHUB22NuAuqWLkcUHC4srJuyDzW3G7b9Tr4iAUc7zuA2bOZn71ofefU3K
         lD3G3cYbyYkpvpqjC/TqxzcVSUcIVSWJRd/TLVQQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibnm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.6 108/149] KVM: PPC: Book3S HV: Check caller of H_SVM_* Hcalls
Date:   Sat, 11 Apr 2020 19:03:05 -0400
Message-Id: <20200411230347.22371-108-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Dufour <ldufour@linux.ibm.com>

[ Upstream commit 8c47b6ff29e3d88484fe59d02f9db6de7e44e310 ]

The Hcall named H_SVM_* are reserved to the Ultravisor. However, nothing
prevent a malicious VM or SVM to call them. This could lead to weird result
and should be filtered out.

Checking the Secure bit of the calling MSR ensure that the call is coming
from either the Ultravisor or a SVM. But any system call made from a SVM
are going through the Ultravisor, and the Ultravisor should filter out
these malicious call. This way, only the Ultravisor is able to make such a
Hcall.

Cc: Bharata B Rao <bharata@linux.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibnm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2cefd071b8483..698701b4a10dc 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1074,25 +1074,35 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 					 kvmppc_get_gpr(vcpu, 6));
 		break;
 	case H_SVM_PAGE_IN:
-		ret = kvmppc_h_svm_page_in(vcpu->kvm,
-					   kvmppc_get_gpr(vcpu, 4),
-					   kvmppc_get_gpr(vcpu, 5),
-					   kvmppc_get_gpr(vcpu, 6));
+		ret = H_UNSUPPORTED;
+		if (kvmppc_get_srr1(vcpu) & MSR_S)
+			ret = kvmppc_h_svm_page_in(vcpu->kvm,
+						   kvmppc_get_gpr(vcpu, 4),
+						   kvmppc_get_gpr(vcpu, 5),
+						   kvmppc_get_gpr(vcpu, 6));
 		break;
 	case H_SVM_PAGE_OUT:
-		ret = kvmppc_h_svm_page_out(vcpu->kvm,
-					    kvmppc_get_gpr(vcpu, 4),
-					    kvmppc_get_gpr(vcpu, 5),
-					    kvmppc_get_gpr(vcpu, 6));
+		ret = H_UNSUPPORTED;
+		if (kvmppc_get_srr1(vcpu) & MSR_S)
+			ret = kvmppc_h_svm_page_out(vcpu->kvm,
+						    kvmppc_get_gpr(vcpu, 4),
+						    kvmppc_get_gpr(vcpu, 5),
+						    kvmppc_get_gpr(vcpu, 6));
 		break;
 	case H_SVM_INIT_START:
-		ret = kvmppc_h_svm_init_start(vcpu->kvm);
+		ret = H_UNSUPPORTED;
+		if (kvmppc_get_srr1(vcpu) & MSR_S)
+			ret = kvmppc_h_svm_init_start(vcpu->kvm);
 		break;
 	case H_SVM_INIT_DONE:
-		ret = kvmppc_h_svm_init_done(vcpu->kvm);
+		ret = H_UNSUPPORTED;
+		if (kvmppc_get_srr1(vcpu) & MSR_S)
+			ret = kvmppc_h_svm_init_done(vcpu->kvm);
 		break;
 	case H_SVM_INIT_ABORT:
-		ret = kvmppc_h_svm_init_abort(vcpu->kvm);
+		ret = H_UNSUPPORTED;
+		if (kvmppc_get_srr1(vcpu) & MSR_S)
+			ret = kvmppc_h_svm_init_abort(vcpu->kvm);
 		break;
 
 	default:
-- 
2.20.1

