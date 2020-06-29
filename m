Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B63C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F363E206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459656;
	bh=3oKAkGkifbDgX3Z5v+1FPNUaEczT6noSTkhiC9qvSdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T7TwXnfhCTk/ix3GJ793oJS5+9eni8KQeDoOg096q858Hp5QgprfJMlEZuGsfak47
	 n9EMbXbYFaUO6T8Q32jrimBISrHASx8aE7VWSvBvFdj2v/AcHVl4/rrX+5V2Pvmf78
	 24Z/xBKy2Zq2px/Hk76dCPDPRqDeqeUIACYyjF48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgF2Tky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387760AbgF2Tkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36492248E5;
        Mon, 29 Jun 2020 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444440;
        bh=3oKAkGkifbDgX3Z5v+1FPNUaEczT6noSTkhiC9qvSdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVKM7yjX0GtfycxX1DU261/G0VL24BQfVYGaZ4a2ZJ/SpOgVSolr9aQJh2CUlZ/lh
         0zWN267k8JM3vZUfYzOkrPdr8CpK2TxsMgI9fe1olTcR3pWFTcGt3mJ0MPGphceJay
         IuQZG/PIwCyCosgEdlarNbO3mU0/EWmcNPUjzIOw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 119/178] drm/amd/display: Use kfree() to free rgb_user in calculate_user_regamma_ramp()
Date:   Mon, 29 Jun 2020 11:24:24 -0400
Message-Id: <20200629152523.2494198-120-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

[ Upstream commit 43a562774fceba867e8eebba977d7d42f8a2eac7 ]

Use kfree() instead of kvfree() to free rgb_user in
calculate_user_regamma_ramp() because the memory is allocated with
kcalloc().

Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 207435fa4f2c6..51d07a4561ce9 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1862,7 +1862,7 @@ bool calculate_user_regamma_ramp(struct dc_transfer_func *output_tf,
 
 	kfree(rgb_regamma);
 rgb_regamma_alloc_fail:
-	kvfree(rgb_user);
+	kfree(rgb_user);
 rgb_user_alloc_fail:
 	return ret;
 }
-- 
2.25.1

