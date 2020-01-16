Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC846C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B260C22525
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193736;
	bh=bbNkedQdnDzdtuUlAZ2NagqN5EXVfxVOs37adHQ4BEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qG/XK1t/q3QbE8uMaqkHv4gjoYK6P73xc77ichNKDuexT++GFFpfyCT4OyMtstY0v
	 QX8VaYm8qW0sNmpSz9JTRc305h9e0s7AbntHsdrM81IN9beNpJn2FIyPu2IHmIbTK0
	 PLMwBhkweR7u/qvjBBsjr4C0vVc5kyrhYKEQ85Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbgAPQzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:55:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732792AbgAPQzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC6122522;
        Thu, 16 Jan 2020 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193724;
        bh=bbNkedQdnDzdtuUlAZ2NagqN5EXVfxVOs37adHQ4BEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZJzo/G2HLWjfXwgiP9E493ETgx21Y3sJQQMlGULYOk0ku3sqXHLc1FULYRJhaSOk
         GvpzDlidoGbFLCvofUxpRZsOyG8XwBh8wezrnGs4bGbAbH3dgvdo45cwofUSGJ8QDE
         41KE4O0128ytpB0k4MmpZzNTig7sTOznomoVaOVc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Houlong Wei <houlong.wei@mediatek.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 018/671] mailbox: mediatek: Add check for possible failure of kzalloc
Date:   Thu, 16 Jan 2020 11:44:09 -0500
Message-Id: <20200116165502.8838-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Houlong Wei <houlong.wei@mediatek.com>

[ Upstream commit 9f0a0a381c5db56e7922dbeea6831f27db58372f ]

The patch 623a6143a845("mailbox: mediatek: Add Mediatek CMDQ driver")
introduce the following static checker warning:
  drivers/mailbox/mtk-cmdq-mailbox.c:366 cmdq_mbox_send_data()
  error: potential null dereference 'task'.  (kzalloc returns null)

Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index aec46d5d3506..f7cc29c00302 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -363,6 +363,9 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	WARN_ON(cmdq->suspended);
 
 	task = kzalloc(sizeof(*task), GFP_ATOMIC);
+	if (!task)
+		return -ENOMEM;
+
 	task->cmdq = cmdq;
 	INIT_LIST_HEAD(&task->list_entry);
 	task->pa_base = pkt->pa_base;
-- 
2.20.1

