Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B1EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A948620885
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519299;
	bh=/In5JdT69yn57IumW2iR6+2tiJcSI5hBOP0xi1d5Da4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bUP/R51TN6xybx/qSZTGBrtaj4A3zMhrQ0fMKYiwpANvGOXQ3TYp4G86IxMTI2eul
	 GRhhSzazpXIA/IO0rL06LRb3AlhNO5xMNdWqnKAJHEL4bNimabLPM73EYQio3nVIAN
	 uhbTUH5Ko5vMfie9R/7iQ1A/Sjiydas/2JpJANNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389248AbgEZSy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389192AbgEZSy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:54:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4685820823;
        Tue, 26 May 2020 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519295;
        bh=/In5JdT69yn57IumW2iR6+2tiJcSI5hBOP0xi1d5Da4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoDYFOpDy7aBAAWpMCZ0pjHjf6uBqDvFOC4P3hHJX+G44xEX8mAwHxJkLVgLNeq8v
         ANAv+G9wk7NzuyPBKRqKZWolyvXxpeJOfgAO68wgpOsdtB16khAMAxWl+DvRfuAnEx
         qz+Vu5j0ECeVnziAgnwuarqqS49ipZ73xAU3JprA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 13/65] media: Fix media_open() to clear filp->private_data in error leg
Date:   Tue, 26 May 2020 20:52:32 +0200
Message-Id: <20200526183911.159307281@linuxfoundation.org>
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

From: Shuah Khan <shuahkh@osg.samsung.com>

commit d40ec6fdb0b03b7be4c7923a3da0e46bf943740a upstream.

Fix media_open() to clear filp->private_data when file open
fails.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/media-devnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/media-devnode.c b/drivers/media/media-devnode.c
index ebf9626e5ae5..a8cb52dc8c4f 100644
--- a/drivers/media/media-devnode.c
+++ b/drivers/media/media-devnode.c
@@ -181,6 +181,7 @@ static int media_open(struct inode *inode, struct file *filp)
 		ret = mdev->fops->open(filp);
 		if (ret) {
 			put_device(&mdev->dev);
+			filp->private_data = NULL;
 			return ret;
 		}
 	}
-- 
2.25.1



