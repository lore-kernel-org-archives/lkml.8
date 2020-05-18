Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D5E207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589803749;
	bh=K8ytwBeEv/7qjVAmjbqoMgPkQXND2o+mOarQpQrSrLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AQkWRF8Twj8wuEkNgyp5Ya7cgJaMOI+C075REbjLJgmRvFJ4H9MDuwNUFparAGRxR
	 WhfFTam6XrnJMRgHRmIMpdF9AaGZ85JgjQy1GzkzJstFCSFiCoczI+7R+CIO123UoK
	 tKQ9VoCNyLf5OsGtIge38vPt8mVtLS68sqARnQeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgERMJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgERMJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:09:06 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 082F8207ED;
        Mon, 18 May 2020 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589803746;
        bh=K8ytwBeEv/7qjVAmjbqoMgPkQXND2o+mOarQpQrSrLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2aNRl6MPtFPULRQ9I8cg0etlWiCzM1wg/PS0cUSN8/YuicAz67EpeRX5g/6D6DMq
         2pVJinHxlWVBIFmLpb6xuPNRBhUifZMn/wC2khRUJukYigeonJ2Ka8/MP0l/BzQPsj
         EVccCaz7+LmDpqExkbqRvRj/lR50PRZ1u5o5S2tw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] x86: Hide the archdata.iommu field behind generic IOMMU_API
Date:   Mon, 18 May 2020 14:08:55 +0200
Message-Id: <20200518120855.27822-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518120855.27822-1-krzk@kernel.org>
References: <20200518120855.27822-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a generic, kernel wide configuration symbol for enabling the
IOMMU specific bits: CONFIG_IOMMU_API.  Implementations (including
INTEL_IOMMU and AMD_IOMMU driver) select it so use it here as well.

This makes the conditional archdata.iommu field consistent with other
platforms and also fixes any compile test builds of other IOMMU drivers,
when INTEL_IOMMU or AMD_IOMMU are not selected).

For the case when INTEL_IOMMU/AMD_IOMMU and COMPILE_TEST are not
selected, this should create functionally equivalent code/choice.  With
COMPILE_TEST this field could appear if other IOMMU drivers are chosen
but neither INTEL_IOMMU nor AMD_IOMMU are not.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/x86/include/asm/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index 7e31f7f1bb06..49bd6cf3eec9 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_DEVICE_H
 
 struct dev_archdata {
-#if defined(CONFIG_INTEL_IOMMU) || defined(CONFIG_AMD_IOMMU)
+#ifdef CONFIG_IOMMU_API
 	void *iommu; /* hook for IOMMU specific extension */
 #endif
 };
-- 
2.17.1

