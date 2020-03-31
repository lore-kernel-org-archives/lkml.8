Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33164C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079B620772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645940;
	bh=CIZJFBOO/lyl3P9I6RSWVKhxjGF5Hijg738vQur+fLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pP6fD2KScC3U6JZduJ0WJXvMtfBrQqyUN/nopHWzcb4p9OVSGBoXvyDt8Vny/GI0c
	 ShKgVlA0xFHN8yrOfVortVrQT04A/CvIM5hn/PbizK07FrM7q/iT7K+eZHShUQ9BlE
	 m58WObRxun418HBbQ4mYU3weJimMs7S7K95QUtxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgCaJMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731775AbgCaJMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:12:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB69F20772;
        Tue, 31 Mar 2020 09:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645935;
        bh=CIZJFBOO/lyl3P9I6RSWVKhxjGF5Hijg738vQur+fLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2ZOGvAurjT46eYhT1PZg0TO2ARKsvuidCWzbaN8edY+oT0qRq5Cwo6S5TLngZpIB
         u2kCuhFuu8hPdCTQ7clW0kKeJMcyB5kZSX0pLzlF4KbX5RPc0G/KrsokZvy0tfcwjg
         E+IorUEDMH4wm2aiWrBNmPRlQ2ctcc2avCe4du3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 038/155] vxlan: check return value of gro_cells_init()
Date:   Tue, 31 Mar 2020 10:57:58 +0200
Message-Id: <20200331085422.679138868@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
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
@@ -2779,10 +2779,19 @@ static void vxlan_vs_add_dev(struct vxla
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
 
@@ -3043,8 +3052,6 @@ static void vxlan_setup(struct net_devic
 
 	vxlan->dev = dev;
 
-	gro_cells_init(&vxlan->gro_cells, dev);
-
 	for (h = 0; h < FDB_HASH_SIZE; ++h) {
 		spin_lock_init(&vxlan->hash_lock[h]);
 		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);


