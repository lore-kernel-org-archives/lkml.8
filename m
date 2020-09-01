Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15A5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A9A2158C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974818;
	bh=7FLAhkpdZYZNY6BxWLsZPdbDhw/khZFS6fnCA4pRsH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tVy55U8rJfjVJTgZjKqnNNCnR1A+z5YF1a50Y2QB9CYs272zpaL/Mvto8dPL4BHh3
	 dV6bxzitL/CLoMI8OcHw5nyepCjnu5fFbcVu3NJvAT0oTmA6qllY5XS6MkiW3wx0ha
	 M8Vah66E5+tyDuHF589XHx/Vhpd0yR+zJck99utU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbgIAPkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbgIAPiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:38:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCB420866;
        Tue,  1 Sep 2020 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974697;
        bh=7FLAhkpdZYZNY6BxWLsZPdbDhw/khZFS6fnCA4pRsH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbdHlD+N9MNcefZTs1OdtspWl/JY/KbJQ+JLxlfm/CZ2m4k9YtCc2gdbF5UrjM+NK
         SZTMoB7Eshvn8HaHXqpp4RNGcTEiEtNITnIFhUxPTk3WJytMrufjM7/UDoBK2tus12
         FPqwnhKfXQIAA8vVqs4ZpK81B1If4O6rri6MaAdA=
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
Subject: [PATCH 5.8 060/255] scsi: fcoe: Memory leak fix in fcoe_sysfs_fcf_del()
Date:   Tue,  1 Sep 2020 17:08:36 +0200
Message-Id: <20200901151003.601543217@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
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
index 1791a393795da..07a0dadc75bf5 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -255,9 +255,9 @@ static void fcoe_sysfs_fcf_del(struct fcoe_fcf *new)
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



