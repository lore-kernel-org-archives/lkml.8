Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB45EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF3320724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918313;
	bh=BPHpRnDBHcpo4fGDGjZSj6AvNa65WkpazKMaiZ9L4Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sxy0KutszsPo1v5OVQCb/nBBCUTvl5la9VYOArE/rf0dSs0CtCbzSBVINIkW0M++d
	 UQ6Y2WuTXPRRDqws+Hd5SoovTuotVS95I7WVReCgqCtHRrH7HFtM9GXMcktPszGik8
	 alW7luCjGC0MTDsfmSdWN6Gq6UZZFY+k33UUsL0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHTKLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbgHTKLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:11:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D26A206DA;
        Thu, 20 Aug 2020 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918306;
        bh=BPHpRnDBHcpo4fGDGjZSj6AvNa65WkpazKMaiZ9L4Xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ti2e9JKgsYurnlrqaGEQ7vJ9kcCIKUhWI7yMGAphL0jq9oFpco3hEWudzUNIw8DHX
         DQBm1JWR5JdYHbr42/zX7B/xaqScNTWRS04guy/Bd/yClLMCOKRwDXqPXT5bVP03dn
         VYmEXmRPrku7/LhGeDgwWcPW/3cLN+7BRV5g3CY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 093/228] drm/radeon: fix array out-of-bounds read and write issues
Date:   Thu, 20 Aug 2020 11:21:08 +0200
Message-Id: <20200820091612.269460920@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 7ee78aff9de13d5dccba133f4a0de5367194b243 ]

There is an off-by-one bounds check on the index into arrays
table->mc_reg_address and table->mc_reg_table_entry[k].mc_data[j] that
can lead to reads and writes outside of arrays. Fix the bound checking
off-by-one error.

Addresses-Coverity: ("Out-of-bounds read/write")
Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 6e607cc7b6e5a..81bc2b89222f2 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -4342,7 +4342,7 @@ static int ci_set_mc_special_registers(struct radeon_device *rdev,
 					table->mc_reg_table_entry[k].mc_data[j] |= 0x100;
 			}
 			j++;
-			if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
+			if (j >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
 				return -EINVAL;
 
 			if (!pi->mem_gddr5) {
-- 
2.25.1



