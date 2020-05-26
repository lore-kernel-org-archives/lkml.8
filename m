Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E26C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755B120776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521647;
	bh=9082s8SwAhFTbqFbYa/4fyiheRIflpQhujxpR+8RCdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pnDtq2pviISxDJ8JGujaVDyKAMmlZmmkrginCDxFv2WiI1v2K79oSP6LSCoI/2q+V
	 d+TrnqFRIGuioV77iadbV3BoqN81Ym5hY0VwfDb08Niod5feJMd4nBrCa4h8gPrWSE
	 /JNRqt91NLJ4cMY5GKf5Uid9MJIASc0Dz1MJpSRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbgEZSz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389430AbgEZSzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:55:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78365208B3;
        Tue, 26 May 2020 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519317;
        bh=9082s8SwAhFTbqFbYa/4fyiheRIflpQhujxpR+8RCdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxCFbhJToac1nmxpXLkbWuXNa5vGsMx55UUGQlIqpihcg9D/eyW5lgg5IJVE48l6j
         PU6hbCq5KrjR6TBWDlxqgKKb31Hd+v20sToWYMzUSShqvTklE661s5SM7YSXZ6LdXC
         nXHM55D7JKMiZ6NCrveUeHUESkEBbAHx7o383D/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 21/65] i2c: dev: dont start function name with return
Date:   Tue, 26 May 2020 20:52:40 +0200
Message-Id: <20200526183914.141946514@linuxfoundation.org>
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

From: Wolfram Sang <wsa@the-dreams.de>

commit 72a71f869c95dc11b73f09fe18c593d4a0618c3f upstream.

I stumbled multiple times over 'return_i2c_dev', especially before the
actual 'return res'. It makes the code hard to read, so reanme the
function to 'put_i2c_dev' which also better matches 'get_free_i2c_dev'.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 5fecc1d9e0a1..382c66d5a470 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -91,7 +91,7 @@ static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 	return i2c_dev;
 }
 
-static void return_i2c_dev(struct i2c_dev *i2c_dev)
+static void put_i2c_dev(struct i2c_dev *i2c_dev)
 {
 	spin_lock(&i2c_dev_list_lock);
 	list_del(&i2c_dev->list);
@@ -582,7 +582,7 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 error:
 	cdev_del(&i2c_dev->cdev);
 error_cdev:
-	return_i2c_dev(i2c_dev);
+	put_i2c_dev(i2c_dev);
 	return res;
 }
 
@@ -599,7 +599,7 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return 0;
 
-	return_i2c_dev(i2c_dev);
+	put_i2c_dev(i2c_dev);
 	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 	cdev_del(&i2c_dev->cdev);
 
-- 
2.25.1



