Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7464C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8577217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581470;
	bh=3RrjVjucjaQRqQ0XpzGPy0vis0dtQ3RxxAdXgJmrAC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iwNFiza5GlBysrUv1eqpsRwG6DeT19ehAa79A8Q+JaN+SFeIashGN29T6/WT6Xv0P
	 vi4KfJs+v75iAdBE3I8q5VsTTQNSRcU8PxcGCGSTMnALBLxH/EXUIVbRUXTD2ZxA+P
	 98vd743hCLceqSvdlfNRzYZTkiXNhFuPYHEoFRxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404473AbgFSP2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404378AbgFSP0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:26:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CCFF20734;
        Fri, 19 Jun 2020 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580413;
        bh=3RrjVjucjaQRqQ0XpzGPy0vis0dtQ3RxxAdXgJmrAC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXH6Y862lxGKG+/n2zF/uQMt0I4IElYrodYySFr+ZG7kjB56B3MC4V5rEzJk7T2hl
         sLaLmcx2IddNlTKyjgFeSC0K5Rt3b1onpFIlcJPbmuYVA54PBmY+Dh7lMy3nWUK4DV
         9yayEMattZm7nwndHcyGEgjGPxy0nwTGc+9lnZQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 239/376] cpuidle: Fix three reference count leaks
Date:   Fri, 19 Jun 2020 16:32:37 +0200
Message-Id: <20200619141721.642832955@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit c343bf1ba5efcbf2266a1fe3baefec9cc82f867f ]

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object.

Previous commit "b8eb718348b8" fixed a similar problem.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
[ rjw: Subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index cdeedbf02646..55107565b319 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -515,7 +515,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 		ret = kobject_init_and_add(&kobj->kobj, &ktype_state_cpuidle,
 					   &kdev->kobj, "state%d", i);
 		if (ret) {
-			kfree(kobj);
+			kobject_put(&kobj->kobj);
 			goto error_state;
 		}
 		cpuidle_add_s2idle_attr_group(kobj);
@@ -646,7 +646,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 	ret = kobject_init_and_add(&kdrv->kobj, &ktype_driver_cpuidle,
 				   &kdev->kobj, "driver");
 	if (ret) {
-		kfree(kdrv);
+		kobject_put(&kdrv->kobj);
 		return ret;
 	}
 
@@ -740,7 +740,7 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
 	error = kobject_init_and_add(&kdev->kobj, &ktype_cpuidle, &cpu_dev->kobj,
 				   "cpuidle");
 	if (error) {
-		kfree(kdev);
+		kobject_put(&kdev->kobj);
 		return error;
 	}
 
-- 
2.25.1



