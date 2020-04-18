Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671FBC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4383621D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221108;
	bh=sD6kM9YtnGhI/BuVDPhEHnyPkH8B8ivMCVvFiSdy2nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oT6ZtxomyEW1qtWkBexW9it/z7XuQUgNgGTueEKiXfDzD+gGSnoKpQHI3VzO+RcRm
	 oqF+avQvkt1YlTpX96ZN7Uw05u6rDPBPZrGt4MjXrNS22Vp/8KmdPdyiMt9jZE7ZBf
	 1l++I61gxCRsK8VIC9yKTYaZyJmanAq/FP2XB6ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgDROpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgDROov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:44:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D76F22252;
        Sat, 18 Apr 2020 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221091;
        bh=sD6kM9YtnGhI/BuVDPhEHnyPkH8B8ivMCVvFiSdy2nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0dHa+R/HQ2z2Qrit8bSpbQGzN6MM8/fv17DeuoaM3CgcykmNc5PamD/tFCD8UK1m
         DSbhwKMFR6iRErODWgO58JJO0RZ6x7uWSykjBkrvr1tkvxQq2aLfAGxnFOeSxmgG5z
         RsCHuh9Kr50bingV5EFjZgh1IsRCGe1li0l+31dQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 11/19] s390/cio: avoid duplicated 'ADD' uevents
Date:   Sat, 18 Apr 2020 10:44:28 -0400
Message-Id: <20200418144436.10818-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144436.10818-1-sashal@kernel.org>
References: <20200418144436.10818-1-sashal@kernel.org>
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
index 6aae684128021..2389a1dc6d300 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -872,8 +872,10 @@ static void io_subchannel_register(struct ccw_device *cdev)
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
@@ -1082,8 +1084,11 @@ static int io_subchannel_probe(struct subchannel *sch)
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

