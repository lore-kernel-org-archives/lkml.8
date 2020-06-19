Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB5D207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582619;
	bh=AwDgvlPuxMjSektF2op7uOYUaYC5N3ZYlM32Knp8Xwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DOOyNqDLmAKhrodZLjQ4YyTpB1ANxGNX1jQzT4q+vPTo7Fcu0qC0RngarH33qfzlw
	 4Yit7kkkBXliYnCAZWgYw5hhhVcappQ0b81vkD6FfWVLq7rZctevuf0mKr4ScH1loG
	 rdgyegDF/xwcJmF0sYmq/U4iWM4oY7BPF+4OsWmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403828AbgFSPL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392087AbgFSPLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:11:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14CA8206FA;
        Fri, 19 Jun 2020 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579473;
        bh=AwDgvlPuxMjSektF2op7uOYUaYC5N3ZYlM32Knp8Xwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWHozHGiGNuBzj9UcJ5psEh+UmekfawbHrju99NnVwvzK+dAY7scW7kQ+DmxNS6PK
         iUIKGTTfTURBjYW/7wtcEFF8lI8TEAQNdVT5OiDK+EvOkD75JjGcKQdQCUREyp5yq/
         XDgeVyw0h3D1yEvNyq0UFjbAYil/ZFTYoBKydZ9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 148/261] cpuidle: Fix three reference count leaks
Date:   Fri, 19 Jun 2020 16:32:39 +0200
Message-Id: <20200619141656.962741005@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
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
index 2bb2683b493c..f8747322b3c7 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -480,7 +480,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 		ret = kobject_init_and_add(&kobj->kobj, &ktype_state_cpuidle,
 					   &kdev->kobj, "state%d", i);
 		if (ret) {
-			kfree(kobj);
+			kobject_put(&kobj->kobj);
 			goto error_state;
 		}
 		cpuidle_add_s2idle_attr_group(kobj);
@@ -611,7 +611,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 	ret = kobject_init_and_add(&kdrv->kobj, &ktype_driver_cpuidle,
 				   &kdev->kobj, "driver");
 	if (ret) {
-		kfree(kdrv);
+		kobject_put(&kdrv->kobj);
 		return ret;
 	}
 
@@ -705,7 +705,7 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
 	error = kobject_init_and_add(&kdev->kobj, &ktype_cpuidle, &cpu_dev->kobj,
 				   "cpuidle");
 	if (error) {
-		kfree(kdev);
+		kobject_put(&kdev->kobj);
 		return error;
 	}
 
-- 
2.25.1



