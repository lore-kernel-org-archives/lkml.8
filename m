Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8A3C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B3A20857
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255083;
	bh=4nPDAK8FhaKO//oce9RzisZ2p1XmrMAHJp8g7CR2YFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BnvR1mnN5PAwKk/OhPUh1a0lBeQ7CbwKCxh2e0c/R1o518dTF2yOIZblCYl2oaNSh
	 KIN6er+xiYvqQSeK4AmBli2I7HldTtGxmA5sIcLVU4JOI+mQIiWg8YdShYczBtaYzl
	 3PJVtQKGVVCLFxheeOhiGH2OIw/63+dUF7YtRskE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgDGKYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbgDGKYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:24:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBFC92082F;
        Tue,  7 Apr 2020 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255075;
        bh=4nPDAK8FhaKO//oce9RzisZ2p1XmrMAHJp8g7CR2YFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tmgn4Ja4jt7JbcJfJ5vIvSfQ4e/muFiJA42Pn3k39cLqScqMVzPBSWI3pyenYW3Fw
         XS4gdqzLKcCUqsKCbCmrl4QngF47SOOktCIUrsNSvqa02Jm+8TvvkCcyZB7eCAcjce
         lFpSQimGU0XDzrFifsrqpnE8W1I5c0X6tG36RiqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 02/46] net: dsa: ksz: Select KSZ protocol tag
Date:   Tue,  7 Apr 2020 12:21:33 +0200
Message-Id: <20200407101459.777473459@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101459.502593074@linuxfoundation.org>
References: <20200407101459.502593074@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

[ Upstream commit f772148eb757b0823fbfdc2fe592d5e06c7f19b0 ]

KSZ protocol tag is needed by the KSZ DSA drivers.

Fixes: 0b9f9dfbfab4 ("dsa: Allow tag drivers to be built as modules")
Tested-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/microchip/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NET_DSA_MICROCHIP_KSZ_COMMON
+	select NET_DSA_TAG_KSZ
 	tristate
 
 menuconfig NET_DSA_MICROCHIP_KSZ9477


