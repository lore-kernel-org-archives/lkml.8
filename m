Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A00FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2C220754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCTK0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:26:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726631AbgCTK0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:26:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02KA5DJo032022
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 06:26:51 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yua2d86d3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 06:26:51 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Fri, 20 Mar 2020 10:26:50 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Mar 2020 10:26:47 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02KAQkkI49938592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 10:26:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45FB5A405C;
        Fri, 20 Mar 2020 10:26:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2C27A405B;
        Fri, 20 Mar 2020 10:26:45 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.145.123.35])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Mar 2020 10:26:45 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/2] KVM: PPC: Book3S HV: check caller of H_SVM_* Hcalls
Date:   Fri, 20 Mar 2020 11:26:42 +0100
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320102643.15516-1-ldufour@linux.ibm.com>
References: <20200320102643.15516-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032010-4275-0000-0000-000003AFA875
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032010-4276-0000-0000-000038C4D94F
Message-Id: <20200320102643.15516-2-ldufour@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_02:2020-03-20,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hcall named H_SVM_* are reserved to the Ultravisor. However, nothing
prevent a malicious VM or SVM to call them. This could lead to weird result
and should be filtered out.

Checking the Secure bit of the calling MSR ensure that the call is coming
from either the Ultravisor or a SVM. But any system call made from a SVM
are going through the Ultravisor, and the Ultravisor should filter out
these malicious call. This way, only the Ultravisor is able to make such a
Hcall.

Cc: Bharata B Rao <bharata@linux.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 33be4d93248a..43773182a737 100644
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
2.25.2

