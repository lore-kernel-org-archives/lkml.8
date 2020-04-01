Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83096C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F242212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758254;
	bh=LEGGdLzK6EnXVJJL0mKnQsj7m5KADf0tp3L9q/gIVUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z9igmmWHD0aWOQ6b7StbPX9S23aOV2gjZpup36+nnhY0TPGD03g8xKUU13Hmq8a12
	 K5tdBw4iegiOwG0XIN3FwRlp6ni5sCZ5oCCsdyd+bml5WN7a+bKwXEIk0WVYFxw7B+
	 USR0V+Se6XXnjyP1yw3N0K0LHYMOMIzqaD98AqmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgDAQYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732532AbgDAQYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:24:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 991FE20857;
        Wed,  1 Apr 2020 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758244;
        bh=LEGGdLzK6EnXVJJL0mKnQsj7m5KADf0tp3L9q/gIVUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n86q/sRiy8v8XuzrwO4GYgRpHY8iOLhymVw9OodsO+OV6jdfhnSfY5H+ms9E3BzdI
         l/ZQ1a39/c262MjArMf6uQeDfZaK/hzAm3ojHxlcA6QyhGlHv+hdSz7lFS0Q2D3a4U
         LtZdLp5+kY8xtktH3w/dLid6MbrVMMrB7q/Sn8Bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 029/116] vxlan: check return value of gro_cells_init()
Date:   Wed,  1 Apr 2020 18:16:45 +0200
Message-Id: <20200401161546.124257042@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
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
@@ -2451,10 +2451,19 @@ static void vxlan_vs_add_dev(struct vxla
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
 
@@ -2712,8 +2721,6 @@ static void vxlan_setup(struct net_devic
 
 	vxlan->dev = dev;
 
-	gro_cells_init(&vxlan->gro_cells, dev);
-
 	for (h = 0; h < FDB_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);
 }


