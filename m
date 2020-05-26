Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C30C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFC920849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519330;
	bh=Wwkq3HttPZDyE/FF5UyUIlAIhjy0c5qM67sxP1MaqhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yQ6d4l4ETxsggSe/EoDVs42EYFcAzeQE8/Y9HqQpAKRHYZqNwowKIKYudyVWSBCIB
	 f+qCRvaBD2CTUKEGnv5uGPUTNXiVztyNzNUzb/DW7m2FfErJYgXjoNACkgVXKWslcV
	 8xdyjPKogHxv9XJ84cskKJpSCZnf7xdq+PgCfjS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbgEZSz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389467AbgEZSzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:55:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BC320849;
        Tue, 26 May 2020 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519322;
        bh=Wwkq3HttPZDyE/FF5UyUIlAIhjy0c5qM67sxP1MaqhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9AATBCVxAyYMMM7aHxFIa6gqR+LyuoX+GzYZQ4w7E0LSSy1xf5+dDirPIR5FFtXv
         RGW8iHX6OkoG9waU0m3j9BNLMm20OzNsJGgkbrR9x9GeA2RO3F0cgaXMcOhRYTHv8p
         7JOzYPGT8oxW0fadymkf7MlJfOjefvP7HiQvoick=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Jean Delvare <jdelvare@suse.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 23/65] i2c-dev: dont get i2c adapter via i2c_dev
Date:   Tue, 26 May 2020 20:52:42 +0200
Message-Id: <20200526183914.867893581@linuxfoundation.org>
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

From: viresh kumar <viresh.kumar@linaro.org>

commit 5136ed4fcb05cd4981cc6034a11e66370ed84789 upstream.

There is no code protecting i2c_dev to be freed after it is returned
from i2c_dev_get_by_minor() and using it to access the value which we
already have (minor) isn't safe really.

Avoid using it and get the adapter directly from 'minor'.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-dev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index e5cd307ebfc9..5543b49e2e05 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -492,13 +492,8 @@ static int i2cdev_open(struct inode *inode, struct file *file)
 	unsigned int minor = iminor(inode);
 	struct i2c_client *client;
 	struct i2c_adapter *adap;
-	struct i2c_dev *i2c_dev;
-
-	i2c_dev = i2c_dev_get_by_minor(minor);
-	if (!i2c_dev)
-		return -ENODEV;
 
-	adap = i2c_get_adapter(i2c_dev->adap->nr);
+	adap = i2c_get_adapter(minor);
 	if (!adap)
 		return -ENODEV;
 
-- 
2.25.1



