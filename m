Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DFBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD9322B47
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087900;
	bh=D3e2sCJnG9+J5kUil6HoKlVF6yIWV36S5MEhl2IJmDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LzlvZnOa6M7GQh5DJdlcbrQjB8D8I78lU0Zve/8hftscBUptDnJWA6b6XiCmNChqN
	 9rxCOF6CVC+ml270DYkTnI1fgVm0a2TmOjEeVThiAcY7XOE9uOueUhtPidBUT5nrRs
	 chiRh+AJncATny5k64oWhIF35pSIgl3fu8Q0Vro0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgHJTKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbgHJTJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:09:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6094221E2;
        Mon, 10 Aug 2020 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086592;
        bh=D3e2sCJnG9+J5kUil6HoKlVF6yIWV36S5MEhl2IJmDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewiMCR0tjKgmc4isYmGv3N/dowGjUcVcyuPYXylQHMwijXcmrDRlrNZUYECbXeqY2
         Ig3Sx2qmNJZnAOXeJMfStIr9e5gTooDRrnL6xrYzuIPK0md85Nsgqtf1oNhneCJEKn
         NpbwdBR6OmxDoPsF2fF+pZmaOMQ69JvSj0gt42/w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Quan <evan.quan@amd.com>, kernel test robot <lkp@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.8 39/64] drm/amd/powerplay: fix compile error with ARCH=arc
Date:   Mon, 10 Aug 2020 15:08:34 -0400
Message-Id: <20200810190859.3793319-39-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810190859.3793319-1-sashal@kernel.org>
References: <20200810190859.3793319-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index aa76c2cea7471..7897be877b961 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -164,7 +164,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
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

