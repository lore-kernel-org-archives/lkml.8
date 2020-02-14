Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD841C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999F4246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697949;
	bh=/i28I5l9CjhJyTMqi7+ktb0Hpgo8pvI7roct7FTl+uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sdq2t7kaeUALOUNbJ9PxgXPRGvBzs9ttKV1gfAU/LQYw54rSh1nI7sIE82lBnQCs1
	 s9tf+BfReNWaFdpD8AV1yKkZv9RDosPElpmCPOHFqf3HtjAOAoS11wV04/Fga3ONFg
	 odE/PIUKJVjaD3oAKC1WOgz3lZnzZVhFD8M/XJVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406861AbgBNQc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406223AbgBNQZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:25:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C0E6247C9;
        Fri, 14 Feb 2020 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697549;
        bh=/i28I5l9CjhJyTMqi7+ktb0Hpgo8pvI7roct7FTl+uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Og8xCedid7mjBa1dtKS44K/oTBkXHMdjzbQwiosFyu4gYvQEylYm7DKJpJFIzG7k
         8x1viL2IE6GWufQ6+DICmoTvjEj6/KY5dDjSviYZq4DJxsdXw+ycc6xY53sA1UpdnE
         Gz4d66GGrISPAG5+eENpAlk+KM2kHVqy1xlZXkcU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 068/100] driver core: Print device when resources present in really_probe()
Date:   Fri, 14 Feb 2020 11:23:52 -0500
Message-Id: <20200214162425.21071-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7c35e699c88bd60734277b26962783c60e04b494 ]

If a device already has devres items attached before probing, a warning
backtrace is printed.  However, this backtrace does not reveal the
offending device, leaving the user uninformed.  Furthermore, using
WARN_ON() causes systems with panic-on-warn to reboot.

Fix this by replacing the WARN_ON() by a dev_crit() message.
Abort probing the device, to prevent doing more damage to the device's
resources.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20191206132219.28908-1-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/dd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1dffb018a7feb..04a923186081f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -283,7 +283,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
-	WARN_ON(!list_empty(&dev->devres_head));
+	if (!list_empty(&dev->devres_head)) {
+		dev_crit(dev, "Resources present before probing\n");
+		return -EBUSY;
+	}
 
 	dev->driver = drv;
 
-- 
2.20.1

