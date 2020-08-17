Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D85C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF1120716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686264;
	bh=N4jKmjfTnZqJhoW5sJMd7w6Us2m6RacpLwrSvhzrIqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qWqkvE+9f38TbJPCKHUjWcuXB03tci5a0g/YmaD6u/I9jwMkizTqLX5Xm1sND0Ix4
	 qZtnR6dItzc6Z8w7AlqZD2zG1z7Yes/elWp06HcM4L06/ebeJ8g2KLkHnSQDtrajMb
	 +Vl/BfDAvwyiiLD4rkHK1TzzlRkegSPkhXxGBVn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbgHQRoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731041AbgHQQO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:14:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE0C20760;
        Mon, 17 Aug 2020 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680892;
        bh=N4jKmjfTnZqJhoW5sJMd7w6Us2m6RacpLwrSvhzrIqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2u06upTj++0RlPVTc2Hxyl3Nn2BcUBLY8VyBlv/F3E3g9uPHvu5/WaEvtsRbdJIMC
         ClJ/E/Yi4fIt/crfSNbhT203cuutgBSgTpls95ISTnENfAAOW99sdOctpczFkw+kCM
         jPgPbhCh7ml71SuTJlkm4AUh9a7sd1jE7FoSIPOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/168] drm/radeon: fix array out-of-bounds read and write issues
Date:   Mon, 17 Aug 2020 17:16:40 +0200
Message-Id: <20200817143737.171022617@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
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
index 9e7d5e44a12fa..90c1afe498bea 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -4364,7 +4364,7 @@ static int ci_set_mc_special_registers(struct radeon_device *rdev,
 					table->mc_reg_table_entry[k].mc_data[j] |= 0x100;
 			}
 			j++;
-			if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
+			if (j >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
 				return -EINVAL;
 
 			if (!pi->mem_gddr5) {
-- 
2.25.1



