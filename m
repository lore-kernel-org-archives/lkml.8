Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA11C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A3621835
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578073;
	bh=CbJdjZrQhMBdYhchWNvBBlWo0jc+OqGxp0v9xYVc5DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kzc3CNcV2K+kuFDDPJfOwE8FEL43GW3mcvE9kYJZ6F3xAOecbKU8zjdlsLgEuvkzd
	 tEOaZFudv2tIMtCXFbCMn+r2qLeUHPSD66C7j96EEU1hnx3eMPIGCNXmhU08fDGuKD
	 RINa+sel+jysIOXrjPcN3YeN53W8sFj79pd/oX7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbgFSOrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388970AbgFSOrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:47:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0C1217D8;
        Fri, 19 Jun 2020 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578060;
        bh=CbJdjZrQhMBdYhchWNvBBlWo0jc+OqGxp0v9xYVc5DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEbfvuukKmS9CidzKeSHHUyaa9wX68ks3JQaDlHiP2nDvM2vAkgPfGwlxVsD3esij
         pkCB4WVk2MTrw2hZ8zycZbR9O6lK1jH1mP0/M/jsUFLf8ZHem6JD5+2J+aVEeuWgKo
         qIoBFcr+CCin6BxKAyEl7f8LzHIa9RASDl+cRs+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 026/190] ACPI: sysfs: Fix reference count leak in acpi_sysfs_add_hotplug_profile()
Date:   Fri, 19 Jun 2020 16:31:11 +0200
Message-Id: <20200619141634.822452238@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
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
@@ -997,8 +997,10 @@ void acpi_sysfs_add_hotplug_profile(stru
 
 	error = kobject_init_and_add(&hotplug->kobj,
 		&acpi_hotplug_profile_ktype, hotplug_kobj, "%s", name);
-	if (error)
+	if (error) {
+		kobject_put(&hotplug->kobj);
 		goto err_out;
+	}
 
 	kobject_uevent(&hotplug->kobj, KOBJ_ADD);
 	return;


