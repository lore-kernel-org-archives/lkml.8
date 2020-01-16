Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB879C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA76206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199383;
	bh=40AYRX+XYA5r8KQlSam5DZOIb3boQuYcYpYbsyWOSeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mca5zrnemU2IHN6RqxeaXZqHuksbkp5OisVjUxG46fXAYva0BujU2lx97VfPENfyy
	 TyVxwQt7JA8RSS7mfgFXFCZjelTD0SY9OMWUF7RUaYI54BP7+YvR2uTx8lNvpIWme7
	 DmsrGj3IjfmMI++Web6dEmIbtdt30t9Jc7V80yBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436689AbgAPS3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:29:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392161AbgAPRZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB7722051A;
        Thu, 16 Jan 2020 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195546;
        bh=40AYRX+XYA5r8KQlSam5DZOIb3boQuYcYpYbsyWOSeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESCmeUDy3jQFbs/KtcIrrh7hwy2keHkfaf5yzHkZ0y74QXPENfbcLJJIVZnCJjP10
         6NmoJ32C4bGhfpV9TqzfeRwtlS9/oivf1vm5bGKvirfMlywlH78Pt7YRug5+cIcLUa
         wVS6msKP+14PetAVfJJaU8AMAcqnhyPtKfbII00E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 138/371] media: cx18: update *pos correctly in cx18_read_pos()
Date:   Thu, 16 Jan 2020 12:20:10 -0500
Message-Id: <20200116172403.18149-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
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
index 98467b2089fa..099d59b992c1 100644
--- a/drivers/media/pci/cx18/cx18-fileops.c
+++ b/drivers/media/pci/cx18/cx18-fileops.c
@@ -484,7 +484,7 @@ static ssize_t cx18_read_pos(struct cx18_stream *s, char __user *ubuf,
 
 	CX18_DEBUG_HI_FILE("read %zd from %s, got %zd\n", count, s->name, rc);
 	if (rc > 0)
-		pos += rc;
+		*pos += rc;
 	return rc;
 }
 
-- 
2.20.1

