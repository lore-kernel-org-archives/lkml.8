Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C00C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE0A21775
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646329;
	bh=JKifc22C2UL+b3jQWkj/4fHSC1WFMr8V0XiS/e49728=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MyoidwL2SlpvCyMJe0JfAooKzFt6p7FDj3E8j3XpprzNp9qosJQYF28qcn3p1Gkwh
	 9VaqtsS4rb/0HogQEVgaU3XsXnc8d5LOFt2oeJyW2kkqSTq8DYQHz/YV03+l9FNTDr
	 PWE8AC0zEIGjDt2cHszzKD6TThNioJgETBszfWBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgDKXF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgDKXFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:05:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BBF820708;
        Sat, 11 Apr 2020 23:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646322;
        bh=JKifc22C2UL+b3jQWkj/4fHSC1WFMr8V0XiS/e49728=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVc6z6KOWxmyqUfZv6HxlBp3GIc4/NUvhh3TK+Jeqz+3wctpfC1S1FdFj0k7L8moX
         LoZX6InOyjo8WB+98rnY6VMEwWhVlz3bhS80kHrZQ7MguDsr6meItUgqb10sprHb4f
         zfagxb83FWhkTgnKPWd0qwiy8J2gz7YaFBXx4Uws=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peikang Zhang <peikang.zhang@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 076/149] drm/amd/display: dc_get_vmid_use_vector() crashes when get called
Date:   Sat, 11 Apr 2020 19:02:33 -0400
Message-Id: <20200411230347.22371-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peikang Zhang <peikang.zhang@amd.com>

[ Upstream commit 68bbca15e7062f4ae16531e29893f78d0b4840b6 ]

[Why]
int i can go out of boundary which will cause crash

[How]
Fixed the maximum value of i to avoid i going out of boundary

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index a96d8de9380e6..f2b39ec35c898 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -62,7 +62,7 @@ int dc_get_vmid_use_vector(struct dc *dc)
 	int i;
 	int in_use = 0;
 
-	for (i = 0; i < dc->vm_helper->num_vmid; i++)
+	for (i = 0; i < MAX_HUBP; i++)
 		in_use |= dc->vm_helper->hubp_vmid_usage[i].vmid_usage[0]
 			| dc->vm_helper->hubp_vmid_usage[i].vmid_usage[1];
 	return in_use;
-- 
2.20.1

