Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB63C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C7720658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759133;
	bh=SZ2hbU+lcMoW+bQFY1RvJSyW+H+et5QDyAcGJi3xasQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LKyllWaErY4rPRjACktX+zhUuGw5xyNXElNaUzxN9ztS5IIpgpMGtp5Wb4qpKSlBp
	 7lD20JwRYOHp/WGgXjRMFNq1IJuAE3NRYGFLmeGGFXtR5U188i7+exqYpEArUbGGht
	 g8IqidQEDjLRv3UOXVWUcbCIsFpO62qSxeY87A3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbgDAQiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387828AbgDAQir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:38:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E00206F8;
        Wed,  1 Apr 2020 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759127;
        bh=SZ2hbU+lcMoW+bQFY1RvJSyW+H+et5QDyAcGJi3xasQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwqJ09O3UHCnP/yO8zjSjb1sNvbRljbjEGKkq0APkIeWIaCFSJGCyfI2tm6FwFsvE
         ODZ1MghCui1DS4WMEFWjSo5PtldAG3BKGH/gStmp0Ir7c0DsczG+32w69KEjcGruZ2
         F2BosoPs/2dIpncUn/MQ8cDvU3OYhkryFtvJ7uHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 045/102] vxlan: check return value of gro_cells_init()
Date:   Wed,  1 Apr 2020 18:17:48 +0200
Message-Id: <20200401161541.347699626@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 384d91c267e621e0926062cfb3f20cb72dc16928 ]

gro_cells_init() returns error if memory allocation is failed.
But the vxlan module doesn't check the return value of gro_cells_init().

Fixes: 58ce31cca1ff ("vxlan: GRO support at tunnel layer")`
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2354,10 +2354,19 @@ static void vxlan_vs_add_dev(struct vxla
 /* Setup stats when device is created */
 static int vxlan_init(struct net_device *dev)
 {
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	int err;
+
 	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 	if (!dev->tstats)
 		return -ENOMEM;
 
+	err = gro_cells_init(&vxlan->gro_cells, dev);
+	if (err) {
+		free_percpu(dev->tstats);
+		return err;
+	}
+
 	return 0;
 }
 
@@ -2623,8 +2632,6 @@ static void vxlan_setup(struct net_devic
 
 	vxlan->dev = dev;
 
-	gro_cells_init(&vxlan->gro_cells, dev);
-
 	for (h = 0; h < FDB_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);
 }


