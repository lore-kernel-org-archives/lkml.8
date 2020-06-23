Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B6B214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945236;
	bh=LVnmN5aZ0vxgsQR5Wy6w1OtuTrMtIj65si1oe4t5o84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sy3Y3dRl/F9iJqTcqILLQxe/gAo4J1FFny87lNG1aT3HyQbfQAn6WAfYn7KeIoILL
	 RVg/VJWd64E4enuwnnD00PlUQkm97gRdYAzX9DumX6DtE5FJTnpgNSMhbl53kznVXG
	 A/Iqq7rxPwOn5KLKfo+R5oU4WrU3vh83KcFRLoKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404044AbgFWUrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392885AbgFWUqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:46:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9035821548;
        Tue, 23 Jun 2020 20:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945214;
        bh=LVnmN5aZ0vxgsQR5Wy6w1OtuTrMtIj65si1oe4t5o84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1UyGcd7Tdn19S8a3Z/tiUlMvpEoykGiO165H3NXSb+PJR2ayTK34ZKBjf7acsFYnP
         Qm+zC1uvYNmC792dkAayUBqt2y2YIgyi82liUl9ythzmiLktVTsqC/g7/f/rehLrih
         +3NV3GgGy7hpiPAtuj1W0IWDY5FMfb2HvFQ4Nx+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 084/136] vfio/mdev: Fix reference count leak in add_mdev_supported_type
Date:   Tue, 23 Jun 2020 21:59:00 +0200
Message-Id: <20200623195307.916629785@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 802df210929ba..7e474e41c85e3 100644
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



