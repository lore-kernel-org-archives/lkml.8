Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7E720899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590601431;
	bh=qsk677uI1G7xG388JRQ1EJcb+HhzqzXoxdTlVWzea00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z1TGtj/SNSXYcG4R8tWSHZ96959gj3yR7kpJiHJJ724JOUuTi3O3QNG99uoG4d0tG
	 rYmJzzAVUbL3tfOBdBYUt520uI6pglLgSZB3a2sPA+0iUW65GtEwsvu8sPT9YedUKK
	 OWM/hmGqDcJshG5oHwsy4x9Fj65EIYmus97fpO4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391520AbgE0Rnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388343AbgE0Rnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:43:49 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DCEE20663;
        Wed, 27 May 2020 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590601429;
        bh=qsk677uI1G7xG388JRQ1EJcb+HhzqzXoxdTlVWzea00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b38dsy5BnxkemvB3aPYKCSp1dQnRdVruwP9i/zmHaxl2Nc2tYliSvyXorhy6EveSt
         mrBcJSt8Swhi4bC7MYWSGFXFuo0fZmzniwoYXhi4KFqdazKK4EdZSWBjgFIgk8Nwlq
         pvKME8zXxxqF+hce0F4a5Kawn3FZbQjYHtntOCuI=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] xenbus: Use dev_printk() when possible
Date:   Wed, 27 May 2020 12:43:26 -0500
Message-Id: <20200527174326.254329-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200527174326.254329-1-helgaas@kernel.org>
References: <20200527174326.254329-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use dev_printk() when possible to include device and driver information in
the conventional format.

Add "#define dev_fmt" to preserve KBUILD_MODNAME in messages.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 8c4d05b687b7..ee9a9170b43a 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -31,6 +31,7 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
 
 #define DPRINTK(fmt, args...)				\
 	pr_debug("xenbus_probe (%s:%d) " fmt ".\n",	\
@@ -608,7 +609,7 @@ int xenbus_dev_suspend(struct device *dev)
 	if (drv->suspend)
 		err = drv->suspend(xdev);
 	if (err)
-		pr_warn("suspend %s failed: %i\n", dev_name(dev), err);
+		dev_warn(dev, "suspend failed: %i\n", err);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_suspend);
@@ -627,8 +628,7 @@ int xenbus_dev_resume(struct device *dev)
 	drv = to_xenbus_driver(dev->driver);
 	err = talk_to_otherend(xdev);
 	if (err) {
-		pr_warn("resume (talk_to_otherend) %s failed: %i\n",
-			dev_name(dev), err);
+		dev_warn(dev, "resume (talk_to_otherend) failed: %i\n", err);
 		return err;
 	}
 
@@ -637,15 +637,14 @@ int xenbus_dev_resume(struct device *dev)
 	if (drv->resume) {
 		err = drv->resume(xdev);
 		if (err) {
-			pr_warn("resume %s failed: %i\n", dev_name(dev), err);
+			dev_warn(dev, "resume failed: %i\n", err);
 			return err;
 		}
 	}
 
 	err = watch_otherend(xdev);
 	if (err) {
-		pr_warn("resume (watch_otherend) %s failed: %d.\n",
-			dev_name(dev), err);
+		dev_warn(dev, "resume (watch_otherend) failed: %d\n", err);
 		return err;
 	}
 
-- 
2.25.1

