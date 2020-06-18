Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A105EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7324C2193E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448246;
	bh=FHh/Lq9YZNROzvpJtdQYpz4bIgDSQXre0exYLtvbXsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r9q8MavY+VZ4FAZjiVIt8Vbb/eP0qukPcK02HSbnPMHsUeIfrYLPlF6nMU9ov+EuM
	 8zzpA6CJHt4M0enzsq6U69pKUGNVE2BFuc6IVNZliBgTjnRW1qZrjIBSJ3PusdSHwf
	 j93A/Oynd8CP5O8kxQXPlrlxQA7EKiOmNo3d4hTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgFRCoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgFRBLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2328120CC7;
        Thu, 18 Jun 2020 01:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442681;
        bh=FHh/Lq9YZNROzvpJtdQYpz4bIgDSQXre0exYLtvbXsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNwnLXJtfsBVJ5KNChqS+rxrGQRZn64ikAZSSHT7DWzyfCc++yfGapbr2KOilfeks
         KmFtX6kbp7J3C0sKgoicvs8llEYgONLGDmSy2aTzw+pRtGsJY0C6mdlNLf2FOKC6vR
         qUSduY6ds25UkjefFwVIT5MeBwa6F486C02C9wpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 149/388] of: property: Fix create device links for all child-supplier dependencies
Date:   Wed, 17 Jun 2020 21:04:06 -0400
Message-Id: <20200618010805.600873-149-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[ Upstream commit ed3655729182a59b9bef1b564c6fc2dcbbbe954e ]

Upon adding a new device from a DT node, we scan its properties and its
children's properties in order to create a consumer/supplier
relationship between the device and the property provider.

That said, it's possible for some of the node's children to be disabled,
which will create links that'll never be fulfilled.

To get around this, use the for_each_available_child_of_node() function
instead of for_each_available_node() when iterating over the node's
children.

Fixes: d4387cd11741 ("of: property: Create device links for all child-supplier depencencies")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index b4916dcc9e72..a8c2b13521b2 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1296,7 +1296,7 @@ static int of_link_to_suppliers(struct device *dev,
 		if (of_link_property(dev, con_np, p->name))
 			ret = -ENODEV;
 
-	for_each_child_of_node(con_np, child)
+	for_each_available_child_of_node(con_np, child)
 		if (of_link_to_suppliers(dev, child) && !ret)
 			ret = -EAGAIN;
 
-- 
2.25.1

