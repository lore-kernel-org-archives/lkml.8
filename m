Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693FBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2F720838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073015;
	bh=jmFDcZ8vPo5JsDA6rhoJdQuuBC/wXnUd4I/ZMyNDUAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fs2KVgo/DgM99q2VZAmhxB2Cx3L0tQ8IwSxbbT/tEsSkpBJy1QcHU2x8xSpbZQz06
	 dnVjKZny0otrVDZe6fgTpYxKi+34K0w53t+pGV0hP/oj36Hay0ouzF96fZDp2NPjxl
	 y1SJqu4pLNGgmewbdcYVpj4W5hWxjQthLDy7y7aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHJPXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbgHJPX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:23:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6432320772;
        Mon, 10 Aug 2020 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073008;
        bh=jmFDcZ8vPo5JsDA6rhoJdQuuBC/wXnUd4I/ZMyNDUAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnFD8QyF/JUvgYvz4b14zFjc09KJQbAvAtGt6Ki7slrf5Io8dWmyQNXCV6vm7lNlm
         S6j/y+w37SHRQsNAeaY/4gd9ToY5h3lh33EwPbmdxZ4sgfzfSWJP7djMTdI11eEfZ8
         6/BjliDDRy6x76pvLoCkY/aNdYpJOIRlX2DLvvhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 33/79] drm/nouveau/kms/tu102: wait for core update to complete when assigning windows
Date:   Mon, 10 Aug 2020 17:20:52 +0200
Message-Id: <20200810151813.925318979@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 705d9d022949e3cdae82d89db6a8fc773eb23dad ]

Fixes a race on Turing between the core cross-channel error checks and
the following window update.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 2625ed84fc44d..5835d19e1c45f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2041,7 +2041,7 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
 	 */
 	if (core->assign_windows) {
 		core->func->wndw.owner(core);
-		core->func->update(core, interlock, false);
+		nv50_disp_atomic_commit_core(state, interlock);
 		core->assign_windows = false;
 		interlock[NV50_DISP_INTERLOCK_CORE] = 0;
 	}
-- 
2.25.1



