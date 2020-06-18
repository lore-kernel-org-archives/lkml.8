Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56878C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286AC20897
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445440;
	bh=id24scQiiVfNzQN1qVqP92RtF/b6HEXy4lOg2XzRJBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAcTt0zDE6X4PlG6GSS4AaOifwdSV14L7jxtPqBbnRkMSTDcovL8f7cvDuc1sX+pZ
	 7LX4GQntNFsddL8/Wz+v+IVDdCfDIkOcYKiSa/ehqrpN82PVujgCq3Fi9tGEpiFWxM
	 s9nUw/ygA260EXYU0BviFmf31aw+lbp5JMYiqbaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbgFRB5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgFRBZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:25:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C3B21D80;
        Thu, 18 Jun 2020 01:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443510;
        bh=id24scQiiVfNzQN1qVqP92RtF/b6HEXy4lOg2XzRJBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JM3H8o8gopaffWlOr0wze/BXz89zHmG0L16i/Hylw2l6/4v/hwU5yxzYIKaB7GmIj
         tHdTNf7xJNgbBnTJUYXCfc06uZlb6GCdYIqCQxW3EIFfc0KEv0Jcd96ClMVFEHQaCk
         u9fhp+CdpWGlrzqZu7eVm8YoHuYqZJcM7J0ye9ZM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 134/172] vfio/mdev: Fix reference count leak in add_mdev_supported_type
Date:   Wed, 17 Jun 2020 21:21:40 -0400
Message-Id: <20200618012218.607130-134-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit aa8ba13cae3134b8ef1c1b6879f66372531da738 ]

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Thus,
replace kfree() by kobject_put() to fix this issue. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/mdev/mdev_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
index e7770b511d03..1692a0cc3036 100644
--- a/drivers/vfio/mdev/mdev_sysfs.c
+++ b/drivers/vfio/mdev/mdev_sysfs.c
@@ -113,7 +113,7 @@ struct mdev_type *add_mdev_supported_type(struct mdev_parent *parent,
 				   "%s-%s", dev_driver_string(parent->dev),
 				   group->name);
 	if (ret) {
-		kfree(type);
+		kobject_put(&type->kobj);
 		return ERR_PTR(ret);
 	}
 
-- 
2.25.1

