Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1290C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B666822527
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582534435;
	bh=wDd04J+iEhOXCJYxcPWpK+K6rE650aIVNXcP80WLgxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O4H5RiG3ZJew+UK85cyHRZcsVmR22dpsFJo9tYXwdBRPr36+CE3zfEmggeHMpTrA1
	 0w8kLfBUgjB4swEBTDAGnmQE42n5XWDT8Rm3nFT3ZoO5RFRb6IWn0axeu9qMs/mfRE
	 /yb+sLhWLBaRs2GFn3KJ9g9ihS5HD49I9DO/3auo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBXIxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:53:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbgBXIxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:53:52 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C665222C2;
        Mon, 24 Feb 2020 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582534431;
        bh=wDd04J+iEhOXCJYxcPWpK+K6rE650aIVNXcP80WLgxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQBE86gm/pYpfaRe5yzJ2NwPpYp7HP27+Qr6vSROFZds1Hky63UENJzmjksN0W0ro
         3U5lvHx+yQWw12Ol+vwvZS385sRdKe3ZNCl7E9u2as7X03nHw/VBuJ3H2U/dvvbxlc
         c6aSbg1yvBadAw9cDiWnxhjyOnkHkllzcW9YDcbA=
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
Subject: [PATCH net-next v1 11/18] net/althera: Delete hardcoded driver version
Date:   Mon, 24 Feb 2020 10:53:04 +0200
Message-Id: <20200224085311.460338-12-leon@kernel.org>
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

Convert to use default version provided by ethtool.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/net/ethernet/altera/altera_tse_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_ethtool.c b/drivers/net/ethernet/altera/altera_tse_ethtool.c
index 23823464f2e7..4299f1301149 100644
--- a/drivers/net/ethernet/altera/altera_tse_ethtool.c
+++ b/drivers/net/ethernet/altera/altera_tse_ethtool.c
@@ -67,7 +67,6 @@ static void tse_get_drvinfo(struct net_device *dev,
 	u32 rev = ioread32(&priv->mac_dev->megacore_revision);

 	strcpy(info->driver, "altera_tse");
-	strcpy(info->version, "v8.0");
 	snprintf(info->fw_version, ETHTOOL_FWVERS_LEN, "v%d.%d",
 		 rev & 0xFFFF, (rev & 0xFFFF0000) >> 16);
 	sprintf(info->bus_info, "platform");
--
2.24.1

