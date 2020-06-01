Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231D6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ED0206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035519;
	bh=VJCgLwsSNHwLmsfHycjLYWKHAkmJNu9lyn4RGGguDvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OQtWshJddx/96lu5uvECRYLRBTiz+vTBQcOItuAlsIexNljtWt5w8M1GO6NuvoRNd
	 musypCDcRPKJ5OwDDLzzMZQepVvEoQOmOfVX1v9fI/edDPENboLTB9G0FRQiZegGKz
	 O5PNOGhXNGX9XBqdBYtxk3xAhUfVkMH6gn14Tok4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgFASSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbgFASSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:18:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3021F2068D;
        Mon,  1 Jun 2020 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035482;
        bh=VJCgLwsSNHwLmsfHycjLYWKHAkmJNu9lyn4RGGguDvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0YNWeSvgh/Kyuco2eEFbSaey6hR1EKYBecmhRjrmRCWgfnwFcPVt10NX3wOH+j+t
         M5v5ki/iIRvMaaeksT2DW9A2Dts3EpT7pkt88MU6GCXAinaXvWkcLqakqvXWjffG3n
         dCtwY7+CQZT7ieAE8xGr1/e+Vv+5rLCaw/s5FI+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 172/177] bonding: Fix reference count leak in bond_sysfs_slave_add.
Date:   Mon,  1 Jun 2020 19:55:10 +0200
Message-Id: <20200601174102.402758611@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

commit a068aab42258e25094bc2c159948d263ed7d7a77 upstream.

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 07699f9a7c8d ("bonding: add sysfs /slave dir for bond slave devices.")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/bonding/bond_sysfs_slave.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_sysfs_slave.c
+++ b/drivers/net/bonding/bond_sysfs_slave.c
@@ -149,8 +149,10 @@ int bond_sysfs_slave_add(struct slave *s
 
 	err = kobject_init_and_add(&slave->kobj, &slave_ktype,
 				   &(slave->dev->dev.kobj), "bonding_slave");
-	if (err)
+	if (err) {
+		kobject_put(&slave->kobj);
 		return err;
+	}
 
 	for (a = slave_attrs; *a; ++a) {
 		err = sysfs_create_file(&slave->kobj, &((*a)->attr));


