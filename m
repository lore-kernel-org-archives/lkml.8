Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C9CC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E9524688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686794;
	bh=SpcGcygHXVPxn1UnRvEt5r5U7UWMz3jhb1BxPra/2sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rjM82w7kpIAV6+sWN/bvpuhIJlJ4V7ROyr5/0XndzTlIAz1Pt3gCOHKqki51G/jl3
	 62ex0D0ArOtn0vyOW798JGk8eiNjiZIwXD/7CYol8+5OJvM17fvm2v3ideaKOmj69M
	 h2ruwLpYX/A6R2nfJdZl5Z5BNxkxiIU/UX/ZK8P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgAVJfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbgAVJf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:35:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FEF52467B;
        Wed, 22 Jan 2020 09:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685728;
        bh=SpcGcygHXVPxn1UnRvEt5r5U7UWMz3jhb1BxPra/2sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tc6jRjp7zPMuZtSyxLzg5N6j7z21E8m9Nxq3+PMDlL/sEnIEF/Fm9GktCZm6S+kO3
         7qYh7dxPi0UEP7O2vTbQI6pVgsNP4UKynaFu2YZJtWK/xnyuC5AUaXbYRXrHdDDUwY
         qUT+ggSZ1/tdQwxg0mbSrkwlVOsULt9I7XRqpA6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.9 21/97] iommu: Remove device link to group on failure
Date:   Wed, 22 Jan 2020 10:28:25 +0100
Message-Id: <20200122092759.508263520@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Derrick <jonathan.derrick@intel.com>

commit 7d4e6ccd1fb09dbfbc49746ca82bd5c25ad4bfe4 upstream.

This adds the missing teardown step that removes the device link from
the group when the device addition fails.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Fixes: 797a8b4d768c5 ("iommu: Handle default domain attach failure")
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/iommu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -439,6 +439,7 @@ err_put_group:
 	mutex_unlock(&group->mutex);
 	dev->iommu_group = NULL;
 	kobject_put(group->devices_kobj);
+	sysfs_remove_link(group->devices_kobj, device->name);
 err_free_name:
 	kfree(device->name);
 err_remove_link:


