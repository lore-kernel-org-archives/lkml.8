Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A9C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1CE20724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479382;
	bh=0VMyTO1GtBI/38g1vV7Z63awjD33oratYrJ0mv7/JHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dQs7FKWsyQqgwzraVwGifo3wN2Xj5wRu6qYMvAp58RartR+HCWM54TYO60HKlnX2H
	 myd4QMmW/rcrksG5FlvRtLV0lMKUxYtzU98gD9BhWo4mk20oPce4Sg3MnGfNZ+AAK9
	 SkIpeHREdiZQ4JX4PMWPVdzEUa8NUYLyLTkWJ8xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgDUO3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbgDUO3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:29:37 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54A120736;
        Tue, 21 Apr 2020 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479377;
        bh=0VMyTO1GtBI/38g1vV7Z63awjD33oratYrJ0mv7/JHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPmHtT68r9bO/MoUPgMPdrodPMGxPuIjQqI0bWZNxLGgWUMqIqTD87PmrvM0xSUbe
         EvoQFdV6EvaYnsb2Ix1szUwqLrpez4Lz1Vtp2MywwqdIxoz0NoNYqqbKPjJSZVrezS
         DC5wt8EQepA2p3XGGcm+4sR9S9vJ+bteuxUto23Y=
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
Subject: [PATCH v2 4/8] arm64: cpufeature: Remove redundant call to id_aa64pfr0_32bit_el0()
Date:   Tue, 21 Apr 2020 15:29:18 +0100
Message-Id: <20200421142922.18950-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421142922.18950-1-will@kernel.org>
References: <20200421142922.18950-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to call id_aa64pfr0_32bit_el0() twice because the
sanitised value of ID_AA64PFR0_EL1 has already been updated for the CPU
being onlined.

Remove the redundant function call.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 838fe5cc8d7e..7dfcdd9e75c1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -792,9 +792,7 @@ void update_cpu_features(int cpu,
 	 * If we have AArch32, we care about 32-bit features for compat.
 	 * If the system doesn't support AArch32, don't update them.
 	 */
-	if (id_aa64pfr0_32bit_el0(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1)) &&
-		id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
-
+	if (id_aa64pfr0_32bit_el0(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1))) {
 		taint |= check_update_ftr_reg(SYS_ID_DFR0_EL1, cpu,
 					info->reg_id_dfr0, boot->reg_id_dfr0);
 		taint |= check_update_ftr_reg(SYS_ID_ISAR0_EL1, cpu,
-- 
2.26.1.301.g55bc3eb7cb9-goog

