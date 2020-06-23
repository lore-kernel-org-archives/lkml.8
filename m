Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E921C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5DE2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943904;
	bh=M+Hx6rSiNbR4a3xFsGvT9QT0Xa+GHzVE9EdR3txncOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DtjWr5Gb3V7twNkZ1YxbFgCnfLwNcoD4HbokIu5nojn9inUo3nt6At1T+iYEYJEUl
	 f8fXWQ1RT/aFs5zn1rFdA8Ys/PA2hKD0ZyuFiibmO7XqR24FUTex/K5Fg7y/fY6sUa
	 bZqjn3pMBmFQOqQNhvjhbEWrzqOVN4i6P9K3z+tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390537AbgFWUZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390503AbgFWUYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:24:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519C420723;
        Tue, 23 Jun 2020 20:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943891;
        bh=M+Hx6rSiNbR4a3xFsGvT9QT0Xa+GHzVE9EdR3txncOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYDnydhiots8YpTShDJzxmyNCxuDpD+NK0mhVe40X/aOxpkD6Bwwm4c6/7ITOq+wX
         9wE65SqvSXEyJGoHys8iL32fwsHEJYxd35U48mL/VDpT2jfme3LxA8oK6HpTnyKQvq
         6LyI8y36c4WjEt1fjcfUgBryBZ3h1Hb4S1o7chto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 064/314] RDMA/core: Fix several reference count leaks.
Date:   Tue, 23 Jun 2020 21:54:19 +0200
Message-Id: <20200623195341.884099507@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 0b8e125e213204508e1b3c4bdfe69713280b7abd ]

kobject_init_and_add() takes reference even when it fails.  If this
function returns an error, kobject_put() must be called to properly clean
up the memory associated with the object. Previous
commit b8eb718348b8 ("net-sysfs: Fix reference count leak in
rx|netdev_queue_add_kobject") fixed a similar problem.

Link: https://lore.kernel.org/r/20200528030231.9082-1-wu000273@umn.edu
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 7a50cedcef1f6..091cca9d88ed7 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1060,8 +1060,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 				   coredev->ports_kobj,
 				   "%d", port_num);
 	if (ret) {
-		kfree(p);
-		return ret;
+		goto err_put;
 	}
 
 	p->gid_attr_group = kzalloc(sizeof(*p->gid_attr_group), GFP_KERNEL);
@@ -1074,8 +1073,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	ret = kobject_init_and_add(&p->gid_attr_group->kobj, &gid_attr_type,
 				   &p->kobj, "gid_attrs");
 	if (ret) {
-		kfree(p->gid_attr_group);
-		goto err_put;
+		goto err_put_gid_attrs;
 	}
 
 	if (device->ops.process_mad && is_full_dev) {
@@ -1406,8 +1404,10 @@ int ib_port_register_module_stat(struct ib_device *device, u8 port_num,
 
 		ret = kobject_init_and_add(kobj, ktype, &port->kobj, "%s",
 					   name);
-		if (ret)
+		if (ret) {
+			kobject_put(kobj);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.25.1



