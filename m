Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00920C33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83DE20684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199330;
	bh=Er9b+hegv+QekdwOFBDM4vu7+PTEEUZ/66FnFh24PYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDxgOcF1Cmwoc3aKo1f5L0CoeIkeyAqj9gee2t+5cUjS0sF87IO/SkGq8vLHGhGhu
	 65vj3AV8+7K2tkcfiTv8pt/8JcqvsSkSoOdy15GbynymERfD5y/nRO+66+KFhF8y5q
	 AkKxKgmY6ehw7h3IZt/LQULkrzA90btfWseheqTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392240AbgAPR0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:26:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392153AbgAPRZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 709262053B;
        Thu, 16 Jan 2020 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195545;
        bh=Er9b+hegv+QekdwOFBDM4vu7+PTEEUZ/66FnFh24PYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8ciJSxw8T6ndVSKFL7k1QZLSfQtAShW25VqUgH68UPB7eZWmIHygweCX/Mk5HQ9F
         QDEP/zCCm7Tysy6y8zLxZc2WU8PvE2RFamLSccNCQfePI1bDbGu2qZrWfendp0xIzd
         Ee1ch0C4iVqjxiPzzFpPGI1o+ZIViglTQCrfoMNQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 137/371] media: ivtv: update *pos correctly in ivtv_read_pos()
Date:   Thu, 16 Jan 2020 12:20:09 -0500
Message-Id: <20200116172403.18149-80-sashal@kernel.org>
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

[ Upstream commit f8e579f3ca0973daef263f513da5edff520a6c0d ]

We had intended to update *pos, but the current code is a no-op.

Fixes: 1a0adaf37c30 ("V4L/DVB (5345): ivtv driver for Conexant cx23416/cx23415 MPEG encoder/decoder")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ivtv/ivtv-fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ivtv/ivtv-fileops.c b/drivers/media/pci/ivtv/ivtv-fileops.c
index c9bd018e53de..e2b19c3eaa87 100644
--- a/drivers/media/pci/ivtv/ivtv-fileops.c
+++ b/drivers/media/pci/ivtv/ivtv-fileops.c
@@ -420,7 +420,7 @@ static ssize_t ivtv_read_pos(struct ivtv_stream *s, char __user *ubuf, size_t co
 
 	IVTV_DEBUG_HI_FILE("read %zd from %s, got %zd\n", count, s->name, rc);
 	if (rc > 0)
-		pos += rc;
+		*pos += rc;
 	return rc;
 }
 
-- 
2.20.1

