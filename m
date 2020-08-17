Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59735C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204D320658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597680371;
	bh=4atO9yVMgJ17YnbD6VFtB6McPjIh2o7LSlKJaMp2yVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D9kvYizz+PzF8NCHPIEFhCHoLD38Ni7mhIdKObLZflJ4mB6OmuAiQq0uDIwRzJW34
	 wNtB4T+9Wg4nn79txkPUgF0IrcEtATXRpPo1JBVxRg8lUffzwdmd7fcj+dFOAYaGKC
	 f9aujbMcxj8ALyE3bTCeL7I5M8rkVJQlfoZRM9tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbgHQQF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730295AbgHQPpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:45:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E0922D00;
        Mon, 17 Aug 2020 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679101;
        bh=4atO9yVMgJ17YnbD6VFtB6McPjIh2o7LSlKJaMp2yVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpuHiD4cmOarA+qjcDZsEiulw7cetCmKpdh+dFp1skvjTGi3iDlk+gI2OFGrRi4Xz
         vunvRxY26HRTYKaFa1g0/OCoMYy5FPMbdyNl2j7JuWXhtMZjWwaCaGUHhliKcxAYFM
         BZSoVI+eDKHBe7g++6GtFLJJf9OmfF+jr/okQsQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 097/393] drm/amd/powerplay: fix compile error with ARCH=arc
Date:   Mon, 17 Aug 2020 17:12:27 +0200
Message-Id: <20200817143824.322383357@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 9822ba2ead1baa3de4860ad9472f652c4cc78c9c ]

Fix the compile error below:
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c: In function 'smu_v11_0_init_microcode':
>> arch/arc/include/asm/bug.h:22:2: error: implicit declaration of function 'pr_warn'; did you mean 'pci_warn'? [-Werror=implicit-function-declaration]
      22 |  pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
         |  ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:176:3: note: in expansion of macro 'BUG'
     176 |   BUG();

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 655ba4fb05dcd..48af305d42d54 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -159,7 +159,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 		chip_name = "navi12";
 		break;
 	default:
-		BUG();
+		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
+		return -EINVAL;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_smc.bin", chip_name);
-- 
2.25.1



