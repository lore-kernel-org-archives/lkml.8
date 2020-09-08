Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D3DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019B920936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599587368;
	bh=yjFhd6N+TPTOiiQRRwoqldwT12MjDPQQ/oVGcbAVcg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u41nNzfINEEUcDlC9OxljGjapsWP+x/sJFWbDkQ3KQTnsb6tesQcGAvTg9+kHQIEQ
	 QRTac1yI2ZxDVCvb1PdbrTImAltjOzDo4+5Yqd/4spkNIC9hw784H0LajTZ0G2FTzx
	 2VgrjubkelYAoh0vQHfu+IgKv2ZXacTWWOAEscrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbgIHRtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbgIHQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C15248DC;
        Tue,  8 Sep 2020 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580374;
        bh=yjFhd6N+TPTOiiQRRwoqldwT12MjDPQQ/oVGcbAVcg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zhz5pYZRt1+ZYPz/uJBPDwQWCY9lTtzbPAKGkwYX3HAOH9DWdX7MeP0qkNstjAiBd
         9oHb68GfVBXW+B6v3uPCb25P+JapL8tuF5j5YcsrD2zHw3zxrYIaX0MnDWbHhLumgo
         HnSMffpwjz0GO6RFQrSrk+U8rp2HK2n5ewpCzSOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 21/65] net: hns: Fix memleak in hns_nic_dev_probe
Date:   Tue,  8 Sep 2020 17:26:06 +0200
Message-Id: <20200908152218.127125367@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 100e3345c6e719d2291e1efd5de311cc24bb9c0b ]

hns_nic_dev_probe allocates ndev, but not free it on
two error handling paths, which may lead to memleak.

Fixes: 63434888aaf1b ("net: hns: net: hns: enet adds support of acpi")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 0733745f4be6c..af832929ae287 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2433,8 +2433,10 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 			priv->enet_ver = AE_VERSION_1;
 		else if (acpi_dev_found(hns_enet_acpi_match[1].id))
 			priv->enet_ver = AE_VERSION_2;
-		else
-			return -ENXIO;
+		else {
+			ret = -ENXIO;
+			goto out_read_prop_fail;
+		}
 
 		/* try to find port-idx-in-ae first */
 		ret = acpi_node_get_property_reference(dev->fwnode,
@@ -2446,7 +2448,8 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 		priv->fwnode = acpi_fwnode_handle(args.adev);
 	} else {
 		dev_err(dev, "cannot read cfg data from OF or acpi\n");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto out_read_prop_fail;
 	}
 
 	ret = device_property_read_u32(dev, "port-idx-in-ae", &port_id);
-- 
2.25.1



