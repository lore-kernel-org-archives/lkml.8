Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57834C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2580D2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338822;
	bh=lUrQunh0+ei5Hfb26Ok1sojhY0Gsu0vIGOsf4QwGHeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tqNBBNF8L5T3slLDivJx4WusLWcLH26l8sqkOOxnB/Dx0phIKRoOI7JNTwy4r9fV8
	 pxYj0Yut1A/t4NtgsfnK22D25r47BeMYEDi2WKOUYRbLh1jI27Affz5w78vZHxr8Ma
	 4ManGo3s1bgJmQfT+2itd3SW6eMdWbuSEW4U2/ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgBJMrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgBJMlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:55 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6538520838;
        Mon, 10 Feb 2020 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338514;
        bh=lUrQunh0+ei5Hfb26Ok1sojhY0Gsu0vIGOsf4QwGHeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4o4+Ue/FOVGz+mqt8u1pxRKPkf68skamOEcDtjFTVebjniMVxTIE8XYBOMdodv+T
         v6/T+iIWlCx05bSALYF936oymjt1F7W7+ZuTvfVKXBxnkWLJnuu0Yg0YpCtL5stSFQ
         4O+adJlp7vjlwYM+4n5ld7x7lYksohvvenCqAHi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 321/367] net: dsa: microchip: enable module autoprobe
Date:   Mon, 10 Feb 2020 04:33:54 -0800
Message-Id: <20200210122452.674365368@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

[ Upstream commit f8c2afa66d5397b0b9293c4347dac6dabb327685 ]

This matches /sys/devices/.../spi1.0/modalias content.

Fixes: 9b2d9f05cddf ("net: dsa: microchip: add ksz9567 to ksz9477 driver")
Fixes: d9033ae95cf4 ("net: dsa: microchip: add KSZ8563 compatibility string")
Fixes: 8c29bebb1f8a ("net: dsa: microchip: add KSZ9893 switch support")
Fixes: 45316818371d ("net: dsa: add support for ksz9897 ethernet switch")
Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/microchip/ksz9477_spi.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/dsa/microchip/ksz9477_spi.c
+++ b/drivers/net/dsa/microchip/ksz9477_spi.c
@@ -101,6 +101,12 @@ static struct spi_driver ksz9477_spi_dri
 
 module_spi_driver(ksz9477_spi_driver);
 
+MODULE_ALIAS("spi:ksz9477");
+MODULE_ALIAS("spi:ksz9897");
+MODULE_ALIAS("spi:ksz9893");
+MODULE_ALIAS("spi:ksz9563");
+MODULE_ALIAS("spi:ksz8563");
+MODULE_ALIAS("spi:ksz9567");
 MODULE_AUTHOR("Woojung Huh <Woojung.Huh@microchip.com>");
 MODULE_DESCRIPTION("Microchip KSZ9477 Series Switch SPI access Driver");
 MODULE_LICENSE("GPL");


