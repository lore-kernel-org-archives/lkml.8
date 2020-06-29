Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D1A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468392;
	bh=qX1K9e9vxB2D/EmLylGSb8b6etswqjPpldVt/sg1kuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kUe8fc2jYgRwvw/sXcBudF93dvLb3UbTUUcwW49/UrOf3o6OY4/1/rQPpLFA4TJHC
	 Lelvgu2PGx3GTLBn3Y/M0eA9gBzlnUahICLgyfC/sAMzM8cSlPx3a7Cz4GMQ7XY6Bv
	 3O35xOPNz0wHEceZOJf1o9K0987Ac7DDQKi08VOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404819AbgF2WGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgF2SfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F4E247D9;
        Mon, 29 Jun 2020 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444145;
        bh=qX1K9e9vxB2D/EmLylGSb8b6etswqjPpldVt/sg1kuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EriN8DL6KE93KuG6HeoDh2TaLuyq69eXT6RVrib16jiKFo/3HpQ3IX+qhyxnVI2bR
         WqfdQ7fTPl6/+wJJX1rRDCWNVcTa2LH5nvHvypTpMN+Hp7puuC7X10aHRb+/Rtwyno
         Md5xsDsgXRwP37OUltRF2qmSkQQILOTG6ckfZ0Fc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John van der Kamp <sjonny@suffe.me.uk>,
        Alex Deucher <alexander.deucher@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 250/265] drm/amdgpu/display: Unlock mutex on error
Date:   Mon, 29 Jun 2020 11:18:03 -0400
Message-Id: <20200629151818.2493727-251-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John van der Kamp <sjonny@suffe.me.uk>

commit ee434a4f9f5ea15b0f84bddd8c012838cf9472c5 upstream.

Make sure we pass through ret label to unlock the mutex.

Signed-off-by: John van der Kamp <sjonny@suffe.me.uk>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index dcf84a61de37f..949d10ef83040 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -510,8 +510,10 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
 
 	srm = psp_get_srm(work->hdcp.config.psp.handle, &srm_version, &srm_size);
 
-	if (!srm)
-		return -EINVAL;
+	if (!srm) {
+		ret = -EINVAL;
+		goto ret;
+	}
 
 	if (pos >= srm_size)
 		ret = 0;
-- 
2.25.1

