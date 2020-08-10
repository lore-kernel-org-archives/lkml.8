Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5257DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233C72080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087479;
	bh=slit+5tZxoGPIjOWZ4Ys7ijQ5PuZFpyv9tER/QkkOas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZhkkrVK6lQCefmpkFcfdwxqYaHSKwY6PbTXQ4vIYZPehSM9xH7HBxBJdiljw8bMn9
	 dy90j2nkCWKUQdzcyfXBJKnSBcRPEHcZBFsx8dX22/CR2GNGccyidS07I+dQutSFTL
	 zhTcd0S4i5ETMiTTuZKwCuMJ4a/dDOBlgekj0I5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHJTMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbgHJTMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:12:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB49B22C9E;
        Mon, 10 Aug 2020 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086736;
        bh=slit+5tZxoGPIjOWZ4Ys7ijQ5PuZFpyv9tER/QkkOas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkBkOqf7rz/u2/BReCxzbOg0T5gj9zHdbsW5Hk+3J+ysJPVqiT5Dv4nrjMFyw/FQN
         tQ4Z/uo77wuopN9AF8hDnuW49nW5w5iGaErQlnp/asaxOAH36Sx24N67WpnIqvdL+E
         TitTVKYidpajJzHgQXDGGfhVOGHimV4qrHfCifps=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 16/45] drm/nouveau: fix reference count leak in nouveau_debugfs_strap_peek
Date:   Mon, 10 Aug 2020 15:11:24 -0400
Message-Id: <20200810191153.3794446-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191153.3794446-1-sashal@kernel.org>
References: <20200810191153.3794446-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 8f29432417b11039ef960ab18987c7d61b2b5396 ]

nouveau_debugfs_strap_peek() calls pm_runtime_get_sync() that
increments the reference count. In case of failure, decrement the
ref count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 7dfbbbc1beea6..5c314f135dd10 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -54,8 +54,10 @@ nouveau_debugfs_strap_peek(struct seq_file *m, void *data)
 	int ret;
 
 	ret = pm_runtime_get_sync(drm->dev->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_autosuspend(drm->dev->dev);
 		return ret;
+	}
 
 	seq_printf(m, "0x%08x\n",
 		   nvif_rd32(&drm->client.device.object, 0x101000));
-- 
2.25.1

