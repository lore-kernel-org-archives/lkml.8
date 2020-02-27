Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F83C52D3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D711F2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811870;
	bh=e8Q15C0HhtCpl/wXksOGPiWdKqOGH67r91PnG+jrvWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSPyTKqtpQhFsMZKkQvYOgVjYQwdXQXADq2fMms8NGNlLTEzxnfAMUzSNi2FGqjZc
	 oPaHnrHSddB8LBxGs5vQ7uVhlP0JZYLIZxERkJ0gLqfzwgJaYteBx5otJ9K3NZP8et
	 o2kt8UQucx6er9eFqYMDwJgS4zU6xtmeJV4KwFgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgB0N5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:57:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732343AbgB0N5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:57:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7F120801;
        Thu, 27 Feb 2020 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811865;
        bh=e8Q15C0HhtCpl/wXksOGPiWdKqOGH67r91PnG+jrvWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zB4tzJWsn5pF3jSn5HnaZmLiN2sYzYcaUMPoBcsUZG9zMBccgmw/QAutUXEBPYT45
         R9clQZ4uhsomacuUDboSwwQVRLI9a/qMSYZeA43j5Nnly/0tNTCyyYLeYLAJoVefR2
         PdIXHieufRl4ugRhvjtfU7sseTmzGVbCuvIoGqvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 114/237] driver core: Print device when resources present in really_probe()
Date:   Thu, 27 Feb 2020 14:35:28 +0100
Message-Id: <20200227132305.250277484@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 536c9ac3b8489..aa1a2d32360f9 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -375,7 +375,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
-	WARN_ON(!list_empty(&dev->devres_head));
+	if (!list_empty(&dev->devres_head)) {
+		dev_crit(dev, "Resources present before probing\n");
+		return -EBUSY;
+	}
 
 re_probe:
 	dev->driver = drv;
-- 
2.20.1



