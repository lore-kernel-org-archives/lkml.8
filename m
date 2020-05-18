Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758CDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F124207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824910;
	bh=2VvWhOFQzzvG/pN3a73j/LJUDOwNB2TYPqpV7CVyMBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qsJdc9mlPjgOA0DaZ+VL9oSqsLydwZLq3waO7GuC1VgI1HpxrzUxZ/iLkwqlRV4pU
	 GXSOGfit10eOX5p458zIUNXNefYYu3untCtspSN76Sw0oYV87Bcs/Z+rJEh3ttjdAy
	 vl3TTx6pkqLa8LtmC1E4Zy2WTdoVjrYlh9p1QF5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbgERSBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731901AbgERSBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:01:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FF520826;
        Mon, 18 May 2020 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824901;
        bh=2VvWhOFQzzvG/pN3a73j/LJUDOwNB2TYPqpV7CVyMBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbflPwHXdUAxKn7wXBqNwMcYSU02KCK6Scs5SE4G82eHiaAEPlhVxNHX0jp5ypA71
         7GHWdYbadUbQYAdn10YrECP7KmBRH8LSvCcq9AIvXomsoukwEuPGvcG5UzRN1dPCmR
         d8jV1dYqVaTdkPjl3PYj9QGcnuvFVjMT4nrA5m58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 050/194] net: broadcom: Select BROADCOM_PHY for BCMGENET
Date:   Mon, 18 May 2020 19:35:40 +0200
Message-Id: <20200518173535.965662570@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 99addbe31f5524494f4d7077bcb3f6fa64c5d160 ]

The GENET controller on the Raspberry Pi 4 (2711) is typically
interfaced with an external Broadcom PHY via a RGMII electrical
interface. To make sure that delays are properly configured at the PHY
side, ensure that we the dedicated Broadcom PHY driver
(CONFIG_BROADCOM_PHY) is enabled for this to happen.

Fixes: 402482a6a78e ("net: bcmgenet: Clear ID_MODE_DIS in EXT_RGMII_OOB_CTRL when not needed")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -69,6 +69,7 @@ config BCMGENET
 	select BCM7XXX_PHY
 	select MDIO_BCM_UNIMAC
 	select DIMLIB
+	select BROADCOM_PHY if ARCH_BCM2835
 	help
 	  This driver supports the built-in Ethernet MACs found in the
 	  Broadcom BCM7xxx Set Top Box family chipset.


