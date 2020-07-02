Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BD9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745D9208B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7EznTBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgGBPYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:24:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41742 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGBPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:23:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062FLdgf070255;
        Thu, 2 Jul 2020 15:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=iZ+fNCbfVkOoz0SFqtiZFdtiQbuuAfs0i65p1wvkl0g=;
 b=a7EznTBcRBcKFU6mj+FwXQYfcB0mNpCxxJLIRLl2DXFJHUyerJQAMkqp907IgBd+TihB
 4l9EDbsycFDSbAktExc6C1X2KUlwniCK+zKVhjJWqZgdhLMVoWoQqdUFz2wtgRBHPWp4
 bQRH7GSAUIy3aSNO0DnLZZva9O6ZHM5McyOTbohK1NJyGvE1290YfVQ9yzvVYoYCIj6Q
 9q8gk78oV4fgiJ7Qo2Z43K/xqDKtF8hUHRFrOUJ7x7WvNqz5bhVCqm3daoAcEaa6BVx4
 Lme1rcBvEG2vANzYj2I6Y5wALV++qp/EHVka/tjYYB42eAwqFitmn0ZfIUpZCvX367fQ hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31ywrbyama-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:23:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062Evr3V162753;
        Thu, 2 Jul 2020 15:21:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31xg2144eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:21:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 062FLiGq021044;
        Thu, 2 Jul 2020 15:21:44 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:20:53 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH RFC 3/7] x86: kernel: cpu: bugs.c: modify static_cpu_has to boot_cpu_has
Date:   Thu,  2 Jul 2020 18:18:23 +0300
Message-Id: <1593703107-8852-4-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=882 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=887
 clxscore=1015 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=1 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of static_cpu_has in bugs.c file is counter-productive
since the code is executed once but there is extra effort to patch
it and keep alternatives in a special section --- so there is both
space and time cost.

Quote from _static_cpu_has definition:
/*
 * Static testing of CPU features. Used the same as boot_cpu_has(). It
 * statically patches the target code for additional performance. Use
 * static_cpu_has() only in fast paths, where every cycle counts. Which
 * means that the boot_cpu_has() variant is already fast enough for the
 * majority of cases and you should stick to using it as it is generally
 * only two instructions: a RIP-relative MOV and a TEST.
 */

There are two other places where static_cpu_has is used and might be
considered critical paths: __speculation_ctrl_update() and vmx_l1d_flush().

Given these facts, changing static_cpu_has to boot_cpu_has is done in
order to bypass alternative instructions which cannot be updated at runtime
for now.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/kernel/cpu/bugs.c | 18 +++++++++---------
 arch/x86/kernel/process.c  |  8 ++++----
 arch/x86/kvm/vmx/vmx.c     |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1760598..21b9df3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -168,8 +168,8 @@ void __ref check_bugs(void)
 		guestval |= guest_spec_ctrl & x86_spec_ctrl_mask;
 
 		/* SSBD controlled in MSR_SPEC_CTRL */
-		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
-		    static_cpu_has(X86_FEATURE_AMD_SSBD))
+		if (boot_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+		    boot_cpu_has(X86_FEATURE_AMD_SSBD))
 			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
 		/* Conditional STIBP enabled? */
@@ -186,8 +186,8 @@ void __ref check_bugs(void)
 	 * If SSBD is not handled in MSR_SPEC_CTRL on AMD, update
 	 * MSR_AMD64_L2_CFG or MSR_VIRT_SPEC_CTRL if supported.
 	 */
-	if (!static_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
-	    !static_cpu_has(X86_FEATURE_VIRT_SSBD))
+	if (!boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
+	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD))
 		return;
 
 	/*
@@ -195,7 +195,7 @@ void __ref check_bugs(void)
 	 * virtual MSR value. If its not permanently enabled, evaluate
 	 * current's TIF_SSBD thread flag.
 	 */
-	if (static_cpu_has(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE))
+	if (boot_cpu_has(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE))
 		hostval = SPEC_CTRL_SSBD;
 	else
 		hostval = ssbd_tif_to_spec_ctrl(ti->flags);
@@ -1164,8 +1164,8 @@ static enum ssb_mitigation __ssb_select_mitigation(void)
 	 * bit in the mask to allow guests to use the mitigation even in the
 	 * case where the host does not enable it.
 	 */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
-	    static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+	if (boot_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+	    boot_cpu_has(X86_FEATURE_AMD_SSBD)) {
 		x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 	}
 
@@ -1181,8 +1181,8 @@ static enum ssb_mitigation __ssb_select_mitigation(void)
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
 		 * use a completely different MSR and bit dependent on family.
 		 */
-		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) &&
-		    !static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+		if (!boot_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) &&
+		    !boot_cpu_has(X86_FEATURE_AMD_SSBD)) {
 			x86_amd_ssb_disable();
 		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f362ce0..6362e0c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -546,14 +546,14 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 	lockdep_assert_irqs_disabled();
 
 	/* Handle change of TIF_SSBD depending on the mitigation method. */
-	if (static_cpu_has(X86_FEATURE_VIRT_SSBD)) {
+	if (boot_cpu_has(X86_FEATURE_VIRT_SSBD)) {
 		if (tif_diff & _TIF_SSBD)
 			amd_set_ssb_virt_state(tifn);
-	} else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
+	} else if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
 		if (tif_diff & _TIF_SSBD)
 			amd_set_core_ssb_state(tifn);
-	} else if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
-		   static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+	} else if (boot_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+		   boot_cpu_has(X86_FEATURE_AMD_SSBD)) {
 		updmsr |= !!(tif_diff & _TIF_SSBD);
 		msr |= ssbd_tif_to_spec_ctrl(tifn);
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cb22f33..f08ef38 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6145,7 +6145,7 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.l1d_flush++;
 
-	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+	if (boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {
 		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
 		return;
 	}
-- 
1.8.3.1

