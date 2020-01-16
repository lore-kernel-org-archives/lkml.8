Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9887DC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694CC206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201341;
	bh=CQDizk1U+ffUTXTTxGwiQ2zeRMUYVg5Zx3vc70w1Lho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B8LxhB7u20m7y+k8mEjT0EBAi12aS0m+LdQz1UR89/4BaUnjlLO9ZhgqMW2FyfC7Z
	 0hiVW1ALQ9kqKeDgpPGaRp0sm6nbaQF67ZLo7L+jB0UPy4Jp5ea/YAdgE3mu0xbjmv
	 HcHWLISlLQ4r75unVWQY+m5B7eyFOkqIn8N8Xy2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437314AbgAPTCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388777AbgAPRFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:05:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9739F20730;
        Thu, 16 Jan 2020 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194339;
        bh=CQDizk1U+ffUTXTTxGwiQ2zeRMUYVg5Zx3vc70w1Lho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zL2+wOr13bF4UK83Hcm6buSj1c9T2b6L8Fo8ROt2y6xgwlVDtwghSWOfHJXPaPkpR
         Wnpx3/Y6tgEHJAZsXTkI9L6YGfbevbZMfdwAh9E4y/HhG3dV3AE+GPLaA225uppWjJ
         h+8MeVTUNroync9/qB56Qq0/iEwVaOQSmvcdYva8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 283/671] of: use correct function prototype for of_overlay_fdt_apply()
Date:   Thu, 16 Jan 2020 11:58:41 -0500
Message-Id: <20200116170509.12787-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

[ Upstream commit ecb0abc1d8528015957fbd034be8bfe760363b3b ]

When CONFIG_OF_OVERLAY is not enabled the fallback stub for
of_overlay_fdt_apply() does not match the prototype for the case when
CONFIG_OF_OVERLAY is enabled. Update the stub to use the correct
function prototype.

Fixes: 39a751a4cb7e ("of: change overlay apply input data from unflattened to FDT")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/of.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index dac0201eacef..d4f14b0302b6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1425,7 +1425,8 @@ int of_overlay_notifier_unregister(struct notifier_block *nb);
 
 #else
 
-static inline int of_overlay_fdt_apply(void *overlay_fdt, int *ovcs_id)
+static inline int of_overlay_fdt_apply(void *overlay_fdt, u32 overlay_fdt_size,
+				       int *ovcs_id)
 {
 	return -ENOTSUPP;
 }
-- 
2.20.1

