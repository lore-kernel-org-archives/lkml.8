Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72718C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C45A24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707583;
	bh=n1O3Eitg6t5fEPekRoEAc1yd6VaL3yvTOGirClRwDvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EOPzVQr1eOdwUpZISio0tW2y5vUwcT1lcEa/XfYYJ1Jfi+y18IL3AehqMMfx14STn
	 1SeLuLoe/vFCiR5+IVSptSpptVtnHnVZVCUQf+XGQP12NcmAeoZUn9p1lwikzR8MEL
	 21PLQQnTsXQum2ucd1E82DXhqPz65ju8MPFKbQ9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbgBNTNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388381AbgBNTM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:59 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A431724654;
        Fri, 14 Feb 2020 19:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707579;
        bh=n1O3Eitg6t5fEPekRoEAc1yd6VaL3yvTOGirClRwDvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUnCO6fvPunnVtTae518A0G9CXOLvgRLoU2qyrUqvQTuVXoWv5+lc7HNSUzG+h5a4
         NHRKa7iMw2wq7cunue30xZW/ubab5GNATUKoLLvoT7vehWqrfBKbihlmn5A9mUFC56
         faC/y4oXgbcn7yG8RDSN+JpkWDYz5UdbA9dX+FNg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 22/23] tools headers kvm: Sync linux/kvm.h with the kernel sources
Date:   Fri, 14 Feb 2020 16:10:56 -0300
Message-Id: <20200214191057.26266-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  7de3f1423ff9 ("KVM: s390: Add new reset vcpu API")

So far we're ignoring those arch specific ioctls, we need to revisit
this at some time to have arch specific tables, etc:

  $ grep S390 tools/perf/trace/beauty/kvm_ioctl.sh
  	egrep -v " ((ARM|PPC|S390)_|[GS]ET_(DEBUGREGS|PIT2|XSAVE|TSC_KHZ)|CREATE_SPAPR_TCE_64)" | \
  $

This addresses these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/arm/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm/include/uapi/asm/kvm.h arch/arm/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index f0a16b4adbbd..4b95f9a31a2f 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1009,6 +1009,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
+#define KVM_CAP_S390_VCPU_RESETS 179
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1473,6 +1474,10 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
 
+/* Available with  KVM_CAP_S390_VCPU_RESETS */
+#define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
+#define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.21.1

