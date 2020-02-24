Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8245C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C63B2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582534408;
	bh=u4B7Vto/10BbegPDSJEemPSvyjrazEXATWOFgauUrqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JWv9INO/+uSk52GH7hg88EMbVAroDPUahKSLtiAb4W4eArNj4ehmtqsOjrvUX/R8y
	 I47CxFCYxQNDHakjgnA/j0gDhp36zKmIvTBxZAYtZt4jqWqC6+TMh/f1M9tcOPAUeY
	 whIwbnhsys+0KOd/tUsu/m+YyYHtoUeUcUoVLbT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgBXIx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:53:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXIxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:53:25 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE692082E;
        Mon, 24 Feb 2020 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582534404;
        bh=u4B7Vto/10BbegPDSJEemPSvyjrazEXATWOFgauUrqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e63QLvxyXaIDOP1R9CuGFUDzaQ1ji5kYXsnE+JQZiUXwNcRRPfVvaAc85BnTjPTZs
         UKQ+ZacCVO+gPjOWVMV9PctUgl6HXLEz9MKtUyD5LG3otHlH0n+2vB+HMZWlyqoPxg
         CIj2dThM7kbJ431fBpp0Jf8g9pZ8Iij5XPnJLwQ0=
From:   Leon Romanovsky <leon@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Don Fry <pcnet32@frontier.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>, linux-acenic@sunsite.dk,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Einon <mark.einon@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        David Dillow <dave@thedillows.org>,
        Netanel Belgazal <netanel@amazon.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Jay Cliburn <jcliburn@gmail.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-arm-kernel@lists.infradead.org,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ion Badulescu <ionut@badula.org>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        Jes Sorensen <jes@trained-monkey.org>,
        nios2-dev@lists.rocketboards.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH net-next v1 02/18] net/dummy: Ditch driver and module versions
Date:   Mon, 24 Feb 2020 10:52:55 +0200
Message-Id: <20200224085311.460338-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224085311.460338-1-leon@kernel.org>
References: <20200224085311.460338-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Delete constant driver and module versions in favor of
standard global version which is unique to whole kernel.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/net/dummy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index 3031a5fc5427..bab3a9bb5e6f 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -42,7 +42,6 @@
 #include <linux/u64_stats_sync.h>

 #define DRV_NAME	"dummy"
-#define DRV_VERSION	"1.0"

 static int numdummies = 1;

@@ -104,7 +103,6 @@ static void dummy_get_drvinfo(struct net_device *dev,
 			      struct ethtool_drvinfo *info)
 {
 	strlcpy(info->driver, DRV_NAME, sizeof(info->driver));
-	strlcpy(info->version, DRV_VERSION, sizeof(info->version));
 }

 static const struct ethtool_ops dummy_ethtool_ops = {
@@ -212,4 +210,3 @@ module_init(dummy_init_module);
 module_exit(dummy_cleanup_module);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK(DRV_NAME);
-MODULE_VERSION(DRV_VERSION);
--
2.24.1

