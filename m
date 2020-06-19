Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39F121548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577355;
	bh=AoH3cFK0EpSM77t0CM5zZZtQfQ769kQ+XhGvi3/sWPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eWLA5z6fzXN+3F5my9GLeccQKsX+hbFOAWygtv3FMwGCzNPiUN8lRLIe+LrwhN9N4
	 5ryXWEUNwZv4bFbyWXEX7exeXWkJySATkaPsWZ7avlk+yRgBFFyoqdaczd0DMILp28
	 t5XhyGLFuBUH6nqbXFggLYvlo8X4eXSTORlkjav0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733312AbgFSOfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733289AbgFSOfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:35:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1874820CC7;
        Fri, 19 Jun 2020 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577349;
        bh=AoH3cFK0EpSM77t0CM5zZZtQfQ769kQ+XhGvi3/sWPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TROizFd3X3vSI009ngh4w/yKlTlkmmJcxGx9K3QszUsW+H4JP/ZJHPMroz7o1mBFV
         omw39qhXYoigQWdKuwn3Z7xKGuo9n8A+dxxefVTzCWaq8PxT6Bevb+JSybRKD7t375
         H0OnCsNGBxcELCNRONTiDA+mb1mSEGz5GuASGJeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 016/101] ACPI: sysfs: Fix reference count leak in acpi_sysfs_add_hotplug_profile()
Date:   Fri, 19 Jun 2020 16:32:05 +0200
Message-Id: <20200619141614.835842526@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

commit 6e6c25283dff866308c87b49434c7dbad4774cc0 upstream.

kobject_init_and_add() takes reference even when it fails.
Thus, when kobject_init_and_add() returns an error,
kobject_put() must be called to properly clean up the kobject.

Fixes: 3f8055c35836 ("ACPI / hotplug: Introduce user space interface for hotplug profiles")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/sysfs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -831,8 +831,10 @@ void acpi_sysfs_add_hotplug_profile(stru
 
 	error = kobject_init_and_add(&hotplug->kobj,
 		&acpi_hotplug_profile_ktype, hotplug_kobj, "%s", name);
-	if (error)
+	if (error) {
+		kobject_put(&hotplug->kobj);
 		goto err_out;
+	}
 
 	kobject_uevent(&hotplug->kobj, KOBJ_ADD);
 	return;


