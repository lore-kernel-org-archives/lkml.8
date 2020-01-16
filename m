Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A53C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1E5217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198128;
	bh=bIFZMnrtPxehiDYOcc4OQ4kbtN8MY8B3HN+2+c8olC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QFwy79wvypF8XQEBYXu5F5JsGyG4DgUkTVNP/oCNi2EAmNm33qGmfwEickfvDf1oG
	 YEI2CJosw/2qaoyDW3JUoRrriyayjOEjNyFGOGI3ntDN6rChbshc9/xcRF9ce/RDyL
	 c6IXWVpBhj5yMD3C/Xi/5dq7kzagM7HFe8N2ksn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAPRik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393232AbgAPRh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377AC246E9;
        Thu, 16 Jan 2020 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196277;
        bh=bIFZMnrtPxehiDYOcc4OQ4kbtN8MY8B3HN+2+c8olC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txGm8Q7OGh5L9NRCHUro5kw7rxhn08DJkB7mb1s4SIVZ0Vy3NsEiTf5ZMDBbCkwTx
         tMuRFzE8wU5KIM2Gbijl/MCEOaA4bf/UThz0z4RM88TyigQZ3ppsi7XP7FvZgvegL9
         5Vxv2X2lgZQM+A1eOWZmt7uzOOSwuenq55+J97hM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 097/251] media: cx18: update *pos correctly in cx18_read_pos()
Date:   Thu, 16 Jan 2020 12:34:06 -0500
Message-Id: <20200116173641.22137-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7afb0df554292dca7568446f619965fb8153085d ]

We should be updating *pos.  The current code is a no-op.

Fixes: 1c1e45d17b66 ("V4L/DVB (7786): cx18: new driver for the Conexant CX23418 MPEG encoder chip")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx18/cx18-fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-fileops.c b/drivers/media/pci/cx18/cx18-fileops.c
index df837408efd5..0171dc5b8809 100644
--- a/drivers/media/pci/cx18/cx18-fileops.c
+++ b/drivers/media/pci/cx18/cx18-fileops.c
@@ -490,7 +490,7 @@ static ssize_t cx18_read_pos(struct cx18_stream *s, char __user *ubuf,
 
 	CX18_DEBUG_HI_FILE("read %zd from %s, got %zd\n", count, s->name, rc);
 	if (rc > 0)
-		pos += rc;
+		*pos += rc;
 	return rc;
 }
 
-- 
2.20.1

