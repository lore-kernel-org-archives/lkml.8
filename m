Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22A5C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A562B2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201056;
	bh=wU6xElxbmamYvCcL2cdheUUez3EvA/zpL6bgRVJJj/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sjkYc6Ca1bJoiG4am3NR27B6PICL4+hfoGecR6Woy31rmzWCb9HnxV2L1HwD7nilK
	 rDmF9dpdQ1G5Xhx15JAfAKA+bzzaH7jS+KL9E2dRLpYTncD7DHr2UTgG/qU6177hCi
	 jD80EPB9RHvg6i7u8YfUaxaFFcPhSWSMGD3qjyN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407229AbgAPS5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:57:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbgAPRHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:07:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58DCF20663;
        Thu, 16 Jan 2020 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194421;
        bh=wU6xElxbmamYvCcL2cdheUUez3EvA/zpL6bgRVJJj/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5Y+/5qAQ4teATAcT0u3t9LowOJRxtE95G2rmoe6wVxdGgpNSNOpmwcyrl9FfmWVa
         b5RI3ttCmY/m/Fed9CoNlTEvjnI4LbDLIR4WQIQEjzA3nEAaFUWaDBANXvBwJXGoZt
         ki+cm21s2BAwVyp9Jas96Z01CHOuxZ8mAeRFrMpA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Parav Pandit <parav@mellanox.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 340/671] vfio/mdev: Avoid release parent reference during error path
Date:   Thu, 16 Jan 2020 11:59:38 -0500
Message-Id: <20200116170509.12787-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 60e7f2c3fe9919cee9534b422865eed49f4efb15 ]

During mdev parent registration in mdev_register_device(),
if parent device is duplicate, it releases the reference of existing
parent device.
This is incorrect. Existing parent device should not be touched.

Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/mdev/mdev_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 0212f0ee8aea..8cfa71230877 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -182,6 +182,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
 	/* Check for duplicate */
 	parent = __find_parent_device(dev);
 	if (parent) {
+		parent = NULL;
 		ret = -EEXIST;
 		goto add_dev_err;
 	}
-- 
2.20.1

