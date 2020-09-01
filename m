Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BACC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2B720767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979472;
	bh=1RWtT8E4YoCSAVBxjIpIKeJoAnVXtAoepvZi3EKMf6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dW1eIGQBM/2SwkEhpQUjkby5rm+PYXZAzZo7BwgHN/IcXCkBVkIj5Avprco5jJOsF
	 jOPfcqxdXwYj6v/SwrtN6nzPmx+hIXVHt43gl++YgjwJd7a/xyyRMdQntHD1N1uP3w
	 FTwwerhi8fyHLYUrPFuRO06ZBIY2OaBACYQBevQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgIAQ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbgIAPXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:23:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE596206FA;
        Tue,  1 Sep 2020 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973782;
        bh=1RWtT8E4YoCSAVBxjIpIKeJoAnVXtAoepvZi3EKMf6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/edVu0xc6YhRdrq0vaMlmZ9FfQn8GL3jyjH+XXedZuSx0KFbyIKjIU0gh/IVRZxx
         4DJdWZ3JadHq0HdZfnT63faUocA8XFhVC151nLNXA47n1FBoJcNlFIlFoqvfyfrkZi
         5BQ28BoKLIW0+GOODwbJBrgE5H9yKFltMOKBxoHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Girish Basrur <gbasrur@marvell.com>,
        Santosh Vernekar <svernekar@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Shyam Sundar <ssundar@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/125] scsi: fcoe: Memory leak fix in fcoe_sysfs_fcf_del()
Date:   Tue,  1 Sep 2020 17:10:00 +0200
Message-Id: <20200901150936.775948335@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javed Hasan <jhasan@marvell.com>

[ Upstream commit e95b4789ff4380733006836d28e554dc296b2298 ]

In fcoe_sysfs_fcf_del(), we first deleted the fcf from the list and then
freed it if ctlr_dev was not NULL. This was causing a memory leak.

Free the fcf even if ctlr_dev is NULL.

Link: https://lore.kernel.org/r/20200729081824.30996-3-jhasan@marvell.com
Reviewed-by: Girish Basrur <gbasrur@marvell.com>
Reviewed-by: Santosh Vernekar <svernekar@marvell.com>
Reviewed-by: Saurav Kashyap <skashyap@marvell.com>
Reviewed-by: Shyam Sundar <ssundar@marvell.com>
Signed-off-by: Javed Hasan <jhasan@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 24cbd0a2cc69f..658c0726581f9 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -267,9 +267,9 @@ static void fcoe_sysfs_fcf_del(struct fcoe_fcf *new)
 		WARN_ON(!fcf_dev);
 		new->fcf_dev = NULL;
 		fcoe_fcf_device_delete(fcf_dev);
-		kfree(new);
 		mutex_unlock(&cdev->lock);
 	}
+	kfree(new);
 }
 
 /**
-- 
2.25.1



