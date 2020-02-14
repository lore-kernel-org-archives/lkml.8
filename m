Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B889CC3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B8524682
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695728;
	bh=5jtGsCSjRRpD360ikcBkCoYPXgSmQEYS0wrNFktcNKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=stK80OdXYpTH+EQpt8wXijEPWD0xXDUDqIZqJnVKKowIKkg69iAKO/hNjco2qaPEV
	 esMjEdt4mYNgOso3SE6sKEBeKnQBlCfqL2nqSQU57nS6NRuDhBLfWi0a2KDPbEJLgf
	 lojMeTacEOs6K1i2a153kCTGOvtJ5QfW1N2NXdl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgBNPz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731721AbgBNPzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:55:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B07024681;
        Fri, 14 Feb 2020 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695715;
        bh=5jtGsCSjRRpD360ikcBkCoYPXgSmQEYS0wrNFktcNKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGFlOTcYvjDHSCq507f4c7DTSSJd/y1VNNugyc8z3Afbsu2yfPLCFbbCYSqZxghXM
         RNifatln/Z108Y54tSdI3ER3PKK/uycyjKpPJx0wPLGBB9K1Qvw24MdGfvfkFs6w3A
         rWyb95LnEOM5qcnxss8P/JdD6tDSgy564ZwdclBc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        shaoyunl <shaoyun.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 293/542] drm/amdkfd: Fix permissions of hang_hws
Date:   Fri, 14 Feb 2020 10:44:45 -0500
Message-Id: <20200214154854.6746-293-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit 2bdac179e217a0c0b548a8c60524977586621b19 ]

Reading from /sys/kernel/debug/kfd/hang_hws would cause a kernel
oops because we didn't implement a read callback. Set the permission
to write-only to prevent that.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: shaoyunl  <shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 15c523027285c..511712c2e382d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -93,7 +93,7 @@ void kfd_debugfs_init(void)
 			    kfd_debugfs_hqds_by_device, &kfd_debugfs_fops);
 	debugfs_create_file("rls", S_IFREG | 0444, debugfs_root,
 			    kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
-	debugfs_create_file("hang_hws", S_IFREG | 0644, debugfs_root,
+	debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
 			    NULL, &kfd_debugfs_hang_hws_fops);
 }
 
-- 
2.20.1

