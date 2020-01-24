Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF73C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B30020838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863629;
	bh=SxPgSaC3Z9OSyuIBN90jXVJ5S8zcRTzhZAnQKqLR6pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xQqMCgHt501qFpboWAwRJGkVJy7dIzTeJ0v6I5YQuzZqq+dcDSg6HpRiqPjmJUPwz
	 8EpvWUWjcccwsXDYI52m4Ko1FBShMTxHGoR5uXO+kF7vArVk11/Z97Ssu3MpD/0zIn
	 B2Jp0s/t/N5Q3NQnNSH+aBojGhhoXZjCMU4vQFdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbgAXLA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:00:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733185AbgAXLAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:00:25 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C692071A;
        Fri, 24 Jan 2020 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863625;
        bh=SxPgSaC3Z9OSyuIBN90jXVJ5S8zcRTzhZAnQKqLR6pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEokW19ESH8H0MND86uYmzSFmfGgh0C6x2tnFWuUMbm45vxyzdNY9rSzYgLoP2msM
         /NKhVbHOFTuMiF2BEEfd1QIzoD+wxPl4fYITnz07r3yyZcNh6ZditFHTBz5plHX3VT
         QO1vImz/6jgyJzu9z16Y5xclEPKU1IcT1dUjkxWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/639] mailbox: mediatek: Add check for possible failure of kzalloc
Date:   Fri, 24 Jan 2020 10:23:25 +0100
Message-Id: <20200124093051.838285303@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index aec46d5d35061..f7cc29c00302a 100644
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



