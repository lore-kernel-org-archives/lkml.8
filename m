Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC929C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844142187F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582534424;
	bh=PqykvPQQ/udBG704OUeCLp9f/aB1NAyE9uTf+TCbpz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pBOef8ktiB2V1iCDIu993x/rGJ/91UcQeJSNms1a8WBMnPUnGQRPp7opcgconalUA
	 Wplpak1sU7NycQOFZ3e54j/BR4xzGa2sfxS9O4qWzHapebkrFdsWD4taXc/0Aw0oUT
	 mBwc739EBkG8LybYPwvZ/RWG31frOrsh8QIktbe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBXIxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbgBXIxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:53:42 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6497214DB;
        Mon, 24 Feb 2020 08:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582534421;
        bh=PqykvPQQ/udBG704OUeCLp9f/aB1NAyE9uTf+TCbpz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/pjM/vcm8JA8QuRjS1Bu+1SaGDuSYghfazALvLx7jH4zI0/CnwUOeFhjLEyaBm0D
         oPdvP4f8CNmalkFD1hQDQg+pJMX2pb6mAEwS88pHG/k0RfcczV8h++l1QkKUbQFmOT
         Fll+u2HS/YvFQlHo70Zuj/eXl/5BtJ+uRmo30hj0=
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
Subject: [PATCH net-next v1 07/18] net/agere: Delete unneeded driver version
Date:   Mon, 24 Feb 2020 10:53:00 +0200
Message-Id: <20200224085311.460338-8-leon@kernel.org>
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

There is no need in driver version for in-tree kernel code.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/net/ethernet/agere/et131x.c | 1 -
 drivers/net/ethernet/agere/et131x.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index cb6a761d5c11..1b19385ad8a9 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -2958,7 +2958,6 @@ static void et131x_get_drvinfo(struct net_device *netdev,
 	struct et131x_adapter *adapter = netdev_priv(netdev);

 	strlcpy(info->driver, DRIVER_NAME, sizeof(info->driver));
-	strlcpy(info->version, DRIVER_VERSION, sizeof(info->version));
 	strlcpy(info->bus_info, pci_name(adapter->pdev),
 		sizeof(info->bus_info));
 }
diff --git a/drivers/net/ethernet/agere/et131x.h b/drivers/net/ethernet/agere/et131x.h
index be9a11c02526..d0e922584d8a 100644
--- a/drivers/net/ethernet/agere/et131x.h
+++ b/drivers/net/ethernet/agere/et131x.h
@@ -46,7 +46,6 @@
  */

 #define DRIVER_NAME "et131x"
-#define DRIVER_VERSION "v2.0"

 /* EEPROM registers */

--
2.24.1

