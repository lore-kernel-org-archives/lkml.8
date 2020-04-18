Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1563C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A2F2072B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221318;
	bh=hsqNaKKlfFUobAtuu5bXo+fEnWq/rXn9x2jK23bzFZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/LktJWDd3ZQ6rYrxzUXKhy5k/Hl6VrUPOokIyT4Le/fnmtGVCh+OhGTpTmqMPWSR
	 +oMKCn1r2Tgdmnu+MYC4vmNmN8Us9bpMzEfqpETARwGHwRiLmMiIRoIQtH3ohUNQtP
	 P7VxtcorFJ7d8e0DzBPzLvk1PGlTguE5ScbGRLwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgDROsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbgDROns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:43:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FBF22202;
        Sat, 18 Apr 2020 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221028;
        bh=hsqNaKKlfFUobAtuu5bXo+fEnWq/rXn9x2jK23bzFZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpMOYLjElQ6Y1U4ftzJHtWvNmosc8cxvPcZXaiobqM/uQJRyXyq++A5eC+aFvhqIL
         lW16if4FmqxIKM8Sh3VvWCFN6jc6fdLRcxR0Uk1ZYuwmeGoQIRplaJRJZExfmMOoRp
         6YN+0fz2gC+6yh6gVO4wcCaVdBbSd2MkOj8wUCrw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/28] s390/cio: avoid duplicated 'ADD' uevents
Date:   Sat, 18 Apr 2020 10:43:15 -0400
Message-Id: <20200418144328.10265-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144328.10265-1-sashal@kernel.org>
References: <20200418144328.10265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@redhat.com>

[ Upstream commit 05ce3e53f375295c2940390b2b429e506e07655c ]

The common I/O layer delays the ADD uevent for subchannels and
delegates generating this uevent to the individual subchannel
drivers. The io_subchannel driver will do so when the associated
ccw_device has been registered -- but unconditionally, so more
ADD uevents will be generated if a subchannel has been unbound
from the io_subchannel driver and later rebound.

To fix this, only generate the ADD event if uevents were still
suppressed for the device.

Fixes: fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")
Message-Id: <20200327124503.9794-2-cohuck@redhat.com>
Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index e5c32f4b5287e..d2203cd178138 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -828,8 +828,10 @@ static void io_subchannel_register(struct ccw_device *cdev)
 	 * Now we know this subchannel will stay, we can throw
 	 * our delayed uevent.
 	 */
-	dev_set_uevent_suppress(&sch->dev, 0);
-	kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+	if (dev_get_uevent_suppress(&sch->dev)) {
+		dev_set_uevent_suppress(&sch->dev, 0);
+		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+	}
 	/* make it known to the system */
 	ret = ccw_device_add(cdev);
 	if (ret) {
@@ -1037,8 +1039,11 @@ static int io_subchannel_probe(struct subchannel *sch)
 		 * Throw the delayed uevent for the subchannel, register
 		 * the ccw_device and exit.
 		 */
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+		if (dev_get_uevent_suppress(&sch->dev)) {
+			/* should always be the case for the console */
+			dev_set_uevent_suppress(&sch->dev, 0);
+			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+		}
 		cdev = sch_get_cdev(sch);
 		rc = ccw_device_add(cdev);
 		if (rc) {
-- 
2.20.1

