Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE8C20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519302;
	bh=T60bd/FuGyzll5nwnnbnCo5b2FiEdm8175Y1UAsRFEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JqVe/K1/VhWRV1EEwG1Mp4GW7+SjRP/bgDW7F/YfLt5+eEF+F4io4YPztS7Pu20PJ
	 6/I3W7TeVUc3mifLgxbnDMAul5woIkLAEB0w0NKoLgOvC1xCMroYqho2Lzom+airWm
	 FaT0kGKKcKHthmSlQ+sPW6HFyZLFD7g7COEftWq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389274AbgEZSzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389242AbgEZSy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:54:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC94F2087D;
        Tue, 26 May 2020 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519298;
        bh=T60bd/FuGyzll5nwnnbnCo5b2FiEdm8175Y1UAsRFEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryILJr8YWvGZzcIJBj+ZPgr3tKSzVVaQUtHxmtexwrkbmVpBdRalgyFzeFP5vjSyd
         1YFonm73FxuYJS8GAVBRQEF9pKAC5R2UI3BGjQHSnbK3B2/hoE1Nihb7CQu8qpzUrp
         ee130Bz/iver1bjy9jR4TeaGgPQBvTo6MG0Cubhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Kellermann <max@duempel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 14/65] drivers/media/media-devnode: clear private_data before put_device()
Date:   Tue, 26 May 2020 20:52:33 +0200
Message-Id: <20200526183911.447183733@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Kellermann <max@duempel.org>

commit bf244f665d76d20312c80524689b32a752888838 upstream.

Callbacks invoked from put_device() may free the struct media_devnode
pointer, so any cleanup needs to be done before put_device().

Signed-off-by: Max Kellermann <max@duempel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/media-devnode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/media-devnode.c b/drivers/media/media-devnode.c
index a8cb52dc8c4f..6c56aebd8db0 100644
--- a/drivers/media/media-devnode.c
+++ b/drivers/media/media-devnode.c
@@ -197,10 +197,11 @@ static int media_release(struct inode *inode, struct file *filp)
 	if (mdev->fops->release)
 		mdev->fops->release(filp);
 
+	filp->private_data = NULL;
+
 	/* decrease the refcount unconditionally since the release()
 	   return value is ignored. */
 	put_device(&mdev->dev);
-	filp->private_data = NULL;
 	return 0;
 }
 
-- 
2.25.1



