Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B9AC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2843206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274640;
	bh=5jtGsCSjRRpD360ikcBkCoYPXgSmQEYS0wrNFktcNKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RTiWWuLuci0fF279BojieluRovrPG3NiblLEgH1Of2Cpdyz7Mfk8GZ4BbrmLRWx42
	 PECHYcuGKDeJISzEUuI/XGxYX3yDKvTcoZI4a6f8TfA39dQ8U+QnNZP9wVKF4w0VXf
	 k8vpExBPLyiJXhdBYGVpQOnujQslur9fKv1rDK10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgBUHww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:52:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbgBUHwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:52:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C164720578;
        Fri, 21 Feb 2020 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271564;
        bh=5jtGsCSjRRpD360ikcBkCoYPXgSmQEYS0wrNFktcNKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gq7ep+d5eWGdK8IwiFZ7R8iW6Pk6GvtW1HSYGWQsdNpB7pOz45CuRetpiczl8qAdf
         O5HWTpXcRCT1tsdGWoevIM2GAOS/RfQc07E2N8bEy+e3OQdH39XMEgvfAj66dZG4uk
         uAr3lSZZ8x5MOIyEY11VCKU1Yg4K/TeqWiK6k90o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        shaoyunl <shaoyun.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 214/399] drm/amdkfd: Fix permissions of hang_hws
Date:   Fri, 21 Feb 2020 08:38:59 +0100
Message-Id: <20200221072423.810968460@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



