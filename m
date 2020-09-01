Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B23FC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F14204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976580;
	bh=I6GAMxGs19nNEZFk2dtb6Q6gWKmT1Q9GK98PIdZDL8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNdzJ31YWQnf6g4vveJkdSvmPW23V+IKfFSKOq2QZ/wEy4UnUV/ZGfesAt1yM8uJU
	 TahrqHbFXVqk8P/uotRMWgopLsaWtpBuGP2iYQ2v9/L3D0rsYIvi3c7TfaMtPskCTJ
	 GtTuPi22arZEUgrhby7Ma9nRo+RJ0WF9q8NS7tOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgIAPis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731122AbgIAPg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:36:57 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23AE021534;
        Tue,  1 Sep 2020 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974616;
        bh=I6GAMxGs19nNEZFk2dtb6Q6gWKmT1Q9GK98PIdZDL8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zowdB2H2eB4whGqAIqgjq0kSUTCJ9ODZq5lxC8Ao8B8qjeKZVWDkwwwaq7/rQcJQB
         kdpayqCjv7MQbLfW7EJ1y8zonS4T/Wm04qn3qG4g5OU/g/knILvV8GgXuegQlquFK4
         K0iYPvWqj/HgjdXRkxHBhrgp6edxQPmOc+ZiAC+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 030/255] drm/amdkfd: fix ref count leak when pm_runtime_get_sync fails
Date:   Tue,  1 Sep 2020 17:08:06 +0200
Message-Id: <20200901151002.218616843@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 1c1ada37af6ee6fb9cfc8da6a56cc83208cd8d6f ]

The call to pm_runtime_get_sync increments the counter even in case of
failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0e0c42e9f6a31..6520a920cad4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1003,8 +1003,10 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 	 */
 	if (!pdd->runtime_inuse) {
 		err = pm_runtime_get_sync(dev->ddev->dev);
-		if (err < 0)
+		if (err < 0) {
+			pm_runtime_put_autosuspend(dev->ddev->dev);
 			return ERR_PTR(err);
+		}
 	}
 
 	err = kfd_iommu_bind_process_to_device(pdd);
-- 
2.25.1



