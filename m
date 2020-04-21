Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D174DC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22AA2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479373;
	bh=3QLFaZ5qSAFsBP92QV4FHVzLISeEK5bbp2aMWKefeKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPkpIEBfmIe2UmpMlmYWe0La2S99K5END1FRSheWAP5tRb2/YBwrSNgibe4UD1KIR
	 ZKPzrtxCFpXSarUDQKoylq4Rp96gFdhGD09XFBnlAsQbzhM8ClMXbVe3+N2TfG2Ma6
	 VLyEsWkcEGicweLpXXi8i/KIW2CHYZweVd1/b2fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgDUO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUO3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:29:31 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD2E206D6;
        Tue, 21 Apr 2020 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479370;
        bh=3QLFaZ5qSAFsBP92QV4FHVzLISeEK5bbp2aMWKefeKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Y3X6NdtTU6Yl9Ad4mqgs39TVDIM/uZ1YdSG87SAw5uZgXPvOqkIBR0jcByJk3kIX
         WayoS5fmJYRiPHDhAvjuJ1herEpwsYKTD2VTfR4lUCc+9IO9aOJShlO7/d7/Iz1DiP
         33jeF6dIrmSdizpzOggPJO4g6mZzxQ6zwB3RRI0E=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com
Subject: [PATCH v2 1/8] arm64: cpufeature: Relax check for IESB support
Date:   Tue, 21 Apr 2020 15:29:15 +0100
Message-Id: <20200421142922.18950-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421142922.18950-1-will@kernel.org>
References: <20200421142922.18950-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

We don't care if IESB is supported or not as we always set
SCTLR_ELx.IESB and, if it works, that's really great.

Relax the ID_AA64MMFR2.IESB cpufeature check so that we don't warn and
taint if it's mismatched.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
[will: rewrote commit message]
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9fac745aa7bb..63df28e6a425 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -247,7 +247,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_FWB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_AT_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LSM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_UAO_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_CNP_SHIFT, 4, 0),
-- 
2.26.1.301.g55bc3eb7cb9-goog

