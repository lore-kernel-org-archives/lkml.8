Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC13C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C34C20774
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586899930;
	bh=f4F1vDQvVnqhKsm6bMVE8f0iBt1TzZeeo5A0mAu+gOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SJBUn98fmxB5MH2n+wNblXlzTyoI2NxU6/mvKQbb5QwiZz/ax5n9sz9UEWpSW7qzf
	 jHREUzSSoGE8eog1iIBCslfry5niG1yvdcc7yY1tr8v2qJoBfqJ6lu7qrPpm8X34QH
	 6PecfSycE8Zgxuim0ICbKv6H3LOiPAUEWsz4+2GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633883AbgDNVcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633846AbgDNVbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:31:34 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D400F20774;
        Tue, 14 Apr 2020 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586899893;
        bh=f4F1vDQvVnqhKsm6bMVE8f0iBt1TzZeeo5A0mAu+gOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxMAEfiCTb8BuAiFEv3D2P8dg3IqYBZvRlKxWBYHsGGKh3KzaV5FRKxBtmGQBBYQl
         OZH7WRKeK/DzX0NMzizGcs2GQF0bHX1I49tyhko8IKhrajDEUtT2l2j++oXQSkOObj
         TZGD8b276CmrUwsWHzdvYkTIU9UlfhLXsWqBD6zs=
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
Subject: [PATCH 4/8] arm64: cpufeature: Remove redundant call to id_aa64pfr0_32bit_el0()
Date:   Tue, 14 Apr 2020 22:31:10 +0100
Message-Id: <20200414213114.2378-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414213114.2378-1-will@kernel.org>
References: <20200414213114.2378-1-will@kernel.org>
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
2.26.0.110.g2183baf09c-goog

