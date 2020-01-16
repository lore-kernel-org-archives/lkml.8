Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1732053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201300;
	bh=sCOKl7AT5wuYByHfu1pu1f4QwZR7geoFCO+SXHsTYyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yauVBKInHNeHXcfdMkDk8iBV4+buXQRWixZr2Q41Q0SMzknbbm+5K5rYLSvQTSXiv
	 LEuKQ4Shah5rrPA3RoczxFIpWekkEiqgoH1ID17qKac4SOVSjlc6CbsCE0c58LqkMa
	 KNIdGKyx4EGwhOIe5YZtY2y4aHMsx4DlNKEkNkOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgAPRFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388764AbgAPRFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:05:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A962081E;
        Thu, 16 Jan 2020 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194336;
        bh=sCOKl7AT5wuYByHfu1pu1f4QwZR7geoFCO+SXHsTYyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mW3N9QDDmeF6o0LsC1jnH3abpNtmYWZnr7wJ2Uiz4BTiXwX8rC2p1ZnRWu2Oh5KPk
         fG7xXv94JZfTuem10wKwNGQTbKl3uQ708MXQASV8HscxoBjM6EnnX5fic3P3NNWwKP
         g6k+4nNjdjt2scoJAKobQgqL6SSc3BBvCd2zXVCI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Deepak Rawat <drawat@vmware.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 281/671] drm/vmwgfx: Remove set but not used variable 'restart'
Date:   Thu, 16 Jan 2020 11:58:39 -0500
Message-Id: <20200116170509.12787-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit b2130cca9c8db5073b71d832da2a6c8311a8f3bb ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c: In function 'vmw_cmdbuf_work_func':
drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:514:7: warning:
 variable 'restart' set but not used [-Wunused-but-set-variable]

It not used any more after commit dc366364c4ef ("drm/vmwgfx: Fix multiple
command buffer context use")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Deepak Rawat <drawat@vmware.com>
Fixes: dc366364c4ef ("drm/vmwgfx: Fix multiple command buffer context use")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index e7e4655d3f36..ce1ad7cd7899 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -511,17 +511,14 @@ static void vmw_cmdbuf_work_func(struct work_struct *work)
 		container_of(work, struct vmw_cmdbuf_man, work);
 	struct vmw_cmdbuf_header *entry, *next;
 	uint32_t dummy;
-	bool restart[SVGA_CB_CONTEXT_MAX];
 	bool send_fence = false;
 	struct list_head restart_head[SVGA_CB_CONTEXT_MAX];
 	int i;
 	struct vmw_cmdbuf_context *ctx;
 	bool global_block = false;
 
-	for_each_cmdbuf_ctx(man, i, ctx) {
+	for_each_cmdbuf_ctx(man, i, ctx)
 		INIT_LIST_HEAD(&restart_head[i]);
-		restart[i] = false;
-	}
 
 	mutex_lock(&man->error_mutex);
 	spin_lock(&man->lock);
@@ -533,7 +530,6 @@ static void vmw_cmdbuf_work_func(struct work_struct *work)
 		const char *cmd_name;
 
 		list_del_init(&entry->list);
-		restart[entry->cb_context] = true;
 		global_block = true;
 
 		if (!vmw_cmd_describe(header, &error_cmd_size, &cmd_name)) {
-- 
2.20.1

