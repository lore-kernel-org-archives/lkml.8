Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA2EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7AA20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462559;
	bh=z9HC8fjtE91zDOgMhT+LLjIAS45FRJcu+53+IAN2WII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FYELq62IwC7nRbff6ZaSgpO2DPkEAn6ibzhtML3e1TbrBOwsoO3N5xT3hdb//LNSS
	 f2zhOv7TREHHe3G08zn65pjTh58adYVP4LivV0yancudI9a/U7vUuWPdN659Zp7+a6
	 R1ZrNgROXva4NL4stO+ItWBViCQCJ+TsvEAK5wj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbgF2U3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732440AbgF2TZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E802533C;
        Mon, 29 Jun 2020 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445179;
        bh=z9HC8fjtE91zDOgMhT+LLjIAS45FRJcu+53+IAN2WII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=he6xZo3N+1K3Z19hlNiaL1laJQNFGyPDDXTiFB9Oc/w2SWk0W5cHd41xQxlnwVlAn
         /JNq9Jyo1QboEK/o8i1jXdMM8LWhmWS2f4FdQvbLCudWv5SmcNPkaJ4mOd1Ci4BVRU
         etoXUie5poofX/9RFT2x9PCpE5eP5R/RYBDyZV5c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 70/78] drm/radeon: fix fb_div check in ni_init_smc_spll_table()
Date:   Mon, 29 Jun 2020 11:37:58 -0400
Message-Id: <20200629153806.2494953-71-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153806.2494953-1-sashal@kernel.org>
References: <20200629153806.2494953-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.186-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.186-rc1
X-KernelTest-Deadline: 2020-07-01T15:38+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

commit 35f760b44b1b9cb16a306bdcc7220fbbf78c4789 upstream.

clk_s is checked twice in a row in ni_init_smc_spll_table().
fb_div should be checked instead.

Fixes: 69e0b57a91ad ("drm/radeon/kms: add dpm support for cayman (v5)")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/ni_dpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index 9416e72f86aaf..d491b3aa124f3 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -2126,7 +2126,7 @@ static int ni_init_smc_spll_table(struct radeon_device *rdev)
 		if (clk_s & ~(SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_SHIFT))
 			ret = -EINVAL;
 
-		if (clk_s & ~(SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_SHIFT))
+		if (fb_div & ~(SMC_NISLANDS_SPLL_DIV_TABLE_FBDIV_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_FBDIV_SHIFT))
 			ret = -EINVAL;
 
 		if (clk_v & ~(SMC_NISLANDS_SPLL_DIV_TABLE_CLKV_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_CLKV_SHIFT))
-- 
2.25.1

