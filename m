Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DA7208A9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519306;
	bh=9BzVbIQ1RgoeVte0yG3HQz5ChixvNH7WvWk2e9xLJDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Iom9DgaCemI4bxUi//bDATFAJHeMjb0C5Rrkc+bjc4CDUAufi5szC/faFQTHosKO
	 yDpokKpjoWBS8HnWWERFCBKGSnkJoA/+RM1Tk73OPMIPumiIjxc6GE6Fbgf814gLcd
	 WMCjQfAVC0N2sYS7PxbZKb/Ghr9ris9mrfOKKEq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbgEZSzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389254AbgEZSzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:55:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2948A20885;
        Tue, 26 May 2020 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519300;
        bh=9BzVbIQ1RgoeVte0yG3HQz5ChixvNH7WvWk2e9xLJDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6ti+fLYl+bWB8wYTT77Uz1peEQGhEootiBnoGIEMfDMpIsy8Itls5FglRhZC1AhF
         ewhJYYcrttaNWcIY5nWRBVSoyQ6OUEZ3m+rs7wrw+9CVXWrw0sjcUyRboOMdqPyNQ5
         KeViJwwt7VrdGL7chPHSz4rXGCiKArh+cOq8denc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Kellermann <max@duempel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 15/65] media-devnode: add missing mutex lock in error handler
Date:   Tue, 26 May 2020 20:52:34 +0200
Message-Id: <20200526183911.693569472@linuxfoundation.org>
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

commit 88336e174645948da269e1812f138f727cd2896b upstream.

We should protect the device unregister patch too, at the error
condition.

Signed-off-by: Max Kellermann <max@duempel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/media-devnode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/media-devnode.c b/drivers/media/media-devnode.c
index 6c56aebd8db0..86c7c3732c84 100644
--- a/drivers/media/media-devnode.c
+++ b/drivers/media/media-devnode.c
@@ -282,8 +282,11 @@ int __must_check media_devnode_register(struct media_devnode *mdev,
 	return 0;
 
 error:
+	mutex_lock(&media_devnode_lock);
 	cdev_del(&mdev->cdev);
 	clear_bit(mdev->minor, media_devnode_nums);
+	mutex_unlock(&media_devnode_lock);
+
 	return ret;
 }
 
-- 
2.25.1



